//
//  CGBlendViewController.m
//  HeaderNote
//
//  Created by Rhino on 2017/7/26.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CGBlendViewController.h"
#import "CGBlendView.h"

static NSString *blendModes[] = {
    @"Normal",
    @"Multiply",
    @"Screen",
    @"Overlay",
    @"Darken",
    @"Lighten",
    @"ColorDodge",
    @"ColorBurn",
    @"SoftLight",
    @"HardLight",
    @"Difference",
    @"Exclusion",
    @"Hue",
    @"Saturation",
    @"Color",
    @"Luminosity",
    @"Clear",
    @"Copy",
    @"SourceIn",
    @"SourceOut",
    @"SourceAtop",
    @"DestinationOver",
    @"DestinationIn",
    @"DestinationOut",
    @"DestinationAtop",
    @"XOR",
    @"PlusDarker",
    @"PlusLighter"
};
static NSInteger blendModeCount = sizeof(blendModes)/sizeof(blendModes[0]);

@interface CGBlendViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) CGBlendView *blendView;
@property (nonatomic, strong) NSArray *colors;

@end

@implementation CGBlendViewController

CGFloat luminanceForColor(UIColor *color){
    //获取UIColor对应的CGColorRef
    CGColorRef cgColor = color.CGColor;
    //获取个颜色组件的值
    const CGFloat *components = CGColorGetComponents(cgColor);
    CGFloat luminance = 0.0;
    //获取颜色模式,根据不同的颜色模式采用不同的方式来计算颜色的亮度
    switch (CGColorSpaceGetModel(CGColorGetColorSpace(cgColor))) {
            //单色模式的颜色
        case kCGColorSpaceModelMonochrome:
            //亮度
            luminance = components[0];
            break;
            //RGB模式的颜色
        case kCGColorSpaceModelRGB:
            //乘以特定的系数的累加和
            luminance = 0.2126 * components[0] + 0.7152 *components[1] + 0.0722 * components[2];
            break;
            //暂不实现
        default:
            luminance = 2.0;
            break;
    }
    
    return luminance;
}

//根据颜色的亮度值进行排序
NSInteger colorSortByLuminance(id color1,id color2,void *context){
    CGFloat luminance1 = luminanceForColor(color1);
    CGFloat luminance2 = luminanceForColor(color2);
    if (luminance1 == luminance2) {
        return NSOrderedSame;
    }
    else if(luminance1 < luminance2){
        return NSOrderedAscending;
    }
    else{
        return NSOrderedDescending;
    }
}

- (NSArray *)colors{
    static NSArray *colorArray = nil;
    if (colorArray == nil) {
        NSArray *unsortedArray = @[[UIColor redColor],
                                   [UIColor greenColor],
                                   [UIColor blueColor],
                                   [UIColor yellowColor],
                                   [UIColor magentaColor],
                                   [UIColor cyanColor],
                                   [UIColor orangeColor],
                                   [UIColor purpleColor],
                                   [UIColor brownColor],
                                   [UIColor whiteColor],
                                   [UIColor lightGrayColor],
                                   [UIColor darkGrayColor],
                                   [UIColor blackColor]
                                   ];
        colorArray = [unsortedArray sortedArrayUsingFunction:colorSortByLuminance context:nil];
    }
    return colorArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width, 200)];
    self.picker.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.picker];

    self.picker.delegate = self;
    self.picker.dataSource = self;

    self.blendView = [[CGBlendView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.view addSubview:self.blendView];

    //默认选中位置
    [self.picker selectRow:[self.colors indexOfObject:_blendView.destinationColor] inComponent:0 animated:NO];
    [self.picker selectRow:[self.colors indexOfObject:_blendView.sourceColor] inComponent:1 animated:NO];
    [self.picker selectRow:_blendView.blendMode inComponent:2 animated:NO];
    

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger numComps = 0;
    switch (component) {
        case 0:
        case 1:
            numComps = self.colors.count;
            break;
        case 2:
            numComps = blendModeCount;
            break;
        default:
            break;
    }
    return numComps;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    CGFloat width = 0;
    switch (component) {
        case 0:
        case 1:
            width = 48;
            break;
        case 2:
            width = 192;
            break;
    }
    return width;
}

#define kColorTag 1
#define kLabelTag 2
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    switch (component) {
        case 0:
        case 1:
            if (view.tag != kColorTag) {
                CGRect frame = CGRectZero;
                frame.size = [pickerView rowSizeForComponent:component];
                frame = CGRectInset(frame, 4.0, 4.0);
                view = [[UIView alloc]initWithFrame:frame];
                view.tag = kColorTag;
                //不允许交互
                view.userInteractionEnabled = NO;
            }
            view.backgroundColor = [self.colors objectAtIndex:row];
            break;
        case 2:
            if (view.tag != kLabelTag) {
                CGRect frame = CGRectZero;
                frame.size = [pickerView rowSizeForComponent:component];
                frame = CGRectInset(frame, 4.0, 4.0);
                view = [[UILabel alloc]initWithFrame:frame];
                view.tag = kLabelTag;
                view.opaque = NO;
                view.backgroundColor = [UIColor clearColor];
                //不允许交互
                view.userInteractionEnabled = NO;
            }
            UILabel *label = (UILabel *)view;
            label.textColor = [UIColor blackColor];
            label.text = blendModes[row];
            label.font = [UIFont boldSystemFontOfSize:18];
            break;
    }
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.blendView.destinationColor = [self.colors objectAtIndex:[pickerView selectedRowInComponent:0]];
    self.blendView.sourceColor = [self.colors objectAtIndex:[pickerView selectedRowInComponent:1]];
    self.blendView.blendMode = (int)[pickerView selectedRowInComponent:2];
    
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
