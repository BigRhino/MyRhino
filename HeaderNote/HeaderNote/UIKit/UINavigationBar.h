//
//  UINavigationBar.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/18.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef UINavigationBar_h
#define UINavigationBar_h

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIView.h>
#import <UIKit/UIInterface.h>
#import <UIKit/UIFont.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIBarCommon.h>
#import <UIKit/UINavigationItem.h>

NS_ASSUME_NONNULL_BEGIN

@class UINavigationItem, UIBarButtonItem, UIImage, UIColor;
@protocol UINavigationBarDelegate;
/*
 导航栏
 用于显示当前栈顶的标题和一些交互按钮,通常位于屏幕顶端的空间,继承自UIView,作为UINavigationItem的容器,以stack的结构形式来管理多个UINavigationItem对象.
 
 */
NS_CLASS_AVAILABLE_IOS(2_0) @interface UINavigationBar : UIView <NSCoding, UIBarPositioning>

//导航条样式 默认 白色|黑色
@property(nonatomic,assign) UIBarStyle barStyle UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;
//代理
@property(nullable,nonatomic,weak) id<UINavigationBarDelegate> delegate;

/*
 New behavior on iOS 7.
 Default is YES.
 You may force an opaque background by setting the property to NO.
 If the navigation bar has a custom background image, the default is inferred
 from the alpha values of the image—YES if it has any pixel with alpha < 1.0
 If you send setTranslucent:YES to a bar with an opaque custom background image
 it will apply a system opacity less than 1.0 to the image.
 If you send setTranslucent:NO to a bar with a translucent custom background image
 it will provide an opaque background for the image using the bar's barTintColor if defined, or black
 for UIBarStyleBlack or white for UIBarStyleDefault if barTintColor is nil.
 */

//是否透明 iOS7以后默认是透明的
@property(nonatomic,assign,getter=isTranslucent) BOOL translucent NS_AVAILABLE_IOS(3_0) UI_APPEARANCE_SELECTOR; // Default is NO on iOS 6 and earlier. Always YES if barStyle is set to UIBarStyleBlackTranslucent

// Pushing a navigation item displays the item's title in the center of the navigation bar.
// The previous top navigation item (if it exists) is displayed as a "back" button on the left.

//将新的UINavigationItem 压入栈
- (void)pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated;
//将UINavigationBar栈顶的UINavigationItem弹出栈
- (nullable UINavigationItem *)popNavigationItemAnimated:(BOOL)animated; // Returns the item that was popped.

//最顶层的UINavigationItem
@property(nullable, nonatomic,readonly,strong) UINavigationItem *topItem;
//最顶层下面的UINavigationItem
@property(nullable, nonatomic,readonly,strong) UINavigationItem *backItem;

//设置UINavigationItems
@property(nullable,nonatomic,copy) NSArray<UINavigationItem *> *items;
- (void)setItems:(nullable NSArray<UINavigationItem *> *)items animated:(BOOL)animated; // If animated is YES, then simulate a push or pop depending on whether the new top item was previously in the stack.

/// When set to YES, the navigation bar will use a larger out-of-line title view when requested by the current navigation item. To specify when the large out-of-line title view appears, see UINavigationItem.largeTitleDisplayMode. Defaults to NO.
@property (nonatomic, readwrite, assign) BOOL prefersLargeTitles UI_APPEARANCE_SELECTOR API_AVAILABLE(ios(11.0)); //API_UNAVAILABLE(tvos)

/*
 The behavior of tintColor for bars has changed on iOS 7.0. It no longer affects the bar's background
 and behaves as described for the tintColor property added to UIView.
 To tint the bar's background, please use -barTintColor.
 */
//镂空颜色(iOS7之后不仅仅会改变背景颜色,还会影响子视图的tintColor属性)
@property(null_resettable, nonatomic,strong) UIColor *tintColor;
//导航条背景颜色
@property(nullable, nonatomic,strong) UIColor *barTintColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // default is nil

/* In general, you should specify a value for the normal state to be used by other states which don't have a custom value set.
 
 Similarly, when a property is dependent on the bar metrics (on the iPhone in landscape orientation, bars have a different height from standard), be sure to specify a value for UIBarMetricsDefault.
 */

//设置导航条背景图片 第三个参数:用来控制在不同状态下导航栏的显示。
//    UIBarMetricsDefault,    //纵屏
//    UIBarMetricsCompact,    //横屏
//    UIBarMetricsDefaultPrompt  //纵屏带备注
//    UIBarMetricsCompactPrompt  //横屏带备注

- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
//获取
- (nullable UIImage *)backgroundImageForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;

/*
 Same as using UIBarPositionAny in -setBackgroundImage:forBarPosition:barMetrics. Resizable images will be stretched
 vertically if necessary when the navigation bar is in the position UIBarPositionTopAttached.
 */
- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)backgroundImageForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* Default is nil. When non-nil, a custom shadow image to show instead of the default shadow image. For a custom shadow to be shown, a custom background image must also be set with -setBackgroundImage:forBarMetrics: (if the default background image is used, the default shadow image will be used).
 */
//阴影图片
@property(nullable, nonatomic,strong) UIImage *shadowImage NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;

/* You may specify the font, text color, and shadow properties for the title in the text attributes dictionary, using the keys found in NSAttributedString.h.
 */
//导航条的标题文本属性，可以设置多项文本相关的属性
@property(nullable,nonatomic,copy) NSDictionary<NSString *,id> *titleTextAttributes NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

//// 根据屏幕状态设置标题的垂直偏移量
- (void)setTitleVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
//// 根据屏幕状态获得标题的垂直偏移量
- (CGFloat)titleVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/*
 The back indicator image is shown beside the back button.
 The back indicator transition mask image is used as a mask for content during push and pop transitions
 Note: These properties must both be set if you want to customize the back indicator image.
 */

//返回效果图片,两个都需要设置,才有效果
@property(nullable,nonatomic,strong) UIImage *backIndicatorImage NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;
@property(nullable,nonatomic,strong) UIImage *backIndicatorTransitionMaskImage NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;

@end

@protocol UINavigationBarDelegate <UIBarPositioningDelegate>

@optional
 // 是否支持pushItem，如果返回NO就不能。
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item; // called to push. return NO not to.
//// pushItem时会调用的函数
- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item;    // called at end of animation of push or immediately if not animated
//// 是否支持popItem，如果返回NO就不能。
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item;  // same as push methods
//// popItem时会调用的函数
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item;

@end

NS_ASSUME_NONNULL_END



#endif /* UINavigationBar_h */
