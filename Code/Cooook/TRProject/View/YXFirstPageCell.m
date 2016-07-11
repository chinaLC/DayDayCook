//
//  YXFirstPageCell.m
//  TRProject
//
//  Created by 李晨 on 16/6/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXFirstPageCell.h"

@interface YXFirstPageCell ()

/** 背图 */
@property (nonatomic, strong) UIImageView *backImage;
@end

@implementation YXFirstPageCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self imageV];
        [self labelCookTime];
        [self labelShareCount];
        [self labelClickCount];
        [self labelDec];
        [self labelTitle];
        [self labelReNewTime];
    }
    return self;
}
- (UIImageView *)imageV {
    if(_imageV == nil) {
        _imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.clipsToBounds = YES;
        [self backImage];
    }
    return _imageV;
}

- (UIImageView *)backImage {
	if(_backImage == nil) {
		_backImage = [[UIImageView alloc] init];
        [self.imageV addSubview:_backImage];
        CGFloat height = kScreenW/1242.0*297;
        [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(0);
            make.height.equalTo(height);
        }];
        _backImage.image = @"buttomImg".yx_image;
	}
	return _backImage;
}
- (UILabel *)labelShareCount {
    if(_labelShareCount == nil) {
        _labelShareCount = [[UILabel alloc] init];
        CGFloat leftX = kScreenW/4.0*3 + 4;
        UIImageView *image = @"Home_shareIcon".yx_imageView;
        [self.backImage addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftX);
            make.bottom.equalTo(-10);
            make.width.height.equalTo(15);
        }];
        [self.backImage addSubview:_labelShareCount];
        [_labelShareCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).equalTo(2);
            make.bottom.equalTo(-10);
        }];
        _labelShareCount.textColor = [UIColor lightTextColor];
        _labelShareCount.font = [UIFont systemFontOfSize:13];
    }
    return _labelShareCount;
}


- (UILabel *)labelCookTime {
    if(_labelCookTime == nil) {
        _labelCookTime = [[UILabel alloc] init];
        UIImageView *image = @"Home_timeIcon".yx_imageView;
        [self.backImage addSubview:image];
        CGFloat leftX = kScreenW/8.0 - 8;
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftX);
            make.bottom.equalTo(-10);
            make.width.height.equalTo(15);
        }];
        [self.backImage addSubview:_labelCookTime];
        [_labelCookTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).equalTo(2);
            make.bottom.equalTo(-10);
        }];
        _labelCookTime.textColor = [UIColor lightTextColor];
        _labelCookTime.font = [UIFont systemFontOfSize:13];
    }
    return _labelCookTime;
}

- (UILabel *)labelClickCount {
    if(_labelClickCount == nil) {
        _labelClickCount = [[UILabel alloc] init];
        [self.backImage addSubview:_labelClickCount];
        [_labelClickCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(-10);
        }];
        _labelClickCount.textColor = [UIColor lightTextColor];
        _labelClickCount.font = [UIFont systemFontOfSize:13];
        UIImageView *image = @"Home_viewIcon".yx_imageView;
        [self.backImage addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_labelClickCount.mas_left).equalTo(-2);
            make.bottom.equalTo(-10);
            make.width.height.equalTo(15);
        }];
    }
    return _labelClickCount;
}

- (UILabel *)labelDec {
    if(_labelDec == nil) {
        _labelDec = [[UILabel alloc] init];
        [self.backImage addSubview:_labelDec];
        CGFloat width = kScreenW -100;
        [_labelDec mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.labelClickCount.mas_top).equalTo(-20);
            make.centerX.equalTo(0);
            make.width.equalTo(width);
        }];
        _labelDec.textColor = [UIColor lightTextColor];
        _labelDec.font = [UIFont systemFontOfSize:19];
    }
    return _labelDec;
}

- (UILabel *)labelTitle {
    if(_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        [self.backImage addSubview:_labelTitle];
        [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.labelDec.mas_top).equalTo(-20);
            make.centerX.equalTo(0);
        }];
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.font = [UIFont systemFontOfSize:22];
    }
    return _labelTitle;
}

- (UILabel *)labelReNewTime {
    if(_labelReNewTime == nil) {
        UIView *view = [UIView new];
        [self.imageV addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(0);
            make.height.equalTo(24);
        }];
        view.backgroundColor = kRGBColor(0, 0, 0, 0.4);
        _labelReNewTime = [[UILabel alloc] init];
        [view addSubview:_labelReNewTime];
        [_labelReNewTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-5);
            make.centerY.equalTo(0);
        }];
        _labelReNewTime.textColor = [UIColor whiteColor];
        _labelReNewTime.font = [UIFont systemFontOfSize:14];
        UIImageView *image = @"Home_calenderIcon".yx_imageView;
        [view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(5);
            make.right.equalTo(_labelReNewTime.mas_left).equalTo(-5);
            make.top.equalTo(5);
            make.width.height.equalTo(14);
        }];
    }
    return _labelReNewTime;
}
@end
