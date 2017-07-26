//
//  CGAffineTransform.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/26.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef CGAffineTransform_h
#define CGAffineTransform_h
//变换矩阵



#ifndef CGAFFINETRANSFORM_H_
#define CGAFFINETRANSFORM_H_

typedef struct CGAffineTransform CGAffineTransform;

#include <CoreGraphics/CGBase.h>
#include <CoreGraphics/CGGeometry.h>

CF_IMPLICIT_BRIDGING_ENABLED

struct CGAffineTransform {
    CGFloat a, b, c, d;
    CGFloat tx, ty;
};

/* The identity transform: [ 1 0 0 1 0 0 ]. */

//常量 代表坐标变换的单位矩阵----任何坐标点经单位矩阵变换后不会发生任何改变
CG_EXTERN const CGAffineTransform CGAffineTransformIdentity
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return the transform [ a b c d tx ty ]. */

//自定义变换矩阵执行变换
CG_EXTERN CGAffineTransform CGAffineTransformMake(CGFloat a, CGFloat b,
                                                  CGFloat c, CGFloat d, CGFloat tx, CGFloat ty)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return a transform which translates by `(tx, ty)':
 t' = [ 1 0 0 1 tx ty ] */

//创建进行位移变换的位移矩阵
CG_EXTERN CGAffineTransform CGAffineTransformMakeTranslation(CGFloat tx,
                                                             CGFloat ty) CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return a transform which scales by `(sx, sy)':
 t' = [ sx 0 0 sy 0 0 ] */

//创建进行缩放变换的缩放矩阵
CG_EXTERN CGAffineTransform CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return a transform which rotates by `angle' radians:
 t' = [ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ] */

//创建进行旋转变换的旋转矩阵
CG_EXTERN CGAffineTransform CGAffineTransformMakeRotation(CGFloat angle)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return true if `t' is the identity transform, false otherwise. */

//是否是单位矩阵(不发生任何改变)
CG_EXTERN bool CGAffineTransformIsIdentity(CGAffineTransform t)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Translate `t' by `(tx, ty)' and return the result:
 t' = [ 1 0 0 1 tx ty ] * t */

//对已有的变换矩阵t额外增加位移变换
CG_EXTERN CGAffineTransform CGAffineTransformTranslate(CGAffineTransform t,
                                                       CGFloat tx, CGFloat ty) CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Scale `t' by `(sx, sy)' and return the result:
 t' = [ sx 0 0 sy 0 0 ] * t */
//对已有的变换矩阵t额外增加缩放变换
CG_EXTERN CGAffineTransform CGAffineTransformScale(CGAffineTransform t,
                                                   CGFloat sx, CGFloat sy) CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Rotate `t' by `angle' radians and return the result:
 t' =  [ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ] * t */
//对已有的变换矩阵t额外增加旋转变换
CG_EXTERN CGAffineTransform CGAffineTransformRotate(CGAffineTransform t,
                                                    CGFloat angle) CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Invert `t' and return the result. If `t' has zero determinant, then `t'
 is returned unchanged. */

//对已有的变换矩阵t进行反转
CG_EXTERN CGAffineTransform CGAffineTransformInvert(CGAffineTransform t)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Concatenate `t2' to `t1' and return the result:
 t' = t1 * t2 */
//将两个矩阵进行叠加
CG_EXTERN CGAffineTransform CGAffineTransformConcat(CGAffineTransform t1,
                                                    CGAffineTransform t2) CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return true if `t1' and `t2' are equal, false otherwise. */
//矩阵是否相等
CG_EXTERN bool CGAffineTransformEqualToTransform(CGAffineTransform t1,
                                                 CGAffineTransform t2) CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Transform `point' by `t' and return the result:
 p' = p * t
 where p = [ x y 1 ]. */
//对指定的点坐标执行变换,函数返回坐标变换后的点坐标
CG_EXTERN CGPoint CGPointApplyAffineTransform(CGPoint point,
                                              CGAffineTransform t) CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Transform `size' by `t' and return the result:
 s' = s * t
 where s = [ width height 0 ]. */
//对指定的CGSize执行变换,函数返回坐标变换后的CGSize
CG_EXTERN CGSize CGSizeApplyAffineTransform(CGSize size, CGAffineTransform t)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Transform `rect' by `t' and return the result. Since affine transforms do
 not preserve rectangles in general, this function returns the smallest
 rectangle which contains the transformed corner points of `rect'. If `t'
 consists solely of scales, flips and translations, then the returned
 rectangle coincides with the rectangle constructed from the four
 transformed corners. */
//对指定的CGRect执行变换,函数返回坐标变换后的CGRect
CG_EXTERN CGRect CGRectApplyAffineTransform(CGRect rect, CGAffineTransform t)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/*** Definitions of inline functions. ***/

CG_INLINE CGAffineTransform
__CGAffineTransformMake(CGFloat a, CGFloat b, CGFloat c, CGFloat d,
                        CGFloat tx, CGFloat ty)
{
    CGAffineTransform t;
    t.a = a; t.b = b; t.c = c; t.d = d; t.tx = tx; t.ty = ty;
    return t;
}
#define CGAffineTransformMake __CGAffineTransformMake

CG_INLINE CGPoint
__CGPointApplyAffineTransform(CGPoint point, CGAffineTransform t)
{
    CGPoint p;
    p.x = (CGFloat)((double)t.a * point.x + (double)t.c * point.y + t.tx);
    p.y = (CGFloat)((double)t.b * point.x + (double)t.d * point.y + t.ty);
    return p;
}
#define CGPointApplyAffineTransform __CGPointApplyAffineTransform

CG_INLINE CGSize
__CGSizeApplyAffineTransform(CGSize size, CGAffineTransform t)
{
    CGSize s;
    s.width = (CGFloat)((double)t.a * size.width + (double)t.c * size.height);
    s.height = (CGFloat)((double)t.b * size.width + (double)t.d * size.height);
    return s;
}
#define CGSizeApplyAffineTransform __CGSizeApplyAffineTransform

CF_IMPLICIT_BRIDGING_DISABLED

#endif /* CGAFFINETRANSFORM_H_ */






#endif /* CGAffineTransform_h */
