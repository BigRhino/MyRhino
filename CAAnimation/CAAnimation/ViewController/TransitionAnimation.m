//
//  TransitionAnimation.m
//  CAAnimation
//
//  Created by Rhino on 2017/7/14.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "TransitionAnimation.h"
#import <UIKit/UIKit.h>

@interface TransitionAnimation()<UIViewControllerAnimatedTransitioning> //<UINavigationControllerDelegate>

@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation TransitionAnimation

//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
//
//}


// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    
    return self.duration;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
}


@end
