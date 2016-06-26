//
//  YXFirstPageCell.m
//  TRProject
//
//  Created by 李晨 on 16/6/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXFirstPageCell.h"

@implementation YXFirstPageCell
- (UIImageView *)imageV {
    if(_imageV == nil) {
        _imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _imageV;
}

@end
