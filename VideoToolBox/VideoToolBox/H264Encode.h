//
//  H264Encode.h
//  VideoToolBox
//
//  Created by Rhino on 2017/7/17.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface H264Encode : NSObject

- (void)prepareEncodeWithWidth:(int )width height:(int)height;

- (void)encodeFrame:(CMSampleBufferRef)sampleBuffer;


@end
