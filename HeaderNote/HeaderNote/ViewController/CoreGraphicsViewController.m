//
//  CoreGraphicsViewController.m
//  HeaderNote
//
//  Created by Rhino on 2017/7/26.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CoreGraphicsViewController.h"

@interface CoreGraphicsViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CoreGraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.imageView = [[UIImageView alloc]initWithImage:[self drawImage:self.view.frame.size]];
//    
//    [self.view addSubview:self.imageView];
}
- (UIImage *)drawImage:(CGSize)size{
    //创建内存中的图片
    UIGraphicsBeginImageContext(size);
    //获取绘图环境
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置线宽
    CGContextSetLineWidth(context, 8);
    //设置线条颜色
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    
    //绘制矩形边框
    CGContextStrokeRect(context, CGRectMake(30, 30, 120, 60));
    //设置填充颜色
    CGContextSetRGBFillColor(context, 1, 1, 0, 1);
    
    //绘制矩形边框
    CGContextFillRect(context, CGRectMake(180, 30, 120, 60));
    //设置线条颜色
    CGContextSetRGBStrokeColor(context, 0, 1, 1, 1);
    
    
    //绘制椭圆
    CGContextStrokeEllipseInRect(context, CGRectMake(30, 120, 120, 60));
    CGContextSetRGBFillColor(context, 1, 0, 1, 1);//设置填充颜色
    //填充一个椭圆
    CGContextFillEllipseInRect(context, CGRectMake(180, 120, 120, 60));
    
    //获取该绘图Context中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束绘图
    UIGraphicsEndImageContext();
    
    //保存到本地
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"newImage.png"];
    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    
    return image;
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
