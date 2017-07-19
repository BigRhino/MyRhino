
//
//  UIToolbar.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/18.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef UIToolbar_h
#define UIToolbar_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIView.h>
#import <UIKit/UIInterface.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIBarButtonItem.h>
#import <UIKit/UIBarCommon.h>

NS_ASSUME_NONNULL_BEGIN

@class UIBarButtonItem, UIColor;
@protocol UIToolbarDelegate;


//工具条
//UINavigationController导航控制器中包含UIToolBar对象,只是被隐藏了
//应用场景:
//1.输入框的inputAccessoryView,显示在键盘的上方,用来辅助编辑
//2.网页浏览器,回退,刷新,书签等操作

NS_CLASS_AVAILABLE_IOS(2_0) __TVOS_PROHIBITED @interface UIToolbar : UIView <UIBarPositioning>

//样式
@property(nonatomic) UIBarStyle barStyle UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED; // default is UIBarStyleDefault

//工具条items 包含多个UIBarButtonItem对象,一个UIBarButtonItem相当于工具条上的一个控件
@property(nullable, nonatomic, copy) NSArray<UIBarButtonItem *> *items; // get/set visible UIBarButtonItem. default is nil. changes not animated. shown in order

/*
 New behavior on iOS 7.
 Default is YES.
 You may force an opaque background by setting the property to NO.
 If the toolbar has a custom background image, the default is inferred
 from the alpha values of the image—YES if it has any pixel with alpha < 1.0
 If you send setTranslucent:YES to a bar with an opaque custom background image
 it will apply a system opacity less than 1.0 to the image.
 If you send setTranslucent:NO to a bar with a translucent custom background image
 it will provide an opaque background for the image using the bar's barTintColor if defined, or black
 for UIBarStyleBlack or white for UIBarStyleDefault if barTintColor is nil.
 */
//是否透明
@property(nonatomic,assign,getter=isTranslucent) BOOL translucent NS_AVAILABLE_IOS(3_0) UI_APPEARANCE_SELECTOR; // Default is NO on iOS 6 and earlier. Always YES if barStyle is set to UIBarStyleBlackTranslucent

//包含的按钮(UIBarButtonItem)
- (void)setItems:(nullable NSArray<UIBarButtonItem *> *)items animated:(BOOL)animated;   // will fade in or out or reorder and adjust spacing

/*
 The behavior of tintColor for bars has changed on iOS 7.0. It no longer affects the bar's background
 and behaves as described for the tintColor property added to UIView.
 To tint the bar's background, please use -barTintColor.
 */
//镂空颜色
@property(null_resettable, nonatomic, strong) UIColor *tintColor;
//背景颜色
@property(nullable, nonatomic, strong) UIColor *barTintColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // default is nil

/* Use these methods to set and access custom background images for toolbars.
 Default is nil. When non-nil the image will be used instead of the system image for toolbars in the
 specified position.
 For the barMetrics argument, UIBarMetricsDefault is the fallback.
 
 DISCUSSION: Interdependence of barStyle, tintColor, backgroundImage.
 When barStyle or tintColor is set as well as the bar's background image,
 the bar buttons (unless otherwise customized) will inherit the underlying
 barStyle or tintColor.
 */
//设置 获取背景图片
- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forToolbarPosition:(UIBarPosition)topOrBottom barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)backgroundImageForToolbarPosition:(UIBarPosition)topOrBottom barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* Default is nil. When non-nil, a custom shadow image to show instead of the default shadow image. For a custom shadow to be shown, a custom background image must also be set with -setBackgroundImage:forToolbarPosition:barMetrics: (if the default background image is used, the default shadow image will be used).
 */
//设置,获取阴影图片
- (void)setShadowImage:(nullable UIImage *)shadowImage forToolbarPosition:(UIBarPosition)topOrBottom NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)shadowImageForToolbarPosition:(UIBarPosition)topOrBottom NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;

@property(nullable, nonatomic, weak) id<UIToolbarDelegate> delegate NS_AVAILABLE_IOS(7_0); // You may not set the delegate when the toolbar is managed by a UINavigationController.
@end

__TVOS_PROHIBITED
@protocol UIToolbarDelegate <UIBarPositioningDelegate>
@end

NS_ASSUME_NONNULL_END



#endif /* UIToolbar_h */
