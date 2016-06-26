//
//  YXMenuViewModel.m
//  TRProject
//
//  Created by 李晨 on 16/6/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXMenuViewModel.h"


@interface YXMenuViewModel ()

@property (nonatomic, assign) NSInteger page;
@end
@implementation YXMenuViewModel
- (void)getDataWithRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    NSInteger tmpPage = 1;
    if (requestMode == VMRequestModeMore) {
        tmpPage = _page + 1;
    }
     [YXNetManager getMessagerFormThePage:tmpPage CompletionHandler:^(YXMenuModel *model, NSError *error) {
        if (!error) {
            if (requestMode == VMRequestModeRefresh) {
                [self.dataList removeAllObjects];
            }
            [self.dataList addObjectsFromArray:model.data];
            _page = tmpPage;
            _isLoadMore = model.data.count == 20;
        }
        !completionHandler ?: completionHandler(error);
    }];
}
#pragma mark - Method Cell
- (NSInteger)numberForRow{
    return self.dataList.count;
}
- (NSURL *)iconIVForRow:(NSInteger)row{
    return self.dataList[row].imageUrl.yx_URL;
}
#pragma mark - LazyLoad 懒加载
- (NSMutableArray<MenuDataModel *> *)dataList {
    if(_dataList == nil) {
        _dataList = [[NSMutableArray<MenuDataModel *> alloc] init];
    }
    return _dataList;
}
@end
