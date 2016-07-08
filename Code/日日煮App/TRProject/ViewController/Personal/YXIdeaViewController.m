//
//  YXIdeaViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXIdeaViewController.h"

@interface YXIdeaViewController ()<UITextViewDelegate>

/** idea */
@property (nonatomic, strong) UITextView *ideaTextView;

/** contact */
@property (nonatomic, strong) UITextField *contactTextField;

/** 提交 */
@property (nonatomic, strong) UIButton *bottomBtn;

/** message */
@property (nonatomic, strong) UILabel *messageLabel;

/** 提示message */
@property (nonatomic, strong) UILabel *ideaLabel;
@end

@implementation YXIdeaViewController
#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"意见反馈";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:@"back_white".yx_image style:UIBarButtonItemStyleDone target:self action:@selector(clickTheBtnBackToLastPage:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    [self bottomBtn];
    [self ideaTextView];
    [self contactTextField];
    [self messageLabel];
    [self ideaLabel];
}
#pragma mark - Method
//返回上一页
- (void)clickTheBtnBackToLastPage:sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//提交意见
- (void)clickTheBtnSendTheMessage:sender{
    NSLog(@"提交意见");
}
#pragma mark - LazyLoad 懒加载
- (UIButton *)bottomBtn {
	if(_bottomBtn == nil) {
		_bottomBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_bottomBtn];
        [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(50);
        }];
        _bottomBtn.backgroundColor = kRGBColor(162, 186, 76, 1.0);
        [_bottomBtn setTitle:@"提交 Submit" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(clickTheBtnSendTheMessage:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _bottomBtn;
}

- (UILabel *)messageLabel {
	if(_messageLabel == nil) {
		_messageLabel = [[UILabel alloc] init];
        [self.view addSubview:_messageLabel];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(self.ideaTextView.mas_bottom).equalTo(10);
        }];
        _messageLabel.text = @"您的联系方式 (选填)";
	}
	return _messageLabel;
}


- (UITextField *)contactTextField {
	if(_contactTextField == nil) {
		_contactTextField = [[UITextField alloc] init];
        [self.view addSubview:_contactTextField];
        [_contactTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageLabel.mas_bottom).equalTo(10);
            make.left.equalTo(15);
            make.right.equalTo(-10);
        }];
        _contactTextField.placeholder = @"邮箱,手机或QQ";
	}
	return _contactTextField;
}

- (UITextView *)ideaTextView {
	if(_ideaTextView == nil) {
		_ideaTextView = [[UITextView alloc] init];
        [self.view addSubview:_ideaTextView];
        [_ideaTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(10);
            make.right.equalTo(-10);
            make.height.equalTo(200);
        }];
        _ideaTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _ideaTextView.backgroundColor = [UIColor whiteColor];
        _ideaTextView.hidden = NO;
        _ideaTextView.delegate = self;
        _ideaTextView.font = [UIFont systemFontOfSize:15];
	}
	return _ideaTextView;
}

- (UILabel *)ideaLabel {
	if(_ideaLabel == nil) {
		_ideaLabel = [[UILabel alloc] init];
        [self.ideaTextView addSubview:_ideaLabel];
        [_ideaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(5);
        }];
        _ideaLabel.text = @"请填写您的意见";
        _ideaLabel.textColor = [UIColor lightGrayColor];
	}
	return _ideaLabel;
}
#pragma mark - UITextView Delegate
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _ideaLabel.text = @"请填写您的意见";
    }else{
        _ideaLabel.text = @"";
    }
}
@end
