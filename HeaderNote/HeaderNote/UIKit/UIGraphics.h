//
//  UIGraphics.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/25.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef UIGraphics_h
#define UIGraphics_h

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

//1.自定义UI时获取当前上下文
//自定义UI 重写drawRect方法,当UIView每次显示出来时,或者UIView的内容需要更新时,都会调用drawRect方法,在调用drawRect方法之前,系统会自动配置
//绘图环境,所以可以在drawRect方法通过该API获取绘图环境

//获取绘图环境
UIKIT_EXTERN CGContextRef __nullable UIGraphicsGetCurrentContext(void) CF_RETURNS_NOT_RETAINED;

UIKIT_EXTERN void UIGraphicsPushContext(CGContextRef context);
UIKIT_EXTERN void UIGraphicsPopContext(void);

//向当前火兔环境所创建的内存中的图片填充一个矩形,绘制使用指定的混合模式.
UIKIT_EXTERN void UIRectFillUsingBlendMode(CGRect rect, CGBlendMode blendMode);
//向当前绘图环境所创建的内存中的图片填充一个矩形
UIKIT_EXTERN void UIRectFill(CGRect rect);

//向当前绘图环境所创建的内存中的图片上绘制一个矩形边框,绘制使用指定的混合模式
UIKIT_EXTERN void UIRectFrameUsingBlendMode(CGRect rect, CGBlendMode blendMode);
//向当前绘图环境所创建的内存中的图片上绘制一个矩形边框
UIKIT_EXTERN void UIRectFrame(CGRect rect);

UIKIT_EXTERN void UIRectClip(CGRect rect);



// UIImage context

// The following methods will only return a 8-bit per channel context in the DeviceRGB color space.
// Any new bitmap drawing code is encouraged to use UIGraphicsImageRenderer in leiu of this API.

//2.创建位图时获取绘图环境
//先调用 UIGraphicsBeginImageContext函数来创建内存中的图片,然后再UIGraphicsGetCurrentContext获取绘图的CGContextRef

//准备绘图环境
UIKIT_EXTERN void     UIGraphicsBeginImageContext(CGSize size);
//传入透明度 比例
UIKIT_EXTERN void     UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale) NS_AVAILABLE_IOS(4_0);
//从当前绘图环境中获取UIImage对象 即获取当前绘制的图形
UIKIT_EXTERN UIImage* __nullable UIGraphicsGetImageFromCurrentImageContext(void);
//结束绘图,并关闭绘图环境
UIKIT_EXTERN void     UIGraphicsEndImageContext(void);




// PDF context

UIKIT_EXTERN BOOL UIGraphicsBeginPDFContextToFile(NSString *path, CGRect bounds, NSDictionary * __nullable documentInfo) NS_AVAILABLE_IOS(3_2);
UIKIT_EXTERN void UIGraphicsBeginPDFContextToData(NSMutableData *data, CGRect bounds, NSDictionary * __nullable documentInfo) NS_AVAILABLE_IOS(3_2);
UIKIT_EXTERN void UIGraphicsEndPDFContext(void) NS_AVAILABLE_IOS(3_2);

UIKIT_EXTERN void UIGraphicsBeginPDFPage(void) NS_AVAILABLE_IOS(3_2);
UIKIT_EXTERN void UIGraphicsBeginPDFPageWithInfo(CGRect bounds, NSDictionary * __nullable pageInfo) NS_AVAILABLE_IOS(3_2);

UIKIT_EXTERN CGRect UIGraphicsGetPDFContextBounds(void) NS_AVAILABLE_IOS(3_2);

UIKIT_EXTERN void UIGraphicsSetPDFContextURLForRect(NSURL *url, CGRect rect) NS_AVAILABLE_IOS(3_2);
UIKIT_EXTERN void UIGraphicsAddPDFContextDestinationAtPoint(NSString *name, CGPoint point) NS_AVAILABLE_IOS(3_2);
UIKIT_EXTERN void UIGraphicsSetPDFContextDestinationForRect(NSString *name, CGRect rect) NS_AVAILABLE_IOS(3_2);

NS_ASSUME_NONNULL_END



#endif /* UIGraphics_h */
