//
//  NavigationTitleView.h
//  MyRhino
//
//  Created by Rhino on 2017/3/2.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationTitleView : UIControl

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong, readonly) UILabel *subtitleLabel;
@property (nonatomic, copy) NSString *subtitle;


@end
