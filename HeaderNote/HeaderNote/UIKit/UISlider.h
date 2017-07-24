//
//  UISlider.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/22.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef UISlider_h
#define UISlider_h

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIKitDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImageView, UIImage;

//滑块 进度条
NS_CLASS_AVAILABLE_IOS(2_0) __TVOS_PROHIBITED @interface UISlider : UIControl <NSCoding>

//当前值 0 ---- 1.0
@property(nonatomic) float value;                                 // default 0.0. this value will be pinned to min/max
//最小值 0
@property(nonatomic) float minimumValue;                          // default 0.0. the current value may change if outside new min value
//最大值 1.0
@property(nonatomic) float maximumValue;                          // default 1.0. the current value may change if outside new max value

//最小值位置的图片
@property(nullable, nonatomic,strong) UIImage *minimumValueImage;          // default is nil. image that appears to left of control (e.g. speaker off)
//最大值位置的图片
@property(nullable, nonatomic,strong) UIImage *maximumValueImage;          // default is nil. image that appears to right of control (e.g. speaker max)

//*/***** 默认YES 滑动滑块会连续调用触发方法,设置为NO 则只会拖动结束后调用一次
@property(nonatomic,getter=isContinuous) BOOL continuous;        // if set, value change events are generated any time the value changes due to dragging. default = YES

//滑块左边部分的颜色
@property(nullable, nonatomic,strong) UIColor *minimumTrackTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
//滑块右边部分的颜色
@property(nullable, nonatomic,strong) UIColor *maximumTrackTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
//滑块的颜色
@property(nullable, nonatomic,strong) UIColor *thumbTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

//设置当前值
- (void)setValue:(float)value animated:(BOOL)animated; // move slider at fixed velocity (i.e. duration depends on distance). does not send action

// set the images for the slider. there are 3, the thumb which is centered by default and the track. You can specify different left and right track
// e.g blue on the left as you increase and white to the right of the thumb. The track images should be 3 part resizable (via UIImage's resizableImage methods) along the direction that is longer

//设置滑块的图片
- (void)setThumbImage:(nullable UIImage *)image forState:(UIControlState)state;
//设置滑块左边的图片
- (void)setMinimumTrackImage:(nullable UIImage *)image forState:(UIControlState)state;
//设置滑块右边的图片
- (void)setMaximumTrackImage:(nullable UIImage *)image forState:(UIControlState)state;

//获取相关图片
- (nullable UIImage *)thumbImageForState:(UIControlState)state;
- (nullable UIImage *)minimumTrackImageForState:(UIControlState)state;
- (nullable UIImage *)maximumTrackImageForState:(UIControlState)state;

//当前状态下的图片...
@property(nullable,nonatomic,readonly) UIImage *currentThumbImage;
@property(nullable,nonatomic,readonly) UIImage *currentMinimumTrackImage;
@property(nullable,nonatomic,readonly) UIImage *currentMaximumTrackImage;

// lets a subclass lay out the track and thumb as needed
- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds;
- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds;
- (CGRect)trackRectForBounds:(CGRect)bounds;
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value;

@end

NS_ASSUME_NONNULL_END


#endif /* UISlider_h */
