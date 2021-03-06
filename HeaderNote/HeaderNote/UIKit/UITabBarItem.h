//
//  UITabBarItem.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/18.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef UITabBarItem_h
#define UITabBarItem_h

#import <Foundation/Foundation.h>
#import <UIKit/UIBarItem.h>
#import <UIKit/UIGeometry.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UISpringLoadedInteractionSupporting.h>

NS_ASSUME_NONNULL_BEGIN

//系统提供的BarItem风格
typedef NS_ENUM(NSInteger, UITabBarSystemItem) {
    UITabBarSystemItemMore,   //更多风格
    UITabBarSystemItemFavorites, //喜爱风格
    UITabBarSystemItemFeatured, //关注风格
    UITabBarSystemItemTopRated, //排行风格
    UITabBarSystemItemRecents,  //最近记录风格
    UITabBarSystemItemContacts, //联系人风格
    UITabBarSystemItemHistory,  //历史风格
    UITabBarSystemItemBookmarks, //书签风格
    UITabBarSystemItemSearch,   //搜索风格
    UITabBarSystemItemDownloads, //下载风格
    UITabBarSystemItemMostRecent, //记录列表风格
    UITabBarSystemItemMostViewed, //浏览列表风格
};

@class UIView, UIImage;

//非UI类
NS_CLASS_AVAILABLE_IOS(2_0) @interface UITabBarItem : UIBarItem

#pragma mark - 构造函数
- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
/* The unselected image is autogenerated from the image argument. The selected image
 is autogenerated from the selectedImage if provided and the image argument otherwise.
 To prevent system coloring, provide images with UIImageRenderingModeAlwaysOriginal (see UIImage.h)
 */
//
- (instancetype)initWithTitle:(nullable NSString *)title image:(nullable UIImage *)image tag:(NSInteger)tag;
- (instancetype)initWithTitle:(nullable NSString *)title image:(nullable UIImage *)image selectedImage:(nullable UIImage *)selectedImage NS_AVAILABLE_IOS(7_0);
//创建系统风格的标签
- (instancetype)initWithTabBarSystemItem:(UITabBarSystemItem)systemItem tag:(NSInteger)tag;

//选中状态的图片
@property(nullable, nonatomic,strong) UIImage *selectedImage NS_AVAILABLE_IOS(7_0);

//角标
@property(nullable, nonatomic, copy) NSString *badgeValue;    // default is nil

/*  These methods are now deprecated. Please use -initWithTitle:image:selectedImage:.
 */
- (void)setFinishedSelectedImage:(nullable UIImage *)selectedImage withFinishedUnselectedImage:(nullable UIImage *)unselectedImage NS_DEPRECATED_IOS(5_0,7_0,"Use initWithTitle:image:selectedImage: or the image and selectedImage properties along with UIImageRenderingModeAlwaysOriginal") __TVOS_PROHIBITED;
- (nullable UIImage *)finishedSelectedImage NS_DEPRECATED_IOS(5_0,7_0) __TVOS_PROHIBITED;
- (nullable UIImage *)finishedUnselectedImage NS_DEPRECATED_IOS(5_0,7_0) __TVOS_PROHIBITED;

/* To set item label text attributes use the appearance selectors available on the superclass, UIBarItem.
 
 Use the following to tweak the relative position of the label within the tab button (for handling visual centering corrections if needed because of custom text attributes)
 */
//BarItem的title偏移量(水平,竖直)
@property (nonatomic, readwrite, assign) UIOffset titlePositionAdjustment NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/// If this item displays a badge, this color will be used for the badge's background. If set to nil, the default background color will be used instead.

//badge角标颜色
@property (nonatomic, readwrite, copy, nullable) UIColor *badgeColor NS_AVAILABLE_IOS(10_0) UI_APPEARANCE_SELECTOR;

/// Provide text attributes to use to draw the badge text for the given singular control state (Normal, Disabled, Focused, Selected, or Highlighted). Default values will be supplied for keys that are not provided by this dictionary. See NSAttributedString.h for details on what keys are available.

//设置badge不同状态下的文本样式属性
//(Normal, Disabled, Focused, Selected, or Highlighted)
//fontsize,fontcolor,font....

- (void)setBadgeTextAttributes:(nullable NSDictionary<NSString *,id> *)textAttributes forState:(UIControlState)state NS_AVAILABLE_IOS(10_0) UI_APPEARANCE_SELECTOR;

//获取badge不同状态下的文本样式属性
- (nullable NSDictionary<NSString *,id> *)badgeTextAttributesForState:(UIControlState)state NS_AVAILABLE_IOS(10_0) UI_APPEARANCE_SELECTOR;

@end

#if TARGET_OS_IOS
@interface UITabBarItem (SpringLoading) <UISpringLoadedInteractionSupporting>
@end
#endif

NS_ASSUME_NONNULL_END



#endif /* UITabBarItem_h */
