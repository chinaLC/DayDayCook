//
//  YXNetManager.h
//  TRProject
//
//  Created by 李晨 on 16/6/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXMenuModel.h"
@interface YXNetManager : NSObject
+ (id)getMessagerFormThePage:(NSInteger)page CompletionHandler:(void(^)(YXMenuModel *model, NSError *error))completionHandler;
+ (id)postDataFormThePage:(NSInteger)page Key:(NSString *)key CompletionHandler:(void(^)(YXMenuModel *model, NSError *error))completionHandler;
@end
