//
//  UIImage+Extesion.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/26.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extesion)

//对指定的UI控件进行截图
+ (UIImage *)captureView:(UIView *)targetView;
+ (UIImage *)captureScreen;

//获取图片指定区域
- (UIImage *)imageAtRect:(CGRect )rect;

//保持图片中恒比缩放,最短便必须匹配targetSize的大小,可能有一条边的长度会超过targetSize指定的大小
- (UIImage *)imageByScalingAspectToMinSize:(CGSize)targetSize;




@end
