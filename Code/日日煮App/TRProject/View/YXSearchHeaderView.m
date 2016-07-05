//
//  YXSearchHeaderView.m
//  TRProject
//
//  Created by 李晨 on 16/7/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXSearchHeaderView.h"

@interface YXSearchHeaderView ()

/** 下方搜索栏 */
@property (nonatomic, strong) UIView *bottomView;
@end
@implementation YXSearchHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self bottomView];
    }
    return self;
}
- (UIControl *)conTechnic {
    if(_conTechnic == nil) {
        _conTechnic = [[UIControl alloc] init];
    }
    return _conTechnic;
}

- (UIControl *)conCookTime {
    if(_conCookTime == nil) {
        _conCookTime = [[UIControl alloc] init];
    }
    return _conCookTime;
}

- (UIControl *)conFlavor {
    if(_conFlavor == nil) {
        _conFlavor = [[UIControl alloc] init];
    }
    return _conFlavor;
}
- (UIView *)bottomView {
	if(_bottomView == nil) {
		_bottomView = [[UIView alloc] init];
        [self addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(64);
        }];
        _bottomView.backgroundColor = kRGBColor(244, 187, 73, 1.0);
    }
	return _bottomView;
}

@end
