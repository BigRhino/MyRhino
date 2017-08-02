//
//  VideoEncode.m
//  VideoToolBox
//
//  Created by Rhino on 2017/7/8.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "VideoEncode.h"
#import <UIKit/UIKit.h>


@interface VideoEncode()
//帧ID
@property (nonatomic, assign) NSInteger frameID;
//编码会话
@property (nonatomic, assign) VTCompressionSessionRef encodeSesssion;
//文件句柄
@property (nonatomic, strong) NSFileHandle *fileHandle;

@end

@implementation VideoEncode

- (instancetype)init{
    if (self = [super init]) {
        
        [self initFileHandle];
        [self initVideoToolBox];
    }
    return self;
}

- (void)initFileHandle{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"VideoTool.h264"];
    [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
    [[NSFileManager defaultManager]createFileAtPath:path contents:nil attributes:nil];
    
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    NSLog(@"path:%@",path);
}

- (void)initVideoToolBox{
    
    //帧ID
    self.frameID = 0;
    int width = [UIScreen mainScreen].bounds.size.width;
    int height = [UIScreen mainScreen].bounds.size.height;
#pragma mark - CreateSession
    //参数1:C语言函数一般第一个都有,分配器,传NULL或kCFAllocatorDefault
    //参数2,参数3:宽度,高度
    //参数4:编码类型 kCMVideoCodecType_H264
    //参数5:编码规范 传NULL VideoToolBox自行选择
    //参数6:源像素缓冲区
    //参数7:压缩数据分配器
    //参数8:回调函数
    //参数9:回调函数的引用
    //参数10:编码会话对象指针
    OSStatus status = VTCompressionSessionCreate(kCFAllocatorDefault, width, height, kCMVideoCodecType_H264, NULL, NULL, NULL, didCompressionOutputCallback, (__bridge void *)self, &_encodeSesssion);
    if (status != noErr) {
        NSLog(@"create compressionSession failed!");
        return;
    }
#pragma mark - ConfigSession
    
    //设置实时编码输出(否则会造成延迟)
    VTSessionSetProperty(self.encodeSesssion, kVTCompressionPropertyKey_RealTime, kCFBooleanTrue);
    
    //图片进行压缩后每秒显示的数据量。
    //设置码率(码率:编码效率,码率越高,则画面越清晰,如果码率较低则会引起马赛克 -->码率高有利于还原原始画面,但是不利于传输)
    int bitRate = 800 * 1024;
    CFNumberRef bitRateRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bitRate);
    VTSessionSetProperty(self.encodeSesssion, kVTCompressionPropertyKey_AverageBitRate, bitRateRef);
    
    NSArray *limit = @[@(bitRate * 1.5/8),@(1)];
    VTSessionSetProperty(self.encodeSesssion, kVTCompressionPropertyKey_DataRateLimits, (__bridge CFArrayRef)limit);
    
    
//    VTSessionSetProperty(self.encodeSesssion, kVTCompressionPropertyKey_ProfileLevel, );
    
    //设置期望帧率(每秒多少帧,如果帧率过低,会造成画面卡顿)
    int fps = 30;
    CFNumberRef fpsRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &fps);
    VTSessionSetProperty(self.encodeSesssion, kVTCompressionPropertyKey_ExpectedFrameRate, fpsRef);
    
    //设置关键帧（GOPsize)间隔
    int frameInterval = 30;
    CFNumberRef frameRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &frameInterval);
    VTSessionSetProperty(self.encodeSesssion, kVTCompressionPropertyKey_MaxKeyFrameInterval, frameRef);
    
#pragma mark - PrepareEncode
    VTCompressionSessionPrepareToEncodeFrames(_encodeSesssion);
    
}

#pragma mark - EncodeFrame
- (void)encodeSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    
    //1.获取CVImageBuffer作为编码的参数之一
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    //2.CMTime 创建时间,更新当前的帧数
    CMTime presenttationTimeStamp = CMTimeMake(self.frameID++, 1000);
    
    //3.VTEncodeInfoFlags
    VTEncodeInfoFlags flags;
    
    //编码
    OSStatus status = VTCompressionSessionEncodeFrame(_encodeSesssion, imageBuffer, presenttationTimeStamp, kCMTimeInvalid, NULL, (__bridge void *)(self), &flags);
    if (status != noErr) {
        NSLog(@"VTCompressionSessionEncodeFrame Failed!");
    }
}

#pragma mark - CallBack
void didCompressionOutputCallback(void *outputCallbackRefCon,void *sourceFrameRefCon,OSStatus status,VTEncodeInfoFlags infoFlags,CMSampleBufferRef sampleBuffer ){
    
    //1.判断状态
    if (status != noErr) {
        NSLog(@"callBack failed!");
        return;
    }
    
    //2.获取传入的参数
    VideoEncode *encode = (__bridge VideoEncode *)outputCallbackRefCon;
    
    //3.判断是否是关键帧
    CFArrayRef arrayRef = CMSampleBufferGetSampleAttachmentsArray(sampleBuffer, true);
    bool isKeyFrame = !(CFDictionaryContainsKey(CFArrayGetValueAtIndex(arrayRef, 0), kCMSampleAttachmentKey_NotSync));
    
    //4.获取SPS PPS数据
    if (isKeyFrame) {
        //获取编码后的信息(存储于CMFormatDescriptionRef中)
        CMFormatDescriptionRef format = CMSampleBufferGetFormatDescription(sampleBuffer);
        
        //获取SPS信息
        size_t sparameterSetSize,sparameterSetCount;
        const uint8_t *sparameterSet;
        CMVideoFormatDescriptionGetH264ParameterSetAtIndex(format, 0, &sparameterSet, &sparameterSetSize, &sparameterSetCount, 0);
        
        //获取PPS信息
        size_t pparameterSetSize,pparameterSetCount;
        const uint8_t *pparameterSet;
        CMVideoFormatDescriptionGetH264ParameterSetAtIndex(format, 1, &pparameterSet, &pparameterSetSize, &pparameterSetCount, 0);
        
        //转成NSData数据,写入文件
        NSData *sps = [NSData dataWithBytes:sparameterSet length:sparameterSetSize];
        NSData *pps = [NSData dataWithBytes:pparameterSet length:pparameterSetSize];
        
        //写入文件
        [encode gotSps:sps pps:pps];
    }
    
    //5.获取数据块
    CMBlockBufferRef dataBuffer = CMSampleBufferGetDataBuffer(sampleBuffer);
    size_t length,totalLength;
    char *dataPointer;
    OSStatus statusCodeRet = CMBlockBufferGetDataPointer(dataBuffer, 0, &length, &totalLength, &dataPointer);
    
    if (statusCodeRet == noErr) {
        size_t bufferOffset = 0;
        //返回的NALU数据前四个字节不是0001的startCode,而是大端模式的帧长度length
        static const int AVCCHeaderLength = 4;
        
        //循环获取NALU数据
        while (bufferOffset < totalLength - AVCCHeaderLength) {
            uint32_t NALUnitLength = 0;
            
            //读取NAL unit length
            memcpy(&NALUnitLength, dataPointer + bufferOffset, AVCCHeaderLength);
            
            //从大端转系统端
            NALUnitLength = CFSwapInt32BigToHost(NALUnitLength);
            
            NSData *data = [[NSData alloc]initWithBytes:(dataPointer + bufferOffset + AVCCHeaderLength) length:NALUnitLength];
            [encode gotEncodedData:data];
            
            // 移动到写一个块，转成NALU单元
            // Move to the next NAL unit in the block buffer
            bufferOffset += AVCCHeaderLength + NALUnitLength;
        }
    }
    
}
//SPS PPS
- (void)gotSps:(NSData *)sps pps:(NSData *)pps{
    // 1.拼接NALU的header
    const char bytes[] = "\x00\x00\x00\x01";
    size_t length = (sizeof(bytes) - 1);
    NSData *byteHeader = [NSData dataWithBytes:bytes length:length];
    
    //2.将NALU的头&NALU的体写入文件
    [self.fileHandle writeData:byteHeader];
    [self.fileHandle writeData:sps];
    [self.fileHandle writeData:byteHeader];
    [self.fileHandle writeData:pps];
    
}
//数据
- (void)gotEncodedData:(NSData *)data{
    NSLog(@"length:%d",(int )[data length]);
    
    if (self.fileHandle != NULL) {
        const char bytes[] = "\x00\x00\x00\x01";
        //String literals have implicit trailing '\0'
        size_t length = (sizeof(bytes) - 1);
        NSData *byteHeader = [NSData dataWithBytes:bytes length:length];
        [self.fileHandle writeData:byteHeader];
        [self.fileHandle writeData:data];
    }
}
#pragma mark - CompleteFrame&&Invilidate&&Release
//结束编码
- (void)endEncode{
    
    VTCompressionSessionCompleteFrames(_encodeSesssion, kCMTimeInvalid);
    VTCompressionSessionInvalidate(_encodeSesssion);
    CFRelease(_encodeSesssion);
    _encodeSesssion = NULL;
    _frameID = 0;
    
}

@end
