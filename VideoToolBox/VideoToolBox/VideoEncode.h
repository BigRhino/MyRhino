//
//  VideoEncode.h
//  VideoToolBox
//
//  Created by Rhino on 2017/7/8.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>

@interface VideoEncode : NSObject

-(void)encodeSampleBuffer:(CMSampleBufferRef)sampleBuffer;

-(void)endEncode;

@end
