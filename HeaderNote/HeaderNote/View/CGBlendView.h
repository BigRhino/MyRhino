//
//  CGBlendView.h
//  HeaderNote
//
//  Created by Rhino on 2017/7/26.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGBlendView : UIView

@property (nonatomic, strong) UIColor *sourceColor;
@property (nonatomic, strong) UIColor *destinationColor;
@property (nonatomic, assign) CGBlendMode blendMode;

@end
