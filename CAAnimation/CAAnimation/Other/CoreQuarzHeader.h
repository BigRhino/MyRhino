//
//  CoreQuarzHeader.h
//  CAAnimation
//
//  Created by Rhino on 2017/7/15.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef CoreQuarzHeader_h
#define CoreQuarzHeader_h

//CAAnimation


//CADisplayLink
//CAEAGLLayer
//CAEmitterCell
//CAEmitterLayer
//CAGradientLayer
//CALayer
//CAMediaTiming 提供了动画的持续时间，速度，和重复计数。

//CAAction 为图层触发一个动画动作提供了提供 标准化响应。
/*
 CAMediaTimingFunction 使用贝塞尔曲线来描述动画改变的时间函数。
//kCAMediaTimingFunctionLinear 匀速时间函数,在动画的整个生命周期里面一直保持速度不变
kCAMediaTimingFunctionEaseIn
kCAMediaTimingFunctionEaseOut 渐缓时间函数 在动画接近其生命周期的时候减慢速度。
kCAMediaTimingFunctionEaseInEaseOut
kCAMediaTimingFunctionDefault
 
 */

//CAReplicatorLayer
//CAScrollLayer 是 CALayer 的子类，简化显示图层的一部分内容。CAScrollLayer 对象的滚动区域的范围在它的子图层里面定义。CAScrollLaye 不提供键盘或鼠标事件处理，也不提供可见的滚动条。
//CAShapeLayer
//CATextLayer 可以方便的从字符串或字符串的内容创建一个图层类的内容。
//CATiledLayer 允许递增的显示大而复杂的图片。
/*
 
 CATransaction

 提供了一个图层变化的过渡效果，它能影响图层的整个内容。 动画进行的时候淡入淡出(fade)、推(push)、显露(reveal)图层的内容。这些过渡效 果可以扩展到你自己定制的 Core Image 滤镜。iOS比Mac OS X的转场动画效果少一点
 
 UINavigationController就是通过CATransition实现了将控制器的视图推入屏幕的动画效果.
 
 type:动画过渡类型
 subtype:动画过渡方向
 startProgress:动画起点(在整体动画的百分比)
 endProgress:动画终点(在整体动画的百分比)
 
 */

//CATransform3D
//CATransformLayer
//CAValueFunction

#endif /* CoreQuarzHeader_h */
