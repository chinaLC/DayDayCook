//
//  YXAboutViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXAboutViewController.h"

@interface YXAboutViewController ()

/** 图 */
@property (nonatomic, strong) UIImageView *img;

/** 版本 */
@property (nonatomic, strong) UILabel *labelVersion;

/** 描述 */
@property (nonatomic, strong) UILabel *labelDec;
@end

@implementation YXAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGBColor(252, 247, 245, 1.0);
    self.navigationItem.title = @"关于";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:@"back_white".yx_image style:UIBarButtonItemStyleDone target:self action:@selector(clickTheBtnBackToLastPage:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    [self img];
    [self labelVersion];
    [self labelDec];
}
//返回上一页
- (void)clickTheBtnBackToLastPage:sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIImageView *)img {
	if(_img == nil) {
		_img = [[UIImageView alloc] init];
        [self.view addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(100);
            make.width.height.equalTo(100);
        }];
        _img.image = @"logo".yx_image;
	}
	return _img;
}

- (UILabel *)labelVersion {
	if(_labelVersion == nil) {
        UIView *view = [UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.img.mas_bottom).equalTo(20);
            make.width.equalTo(140);
            make.height.equalTo(30);
        }];
		_labelVersion = [[UILabel alloc] init];
        [view addSubview:_labelVersion];
        [_labelVersion mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        NSString *str = [NSString stringWithFormat:@"版本 v%@", [[NSUserDefaults standardUserDefaults]stringForKey:@"RunVersion"]];
        _labelVersion.text = str;
        view.backgroundColor = kRGBColor(241, 228, 220, 1.0);
        _labelVersion.textColor = kRGBColor(178, 156, 143, 1.0);
        view.layer.cornerRadius = 15;
        _labelVersion.textAlignment = NSTextAlignmentCenter;
	}
	return _labelVersion;
}

- (UILabel *)labelDec {
	if(_labelDec == nil) {
        UIView *view = [UIView new];
        [self.view addSubview:view];
        CGFloat top = kScreenH/2;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(top);
            make.bottom.equalTo(-100);
            make.left.right.equalTo(0);
        }];
		_labelDec = [[UILabel alloc] init];
        [view addSubview:_labelDec];
        [_labelDec mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(20);
            make.left.equalTo(20);
            make.right.equalTo(-20);
        }];
        view.backgroundColor = [UIColor whiteColor];
        _labelDec.textAlignment = NSTextAlignmentLeft;
        NSString *path = [kMyBundlePath stringByAppendingPathComponent:@"AboutFile.rtf"];
        NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        _labelDec.text = str;
        _labelDec.numberOfLines = 0;
        _labelDec.textColor = kRGBColor(178, 156, 143, 1.0);
        _labelDec.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
	}
	return _labelDec;
}

@end
