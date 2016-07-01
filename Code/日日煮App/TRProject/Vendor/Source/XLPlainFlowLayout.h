//
//  XLPlainFlowLayout.h
//  XLPlainFlowLayout
//
//  Created by hebe on 15/7/30.
//  Copyright (c) 2015年 ___ZhangXiaoLiang___. All rights reserved.
//
//  工作邮箱E-mail: k52471@126.com

#import <UIKit/UIKit.h>

@interface XLPlainFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign, readonly) CGFloat naviHeight;
@property (nonatomic, assign, readonly) CGFloat headerHeight;
- (instancetype)initWithHeight:(CGFloat)height HeaderHeight:(CGFloat)headerHeight;
@end
