//
//  VideoCaptuer.m
//  VideoToolBox
//
//  Created by Rhino on 2017/7/8.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "VideoCaptuer.h"
#import <AVFoundation/AVFoundation.h>
#import "H264Encode.h"

@interface VideoCaptuer()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) H264Encode *encoder;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preViewLayer;

@property (nonatomic, strong) dispatch_queue_t captureQueue;

@end

@implementation VideoCaptuer

- (void)startCapturing:(UIView *)preView{
    
    //---------准备编码---------------
    self.encoder = [[H264Encode alloc]init];
    //录制方向为竖屏,1280*720 所以这里写成720*1280
    [self.encoder prepareEncodeWithWidth:720 height:1280];
    
    //---------视频采集----------------
    
    //1.初始化捕捉对象
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPreset1280x720];
    self.session = session;
    
    //2.设置视频的输入  默认后置摄像头
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if ([session canAddInput:inputDevice]) {
        [session addInput:inputDevice];
    }
    //3.设置视频的输出
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc]init];
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    [output setAlwaysDiscardsLateVideoFrames:YES];
    //设置代理
    self.captureQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [output setSampleBufferDelegate:self queue:self.captureQueue];
    
    //设置视频录制方向
    AVCaptureConnection *connection = [output connectionWithMediaType:AVMediaTypeVideo];
    if(connection.isVideoOrientationSupported){
        //竖屏
        [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    }else{
        NSLog(@"不支持设置方向");
    };
    
    
    //4.设置预览图层
    self.preViewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
    self.preViewLayer.frame = preView.bounds;
    [preView.layer insertSublayer:self.preViewLayer atIndex:0];
    
    //5.开始采集
    [session startRunning];
    
}


- (void)stopCapturing{
    [self.session stopRunning];
    [self.preViewLayer removeFromSuperlayer];
    //[self.encoder endEncode];
}

//如果出现丢帧
- (void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
}
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    NSLog(@"采集到视频画面");
    [self.encoder encodeFrame:sampleBuffer];
}


@end
