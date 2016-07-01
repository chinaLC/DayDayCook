//
//  YXFirstPageCell.h
//  TRProject
//
//  Created by 李晨 on 16/6/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXFirstPageCell : UICollectionViewCell

/** 菜图片 */
@property (nonatomic, strong) UIImageView *imageV;

/** 题目 */
@property (nonatomic, strong) UILabel *labelTitle;

/** 描述 */
@property (nonatomic, strong) UILabel *labelDec;

/** 更新时间 */
@property (nonatomic, strong) UILabel *labelReNewTime;

/** 分享人数 */
@property (nonatomic, strong) UILabel *labelShareCount;

/** 烹调时长 */
@property (nonatomic, strong) UILabel *labelCookTime;

/** 点击人数 */
@property (nonatomic, strong) UILabel *labelClickCount;



@end
