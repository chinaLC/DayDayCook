//
//  UIView+HUD.m
//  TRProject
//
//  Created by tarena on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "UIView+HUD.h"
//超时
#define kTimeOut  30
//弹出提示时长
#define kDuration  1
@implementation UIView (HUD)
- (void)showBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
        [self addSubview:hud];
        UIImage *img = [UIImage animatedImageNamed:@"loadingIcon" duration:.4];
        UIImageView *image = [[UIImageView alloc]initWithImage:img];
        UIImageView *image_t = @"loadingIconk".yx_imageView;
        [image_t addSubview:image];
        hud.customView = image_t;
        [hud setMode:MBProgressHUDModeCustomView];
        hud.color = [UIColor clearColor];
        [hud show:YES];
        [hud hide:YES afterDelay:kTimeOut];
    });
}

- (void)showWarning:(NSString *)warning{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = warning;
        [hud hide:YES afterDelay:kDuration];
    });
}

- (void)hideBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
    });
}
@end










