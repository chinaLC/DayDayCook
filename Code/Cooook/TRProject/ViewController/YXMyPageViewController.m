//
//  YXMyPageViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXMyPageViewController.h"
#import "YXLoginViewController.h"
#import "YXSettingViewController.h"
static NSString *const myPageIdentify = @"MyPageCell";

@interface YXMyPageViewController ()

/** 头像 */
@property (nonatomic, strong) UIImageView *imgHead;

/** 注册登录按钮 */
@property (nonatomic, strong) UIButton *btn;
@end
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
    self.navigationItem.title = @"我的日日煮";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:@"back_white".yx_image style:UIBarButtonItemStyleDone target:self action:@selector(clickTheBtnBackToLastPage:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:myPageIdentify];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
    view.backgroundColor = kRGBColor(253, 183, 154, 1.0);
    _imgHead = @"Personal_head".yx_imageView;
    [view addSubview:_imgHead];
    [_imgHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.width.height.equalTo(63);
    }];
    [view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgHead.mas_bottom).equalTo(10);
        make.centerX.equalTo(0);
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
    if (indexPath.section) {
        YXSettingViewController *settingVC = [YXSettingViewController new];
        [self.navigationController pushViewController:settingVC animated:YES];
    }else {
//        [self presentViewController:[YXLoginViewController new] animated:YES completion:nil];
        [self.view showWarning:@"暂时无法使用"];
    }
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - LazyLoad 懒加载

- (UIImageView *)imgHead {
    if(_imgHead == nil) {
        _imgHead = [[UIImageView alloc] init];
    }
    return _imgHead;
}
- (UIButton *)btn {
    if(_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn setTitle:@"注册/登录" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(clickTheBtnPeresentToNextPage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

#pragma mark - Method 
//返回上一页
- (void)clickTheBtnBackToLastPage:sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//注册 登录
- (void)clickTheBtnPeresentToNextPage:sender{
//    [self presentViewController:[YXLoginViewController new] animated:YES completion:nil];
    [self.view showWarning:@"暂时无法登陆"];
}
//cell 数据
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
