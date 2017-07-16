//
//  AddUserViewController.m
//  SQLite3Demo
//
//  Created by Rhino on 2017/7/16.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "AddUserViewController.h"
#import "ContactModel.h"
#import "DBManage.h"

#define TextField_Origin_Tag 10

@interface AddUserViewController ()

@end

@implementation AddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI{
    self.title = @"添加联系人";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = item;
    
    NSArray *titles = @[@"姓名",@"电话",@"邮箱",@"头像",@"备注"];
    
    //把输入框加上
    for (int i = 0; i <5;i ++) {
        UILabel *lable = [[UILabel alloc]init];
        lable.frame = CGRectMake(10, 80 + (30 +10)*i, 60, 30);
        lable.text = titles[i];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = [UIColor grayColor];
        
        [self.view addSubview:lable];
        
        UITextField *textField = [[UITextField alloc]init];
        textField.frame = CGRectMake(CGRectGetMaxX(lable.frame)+10, lable.frame.origin.y, self.view.bounds.size.width - 10 * 3 - 60, 30);
        textField.borderStyle = UITextBorderStyleLine;
        textField.tag =TextField_Origin_Tag +i;
        [self.view addSubview:textField];
        
    }
    
    
}
- (void)done{
    
    DBManage *manage = [DBManage defaultDBManager];
    //@[@"姓名",@"电话",@"邮箱",@"头像",@"备注"]
    ContactModel *user = [[ContactModel alloc]init];
    user.name = ((UITextField *)[self.view viewWithTag:TextField_Origin_Tag]).text;
    user.tel = ((UITextField *)[self.view viewWithTag:TextField_Origin_Tag+1]).text;
    
    user.email = ((UITextField *)[self.view viewWithTag:TextField_Origin_Tag+2]).text;
    
    user.head = ((UITextField *)[self.view viewWithTag:TextField_Origin_Tag+3]).text;
    
    user.remark = ((UITextField *)[self.view viewWithTag:TextField_Origin_Tag+4]).text;
    
    
    //要判断是插入新数据 还是修改旧数据
    
    if (self.user) {
        //是修改
        [manage updateUser:self.user toUser:user];
    }else{
        //添加
        
        //存入到数据库
        [manage addUser:user];
    }
    
    
    
    
    
    
    //返回到上一页面
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)setUser:(ContactModel *)user{
    _user = user;
    ((UITextField *)[self.view viewWithTag:TextField_Origin_Tag]).text = user.name;
    ((UITextField *)[self.view viewWithTag:TextField_Origin_Tag+1]).text = user.tel;
    
    ((UITextField *)[self.view viewWithTag:TextField_Origin_Tag+2]).text = user.email;
    
    ((UITextField *)[self.view viewWithTag:TextField_Origin_Tag+3]).text = user.head;
    
    ((UITextField *)[self.view viewWithTag:TextField_Origin_Tag+4]).text = user.remark;
    
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
