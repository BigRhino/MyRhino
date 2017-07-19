//
//  UIView+Transition.h
//  CAAnimation
//
//  Created by Rhino on 2017/7/16.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    TransitionTypeCameraIris = 0,
    TransitionTypeCube,
    TransitionTypeFade,
    TransitionTypeMoveIn,
    TransitionTypeOglFilp,
    TransitionTypePageCurl,
    TransitionTypePageUnCurl,
    TransitionTypePush,
    TransitionTypeReveal,
    TransitionTypeRippleEffect,
    TransitionTypeSuckEffect
} TransitionType;

typedef enum {
    TransitionSubTypeFromLeft = 0,
    TransitionSubTypeFromRight,
    TransitionSubTypeFromTop,
    TransitionSubTypeFromBottom
} TransitionSubType;


@interface UIView (Transition)

- (void)transitionWithType:(TransitionType)type andSubType:(TransitionSubType)subType andDuration:(NSTimeInterval)interval;


@end
