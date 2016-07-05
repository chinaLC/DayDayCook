//
//  YXSearchHeaderView.h
//  TRProject
//
//  Created by 李晨 on 16/7/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXSearchHeaderView : UICollectionReusableView


/** technic 烹饪技术 */
@property (nonatomic, strong) UIControl *conTechnic;

/** cooktime 烹饪时间 */
@property (nonatomic, strong) UIControl *conCookTime;

/** flavor 味道 */
@property (nonatomic, strong) UIControl *conFlavor;


@end
