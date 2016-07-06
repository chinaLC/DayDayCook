//
//  YXLoginViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXLoginViewController.h"
static NSString *const storyBoardID = @"YXLoginViewController";
@interface YXLoginViewController ()
//账号
@property (weak, nonatomic) IBOutlet UITextField *name;
//密码
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation YXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self = [storyBoard instantiateViewControllerWithIdentifier:storyBoardID];
    }
    return self;
}
//左上角X返回上一页
- (IBAction)dismissToLastPage:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//登录按钮
- (IBAction)clickTheBtnForLogin:(UIButton *)sender {
    NSLog(@"登录");
}
//注册按钮
- (IBAction)clickTheBtnForRegister:(UIButton *)sender {
    NSLog(@"注册");
}
//忘记密码
- (IBAction)clickTheBtnForForgetThePassword:(UIButton *)sender {
    NSLog(@"忘记密码");
}
//快速登录微信
- (IBAction)clickTheBtnForFastLoginWechat:(UIButton *)sender {
    NSLog(@"快速登录微信");
}
//快速登录微博
- (IBAction)clickTheBtnForFastLoginWeibo:(UIButton *)sender {
    NSLog(@"快速登录微博");
}
//快速登录QQ
- (IBAction)clickTheBtnForFastLoginQQ:(UIButton *)sender {
    NSLog(@"快速登录QQ");
}


@end
