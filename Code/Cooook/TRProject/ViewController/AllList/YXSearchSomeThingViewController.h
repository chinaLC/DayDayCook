//
//  YXSearchSomeThingViewController.h
//  TRProject
//
//  Created by 李晨 on 16/7/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXSearchSomeThingViewController : UIViewController
- (instancetype)initWithKey:(NSString *)key;
@property (nonatomic, readonly) NSString *key;
@end
