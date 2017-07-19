//
//  UITabBarController.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/18.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef UITabBarController_h
#define UITabBarController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIViewController.h>
#import <UIKit/UIViewControllerTransitioning.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UITabBar.h>

NS_ASSUME_NONNULL_BEGIN

@class UIView, UIImage, UINavigationController, UITabBarItem;
@protocol UITabBarControllerDelegate;

/*!
 UITabBarController manages a button bar and transition view, for an application with multiple top-level modes.
 
 To use in your application, add its view to the view hierarchy, then add top-level view controllers in order.
 Most clients will not need to subclass UITabBarController.
 
 If more than five view controllers are added to a tab bar controller, only the first four will display.
 The rest will be accessible under an automatically generated More item.
 
 UITabBarController is rotatable if all of its view controllers are rotatable.
 */

/**
 标签/分栏控制器 是一个容器类,管理一个并列关系的控制器数组.有一个Tabbar用来切换视图
 当子视图控制器的个数大于5时,会造成tabbar中的按钮拥挤,所以会将第五个控制器交由系统自己创建即即属性:moreNavigationController,moreNavigationController是一个导航控制器,管理剩余的子视图控制器列表,我们可以通过属性customizableViewControllers获取.同样也可以通过代理方法重新排列视图控制器的顺序
 需要注意的是:
 1.moreNavigationController的下标不是4,而是一个最大的正整数
 2.被添加到由MORE控制器管理的子控制器,并不会执行shouldSelectViewController:,didSelectedViewController代理方法.
 
 **/
NS_CLASS_AVAILABLE_IOS(2_0) @interface UITabBarController : UIViewController <UITabBarDelegate, NSCoding>

//容器,子视图控制器列表
@property(nullable, nonatomic,copy) NSArray<__kindof UIViewController *> *viewControllers;
// If the number of view controllers is greater than the number displayable by a tab bar, a "More" navigation controller will automatically be shown.
// The "More" navigation controller will not be returned by -viewControllers, but it may be returned by -selectedViewController.
//设置子视图控制器列表
- (void)setViewControllers:(NSArray<__kindof UIViewController *> * __nullable)viewControllers animated:(BOOL)animated;

//当前选中的子视图控制器
@property(nullable, nonatomic, assign) __kindof UIViewController *selectedViewController; // This may return the "More" navigation controller if it exists.

//当前选中的子视图控制器在viewControllers的下标位置
@property(nonatomic) NSUInteger selectedIndex;

//More导航控制器
@property(nonatomic, readonly) UINavigationController *moreNavigationController __TVOS_PROHIBITED; // Returns the "More" navigation controller, creating it if it does not already exist.

//More控制器管理的控制器数组
@property(nullable, nonatomic, copy) NSArray<__kindof UIViewController *> *customizableViewControllers __TVOS_PROHIBITED; // If non-nil, then the "More" view will include an "Edit" button that displays customization UI for the specified controllers. By default, all view controllers are customizable.

//Tabbar  UI
@property(nonatomic,readonly) UITabBar *tabBar NS_AVAILABLE_IOS(3_0); // Provided for -[UIActionSheet showFromTabBar:]. Attempting to modify the contents of the tab bar directly will throw an exception.

//代理
@property(nullable, nonatomic,weak) id<UITabBarControllerDelegate> delegate;

@end

#pragma mark - UITabBarControllerDelegate

@protocol UITabBarControllerDelegate <NSObject>
@optional

//设置能否选中某个视图控制器,点击的时候调用该方法,若返回NO,不会执行Selected
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0);
//选中某个视图控制器时调用
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

//More 多余五个视图控制器时
//将要开始调整标签时调用: 即点击Edit按钮时调用
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;

//将要结束调整标签时调用,changed表示是否调整过标签顺序 点击save按钮
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
//结束调整标签时调用
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed __TVOS_PROHIBITED;


//方向,首先app应支持这个方向,否则会崩溃
//比如将标签栏放在左边,右边....
- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;

//应该跟设备方向有关.. 不确定
- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;

//自定义转场动画
- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0);

- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);

@end

@interface UIViewController (UITabBarControllerItem)

@property(null_resettable, nonatomic, strong) UITabBarItem *tabBarItem; // Automatically created lazily with the view controller's title if it's not set explicitly.

@property(nullable, nonatomic, readonly, strong) UITabBarController *tabBarController; // If the view controller has a tab bar controller as its ancestor, return it. Returns nil otherwise.

@end

NS_ASSUME_NONNULL_END



#endif /* UITabBarController_h */
