//
//  YXCookMenuView.m
//  TRProject
//
//  Created by 李晨 on 16/7/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXCookMenuView.h"

@implementation YXCookMenuView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self labelTitle];
        [self labelNum];
        [self labelTime];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (UILabel *)labelTitle {
    if(_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        [self addSubview:_labelTitle];
        [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(15);
            make.right.equalTo(-10);
        }];
        _labelTitle.textColor = kRGBColor(222, 76, 60, 1.0);
        _labelTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    }
    return _labelTitle;
}

- (UILabel *)labelTime {
    if(_labelTime == nil) {
        UIImageView *image = @"time".yx_imageView;
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.bottom.equalTo(-10);
            make.width.height.equalTo(15);
        }];
        _labelTime = [[UILabel alloc] init];
        [self addSubview:_labelTime];
        [_labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).equalTo(5);
            make.bottom.equalTo(-10);
        }];
        _labelTime.textColor = kRGBColor(76, 64, 58, 1.0);
        _labelTime.font = [UIFont systemFontOfSize:15];
        
    }
    return _labelTime;
}

- (UILabel *)labelNum {
    if(_labelNum == nil) {
        UIImageView *image = @"eye".yx_imageView;
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.labelTime.mas_right).equalTo(20);
            make.bottom.equalTo(-10);
            make.width.height.equalTo(15);
        }];
        _labelNum = [[UILabel alloc] init];
        [self addSubview:_labelNum];
        [_labelNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).equalTo(5);
            make.bottom.equalTo(-10);
        }];
        _labelNum.textColor = kRGBColor(76, 64, 58, 1.0);
        _labelNum.font = [UIFont systemFontOfSize:15];
    }
    return _labelNum;
}

@end
