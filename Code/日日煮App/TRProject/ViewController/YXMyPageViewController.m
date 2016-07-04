//
//  YXMyPageViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXMyPageViewController.h"
static NSString *const myPageIdentify = @"MyPageCell";
@implementation YXMyPageViewController
#pragma mark - 初始化方式
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:myPageIdentify];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
    UIImageView *image = @"bbgb".yx_imageView;
    [view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    self.tableView.tableHeaderView = view;
    self.tableView.tableFooterView = @"launch_back".yx_imageView;
    self.tableView.scrollEnabled = NO;
}
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section ? 0: 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UITableView DateSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self cellList].count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self cellList][section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myPageIdentify forIndexPath:indexPath];
    cell.imageView.image = [self cellList][indexPath.section][indexPath.row][@"img"];
    cell.textLabel.text = [self cellList][indexPath.section][indexPath.row][@"text"];
    return cell;
}
- (NSArray<NSArray<NSDictionary *> *> *)cellList{
    return @[@[@{@"img":@"Personal_newsIcon".yx_image,
                 @"text":@"我的消息"},
               @{@"img":@"Personal_collectIcon".yx_image,
                 @"text":@"我的收藏"},
               @{@"img":@"Personal_trackIcon".yx_image,
                 @"text":@"我的足迹"},
               @{@"img":@"Personal_mycommentIcon".yx_image,
                 @"text":@"我的评价"}],
             @[@{@"img":@"Personal_settingIcon".yx_image,
                 @"text":@"设置"}]];
}
@end
