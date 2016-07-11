//
//  YXNetManager.m
//  TRProject
//
//  Created by 李晨 on 16/6/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXNetManager.h"

@implementation YXNetManager
+ (id)getMessagerFormThePage:(NSInteger)page CompletionHandler:(void (^)(YXMenuModel *, NSError *))completionHandler{
    
//    ?currentPage=2&pageSize=20&name=&categoryId=&parentId=&screeningId=&tagId=&username=&password=
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@(page) forKey:@"currentPage"];
    [dic setValue:@(20) forKey:@"pageSize"];
    [dic setValue:@"" forKey:@"name"];
    [dic setValue:@"" forKey:@"categoryId"];
    [dic setValue:@"" forKey:@"parentId"];
    [dic setValue:@"" forKey:@"screeningId"];
    [dic setValue:@"" forKey:@"tagId"];
    [dic setValue:@"" forKey:@"username"];
    [dic setValue:@"" forKey:@"password"];
    
    return [self GET:kDayDayCookPath parameters:dic progress:nil completionHandler:^(id jsonObject, NSError *error) {
        !completionHandler ?: completionHandler([YXMenuModel parseJSON:jsonObject],error);
    }];
}
+ (id)postDataFormThePage:(NSInteger)page Key:(NSString *)key CompletionHandler:(void (^)(YXMenuModel *, NSError *))completionHandler{
    NSString *str_key = [NSString stringWithCString:[key UTF8String] encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@(page) forKey:@"currentPage"];
    [dic setValue:@(20) forKey:@"pageSize"];
    [dic setValue:str_key forKey:@"name"];
    [dic setValue:@"" forKey:@"categoryId"];
    [dic setValue:@"" forKey:@"parentId"];
    [dic setValue:@"" forKey:@"screeningId"];
    [dic setValue:@"" forKey:@"tagId"];
    [dic setValue:@"" forKey:@"username"];
    [dic setValue:@"" forKey:@"password"];
    return [self POST:kDayDayCookPath parameters:dic progress:nil completionHandler:^(id jsonObject, NSError *error) {
        !completionHandler ?: completionHandler([YXMenuModel parseJSON:jsonObject],error);
    }];
}
@end
