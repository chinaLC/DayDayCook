//
//  YXSearchHeaderView.h
//  TRProject
//
//  Created by 李晨 on 16/7/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>
#import "YXMenuModel.h"
@class ControlList;
@interface YXSearchHeaderView : UICollectionReusableView


/** technic 烹饪技术 */
@property (nonatomic, strong) ControlList *conTechnic;

/** cooktime 烹饪时间 */
@property (nonatomic, strong) ControlList *conCookTime;

/** flavor 味道 */
@property (nonatomic, strong) ControlList *conFlavor;

/** 上方滚动视图 */
@property (nonatomic, strong) iCarousel *ic;

/** 滚动视图数据 */
@property (nonatomic, readonly) NSArray<MenuDataModel *> *icList;

- (void)reloadViewWithIcList:(NSArray *)icList CompletionHandler:(void(^)())completionHandler;
@end

@interface ControlList : UIControl

/** 左图 */
@property (nonatomic, strong) UIImageView *img;

/** title */
@property (nonatomic, strong) UILabel *lab;


/** 普通 */
@property (nonatomic, readonly) UIImage *nomImg;

/** 高亮 */
@property (nonatomic, readonly) UIImage *highlightImg;


- (instancetype)initWithImage:(UIImage *)nomImg highlightedImage:(UIImage *)highlightImg;

@end
