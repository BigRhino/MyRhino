//
//  UIView+Transition.m
//  CAAnimation
//
//  Created by Rhino on 2017/7/16.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "UIView+Transition.h"

@implementation UIView (Transition)

//私有API
- (void)transitionWithType:(TransitionType)type andSubType:(TransitionSubType)subType andDuration:(NSTimeInterval)interval{
    
    NSArray * typeArr = @[@"cameraIris",
                          @"cube",
                          @"fade",
                          @"moveIn",
                          @"oglFilp",
                          @"pageCurl",
                          @"pageUnCurl",
                          @"push",
                          @"reveal",
                          @"rippleEffect",
                          @"suckEffect"];
    
    NSArray * subTypeArr = @[@"fromLeft", @"fromRight", @"fromTop", @"fromBottom"];
    
    CATransition * trans = [CATransition animation];
    trans.duration = interval;
    trans.type = typeArr[type];
    trans.subtype = subTypeArr[subType];
    [self.layer addAnimation:trans forKey:nil];
}

@end
