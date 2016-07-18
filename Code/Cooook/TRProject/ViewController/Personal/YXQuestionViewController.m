//
//  YXQuestionViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXQuestionViewController.h"
#import <WebKit/WebKit.h>
#define kQuestionPath @"http://api.daydaycook.com.cn/daydaycook/h5/recipe/loadProblem.do?username=(null)&password=(null)"
@interface YXQuestionViewController ()

/** WebView */
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation YXQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"常见问题";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:@"back_white".yx_image style:UIBarButtonItemStyleDone target:self action:@selector(clickTheBtnBackToLastPage:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    [self webView];
}
//返回上一页
- (void)clickTheBtnBackToLastPage:sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (WKWebView *)webView {
	if(_webView == nil) {
		_webView = [[WKWebView alloc] init];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        [_webView loadRequest:[NSURLRequest requestWithURL:kQuestionPath.yx_URL]];
	}
	return _webView;
}

@end
