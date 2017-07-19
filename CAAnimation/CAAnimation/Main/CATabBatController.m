//
//  CATabBatController.m
//  CAAnimation
//
//  Created by Rhino on 2017/7/18.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CATabBatController.h"
#import "UIViewAnimationController.h"
#import "CAAnimationViewController.h"

@interface CATabBatController ()

@end

@implementation CATabBatController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *firstVc = [[UINavigationController alloc]initWithRootViewController:[[CAAnimationViewController alloc]init]];
    UIViewController *secondVc = [[UINavigationController alloc]initWithRootViewController:[[UIViewAnimationController alloc]init]];
    
    [self addChildViewController:firstVc title:@"CAAnimation" imageName:@"caanimation"];
    [self addChildViewController:secondVc title:@"UIView" imageName:@"uiview"];
    
}

//UITabBarItem :UIBarItem : NSObject 非UI控件
//主要title,image,selectedImage,badgeValue

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName{
    
    //标签栏的标题
    childController.tabBarItem.title = title;
    //标签的图片
    childController.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tab_%@",imageName]];
    //标签被选中时的图片
    childController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tab_%@_selected",imageName]];
    [self addChildViewController:childController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
