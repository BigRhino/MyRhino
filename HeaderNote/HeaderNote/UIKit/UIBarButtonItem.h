//
//  UIBarButtonItem.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/18.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef UIBarButtonItem_h
#define UIBarButtonItem_h



#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIBarItem.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIAppearance.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIBarCommon.h>
#import <UIKit/UISpringLoadedInteractionSupporting.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UIBarButtonItemStyle) {
    UIBarButtonItemStylePlain,  //扁平的
    UIBarButtonItemStyleBordered NS_ENUM_DEPRECATED_IOS(2_0, 8_0, "Use UIBarButtonItemStylePlain when minimum deployment target is iOS7 or later"),
    UIBarButtonItemStyleDone,
};
//UIBarButtonSystemItemFlexibleSpace,可伸缩宽度的空白间隔,默认会"努力占据"更多的宽度.比如,最后一个按钮前面插入UIBarButtonSystemItemFlexibleSpace,即可把最后一个按钮,挤到最右边. 若想放置中间,可以左右两边各方一个FlexibleSpace
//UIBarButtonSystemItemFixedSpace 固定宽度的空白间隔

//系统BarButtonItem样式
typedef NS_ENUM(NSInteger, UIBarButtonSystemItem) {
    UIBarButtonSystemItemDone,           //Done完成风格
    UIBarButtonSystemItemCancel,         //Cancle 取消
    UIBarButtonSystemItemEdit,           //Edit 编辑
    UIBarButtonSystemItemSave,           //save 保存
    UIBarButtonSystemItemAdd,            //添加 +风格
    UIBarButtonSystemItemFlexibleSpace, //占位 空白间隔  不显示  自由宽度占位符，会将所有空间平分，不需要指定宽度
    UIBarButtonSystemItemFixedSpace,    //占位 空白间隔  固定宽度的占位符，必须指定它的宽度
    UIBarButtonSystemItemCompose,       //构图风格
    UIBarButtonSystemItemReply,        //类似回退
    UIBarButtonSystemItemAction,       //类似分享
    UIBarButtonSystemItemOrganize,     //类似文件夹
    UIBarButtonSystemItemBookmarks,    //书签
    UIBarButtonSystemItemSearch,       //搜索
    UIBarButtonSystemItemRefresh,      //刷新
    UIBarButtonSystemItemStop,         //停止
    UIBarButtonSystemItemCamera,       //相机
    UIBarButtonSystemItemTrash,        //垃圾桶
    UIBarButtonSystemItemPlay,         //播放
    UIBarButtonSystemItemPause,        //暂停
    UIBarButtonSystemItemRewind,       //快退
    UIBarButtonSystemItemFastForward,  //快进
    UIBarButtonSystemItemUndo NS_ENUM_AVAILABLE_IOS(3_0),  //Undo
    UIBarButtonSystemItemRedo NS_ENUM_AVAILABLE_IOS(3_0),  //Redo
    UIBarButtonSystemItemPageCurl NS_ENUM_DEPRECATED_IOS(4_0, 11_0) //Page
};

@class UIImage, UIView;


NS_CLASS_AVAILABLE_IOS(2_0) @interface UIBarButtonItem : UIBarItem <NSCoding>

//构造函数
- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
//图片,样式,对象,对象动作
- (instancetype)initWithImage:(nullable UIImage *)image style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action;
- (instancetype)initWithImage:(nullable UIImage *)image landscapeImagePhone:(nullable UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action NS_AVAILABLE_IOS(5_0); // landscapeImagePhone will be used for the bar button image when the bar has Compact or Condensed bar metrics.

//使用系统样式创建
- (instancetype)initWithTitle:(nullable NSString *)title style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action;
- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(nullable id)target action:(nullable SEL)action;

//自定义控件
- (instancetype)initWithCustomView:(UIView *)customView;

//样式
@property(nonatomic)         UIBarButtonItemStyle style;            // default is UIBarButtonItemStylePlain
//宽度 默认 0
@property(nonatomic)         CGFloat              width;            // default is 0.0
//
@property(nullable, nonatomic,copy)    NSSet<NSString *>   *possibleTitles;   // default is nil
//
@property(nullable, nonatomic,strong)  __kindof UIView     *customView;       // default is nil
//执行动作
@property(nullable, nonatomic)         SEL                  action;           // default is NULL
//执行目标对象
@property(nullable, nonatomic,weak)    id                   target;           // default is nil

//
// Appearance modifiers
//

/* Send these messages to the [UIBarButtonItem appearance] proxy to customize all buttons, or, to customize a specific button, send them to a specific UIBarButtonItem instance, which may be used in all the usual places in a UINavigationItem (backBarButtonItem, leftBarButtonItem, rightBarButtonItem) or a UIToolbar.
 */

/* In general, you should specify a value for the normal state to be used by other states which don't have a custom value set.
 
 Similarly, when a property is dependent on the bar metrics (on the iPhone in landscape orientation, bars have a different height from standard), be sure to specify a value for UIBarMetricsDefault.
 
 This sets the background image for buttons of any style.
 */
- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)backgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* This sets the background image for buttons with a specific style. When calling this on a UIBarButtonItem instance, the style argument must match the button's style; when calling on the UIAppearance proxy, any style may be passed.
 */
- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)backgroundImageForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;

@property(nullable, nonatomic,strong) UIColor *tintColor NS_AVAILABLE_IOS(5_0);

/* For adjusting the vertical centering of bordered bar buttons within the bar
 */
- (void)setBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (CGFloat)backgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* For adjusting the position of a title (if any) within a bordered bar button
 */
- (void)setTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (UIOffset)titlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* The remaining appearance modifiers apply solely to UINavigationBar back buttons and are ignored by other buttons.
 */
/*
 backgroundImage must be a resizable image for good results.
 */
- (void)setBackButtonBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;
- (nullable UIImage *)backButtonBackgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;

- (void)setBackButtonTitlePositionAdjustment:(UIOffset)adjustment forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;
- (UIOffset)backButtonTitlePositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;

/* For adjusting the vertical centering of bordered bar buttons within the bar
 */
- (void)setBackButtonBackgroundVerticalPositionAdjustment:(CGFloat)adjustment forBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;
- (CGFloat)backButtonBackgroundVerticalPositionAdjustmentForBarMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;

@end

#if TARGET_OS_IOS
@interface UIBarButtonItem (SpringLoading) <UISpringLoadedInteractionSupporting>
@end
#endif

NS_ASSUME_NONNULL_END



#endif /* UIBarButtonItem_h */
