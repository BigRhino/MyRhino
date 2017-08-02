//
//  VideoCaptuer.h
//  VideoToolBox
//
//  Created by Rhino on 2017/7/8.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VideoCaptuer : NSObject

- (void)startCapturing:(UIView *)preView;

- (void)stopCapturing;


@end
