//
//  YXSearchViewModel.h
//  TRProject
//
//  Created by 李晨 on 16/7/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRBaseViewModel.h"
#import "YXNetManager.h"
@interface YXSearchViewModel : TRBaseViewModel

- (instancetype)initWithKey:(NSString *)key;
@property (nonatomic, readonly) NSString *key;

/** 加载更多数据的可变数组 */
@property (nonatomic, strong) NSMutableArray<MenuDataModel *> *dataList;

//对应行数
- (NSInteger)numberForRow;
//图片
- (NSURL *)iconIVForRow:(NSInteger)row;
//点击人数
- (NSString *)clickCountForRow:(NSInteger)row;
//分享人数
- (NSString *)shareCountForRow:(NSInteger)row;
//烹调时长
- (NSString *)cookTimeForRow:(NSInteger)row;
//详情
- (NSString *)detailForRow:(NSInteger)row;
//题目
- (NSString *)titleForRow:(NSInteger)row;
//更新时间
- (NSString *)releaseDateForRow:(NSInteger)row;
//数据
- (MenuDataModel *)dataForRow:(NSInteger)row;
/** 有更多页 */
@property (nonatomic) BOOL isLoadMore;
@end
