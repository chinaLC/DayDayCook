//
//  YXRegisterViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXRegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
static NSString *const storyBoardID = @"YXRegisterViewController";
@interface YXRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *messagerNumber;
@property (weak, nonatomic) IBOutlet UITextField *secret;
@end
static int tim = 0;
@implementation YXRegisterViewController{
    NSTimer *timer;
}
#pragma mark - init
- (instancetype)initWithViewControllerMode:(ViewControllerMode)viewControllerMode
{
    self = [super init];
    if (self) {
        _viewControllerMode = viewControllerMode;
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self = [storyBoard instantiateViewControllerWithIdentifier:storyBoardID];
    }
    return self;
}
- (instancetype)init
{
    NSAssert1(NO, @"必须使用(instancetype)initWithControllerMode:初始化 %s", __FUNCTION__);
    return nil;
}
#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:@"back_white".yx_image style:UIBarButtonItemStyleDone target:self action:@selector(clickTheBtnBackToLastPage:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
//    UILabel *_label = [[UILabel alloc] init];
//    [self.bottomView addSubview:_label];
//    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(90);
//        make.centerX.equalTo(0);
//    }];
//    _label.font = [UIFont systemFontOfSize:15];
//    if (self.viewControllerMode == ViewControllerModeRegister) {
//        _label.text = @"我已阅读并同意";
//    }else {
//        _label.text = @"";
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.secret) {
        [self clickUpTheButtonComplete:nil];
        [self.secret resignFirstResponder];
    }
    
    return YES;
}
#pragma mark - Method
//点击完成按钮
- (IBAction)clickUpTheButtonComplete:(UIButton *)sender {
    if (self.secret.text.length < 1) {
        [self.tableView showWarning:@"请设置密码"];
        return;
    }
    [self.tableView showBusyHUD];
    [[NSOperationQueue new]addOperationWithBlock:^{
        [SMSSDK commitVerificationCode:self.messagerNumber.text phoneNumber:self.phoneNumber.text zone:@"86" result:^(NSError *error) {
            [self.tableView hideBusyHUD];
            if (error) {
                NSLog(@"error:%@",error);
                [self.tableView showWarning:@"验证码不正确"];
                return;
            }
        }];
    }];
    //注册
}
//获取验证码
- (IBAction)clickUpTheButtonGetMessager:(UIButton *)sender {
    if (self.phoneNumber.text.length != 11) {
        [self.tableView showWarning:@"请输入正确的手机号"];
        return;
    }
    [[NSOperationQueue new]addOperationWithBlock:^{
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumber.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (error) {
                NSLog(@"error:%@",error);
                return;
            }
        }];
    }];
    [timer invalidate];
    timer = nil;
    sender.enabled = NO;
    sender.backgroundColor = [UIColor lightGrayColor];
    [sender setTitle:@"60秒后重发" forState:UIControlStateDisabled];
    tim = 60;
    timer = [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        tim --;
        NSString *str = [NSString stringWithFormat:@"%d秒后重发",tim];
        [sender setTitle:str forState:UIControlStateDisabled];
        if (tim == 0) {
            sender.enabled = YES;
            [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor orangeColor];
        }
    } repeats:YES];
}
- (void)clickTheBtnBackToLastPage:sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
