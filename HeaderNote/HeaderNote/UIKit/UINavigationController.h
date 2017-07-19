//
//  UINavigationController.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/18.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef UINavigationController_h
#define UINavigationController_h



#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIViewController.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIInterface.h>
#import <UIKit/UIGeometry.h>
#import <UIKit/UIPanGestureRecognizer.h>
#import <UIKit/UITapGestureRecognizer.h>

/*!
 UINavigationController manages a stack of view controllers and a navigation bar.
 It performs horizontal view transitions for pushed and popped views while keeping the navigation bar in sync.
 
 Most clients will not need to subclass UINavigationController.
 
 If a navigation controller is nested in a tabbar controller, it uses the title and toolbar attributes of the bottom view controller on the stack.
 
 UINavigationController is rotatable if its top view controller is rotatable.
 Navigation between controllers with non-uniform rotatability is currently not supported.
 */

/**
 UINavigationController 导航控制器,是一个容器类,没有视图层,管理一个栈结构类型的视图控制器数组和一个导航条UINavigationBar
 相关概念:
 栈:先进后出,后进先出 ,入栈:push 出栈:pop 栈顶元素:最后入栈的元素 栈底元素:第一个入栈的
使用:
1.UINavigationController必须有一个根视图控制器,即栈底元素,否则看不到什么效果,其本质就是管理视图控制器的层级结构的.
2.push入栈,pop出栈时视图水平方向有一个渐进或者淡出的转场动画,当然我们可以进行自定制转场动画
3.控制器和导航条根据设备的方向会自动旋转.
4.经常UITabBarController嵌套一个UINavigationController使用
 
 **/
NS_ASSUME_NONNULL_BEGIN

 //操作类型
typedef NS_ENUM(NSInteger, UINavigationControllerOperation) {
    UINavigationControllerOperationNone,
    UINavigationControllerOperationPush, //push 推入
    UINavigationControllerOperationPop,  //pop  推出
};

//常量 隐藏或者显示TabBar的间隔时间
UIKIT_EXTERN const CGFloat UINavigationControllerHideShowBarDuration;

@class UIView, UINavigationBar, UINavigationItem, UIToolbar;
@protocol UINavigationControllerDelegate;


NS_CLASS_AVAILABLE_IOS(2_0) @interface UINavigationController : UIViewController


/* Use this initializer to make the navigation controller use your custom bar class.
 Passing nil for navigationBarClass will get you UINavigationBar, nil for toolbarClass gets UIToolbar.
 The arguments must otherwise be subclasses of the respective UIKit classes.
 */

//创建一个自定义NavigationBar和ToolBar的导航控制器,参数必须是UIKit的子类对象,传nil代表使用系统默认的UINavigationBar,UIToolbar
- (instancetype)initWithNavigationBarClass:(nullable Class)navigationBarClass toolbarClass:(nullable Class)toolbarClass NS_AVAILABLE_IOS(5_0);

//根据根视图控制器创建一个导航控制器
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController; // Convenience method pushes the root view controller without animation.

//推入一个视图控制器  是否显示转场动画
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated; // Uses a horizontal slide transition. Has no effect if the view controller is already in the stack.
//推出栈顶的视图控制器 是否显示动画
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated; // Returns the popped controller.

//推出
- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated; // Pops view controllers until the one specified is on top. Returns the popped controllers.
- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated; // Pops until there's only a single view controller left on the stack. Returns the popped controllers.

//栈顶视图控制器
@property(nullable, nonatomic,readonly,strong) UIViewController *topViewController; // The top view controller on the stack.
//当前界面可见的视图控制器
@property(nullable, nonatomic,readonly,strong) UIViewController *visibleViewController; // Return modal view controller if it exists. Otherwise the top view controller.

//管理的视图控制器数组
@property(nonatomic,copy) NSArray<__kindof UIViewController *> *viewControllers; // The current view controller stack.

//设置视图控制器数组
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated NS_AVAILABLE_IOS(3_0); // If animated is YES, then simulate a push or pop depending on whether the new top view controller was previously in the stack.

//导航条是否隐藏
@property(nonatomic,getter=isNavigationBarHidden) BOOL navigationBarHidden;

//设置导航条是否隐藏  有无动画
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated; // Hide or show the navigation bar. If animated, it will transition vertically using UINavigationControllerHideShowBarDuration.

//导航条 只读
@property(nonatomic,readonly) UINavigationBar *navigationBar; // The navigation bar managed by the controller. Pushing, popping or setting navigation items on a managed navigation bar is not supported.

//工具条 默认是隐藏
@property(nonatomic,getter=isToolbarHidden) BOOL toolbarHidden NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED; // Defaults to YES, i.e. hidden.

//设置工具条 是否隐藏  动画  在屏幕底部
- (void)setToolbarHidden:(BOOL)hidden animated:(BOOL)animated NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED; // Hide or show the toolbar at the bottom of the screen. If animated, it will transition vertically using UINavigationControllerHideShowBarDuration.

//工具条
@property(null_resettable,nonatomic,readonly) UIToolbar *toolbar NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED; // For use when presenting an action sheet.

//代理
@property(nullable, nonatomic, weak) id<UINavigationControllerDelegate> delegate;

@property(nullable, nonatomic, readonly) UIGestureRecognizer *interactivePopGestureRecognizer NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;

- (void)showViewController:(UIViewController *)vc sender:(nullable id)sender NS_AVAILABLE_IOS(8_0); // Interpreted as pushViewController:animated:

/// When the keyboard appears, the navigation controller's navigationBar toolbar will be hidden. The bars will remain hidden when the keyboard dismisses, but a tap in the content area will show them.
//当键盘弹出的时候,隐藏导航控制器的导航条,工具条 NavigationBar,ToolBar
//键盘消失还是处于影藏状态的,除非点击内容区域

@property (nonatomic, readwrite, assign) BOOL hidesBarsWhenKeyboardAppears NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;

/// When the user swipes, the navigation controller's navigationBar & toolbar will be hidden (on a swipe up) or shown (on a swipe down). The toolbar only participates if it has items.
//当用户滑动的时候,隐藏导航条&&工具条
@property (nonatomic, readwrite, assign) BOOL hidesBarsOnSwipe NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;
/// The gesture recognizer that triggers if the bars will hide or show due to a swipe. Do not change the delegate or attempt to replace this gesture by overriding this method.
@property (nonatomic, readonly, strong) UIPanGestureRecognizer *barHideOnSwipeGestureRecognizer NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;

/// When the UINavigationController's vertical size class is compact, hide the UINavigationBar and UIToolbar. Unhandled taps in the regions that would normally be occupied by these bars will reveal the bars.
//当设备横屏,自动隐藏导航条工具条
@property (nonatomic, readwrite, assign) BOOL hidesBarsWhenVerticallyCompact NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;


/// When the user taps, the navigation controller's navigationBar & toolbar will be hidden or shown, depending on the hidden state of the navigationBar. The toolbar will only be shown if it has items to display.
//点击屏幕时,自动隐藏导航条&&工具条
@property (nonatomic, readwrite, assign) BOOL hidesBarsOnTap NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;
/// The gesture recognizer used to recognize if the bars will hide or show due to a tap in content. Do not change the delegate or attempt to replace this gesture by overriding this method.
@property (nonatomic, readonly, assign) UITapGestureRecognizer *barHideOnTapGestureRecognizer NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;

@end

@protocol UIViewControllerInteractiveTransitioning;
@protocol UIViewControllerAnimatedTransitioning;

@protocol UINavigationControllerDelegate <NSObject>

@optional

// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.

//将要显示某个视图控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
//已经显示某个视图控制器 初始化的时候即栈顶元素会执行两次!!!,其余一次
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated;

//方向
- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;


//自定义转场动画
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0);

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);

@end

@interface UIViewController (UINavigationControllerItem)

@property(nonatomic,readonly,strong) UINavigationItem *navigationItem; // Created on-demand so that a view controller may customize its navigation appearance.
@property(nonatomic) BOOL hidesBottomBarWhenPushed __TVOS_PROHIBITED; // If YES, then when this view controller is pushed into a controller hierarchy with a bottom bar (like a tab bar), the bottom bar will slide out. Default is NO.
@property(nullable, nonatomic,readonly,strong) UINavigationController *navigationController; // If this view controller has been pushed onto a navigation controller, return it.

@end

@interface UIViewController (UINavigationControllerContextualToolbarItems)

@property (nullable, nonatomic, strong) NSArray<__kindof UIBarButtonItem *> *toolbarItems NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
- (void)setToolbarItems:(nullable NSArray<UIBarButtonItem *> *)toolbarItems animated:(BOOL)animated NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;

@end

NS_ASSUME_NONNULL_END



#endif /* UINavigationController_h */
