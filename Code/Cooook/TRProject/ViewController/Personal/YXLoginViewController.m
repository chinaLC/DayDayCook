//
//  YXLoginViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXLoginViewController.h"
#import "YXRegisterViewController.h"
static NSString *const storyBoardID = @"YXLoginViewController";
@interface YXLoginViewController ()<UITextFieldDelegate>
//账号
@property (weak, nonatomic) IBOutlet UITextField *name;
//密码
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation YXLoginViewController
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.name) {
        [self.password becomeFirstResponder];
    } else if (textField == self.password) {
        [self clickTheBtnForLogin:nil];
        [self.password resignFirstResponder];
    }
    
    return YES;
}
#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.name.returnKeyType = UIReturnKeyNext;
    self.password.returnKeyType = UIReturnKeyGo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - init
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self = [storyBoard instantiateViewControllerWithIdentifier:storyBoardID];
    }
    return self;
}

#pragma mark - Method
//左上角X返回上一页
- (IBAction)dismissToLastPage:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//登录按钮
- (IBAction)clickTheBtnForLogin:(UIButton *)sender {
    DDLogInfo(@"登录");
}
//注册按钮
- (IBAction)clickTheBtnForRegister:(UIButton *)sender {
    YXRegisterViewController *registerVC = [[YXRegisterViewController alloc]initWithViewControllerMode:ViewControllerModeRegister];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:registerVC];
    registerVC.navigationItem.title = @"注册新账号";
    navi.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navi animated:YES completion:nil];
}
//忘记密码
- (IBAction)clickTheBtnForForgetThePassword:(UIButton *)sender {
    YXRegisterViewController *registerVC = [[YXRegisterViewController alloc]initWithViewControllerMode:ViewControllerModeForget];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:registerVC];
    registerVC.navigationItem.title = @"忘记密码";
    navi.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navi animated:YES completion:nil];
}
//快速登录微信
- (IBAction)clickTheBtnForFastLoginWechat:(UIButton *)sender {
    DDLogInfo(@"快速登录微信");
}
//快速登录微博
- (IBAction)clickTheBtnForFastLoginWeibo:(UIButton *)sender {
    DDLogInfo(@"快速登录微博");
}
//快速登录QQ
- (IBAction)clickTheBtnForFastLoginQQ:(UIButton *)sender {
    DDLogInfo(@"快速登录QQ");
}


@end
