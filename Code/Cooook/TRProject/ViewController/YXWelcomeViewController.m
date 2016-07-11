//
//  YXWelcomeViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXWelcomeViewController.h"
#import "YXFirstPageViewController.h"
@interface YXWelcomeViewController ()

/** 欢迎页滚动视图 */
@property (nonatomic, strong) UIScrollView *welcomeScrollView;
@end

@implementation YXWelcomeViewController
#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self welcomeScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Method
//开始体验按钮
- (void)clickUpItStartToEnjoyApp:sender{
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[YXFirstPageViewController new]];
    self.view.window.rootViewController = navi;
    NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
    NSString *version = infoDic[@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults]setObject:version forKey:@"RunVersion"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
#pragma mark - LazyLoad 懒加载
- (UIScrollView *)welcomeScrollView {
	if(_welcomeScrollView == nil) {
        NSString *path = [kMyBundlePath stringByAppendingPathComponent:@"WelcomePageList.plist"];
        NSArray<NSString *> *welcomeList = [NSArray arrayWithContentsOfFile:path];
        _welcomeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        [self.view addSubview:_welcomeScrollView];
        _welcomeScrollView.pagingEnabled = YES;
        for (int i = 0; i < welcomeList.count; i ++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW * i, 0, kScreenW, kScreenH)];
            img.image = welcomeList[i].yx_image;
            [_welcomeScrollView addSubview:img];
        }
        UIControl *con = [[UIControl alloc]initWithFrame:CGRectMake(kScreenW * (welcomeList.count-1), 0, kScreenW, kScreenH)];
        [_welcomeScrollView addSubview:con];
        [con addTarget:self action:@selector(clickUpItStartToEnjoyApp:) forControlEvents:UIControlEventTouchUpInside];
        _welcomeScrollView.contentSize = CGSizeMake(kScreenW * welcomeList.count, 0);
	}
	return _welcomeScrollView;
}

@end
