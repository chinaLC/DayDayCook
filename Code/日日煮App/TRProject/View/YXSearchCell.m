//
//  YXSearchCell.m
//  TRProject
//
//  Created by 李晨 on 16/7/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXSearchCell.h"
@interface YXSearchCell ()

/** 底色白色 */
@property (nonatomic, strong) UIView *bottomView;

@end
@implementation YXSearchCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self imageV];
        [self labelDec];
        [self labelNum];
        [self labelTitle];
    }
    return self;
}
- (UIImageView *)imageV {
    if(_imageV == nil) {
        _imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.height.equalTo(self.imageV.mas_width);
        }];
    }
    return _imageV;
}

- (UILabel *)labelTitle {
    if(_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        [self.bottomView addSubview:_labelTitle];
        [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.labelDec.mas_top).equalTo(-10);
            make.left.equalTo(16);
            make.right.equalTo(-5);
        }];
        _labelTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    }
    return _labelTitle;
}

- (UILabel *)labelDec {
    if(_labelDec == nil) {
        _labelDec = [[UILabel alloc] init];
        [self.bottomView addSubview:_labelDec];
        [_labelDec mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
            make.right.equalTo(-15);
        }];
        _labelDec.textColor = kRGBColor(174, 165, 168, 1.0);
        _labelDec.font = [UIFont systemFontOfSize:14];
        
        _labelDec.numberOfLines = 2;
        
    }
    return _labelDec;
}

- (UILabel *)labelNum {
    if(_labelNum == nil) {
        _labelNum = [[UILabel alloc] init];
        UIImageView *imageHeart = @"like1".yx_imageView;
        UIImageView *imageViewNum = @"view".yx_imageView;
        [self.bottomView addSubview:imageViewNum];
        [imageViewNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(19);
            make.height.equalTo(14);
            make.centerX.equalTo(-10);
            make.top.equalTo(self.labelDec.mas_bottom).equalTo(10);
        }];
        [self.bottomView addSubview:imageHeart];
        [imageHeart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labelDec.mas_bottom).equalTo(10);
            make.width.equalTo(19);
            make.height.equalTo(14);
            make.right.equalTo(imageViewNum.mas_left).equalTo(-20);
        }];
        [self.bottomView addSubview:_labelNum];
        [_labelNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labelDec.mas_bottom).equalTo(10);
            make.left.equalTo(imageViewNum.mas_right).equalTo(10);
        }];
        _labelNum.textColor = kRGBColor(174, 165, 168, 1.0);
        _labelNum.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    }
    return _labelNum;
}

- (UIView *)bottomView {
    if(_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        [self.contentView addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(self.imageV.mas_bottom);
        }];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

@end
