//
//  UISegmentedControl.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/24.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef UISegmentedControl_h
#define UISegmentedControl_h

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIGeometry.h>
#import <UIKit/UIBarButtonItem.h>
#import <UIKit/UISpringLoadedInteractionSupporting.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UISegmentedControlStyle) {
    UISegmentedControlStylePlain,     // large plain
    UISegmentedControlStyleBordered,  // large bordered
    UISegmentedControlStyleBar,       // small button/nav bar style. tintable
    UISegmentedControlStyleBezeled,   // DEPRECATED. Do not use this style.
} NS_DEPRECATED_IOS(2_0, 7_0, "The segmentedControlStyle property no longer has any effect") __TVOS_PROHIBITED;

enum {
    UISegmentedControlNoSegment = -1   // segment index for no selected segment
};

typedef NS_ENUM(NSInteger, UISegmentedControlSegment) {
    UISegmentedControlSegmentAny = 0,
    UISegmentedControlSegmentLeft = 1,   // The capped, leftmost segment. Only applies when numSegments > 1.
    UISegmentedControlSegmentCenter = 2, // Any segment between the left and rightmost segments. Only applies when numSegments > 2.
    UISegmentedControlSegmentRight = 3,  // The capped,rightmost segment. Only applies when numSegments > 1.
    UISegmentedControlSegmentAlone = 4,  // The standalone segment, capped on both ends. Only applies when numSegments = 1.
};

@class UIImage, UIColor;

NS_CLASS_AVAILABLE_IOS(2_0) @interface UISegmentedControl : UIControl <NSCoding>

///构造函数,传入一个字符串数组或者UIImages.自动根据内容适应尺寸
- (instancetype)initWithItems:(nullable NSArray *)items; // items can be NSStrings or UIImages. control is automatically sized to fit content
//样式  失效_没有任何效果
@property(nonatomic) UISegmentedControlStyle segmentedControlStyle NS_DEPRECATED_IOS(2_0, 7_0, "The segmentedControlStyle property no longer has any effect") __TVOS_PROHIBITED;

//默认NO 决定了其"切换"功能的本质,用户点击某个模块按钮时,按钮会保持选中状态,设置为YES,当用户手指离开屏幕,按钮的选中状态会消失.
@property(nonatomic,getter=isMomentary) BOOL momentary;             // if set, then we don't keep showing selected state after tracking ends. default is NO
//内容(按钮)个数
@property(nonatomic,readonly) NSUInteger numberOfSegments;

// For segments whose width value is 0, setting this property to YES attempts to adjust segment widths based on their content widths. Default is NO.
//设置每个按钮的宽度自适应//默认为NO
@property(nonatomic) BOOL apportionsSegmentWidthsByContent NS_AVAILABLE_IOS(5_0);

//插入一个按钮
- (void)insertSegmentWithTitle:(nullable NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated; // insert before segment number. 0..#segments. value pinned
//插入一个UIImage类型的按钮
- (void)insertSegmentWithImage:(nullable UIImage *)image  atIndex:(NSUInteger)segment animated:(BOOL)animated;
//删除指定下标位置的按钮
- (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated;
//删除所有元素
- (void)removeAllSegments;

//设置|获取指定下标的元素标题
- (void)setTitle:(nullable NSString *)title forSegmentAtIndex:(NSUInteger)segment;      // can only have image or title, not both. must be 0..#segments - 1 (or ignored). default is nil
- (nullable NSString *)titleForSegmentAtIndex:(NSUInteger)segment;

//设置|获取指定下标的元素图片
- (void)setImage:(nullable UIImage *)image forSegmentAtIndex:(NSUInteger)segment;       // can only have image or title, not both. must be 0..#segments - 1 (or ignored). default is nil
- (nullable UIImage *)imageForSegmentAtIndex:(NSUInteger)segment;

//默认所有元素的宽度是相等的,内容过长的会省略为....
//设置|获取指定下标元素的宽度
- (void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment;         // set to 0.0 width to autosize. default is 0.0
- (CGFloat)widthForSegmentAtIndex:(NSUInteger)segment;


//自定义|获取 按钮中内容的位置(图片或者文字)
- (void)setContentOffset:(CGSize)offset forSegmentAtIndex:(NSUInteger)segment; // adjust offset of image or text inside the segment. default is (0,0)
- (CGSize)contentOffsetForSegmentAtIndex:(NSUInteger)segment;

//设置按钮是否有效(可点击)
- (void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment;        // default is YES
- (BOOL)isEnabledForSegmentAtIndex:(NSUInteger)segment;

// ignored in momentary mode. returns last segment pressed. default is UISegmentedControlNoSegment until a segment is pressed
// the UIControlEventValueChanged action is invoked when the segment changes via a user event. set to UISegmentedControlNoSegment to turn off selection
//选中的下标 默认没有选中下标
@property(nonatomic) NSInteger selectedSegmentIndex;

// The tintColor is inherited through the superview hierarchy. See UIView for more information.
//镂空颜色
@property(null_resettable,nonatomic,strong) UIColor *tintColor;

/* If backgroundImage is an image returned from -[UIImage resizableImageWithCapInsets:] the cap widths will be calculated from that information, otherwise, the cap width will be calculated by subtracting one from the image's width then dividing by 2. The cap widths will also be used as the margins for text placement. To adjust the margin use the margin adjustment methods.
 
 In general, you should specify a value for the normal state to be used by other states which don't have a custom value set.
 
 Similarly, when a property is dependent on the bar metrics, be sure to specify a value for UIBarMetricsDefault.
 In the case of the segmented control, appearance properties for UIBarMetricsCompact are only respected for segmented controls in the smaller navigation and toolbars.
 */
//设置|获取背景图片
- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)backgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* To customize the segmented control appearance you will need to provide divider images to go between two unselected segments (leftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal), selected on the left and unselected on the right (leftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal), and unselected on the left and selected on the right (leftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected).
 */
//设置|获取分割部分(间距)图片
- (void)setDividerImage:(nullable UIImage *)dividerImage forLeftSegmentState:(UIControlState)leftState rightSegmentState:(UIControlState)rightState barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)dividerImageForLeftSegmentState:(UIControlState)leftState rightSegmentState:(UIControlState)rightState barMetrics:(UIBarMetrics)barMetrics  NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* You may specify the font, text color, and shadow properties for the title in the text attributes dictionary, using the keys found in NSAttributedString.h.
 */
//设置|获取文本描述属性
- (void)setTitleTextAttributes:(nullable NSDictionary *)attributes forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable NSDictionary *)titleTextAttributesForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* For adjusting the position of a title or image within the given segment of a segmented control.
 */
//设置|获取内容偏移量
- (void)setContentPositionAdjustment:(UIOffset)adjustment forSegmentType:(UISegmentedControlSegment)leftCenterRightOrAlone barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (UIOffset)contentPositionAdjustmentForSegmentType:(UISegmentedControlSegment)leftCenterRightOrAlone barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

@end

#if TARGET_OS_IOS
@interface UISegmentedControl (SpringLoading) <UISpringLoadedInteractionSupporting>
@end
#endif

NS_ASSUME_NONNULL_END



#endif /* UISegmentedControl_h */
