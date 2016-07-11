//
//  YXRegisterViewController.h
//  TRProject
//
//  Created by 李晨 on 16/7/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ViewControllerMode) {
    ViewControllerModeRegister,
    ViewControllerModeForget,
};
@interface YXRegisterViewController : UITableViewController
- (instancetype)initWithViewControllerMode:(ViewControllerMode)viewControllerMode;
/** 控制器模式 */
@property (nonatomic, readonly) ViewControllerMode viewControllerMode;
@end
