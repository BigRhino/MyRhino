//
//  CGContextRef.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/25.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef CGContextRef_h
#define CGContextRef_h


#ifndef CGCONTEXT_H_
#define CGCONTEXT_H_

#include <CoreFoundation/CFBase.h>
#include <CoreFoundation/CFAvailability.h>
#include <stdint.h>

typedef struct CF_BRIDGED_TYPE(id) CGContext *CGContextRef;

#include <CoreGraphics/CGBase.h>
#include <CoreGraphics/CGAffineTransform.h>
#include <CoreGraphics/CGColor.h>
#include <CoreGraphics/CGColorSpace.h>
#include <CoreGraphics/CGFont.h>
#include <CoreGraphics/CGGradient.h>
#include <CoreGraphics/CGImage.h>
#include <CoreGraphics/CGPath.h>
#include <CoreGraphics/CGPattern.h>
#include <CoreGraphics/CGPDFDocument.h>
#include <CoreGraphics/CGShading.h>

CF_IMPLICIT_BRIDGING_ENABLED

CF_ASSUME_NONNULL_BEGIN

/* Drawing modes for paths. */
///路径绘制模式
typedef CF_ENUM (int32_t, CGPathDrawingMode) {
    kCGPathFill, //指定填充路径 CGContextFillPath()
    kCGPathEOFill, //指定采用even-odd模式填充路径  CGContextEOFillPath()
    kCGPathStroke, //指定只绘制路径  CGContextStrokePath)
    kCGPathFillStroke, //指定既绘制路径,也填充路径
    kCGPathEOFillStroke //指既绘制路径,也采用even-odd模式填充路径
};

/* Drawing modes for text. */
//文本绘制模式
typedef CF_ENUM (int32_t, CGTextDrawingMode) {
    kCGTextFill,
    kCGTextStroke,
    kCGTextFillStroke,
    kCGTextInvisible,
    kCGTextFillClip,
    kCGTextStrokeClip,
    kCGTextFillStrokeClip,
    kCGTextClip
};

/* Text encodings. */

typedef CF_ENUM (int32_t, CGTextEncoding) {
    kCGEncodingFontSpecific,
    kCGEncodingMacRoman
} CG_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_9, __IPHONE_2_0, __IPHONE_7_0);

/* Interpolation quality. */

typedef CF_ENUM (int32_t, CGInterpolationQuality) {
    kCGInterpolationDefault = 0,  /* Let the context decide. */
    kCGInterpolationNone = 1,     /* Never interpolate. */
    kCGInterpolationLow = 2,      /* Low quality, fast interpolation. */
    kCGInterpolationMedium = 4,   /* Medium quality, slower than kCGInterpolationLow. */
    kCGInterpolationHigh = 3      /* Highest quality, slower than kCGInterpolationMedium. */
};

/* Blend modes.
 
 The blend modes from kCGBlendModeNormal to kCGBlendModeLuminosity are
 supported in Mac OS X 10.4 and later. The Porter-Duff blend modes (from
 kCGBlendModeClear to kCGBlendModePlusLighter) are supported in Mac OS X
 10.5 and later. The names of the Porter-Duff blend modes are historical.
 
 Note that the Porter-Duff blend modes are not necessarily supported in
 every context. In particular, they are only guaranteed to work in
 bitmap-based contexts, such as those created by CGBitmapContextCreate. It
 is your responsibility to make sure that they do what you want when you
 use them in a CGContext. */

//混合(叠加)模式
typedef CF_ENUM (int32_t, CGBlendMode) {
    /* Available in Mac OS X 10.4 & later. */
    kCGBlendModeNormal,
    kCGBlendModeMultiply,
    kCGBlendModeScreen,
    kCGBlendModeOverlay,
    kCGBlendModeDarken,
    kCGBlendModeLighten,
    kCGBlendModeColorDodge,
    kCGBlendModeColorBurn,
    kCGBlendModeSoftLight,
    kCGBlendModeHardLight,
    kCGBlendModeDifference,
    kCGBlendModeExclusion,
    kCGBlendModeHue,
    kCGBlendModeSaturation,
    kCGBlendModeColor,
    kCGBlendModeLuminosity,
    
    /* Available in Mac OS X 10.5 & later. R, S, and D are, respectively,
     premultiplied result, source, and destination colors with alpha; Ra,
     Sa, and Da are the alpha components of these colors.
     
     The Porter-Duff "source over" mode is called `kCGBlendModeNormal':
     R = S + D*(1 - Sa)
     
     Note that the Porter-Duff "XOR" mode is only titularly related to the
     classical bitmap XOR operation (which is unsupported by
     CoreGraphics). */
    
    kCGBlendModeClear,                  /* R = 0 */
    kCGBlendModeCopy,                   /* R = S */
    kCGBlendModeSourceIn,               /* R = S*Da */
    kCGBlendModeSourceOut,              /* R = S*(1 - Da) */
    kCGBlendModeSourceAtop,             /* R = S*Da + D*(1 - Sa) */
    kCGBlendModeDestinationOver,        /* R = S*(1 - Da) + D */
    kCGBlendModeDestinationIn,          /* R = D*Sa */
    kCGBlendModeDestinationOut,         /* R = D*(1 - Sa) */
    kCGBlendModeDestinationAtop,        /* R = S*(1 - Da) + D*Sa */
    kCGBlendModeXOR,                    /* R = S*(1 - Da) + D*(1 - Sa) */
    kCGBlendModePlusDarker,             /* R = MAX(0, (1 - D) + (1 - S)) */
    kCGBlendModePlusLighter             /* R = MIN(1, S + D) */
};

/* Return the CFTypeID for CGContextRefs. */

CG_EXTERN CFTypeID CGContextGetTypeID(void)
CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);

/** Graphics state functions. **/
#pragma mark - 绘制状态函数(保存,恢复)

/* Push a copy of the current graphics state onto the graphics state stack.
 Note that the path is not considered part of the graphics state, and is
 not saved. */

//保存CGContextRef当前的绘图状态,方便以后恢复该状态
//保存当前坐标系统的状态,设置的填充风格\线条风格\阴影风格等各种绘图状态,但不会保存当前绘制的图形.
CG_EXTERN void CGContextSaveGState(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Restore the current graphics state from the one on the top of the
 graphics state stack, popping the graphics state stack in the process. */

//把CGContextRef的状态恢复到最近一次保存时的状态
CG_EXTERN void CGContextRestoreGState(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Coordinate space transformations. **/
#pragma mark - 坐标空间转换
/* Scale the current graphics state's transformation matrix (the CTM) by
 `(sx, sy)'. */
/* 缩放坐标系统 控制坐标系统水平方向缩放sx,垂直方向上缩放sy,在缩放后的坐标系统上绘制图形时,所有点的X坐标都相当于乘以sx因子,所有点的Y坐标都相当于乘以sy因子 */
CG_EXTERN void CGContextScaleCTM(CGContextRef cg_nullable c,
                                 CGFloat sx, CGFloat sy)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Translate the current graphics state's transformation matrix (the CTM) by
 `(tx, ty)'. */
//平移坐标系统
//相当于把原来位于(0,0)位置的坐标原点平移到(tx,ty)点,在平移后的坐标系统上绘制图形时,所有坐标点的X坐标都相当于
//增加了tx,所有点的Y坐标都相当于增加了ty.
CG_EXTERN void CGContextTranslateCTM(CGContextRef cg_nullable c,
                                     CGFloat tx, CGFloat ty)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Rotate the current graphics state's transformation matrix (the CTM) by
 `angle' radians. */

/* 旋转坐标系统控制坐标系统旋转了angle弧度,在缩放后的坐标系统上绘制图形时,所有坐标点的X,Y坐标都相当于旋转了angle弧度之后的坐标 */
CG_EXTERN void CGContextRotateCTM(CGContextRef cg_nullable c, CGFloat angle)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Concatenate the current graphics state's transformation matrix (the CTM)
 with the affine transform `transform'. */
//矩阵变换
//使用transform变换矩阵对CGContextRef的坐标系统执行变换,通过使用坐标矩阵可以对坐标系统实行任意变换.
CG_EXTERN void CGContextConcatCTM(CGContextRef cg_nullable c,
                                  CGAffineTransform transform)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return the current graphics state's transformation matrix. Returns
 CGAffineTransformIdentity in case of inavlid context. */
//获取CGContextRef的坐标系统的变换矩阵
CG_EXTERN CGAffineTransform CGContextGetCTM(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Drawing attribute functions. **/
#pragma mark - 绘制描述相关方法

/* Set the line width in the current graphics state to `width'. */
//设置绘制直线,边框时的线条宽度
CG_EXTERN void CGContextSetLineWidth(CGContextRef cg_nullable c, CGFloat width)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the line cap in the current graphics state to `cap'. */
//设置线段端点的绘制形状, CGLineCap:枚举
CG_EXTERN void CGContextSetLineCap(CGContextRef cg_nullable c, CGLineCap cap)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the line join in the current graphics state to `join'. */
//设置线条连接点的风格,CGLineJoin 枚举
CG_EXTERN void CGContextSetLineJoin(CGContextRef cg_nullable c, CGLineJoin join)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the miter limit in the current graphics state to `limit'. */
//当把连接点风格设置为Meter风格时,该方法用于控制锐角箭头的长度
CG_EXTERN void CGContextSetMiterLimit(CGContextRef cg_nullable c, CGFloat limit)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the line dash patttern in the current graphics state of `c'. */
//设置绘制边框时所用的点线模式,Quarz 2D支持非常强大的点线模式,(虚线)
//第二个参数:指定点线的相位
//第三个参数:数组{长度:间距.....}
//{2,3}代表实线长度为2,间距为3的虚线
//{2,3,1}代表实线长度为2,间距为3,长为1的实线,距离为2的间距,长度为3的实线,距离为1的间距....的点线模式
//{5,3,1,2}代表长度为5的实线,距离为3的间距,长为1的实线,距离为2的间距,长度为5的实线....的点线模式
CG_EXTERN void CGContextSetLineDash(CGContextRef cg_nullable c, CGFloat phase,
                                    const CGFloat * __nullable lengths, size_t count)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the path flatness parameter in the current graphics state of `c' to
 `flatness'. */

CG_EXTERN void CGContextSetFlatness(CGContextRef cg_nullable c, CGFloat flatness)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the alpha value in the current graphics state of `c' to `alpha'. */
//设置全局透明度
CG_EXTERN void CGContextSetAlpha(CGContextRef cg_nullable c, CGFloat alpha)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the blend mode of `context' to `mode'. */
//设置CGContextRef的叠加模式,Quarz 2D支持多种叠加模式
CG_EXTERN void CGContextSetBlendMode(CGContextRef cg_nullable c, CGBlendMode mode)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/** Path construction functions. **/
#pragma mark - 路径CGPath结构方法----------
/* Note that a context has a single path in use at any time: a path is not
 part of the graphics state. */

/* Begin a new path. The old path is discarded. */
//开始定义路径
CG_EXTERN void CGContextBeginPath(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Start a new subpath at point `(x, y)' in the context's path. */
//把CGContextRef的当前路径的结束点移动到x,y对应的点
CG_EXTERN void CGContextMoveToPoint(CGContextRef cg_nullable c,
                                    CGFloat x, CGFloat y)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Append a straight line segment from the current point to `(x, y)'. */
//把CGContextRef的当前路径从当前结束点连接到x,y对应的点
CG_EXTERN void CGContextAddLineToPoint(CGContextRef cg_nullable c,
                                       CGFloat x, CGFloat y)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Append a cubic Bezier curve from the current point to `(x,y)', with
 control points `(cp1x, cp1y)' and `(cp2x, cp2y)'. */
//向CGContextRef的当前路径上添加一段贝塞尔曲线(四个点)
//起点:路径的当前点
//结束点:x,y.
//控制点:(cp1x,cp1y),(cp2x,cp2y)
CG_EXTERN void CGContextAddCurveToPoint(CGContextRef cg_nullable c, CGFloat cp1x,
                                        CGFloat cp1y, CGFloat cp2x, CGFloat cp2y, CGFloat x, CGFloat y)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Append a quadratic curve from the current point to `(x, y)', with control
 point `(cpx, cpy)'. */
//向CGContextRef的当前路径上添加一段二次曲线(起点,结束点,控制点)
//起点:路径的当前点
//结束点:(x,y)
//控制点:(cpx,cpy)
CG_EXTERN void CGContextAddQuadCurveToPoint(CGContextRef cg_nullable c,
                                            CGFloat cpx, CGFloat cpy, CGFloat x, CGFloat y)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Close the current subpath of the context's path. */
//关闭前面定义的路径
CG_EXTERN void CGContextClosePath(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Path construction convenience functions. **/

/* Add a single rect to the context's path. */
//向CGContextRef的当前路径上添加一个矩形
CG_EXTERN void CGContextAddRect(CGContextRef cg_nullable c, CGRect rect)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Add a set of rects to the context's path. */
//向CGContextRef的当前路径上添加多个矩形
CG_EXTERN void CGContextAddRects(CGContextRef cg_nullable c,
                                 const CGRect * __nullable rects, size_t count)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Add a set of lines to the context's path. */
//向CGContextRef的当前路径上添加多条线段,该方法需要传入N个CGPoint组成的数组,其中1,2个点组成第一条线段,2,3点组成第二条线段,以此类推
CG_EXTERN void CGContextAddLines(CGContextRef cg_nullable c,
                                 const CGPoint * __nullable points, size_t count)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Add an ellipse inside `rect' to the current path of `context'. See the
 function `CGPathAddEllipseInRect' for more information on how the path
 for the ellipse is constructed. */
//向CGContextRef的当前路径上添加一个椭圆
CG_EXTERN void CGContextAddEllipseInRect(CGContextRef cg_nullable c, CGRect rect)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Add an arc of a circle to the context's path, possibly preceded by a
 straight line segment. `(x, y)' is the center of the arc; `radius' is its
 radius; `startAngle' is the angle to the first endpoint of the arc;
 `endAngle' is the angle to the second endpoint of the arc; and
 `clockwise' is 1 if the arc is to be drawn clockwise, 0 otherwise.
 `startAngle' and `endAngle' are measured in radians. */
//向CGContextRef的当前路径上添加一段弧,与前一个方法只是定义弧的方式不同,
CG_EXTERN void CGContextAddArc(CGContextRef cg_nullable c, CGFloat x, CGFloat y,
                               CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Add an arc of a circle to the context's path, possibly preceded by a
 straight line segment. `radius' is the radius of the arc. The arc is
 tangent to the line from the current point to `(x1, y1)', and the line
 from `(x1, y1)' to `(x2, y2)'. */
//向CGContextRef的当前路径上添加一段弧
CG_EXTERN void CGContextAddArcToPoint(CGContextRef cg_nullable c,
                                      CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2, CGFloat radius)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Add `path' to the path of context. The points in `path' are transformed
 by the CTM of context before they are added. */
//将已有的CGPathRef代表的路径添加到当前CGContextRef的路径中
CG_EXTERN void CGContextAddPath(CGContextRef cg_nullable c,
                                CGPathRef cg_nullable path)
CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);

/** Path stroking. **/
#pragma mark - 路径stroking
/* Replace the path in `context' with the stroked version of the path, using
 the parameters of `context' to calculate the stroked path. The resulting
 path is created such that filling it with the appropriate color will
 produce the same results as stroking the original path. You can use this
 path in the same way you can use the path of any context; for example,
 you can clip to the stroked version of a path by calling this function
 followed by a call to "CGContextClip". */

//使用绘制当前路径时覆盖的区域作为当前CGContextRef中的新路径,举例来说,加入当前CGContextRef包含一个圆形路径且线宽为10,
//调用该方法后,当前的CGContextRef将包含一个环宽为10的环形路径

CG_EXTERN void CGContextReplacePathWithStrokedPath(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/** Path information functions. **/
#pragma mark - CGPath路径信息方法--------
/* Return true if the path of `context' contains no elements, false
 otherwise. */
//用于判断指定CGContextRef包含的路径是否为空
CG_EXTERN bool CGContextIsPathEmpty(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return the current point of the current subpath of the path of
 `context'. */
///用于返回指定CGContextRef包含的路径的当前点
CG_EXTERN CGPoint CGContextGetPathCurrentPoint(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return the bounding box of the path of `context'. The bounding box is the
 smallest rectangle completely enclosing all points in the path, including
 control points for Bezier and quadratic curves. */
//用于指定CGContextRef中能完整包围所有路径的最小矩形
CG_EXTERN CGRect CGContextGetPathBoundingBox(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return a copy of the path of `context'. The returned path is specified in
 the current user space of `context'. */

CG_EXTERN CGPathRef __nullable CGContextCopyPath(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);

/* Return true if `point' is contained in the current path of `context'. A
 point is contained within a context's path if it is inside the painted
 region when the path is stroked or filled with opaque colors using the
 path drawing mode `mode'. `point' is specified is user space. */

////判断指定CGContextRef包含的路径按指定绘制模式进行绘制时,是否需要绘制point点
CG_EXTERN bool CGContextPathContainsPoint(CGContextRef cg_nullable c,
                                          CGPoint point, CGPathDrawingMode mode)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/** Path drawing functions. **/
#pragma mark - 路径绘制方法
/* Draw the context's path using drawing mode `mode'. */

//使用指定模式绘制当前CGContextRef中所包含的路径
//第二个参数是个枚举
CG_EXTERN void CGContextDrawPath(CGContextRef cg_nullable c,
                                 CGPathDrawingMode mode)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Path drawing convenience functions. **/
#pragma mark - CGPath 路径绘制便利方法-------
/* Fill the context's path using the winding-number fill rule. Any open
 subpath of the path is implicitly closed. */

//填充该路径包围的区域
CG_EXTERN void CGContextFillPath(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Fill the context's path using the even-odd fill rule. Any open subpath of
 the path is implicitly closed. */
//使用奇偶规则来填充改路径包围的区域,奇偶规则是指:如果某个点被路径包围了奇数次,系统绘制该点,
//如果被路径包围了偶数次,系统不会绘制该店填充该路径包围的区域
CG_EXTERN void CGContextEOFillPath(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Stroke the context's path. */
//使用当前CGContextRef设置的线宽绘制路径
CG_EXTERN void CGContextStrokePath(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Fill `rect' with the current fill color. */
//填充rect代表的矩形
CG_EXTERN void CGContextFillRect(CGContextRef cg_nullable c, CGRect rect)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Fill `rects', an array of `count' CGRects, with the current fill
 color. */
//填充多个矩形
CG_EXTERN void CGContextFillRects(CGContextRef cg_nullable c,
                                  const CGRect * __nullable rects, size_t count)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);


/* Stroke `rect' with the current stroke color and the current linewidth. */
//使用当前CGContextRef设置的线宽绘制矩形框
CG_EXTERN void CGContextStrokeRect(CGContextRef cg_nullable c, CGRect rect)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Stroke `rect' with the current stroke color, using `width' as the the
 line width. */
//使用指定线宽绘制矩形框
CG_EXTERN void CGContextStrokeRectWithWidth(CGContextRef cg_nullable c,
                                            CGRect rect, CGFloat width)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Clear `rect' (that is, set the region within the rect to transparent). */
//擦除指定矩形区域上绘制的图形
CG_EXTERN void CGContextClearRect(CGContextRef cg_nullable c, CGRect rect)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Fill an ellipse (an oval) inside `rect'. */
//填充rect矩形的内切圆区域
CG_EXTERN void CGContextFillEllipseInRect(CGContextRef cg_nullable c,
                                          CGRect rect)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Stroke an ellipse (an oval) inside `rect'. */
//使用当前GContextRef设置的线宽绘制rect矩形的内切椭圆
CG_EXTERN void CGContextStrokeEllipseInRect(CGContextRef cg_nullable c,
                                            CGRect rect)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Stroke a sequence of line segments one after another in `context'. The
 line segments are specified by `points', an array of `count' CGPoints.
 This function is equivalent to
 
 CGContextBeginPath(context);
 for (k = 0; k < count; k += 2) {
 CGContextMoveToPoint(context, s[k].x, s[k].y);
 CGContextAddLineToPoint(context, s[k+1].x, s[k+1].y);
 }
 CGContextStrokePath(context); */
//使用当前CGContextRef设置的线宽绘制多条线段,该方法需要传入2N个CGPoint组成的数组,其中1,2两个点组成第一条线段,
//3,4个点组成第二条线段,以此类推
CG_EXTERN void CGContextStrokeLineSegments(CGContextRef cg_nullable c,
                                           const CGPoint * __nullable points, size_t count)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/** Clipping functions. **/
#pragma mark - Clipping functions
/* Intersect the context's path with the current clip path and use the
 resulting path as the clip path for subsequent rendering operations. Use
 the winding-number fill rule for deciding what's inside the path. */

CG_EXTERN void CGContextClip(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Intersect the context's path with the current clip path and use the
 resulting path as the clip path for subsequent rendering operations. Use
 the even-odd fill rule for deciding what's inside the path. */

CG_EXTERN void CGContextEOClip(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Reset the current clip of `c' to the default value. */

CG_EXTERN void CGContextResetClip(CGContextRef c);

/* Add `mask' transformed to `rect' to the clipping area of `context'. The
 mask, which may be either an image mask or an image, is mapped into the
 specified rectangle and intersected with the current clipping area of the
 context.
 
 If `mask' is an image mask, then it clips in a manner identical to the
 behavior if it were used with "CGContextDrawImage": it indicates an area
 to be masked out (left unchanged) when drawing. The source samples of the
 image mask determine which points of the clipping area are changed,
 acting as an "inverse alpha": if the value of a source sample in the
 image mask is S, then the corresponding point in the current clipping
 area will be multiplied by an alpha of (1-S). (For example, if S is 1,
 then the point in the clipping area becomes clear, while if S is 0, the
 point in the clipping area is unchanged.
 
 If `mask' is an image, then it serves as alpha mask and is blended with
 the current clipping area. The source samples of mask determine which
 points of the clipping area are changed: if the value of the source
 sample in mask is S, then the corresponding point in the current clipping
 area will be multiplied by an alpha of S. (For example, if S is 0, then
 the point in the clipping area becomes clear, while if S is 1, the point
 in the clipping area is unchanged.
 
 If `mask' is an image, then it must be in the DeviceGray color space, may
 not have alpha, and may not be masked by an image mask or masking
 color. */

CG_EXTERN void CGContextClipToMask(CGContextRef cg_nullable c, CGRect rect,
                                   CGImageRef cg_nullable mask)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Return the bounding box of the clip path of `c' in user space. The
 bounding box is the smallest rectangle completely enclosing all points in
 the clip. */

CG_EXTERN CGRect CGContextGetClipBoundingBox(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_3, __IPHONE_2_0);

/** Clipping convenience functions. **/
#pragma mark - Clipping convenience functions
/* Intersect the current clipping path with `rect'. Note that this function
 resets the context's path to the empty path. */

CG_EXTERN void CGContextClipToRect(CGContextRef cg_nullable c, CGRect rect)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Intersect the current clipping path with the clipping region formed by
 creating a path consisting of all rects in `rects'. Note that this
 function resets the context's path to the empty path. */

CG_EXTERN void CGContextClipToRects(CGContextRef cg_nullable c,
                                    const CGRect *  rects, size_t count)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Primitive color functions. **/
#pragma mark - Primitive color functions

/* Set the current fill color in the context `c' to `color'. */

CG_EXTERN void CGContextSetFillColorWithColor(CGContextRef cg_nullable c,
                                              CGColorRef cg_nullable color)
CG_AVAILABLE_STARTING(__MAC_10_3, __IPHONE_2_0);

/* Set the current stroke color in the context `c' to `color'. */

CG_EXTERN void CGContextSetStrokeColorWithColor(CGContextRef cg_nullable c,
                                                CGColorRef cg_nullable color)
CG_AVAILABLE_STARTING(__MAC_10_3, __IPHONE_2_0);

/** Color space functions. **/
#pragma mark - 颜色空间函数

/* Set the current fill color space in `context' to `space'. As a
 side-effect, set the fill color to a default value appropriate for the
 color space. */

CG_EXTERN void CGContextSetFillColorSpace(CGContextRef cg_nullable c,
                                          CGColorSpaceRef cg_nullable space)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the current stroke color space in `context' to `space'. As a
 side-effect, set the stroke color to a default value appropriate for the
 color space. */

CG_EXTERN void CGContextSetStrokeColorSpace(CGContextRef cg_nullable c,
                                            CGColorSpaceRef cg_nullable space)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Color functions. **/
#pragma mark - 颜色函数
/* Set the components of the current fill color in `context' to the values
 specifed by `components'. The number of elements in `components' must be
 one greater than the number of components in the current fill color space
 (N color components + 1 alpha component). The current fill color space
 must not be a pattern color space. */

CG_EXTERN void CGContextSetFillColor(CGContextRef cg_nullable c,
                                     const CGFloat * cg_nullable components)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the components of the current stroke color in `context' to the values
 specifed by `components'. The number of elements in `components' must be
 one greater than the number of components in the current stroke color
 space (N color components + 1 alpha component). The current stroke color
 space must not be a pattern color space. */

CG_EXTERN void CGContextSetStrokeColor(CGContextRef cg_nullable c,
                                       const CGFloat * cg_nullable components)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Pattern functions. **/
#pragma mark - 模式填充方法
/* Set the components of the current fill color in `context' to the values
 specifed by `components', and set the current fill pattern to `pattern'.
 The number of elements in `components' must be one greater than the
 number of components in the current fill color space (N color components
 + 1 alpha component). The current fill color space must be a pattern
 color space. */
//设置该CGContextRef使用位图填充
CG_EXTERN void CGContextSetFillPattern(CGContextRef cg_nullable c,
                                       CGPatternRef cg_nullable pattern, const CGFloat * cg_nullable components)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the components of the current stroke color in `context' to the values
 specifed by `components', and set the current stroke pattern to
 `pattern'. The number of elements in `components' must be one greater
 than the number of components in the current stroke color space (N color
 components + 1 alpha component). The current stroke color space must be a
 pattern color space. */
//设置该CGContextRef使用位图绘制线条,边框
CG_EXTERN void CGContextSetStrokePattern(CGContextRef cg_nullable c,
                                         CGPatternRef cg_nullable pattern, const CGFloat * cg_nullable components)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the pattern phase in the current graphics state of `context' to
 `phase'. */
//设置该CGContextRef采取位图填空的相位
CG_EXTERN void CGContextSetPatternPhase(CGContextRef cg_nullable c, CGSize phase)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Color convenience functions. **/
#pragma mark - 颜色便利方法
/* Set the current fill color space in `context' to `DeviceGray' and set the
 components of the current fill color to `(gray, alpha)'. */
//使用灰色来设置该CGContextRef的填充颜色
CG_EXTERN void CGContextSetGrayFillColor(CGContextRef cg_nullable c,
                                         CGFloat gray, CGFloat alpha)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the current stroke color space in `context' to `DeviceGray' and set
 the components of the current stroke color to `(gray, alpha)'. */
//使用灰色来设置该CGContextRef的线条颜色
CG_EXTERN void CGContextSetGrayStrokeColor(CGContextRef cg_nullable c,
                                           CGFloat gray, CGFloat alpha)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the current fill color space in `context' to `DeviceRGB' and set the
 components of the current fill color to `(red, green, blue, alpha)'. */
//使用RGB颜色模式来设置该CGContextRef的填充颜色
CG_EXTERN void CGContextSetRGBFillColor(CGContextRef cg_nullable c, CGFloat red,
                                        CGFloat green, CGFloat blue, CGFloat alpha)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the current stroke color space in `context' to `DeviceRGB' and set
 the components of the current stroke color to `(red, green, blue,
 alpha)'. */
//使用RGB颜色模式来设置该CGContextRef的线条颜色
CG_EXTERN void CGContextSetRGBStrokeColor(CGContextRef cg_nullable c,
                                          CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the current fill color space in `context' to `DeviceCMYK' and set the
 components of the current fill color to `(cyan, magenta, yellow, black,
 alpha)'. */
//使用CMYK颜色模式来设置该CGContextRef的填充颜色
CG_EXTERN void CGContextSetCMYKFillColor(CGContextRef cg_nullable c,
                                         CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the current stroke color space in `context' to `DeviceCMYK' and set
 the components of the current stroke color to `(cyan, magenta, yellow,
 black, alpha)'. */
//使用CMYK颜色模式来设置该CGContextRef的线条颜色
CG_EXTERN void CGContextSetCMYKStrokeColor(CGContextRef cg_nullable c,
                                           CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Rendering intent. **/
#pragma mark - Rendering intent.
/* Set the rendering intent in the current graphics state of `context' to
 `intent'. */

CG_EXTERN void CGContextSetRenderingIntent(CGContextRef cg_nullable c,
                                           CGColorRenderingIntent intent)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Image functions. **/
#pragma mark - Image functions
/* Draw `image' in the rectangular area specified by `rect' in the context
 `c'. The image is scaled, if necessary, to fit into `rect'. */
//将CIImage绘制到Rect区域内
CG_EXTERN void CGContextDrawImage(CGContextRef cg_nullable c, CGRect rect,
                                  CGImageRef cg_nullable image)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Draw `image' tiled in the context `c'. The image is scaled to the size
 specified by `rect' in user space, positioned at the origin of `rect' in
 user space, then replicated, stepping the width of `rect' horizontally
 and the height of `rect' vertically, to fill the current clip region.
 Unlike patterns, the image is tiled in user space, so transformations
 applied to the CTM affect the final result. */
//采用'平铺'模式将image绘制到rect区域内
CG_EXTERN void CGContextDrawTiledImage(CGContextRef cg_nullable c, CGRect rect,
                                       CGImageRef cg_nullable image)
CG_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

/* Return the interpolation quality for image rendering of `context'. The
 interpolation quality is a gstate parameter which controls the level of
 interpolation performed when an image is interpolated (for example, when
 scaling the image). Note that it is merely a hint to the context: not all
 contexts support all interpolation quality levels. */

//获取当前CGContextRef在放大图片时的插值质量
CG_EXTERN CGInterpolationQuality
CGContextGetInterpolationQuality(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the interpolation quality of `context' to `quality'. */
//设置当前CGContextRef在放大图片时的插值质量
CG_EXTERN void CGContextSetInterpolationQuality(CGContextRef cg_nullable c,
                                                CGInterpolationQuality quality)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Shadow support. **/
#pragma mark - 阴影
/* Set the shadow parameters in `context'. `offset' specifies a translation
 in base-space; `blur' is a non-negative number specifying the amount of
 blur; `color' specifies the color of the shadow, which may contain a
 non-opaque alpha value. If `color' is NULL, it's equivalent to specifying
 a fully transparent color. The shadow is a gstate parameter. After a
 shadow is specified, all objects drawn subsequently will be shadowed. To
 turn off shadowing, set the shadow color to a fully transparent color (or
 pass NULL as the color), or use the standard gsave/grestore mechanism. */

//设置阴影在X,Y方向上的偏移,以及模糊度和阴影的颜色
CG_EXTERN void CGContextSetShadowWithColor(CGContextRef cg_nullable c,
                                           CGSize offset, CGFloat blur, CGColorRef __nullable color)
CG_AVAILABLE_STARTING(__MAC_10_3, __IPHONE_2_0);

/* Equivalent to calling
 CGContextSetShadowWithColor(context, offset, blur, color)
 where color is black with 1/3 alpha (i.e., RGBA = {0, 0, 0, 1.0/3.0}) in
 the DeviceRGB color space. */
//设置阴影 在X,Y方向上的偏移,以及模糊度(blur越大,阴影越模糊),该函数没有设置阴影颜色,默认使用1/3透明的黑色(RGBA(0,0,0,1.0/3.0))作为阴影颜色
CG_EXTERN void CGContextSetShadow(CGContextRef cg_nullable c, CGSize offset,
                                  CGFloat blur)
CG_AVAILABLE_STARTING(__MAC_10_3, __IPHONE_2_0);


/** Gradient and shading functions. **/
#pragma mark - 渐变和阴影相关函数
/* Fill the current clipping region of `context' with a linear gradient from
 `startPoint' to `endPoint'. The location 0 of `gradient' corresponds to
 `startPoint'; the location 1 of `gradient' corresponds to `endPoint';
 colors are linearly interpolated between these two points based on the
 values of the gradient's locations. The option flags control whether the
 gradient is drawn before the start point or after the end point. */
//设置线性渐变填充,
//第二个参数:渐变对象(渐变颜色)
//参数3:线性渐变的开始点
//参数4:线性渐变的结束点
//参数5:配置选项
//kCGGradientDrawsBeforeStartLocation 扩展填充起始点之前的区域
//kCGGradientDrawsAfterEndLocation    扩展填充结束点之后的区域
CG_EXTERN void CGContextDrawLinearGradient(CGContextRef cg_nullable c,
                                           CGGradientRef cg_nullable gradient, CGPoint startPoint, CGPoint endPoint,
                                           CGGradientDrawingOptions options)
CG_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

/* Fill the current clipping region of `context' with a radial gradient
 between two circles defined by the center point and radius of each
 circle. The location 0 of `gradient' corresponds to a circle centered at
 `startCenter' with radius `startRadius'; the location 1 of `gradient'
 corresponds to a circle centered at `endCenter' with radius `endRadius';
 colors are linearly interpolated between these two circles based on the
 values of the gradient's locations. The option flags control whether the
 gradient is drawn before the start circle or after the end circle. */

//设置圆形渐变填充
//参数2:渐变对象
//参数3:起始圆的圆心
//参数4:起始圆的半径
//参数5:结束圆的圆心
//参数6:结束圆的半径
//参数7:配置
CG_EXTERN void CGContextDrawRadialGradient(CGContextRef cg_nullable c,
                                           CGGradientRef cg_nullable gradient, CGPoint startCenter, CGFloat startRadius,
                                           CGPoint endCenter, CGFloat endRadius, CGGradientDrawingOptions options)
CG_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

/* Fill the current clipping region of `context' with `shading'. */

CG_EXTERN void CGContextDrawShading(CGContextRef cg_nullable c,
                                    cg_nullable CGShadingRef shading)
CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);

/** Text functions. **/

/* Set the current character spacing in `context' to `spacing'. The
 character spacing is added to the displacement between the origin of one
 character and the origin of the next. */
//设置该CGContextRef中绘制文本的字符间距
CG_EXTERN void CGContextSetCharacterSpacing(CGContextRef cg_nullable c,
                                            CGFloat spacing)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the user-space point at which text will be drawn in the context `c'
 to `(x, y)'. */
//设置CGContextRef的一个文本的绘制位置
CG_EXTERN void CGContextSetTextPosition(CGContextRef cg_nullable c,
                                        CGFloat x, CGFloat y)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return the user-space point at which text will be drawn in `context'. */
//获取该CGContextRef中当前绘制文本的位置
CG_EXTERN CGPoint CGContextGetTextPosition(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the text matrix in the context `c' to `t'. */
//设置对将要绘制的文本执行指定的变换
CG_EXTERN void CGContextSetTextMatrix(CGContextRef cg_nullable c,
                                      CGAffineTransform t)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Return the text matrix in the context `c'. Returns CGAffineTransformIdentity
 if `c' is not a valid context. */
//获取当前对文本执行变换的变换矩阵
CG_EXTERN CGAffineTransform CGContextGetTextMatrix(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the text drawing mode in the current graphics state of the context
 `c' to `mode'. */
//设置该CGContextRef绘制文本的绘制模式
//kCGTextFill
//kCGTextStroke
//KCGTextFillStroke
CG_EXTERN void CGContextSetTextDrawingMode(CGContextRef cg_nullable c,
                                           CGTextDrawingMode mode)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the font in the current graphics state of the context `c' to
 `font'. */
//设置该CGContextRef中绘制文本的字体
CG_EXTERN void CGContextSetFont(CGContextRef cg_nullable c,
                                CGFontRef cg_nullable font)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Set the font size in the current graphics state of the context `c' to
 `size'. */
//设置该CGContextRef中绘制文本的字体大小
CG_EXTERN void CGContextSetFontSize(CGContextRef cg_nullable c, CGFloat size)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Draw `glyphs', an array of `count' CGGlyphs, at the points specified by
 `positions'. Each element of `positions' specifies the position from the
 associated glyph; the positions are specified in user space. */

CG_EXTERN void CGContextShowGlyphsAtPositions(CGContextRef cg_nullable c,
                                              const CGGlyph * cg_nullable glyphs, const CGPoint * cg_nullable Lpositions,
                                              size_t count)
CG_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

/** PDF functions. **/

/* Draw `page' in the current user space of the context `c'. */

CG_EXTERN void CGContextDrawPDFPage(CGContextRef cg_nullable c,
                                    CGPDFPageRef cg_nullable page)
CG_AVAILABLE_STARTING(__MAC_10_3, __IPHONE_2_0);

/** Output page functions. **/

/* Begin a new page. */

CG_EXTERN void CGContextBeginPage(CGContextRef cg_nullable c,
                                  const CGRect * __nullable mediaBox)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* End the current page. */

CG_EXTERN void CGContextEndPage(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Context functions. **/

/* Equivalent to `CFRetain(c)'. */

CG_EXTERN CGContextRef cg_nullable CGContextRetain(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Equivalent to `CFRelease(c)'. */

CG_EXTERN void CGContextRelease(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Flush all drawing to the destination. */

CG_EXTERN void CGContextFlush(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Synchronized drawing. */

CG_EXTERN void CGContextSynchronize(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/** Antialiasing functions. **/

/* Turn on antialiasing if `shouldAntialias' is true; turn it off otherwise.
 This parameter is part of the graphics state. */
//设置该CGContextRef是否应该抗锯齿(即光滑图形曲线边缘)
CG_EXTERN void CGContextSetShouldAntialias(CGContextRef cg_nullable c,
                                           bool shouldAntialias)
CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/* Allow antialiasing in `context' if `allowsAntialiasing' is true; don't
 allow it otherwise. This parameter is not part of the graphics state. A
 context will perform antialiasing if both `allowsAntialiasing' and the
 graphics state parameter `shouldAntialias' are true. */
//设置该CGContextRef是否允许抗锯齿
CG_EXTERN void CGContextSetAllowsAntialiasing(CGContextRef cg_nullable c,
                                              bool allowsAntialiasing)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/** Font display functions. **/

/* Turn on font smoothing if `shouldSmoothFonts' is true; turn it off
 otherwise. This parameter is part of the graphics state. Note that this
 doesn't guarantee that font smoothing will occur: not all destination
 contexts support font smoothing. */
//设置该CGContextRef是否允许光滑字体
CG_EXTERN void CGContextSetShouldSmoothFonts(CGContextRef cg_nullable c,
                                             bool shouldSmoothFonts)
CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);

/* If `allowsFontSmoothing' is true, then allow font smoothing when
 displaying text in `context'; otherwise, don't allow font smoothing. This
 parameter is not part of the graphics state. Fonts will be smoothed if
 they are antialiased when drawn and if both `allowsFontSmoothing' and the
 graphics state parameter `shouldSmoothFonts' are true. */
//设置该CGContextRef是否允许光滑字体
CG_EXTERN void CGContextSetAllowsFontSmoothing(CGContextRef cg_nullable c,
                                               bool allowsFontSmoothing)
CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);

/* If `shouldSubpixelPositionFonts' is true, then glyphs may be placed at
 subpixel positions (if allowed) when displaying text in `context';
 otherwise, glyphs will be forced to integer pixel boundaries. This
 parameter is part of the graphics state. */

CG_EXTERN void CGContextSetShouldSubpixelPositionFonts(
                                                       CGContextRef cg_nullable c, bool shouldSubpixelPositionFonts)
CG_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

/* If `allowsFontSubpixelPositioning' is true, then allow font subpixel
 positioning when displaying text in `context'; otherwise, don't allow
 subpixel positioning. This parameter is not part of the graphics state. A
 context will place glyphs at subpixel positions if fonts will be
 antialiased when drawn and if both `allowsFontSubpixelPositioning' and
 the graphics state parameter `shouldSubpixelPositionFonts' are true. */

CG_EXTERN void CGContextSetAllowsFontSubpixelPositioning(
                                                         CGContextRef cg_nullable c, bool allowsFontSubpixelPositioning)
CG_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

/* If `shouldSubpixelQuantizeFonts' is true, then quantize the subpixel
 positions of glyphs when displaying text in `context'; otherwise, don't
 quantize the subpixel positions. This parameter is part of the graphics
 state. */

CG_EXTERN void CGContextSetShouldSubpixelQuantizeFonts(
                                                       CGContextRef cg_nullable c, bool shouldSubpixelQuantizeFonts)
CG_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

/* If `allowsFontSubpixelQuantization' is true, then allow font subpixel
 quantization when displaying text in `context'; otherwise, don't allow
 subpixel quantization. This parameter is not part of the graphics state.
 A context quantizes subpixel positions if glyphs will be drawn at
 subpixel positions and `allowsFontSubpixelQuantization' and the graphics
 state parameter `shouldSubpixelQuantizeFonts' are both true. */

CG_EXTERN void CGContextSetAllowsFontSubpixelQuantization(
                                                          CGContextRef cg_nullable c, bool allowsFontSubpixelQuantization)
CG_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

/** Transparency layer support. **/

/* Begin a transparency layer in `context'. All subsequent drawing
 operations until a corresponding `CGContextEndTransparencyLayer' are
 composited into a fully transparent backdrop (which is treated as a
 separate destination buffer from the context). After the transparency
 layer is ended, the result is composited into the context using the
 global alpha and shadow state of the context. This operation respects the
 clipping region of the context. After a call to this function, all of the
 parameters in the graphics state remain unchanged with the exception of
 the following:
 - The global alpha is set to 1.
 - The shadow is turned off.
 - The blend mode is set to `kCGBlendModeNormal'.
 Ending the transparency layer restores these parameters to the values
 they had before `CGContextBeginTransparencyLayer' was called.
 Transparency layers may be nested. */

CG_EXTERN void CGContextBeginTransparencyLayer(CGContextRef cg_nullable c,
                                               CFDictionaryRef __nullable auxiliaryInfo)
CG_AVAILABLE_STARTING(__MAC_10_3, __IPHONE_2_0);

/* Begin a transparency layer in `context'. This function is identical to
 `CGContextBeginTransparencyLayer' except that the content of the
 transparency layer will be bounded by `rect' (specified in user space). */

CG_EXTERN void CGContextBeginTransparencyLayerWithRect(
                                                       CGContextRef cg_nullable c, CGRect rect, CFDictionaryRef __nullable auxInfo)
CG_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

/* End a tranparency layer. */

CG_EXTERN void CGContextEndTransparencyLayer(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_3, __IPHONE_2_0);

/** User space to device space tranformations. **/

/* Return the affine transform mapping the user space (abstract coordinates)
 of `context' to device space (pixels). */

CG_EXTERN CGAffineTransform
CGContextGetUserSpaceToDeviceSpaceTransform(CGContextRef cg_nullable c)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Transform `point' from the user space of `context' to device space. */

CG_EXTERN CGPoint CGContextConvertPointToDeviceSpace(CGContextRef cg_nullable c,
                                                     CGPoint point)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Transform `point' from device space to the user space of `context'. */

CG_EXTERN CGPoint CGContextConvertPointToUserSpace(CGContextRef cg_nullable c,
                                                   CGPoint point)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Transform `size' from the user space of `context' to device space. */

CG_EXTERN CGSize CGContextConvertSizeToDeviceSpace(CGContextRef cg_nullable c,
                                                   CGSize size)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Transform `size' from device space to the user space of `context'. */

CG_EXTERN CGSize CGContextConvertSizeToUserSpace(CGContextRef cg_nullable c,
                                                 CGSize size)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Transform `rect' from the user space of `context' to device space. Since
 affine transforms do not preserve rectangles in general, this function
 returns the smallest rectangle which contains the transformed corner
 points of `rect'. */

CG_EXTERN CGRect CGContextConvertRectToDeviceSpace(CGContextRef cg_nullable c,
                                                   CGRect rect)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/* Transform `rect' from device space to the user space of `context'. Since
 affine transforms do not preserve rectangles in general, this function
 returns the smallest rectangle which contains the transformed corner
 points of `rect'. */

CG_EXTERN CGRect CGContextConvertRectToUserSpace(CGContextRef cg_nullable c,
                                                 CGRect rect)
CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

/** Deprecated functions. **/

/* DEPRECATED; use the CoreText API instead. */
//失效 CoreText
//设置该CGContextRef当前绘制文本的字体,字体大小
CG_EXTERN void CGContextSelectFont(CGContextRef cg_nullable c,
                                   const char * cg_nullable name, CGFloat size, CGTextEncoding textEncoding)
CG_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_9,
                            __IPHONE_2_0, __IPHONE_7_0);

/* DEPRECATED; use the CoreText API instead. */
//控制CGContextRef在当前绘制点绘制指定文本
CG_EXTERN void CGContextShowText(CGContextRef cg_nullable c,
                                 const char * cg_nullable string, size_t length)
CG_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_9,
                            __IPHONE_2_0, __IPHONE_7_0);

/* DEPRECATED; use the CoreText API instead. */
//////控制CGContextRef在指定绘制点绘制指定文本
CG_EXTERN void CGContextShowTextAtPoint(CGContextRef cg_nullable c,
                                        CGFloat x, CGFloat y, const char * cg_nullable string, size_t length)
CG_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_9,
                            __IPHONE_2_0, __IPHONE_7_0);

/* DEPRECATED; use the CoreText API instead. */

CG_EXTERN void CGContextShowGlyphs(CGContextRef cg_nullable c,
                                   const CGGlyph * __nullable g, size_t count)
CG_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_9,
                            __IPHONE_2_0, __IPHONE_7_0);

/* DEPRECATED; use the CoreText API instead. */

CG_EXTERN void CGContextShowGlyphsAtPoint(CGContextRef cg_nullable c, CGFloat x,
                                          CGFloat y, const CGGlyph * __nullable glyphs, size_t count)
CG_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_9,
                            __IPHONE_2_0, __IPHONE_7_0);

/* DEPRECATED; use the CoreText API instead. */

CG_EXTERN void CGContextShowGlyphsWithAdvances(CGContextRef cg_nullable c,
                                               const CGGlyph * __nullable glyphs, const CGSize * __nullable advances,
                                               size_t count)
CG_AVAILABLE_BUT_DEPRECATED(__MAC_10_3, __MAC_10_9,
                            __IPHONE_2_0, __IPHONE_7_0);

/* DEPRECATED; use the CGPDFPage API instead. */

CG_EXTERN void CGContextDrawPDFDocument(CGContextRef cg_nullable c, CGRect rect,
                                        CGPDFDocumentRef cg_nullable document, int page)
CG_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_5,
                            __IPHONE_NA, __IPHONE_NA);

CF_ASSUME_NONNULL_END

CF_IMPLICIT_BRIDGING_DISABLED

#endif /* CGCONTEXT_H_ */



#endif /* CGContextRef_h */
