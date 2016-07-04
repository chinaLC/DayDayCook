//
//  YXMenuModel.m
//  TRProject
//
//  Created by 李晨 on 16/6/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXMenuModel.h"

@implementation YXMenuModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data": [MenuDataModel class]};
}
@end
@implementation MenuDataModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id",
             @"desc": @"description"};
}
@end


