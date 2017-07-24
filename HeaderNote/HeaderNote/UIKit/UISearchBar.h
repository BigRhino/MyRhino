//
//  UISearchBar.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/22.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef UISearchBar_h
#define UISearchBar_h

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import <UIKit/UIInterface.h>
#import <UIKit/UIGeometry.h>
#import <UIKit/UITextField.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIBarButtonItem.h>
#import <UIKit/UIBarCommon.h>

NS_ASSUME_NONNULL_BEGIN

//搜索条icon图片
typedef NS_ENUM(NSInteger, UISearchBarIcon) {
    //搜索
    UISearchBarIconSearch, // The magnifying glass
    //清除
    UISearchBarIconClear __TVOS_PROHIBITED, // The circle with an x in it
    //书签
    UISearchBarIconBookmark __TVOS_PROHIBITED, // The open book icon
    //搜索结果
    UISearchBarIconResultsList __TVOS_PROHIBITED, // The list lozenge icon
};
//风格
typedef NS_ENUM(NSUInteger, UISearchBarStyle) {
    UISearchBarStyleDefault,    // currently UISearchBarStyleProminent
    UISearchBarStyleProminent,  // used my Mail, Messages and Contacts
    UISearchBarStyleMinimal     // used by Calendar, Notes and Music
} NS_ENUM_AVAILABLE_IOS(7_0);


@protocol UISearchBarDelegate;
@class UITextField, UILabel, UIButton, UIColor;

/*
 UISearchBar officially conformed to UITextInputTraits in iOS 8.0 and privately conformed in iOS 7.0. Prior to 7.0, UISearchBar only implemented these four traits: autocapitalizationType, autocorrectionType, spellCheckingType and keyboardType. If your deployment target is <7.0 and you are using any trait other than one of the four mentioned, you must check its availability with respondsToSelector:
 */

NS_CLASS_AVAILABLE_IOS(2_0) @interface UISearchBar : UIView <UIBarPositioning, UITextInputTraits>

//构造函数
- (instancetype)init __TVOS_PROHIBITED;
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER __TVOS_PROHIBITED;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER __TVOS_PROHIBITED;

//样式
@property(nonatomic)        UIBarStyle              barStyle __TVOS_PROHIBITED;              // default is UIBarStyleDefault (blue)
//代理
@property(nullable,nonatomic,weak) id<UISearchBarDelegate> delegate;              // weak reference. default is nil
//输入框内容
@property(nullable,nonatomic,copy)   NSString               *text;                  // current/starting search text
//备注
@property(nullable,nonatomic,copy)   NSString               *prompt;                // default is nil
//输入框占位符内容
@property(nullable,nonatomic,copy)   NSString               *placeholder;           // default is nil
//是否显示书签按钮
@property(nonatomic)        BOOL                    showsBookmarkButton __TVOS_PROHIBITED;   // default is NO
//是否显示取消按钮
@property(nonatomic)        BOOL                    showsCancelButton __TVOS_PROHIBITED;     // default is NO
//是否显示搜索结果按钮 和书签按钮互斥(只能显示一个)
@property(nonatomic)        BOOL                    showsSearchResultsButton NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED; // default is NO
@property(nonatomic, getter=isSearchResultsButtonSelected) BOOL searchResultsButtonSelected NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED; // default is NO
//设置取消按钮
- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;

/// Use this method to modify the contents of the Unified Content Bar, shown on top of the keyboard when search is engaged.
/// You may modify the returned inputAssistantItem to add to or replace the existing items on the bar.
/// Modifications made to the returned UITextInputAssistantItem are reflected automatically.
@property (nonatomic, readonly, strong) UITextInputAssistantItem *inputAssistantItem NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

/*
 The behavior of tintColor for bars has changed on iOS 7.0. It no longer affects the bar's background
 and behaves as described for the tintColor property added to UIView.
 To tint the bar's background, please use -barTintColor.
 */
@property(null_resettable, nonatomic,strong) UIColor *tintColor;
//背景颜色
@property(nullable, nonatomic,strong) UIColor *barTintColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // default is nil
//样式
@property (nonatomic) UISearchBarStyle searchBarStyle NS_AVAILABLE_IOS(7_0);

/*
 New behavior on iOS 7.
 Default is YES.
 You may force an opaque background by setting the property to NO.
 If the search bar has a custom background image, the default is inferred
 from the alpha values of the image—YES if it has any pixel with alpha < 1.0
 If you send setTranslucent:YES to a bar with an opaque custom background image
 it will apply a system opacity less than 1.0 to the image.
 If you send setTranslucent:NO to a bar with a translucent custom background image
 it will provide an opaque background for the image using the bar's barTintColor if defined, or black
 for UIBarStyleBlack or white for UIBarStyleDefault if barTintColor is nil.
 */
//透明度
@property(nonatomic,assign,getter=isTranslucent) BOOL translucent NS_AVAILABLE_IOS(3_0); // Default is NO on iOS 6 and earlier. Always YES if barStyle is set to UIBarStyleBlackTranslucent

//扩展栏按钮标题 实际为UISegementControl
@property(nullable, nonatomic,copy) NSArray<NSString *>   *scopeButtonTitles        NS_AVAILABLE_IOS(3_0); // array of NSStrings. no scope bar shown unless 2 or more items
//扩展栏按钮选中下标
@property(nonatomic)      NSInteger  selectedScopeButtonIndex NS_AVAILABLE_IOS(3_0); // index into array of scope button titles. default is 0. ignored if out of range
//显示扩展栏 必须调用[self sizeToFit]才会显示,否则布局不对
@property(nonatomic)      BOOL       showsScopeBar            NS_AVAILABLE_IOS(3_0); // default is NO. if YES, shows the scope bar. call sizeToFit: to update frame

/* Allow placement of an input accessory view to the keyboard for the search bar
 */
//辅助视图
@property (nullable, nonatomic, readwrite, strong) UIView *inputAccessoryView;

// 1pt wide images and resizable images will be scaled or tiled according to the resizable area, otherwise the image will be tiled
//背景图片 1pt的图片就可以,会被填充
@property(nullable, nonatomic,strong) UIImage *backgroundImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
//扩展视图的背景图片
@property(nullable, nonatomic,strong) UIImage *scopeBarBackgroundImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

//设置背景图片
- (void)setBackgroundImage:(nullable UIImage *)backgroundImage forBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // Use UIBarMetricsDefaultPrompt to set a separate backgroundImage for a search bar with a prompt
- (nullable UIImage *)backgroundImageForBarPosition:(UIBarPosition)barPosition barMetrics:(UIBarMetrics)barMetrics NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;

/* In general, you should specify a value for the normal state to be used by other states which don't have a custom value set
 */

/* The rounded-rect search text field image. Valid states are UIControlStateNormal and UIControlStateDisabled
 */
//设置文本编辑框的背景图片
- (void)setSearchFieldBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)searchFieldBackgroundImageForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

//设置搜索条图标的图片
- (void)setImage:(nullable UIImage *)iconImage forSearchBarIcon:(UISearchBarIcon)icon state:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)imageForSearchBarIcon:(UISearchBarIcon)icon state:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

//
// Customizing the appearance of the scope bar buttons.
//

/* If backgroundImage is an image returned from -[UIImage resizableImageWithCapInsets:] the cap widths will be calculated from the edge insets, otherwise, the cap width will be calculated by subtracting one from the image's width then dividing by 2. The cap widths will also be used as the margins for text placement. To adjust the margin use the margin adjustment methods.
 */
//设置扩展条的背景图片
- (void)setScopeBarButtonBackgroundImage:(nullable UIImage *)backgroundImage forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)scopeBarButtonBackgroundImageForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* To customize the segmented control appearance you will need to provide divider images to go between two unselected segments (leftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal), selected on the left and unselected on the right (leftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal), and unselected on the left and selected on the right (leftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected).
 */
//设置扩展条(UISegementControl)的分割部分图片
- (void)setScopeBarButtonDividerImage:(nullable UIImage *)dividerImage forLeftSegmentState:(UIControlState)leftState rightSegmentState:(UIControlState)rightState NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable UIImage *)scopeBarButtonDividerImageForLeftSegmentState:(UIControlState)leftState rightSegmentState:(UIControlState)rightState NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* You may specify the font, text color, and shadow properties for the title in the text attributes dictionary, using the keys found in NSAttributedString.h.
 */
//设置扩展条的文本属性
- (void)setScopeBarButtonTitleTextAttributes:(nullable NSDictionary<NSString *, id> *)attributes forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (nullable NSDictionary<NSString *, id> *)scopeBarButtonTitleTextAttributesForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* To nudge the position of the search text field background in the search bar
 */

@property(nonatomic) UIOffset searchFieldBackgroundPositionAdjustment NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* To nudge the position of the text within the search text field background
 */
//设置搜索条文本框的位置偏移 UIOffset是一个结构体,表示水平方向和竖直方向的偏移
@property(nonatomic) UIOffset searchTextPositionAdjustment NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* To nudge the position of the icon within the search text field
 */
//设置icon的位置偏移
- (void)setPositionAdjustment:(UIOffset)adjustment forSearchBarIcon:(UISearchBarIcon)icon NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (UIOffset)positionAdjustmentForSearchBarIcon:(UISearchBarIcon)icon NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@end

@protocol UISearchBarDelegate <UIBarPositioningDelegate>

@optional

//是否可以进行编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;                      // return NO to not become first responder
//开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;                     // called when text starts editing
//是否可以结束编辑
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;                        // return NO to not resign first responder
//结束编辑时会触发
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;                       // called when text ends editing
//输入框文字改变时触发
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
//是否允许输入框的文本发生变化,编辑发生之前触发
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); // called before text changes
//当用户点击键盘上的搜索按钮时会触发下面的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
//当用户点击"图书"图标按钮时会触发下面的方法
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED; // called when bookmark button pressed

//当用户点击"取消"按钮时会触发下面的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;   // called when cancel button pressed
//当用户点击"搜索结果列表"按钮时会触发下面的方法
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED; // called when search results button pressed
//点击切换扩展栏上的模块按钮触发
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0);

@end

NS_ASSUME_NONNULL_END


#endif /* UISearchBar_h */
