//
//  YXFirstPageViewController.m
//  TRProject
//
//  Created by 李晨 on 16/6/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXFirstPageViewController.h"
#import "YXMenuViewModel.h"
#import "YXFirstPageCell.h"
#import "StickCollectionViewFlowLayout.h"
#import "YXSearchPageViewController.h"
#import "YXCookMenuViewController.h"
#import "LBToAppStore.h"
static NSString *const identify = @"Cell";

@interface YXFirstPageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

/** 回到顶部 */
@property (nonatomic, strong) UIControl *upToTop;

/** ViewModel层解析 */
@property (nonatomic, strong) YXMenuViewModel *menuVM;

/** 滚动视图 */
@property (nonatomic, strong) UICollectionView *collectionView;

/** 搜索 */
@property (nonatomic, strong) UIView *searchView;

/** 搜索按钮 */
@property (nonatomic, strong) UIButton *btnSearch;
@end
@implementation YXFirstPageViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    //判断网络状况
//    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
//     [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//         if (status == AFNetworkReachabilityStatusUnknown||AFNetworkReachabilityStatusNotReachable) {
//             [self.view showWarning:@"当前没有网络"];
//             return;
//         }
//         if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
//             [self.view showWarning:@"当前使用的是蜂窝数据流量"];
//         }
//     }];
    //用户好评系统
//    LBToAppStore *toAppStore = [[LBToAppStore alloc]init];
//    toAppStore.myAppID = @"???";
//    [toAppStore showGotoAppStore:self];
    [self collectionView];
    [self upToTop];
    [self searchView];
    [self btnSearch];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:@"find_off".yx_image style:UIBarButtonItemStylePlain target:self action:@selector(clickUpTheButton:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.title = @"Cooook";
}
#pragma mark - CollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.menuVM.numberForRow;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YXFirstPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.labelClickCount.text = [self.menuVM clickCountForRow:indexPath.row];
    cell.labelCookTime.text = [self.menuVM cookTimeForRow:indexPath.row];
    cell.labelShareCount.text = [self.menuVM shareCountForRow:indexPath.row];
    cell.labelDec.text = [self.menuVM detailForRow:indexPath.row];
    cell.labelTitle.text = [self.menuVM titleForRow:indexPath.row];
    cell.labelReNewTime.text = [self.menuVM releaseDateForRow:indexPath.row];
    [cell.imageV setImageWithURL:[self.menuVM iconIVForRow:indexPath.row]placeholder:@"default".yx_image];
    return cell;
}
#pragma mark - CollectionView Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.frame.origin.y == kScreenH/2) {
        return CGSizeMake(kScreenW, kScreenH/4);
    }
    return CGSizeMake(kScreenW, kScreenH/2);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    YXCookMenuViewController *cookMenuVC = [[YXCookMenuViewController alloc]initWithData:[self.menuVM dataForRow:indexPath.row]];
    [self.navigationController pushViewController:cookMenuVC animated:YES];
}
#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGRect rect = self.searchView.frame;
    rect.origin.x = kScreenW - 80;
    [UIView animateWithDuration:1 animations:^{
        self.searchView.frame = rect;
    }];
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    CGRect rect = self.searchView.frame;
    rect.origin.x = kScreenW - 20;
    [UIView animateWithDuration:0.5 animations:^{
         self.searchView.frame = rect;
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    if(yOffset>kScreenH){
        self.upToTop.layer.hidden = NO;
    }else{
        self.upToTop.layer.hidden = YES;
    }
}
#pragma mark - LazyLoad 懒加载
- (YXMenuViewModel *)menuVM {
    if(_menuVM == nil) {
        _menuVM = [[YXMenuViewModel alloc] init];
    }
    return _menuVM;
}

- (UIControl *)upToTop {
    if(_upToTop == nil) {
        _upToTop = [[UIControl alloc] init];
        [self.view addSubview:_upToTop];
        [_upToTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-30);
            make.bottom.equalTo(-160);
            make.width.height.equalTo(45);
        }];
        _upToTop.layer.cornerRadius = 45/2.0;
        UIImageView *image = @"upupup".yx_imageView;
        [_upToTop addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        [_upToTop addTarget:self action:@selector(clickItWillToTop:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upToTop;
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[StickCollectionViewFlowLayout new]];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[YXFirstPageCell class] forCellWithReuseIdentifier:identify];

        NSArray *arr = @[@"load1".yx_image, @"load2".yx_image, @"load3".yx_image, @"load4".yx_image, @"load5".yx_image, @"load6".yx_image];
        NSArray *arr1 = @[@"load1".yx_image];
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh:)];
//        [header setImages:arr forState:MJRefreshStateIdle];
        [header setImages:arr1 forState:MJRefreshStatePulling];
        [header setImages:arr forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.collectionView.mj_header = header;
        WK(weakSelf);
        [self.collectionView addBackFooterRefresh:^{
            [weakSelf.menuVM getDataWithRequestMode:VMRequestModeMore completionHandler:^(NSError *error) {
                if (error) {
                    DDLogError(@"error: %@",error);
                    return ;
                }
                [weakSelf.collectionView reloadData];
                if (weakSelf.menuVM.isLoadMore) {
                    [weakSelf.collectionView endFooterRefresh];
                }else {
                    [weakSelf.collectionView endFooterRefreshWithNoMoreData];
                }
            }];
        }];
        [self.collectionView beginHeaderRefresh];
    }
    return _collectionView;
}
- (UIView *)searchView {
    if(_searchView == nil) {
        _searchView = [[UIView alloc] init];
        [self.view addSubview:_searchView];
        [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(190);
            make.bottom.equalTo(-90);
            make.height.equalTo(45);
            make.width.equalTo(200);
        }];
        _searchView.backgroundColor = kRGBColor(253, 183, 154, 1.0);
        _searchView.layer.cornerRadius = 22.5;
    }
    return _searchView;
}

- (UIButton *)btnSearch {
    if(_btnSearch == nil) {
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.searchView addSubview:_btnSearch];
        [_btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
            make.width.height.equalTo(33);
        }];
        [_btnSearch addTarget:self action:@selector(clickUpTheButton:) forControlEvents:UIControlEventTouchUpInside];
        [_btnSearch setImage:@"search".yx_image forState:UIControlStateNormal];
    }
    return _btnSearch;
}

#pragma mark - Method 按钮
//左上方按钮&右下方按钮 去搜索页
- (void)clickUpTheButton:sender{
    YXSearchPageViewController *searchVC = [YXSearchPageViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}
//回到顶部
- (void)clickItWillToTop:sender{
    [self.collectionView scrollToTop];
}
//头部刷新
- (void)headerRefresh:sender{
    [self.menuVM getDataWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
        if (error) {
            DDLogError(@"error: %@",error);
            return ;
        }
        [self.collectionView reloadData];
        [self.collectionView endHeaderRefresh];
        if (self.menuVM.isLoadMore) {
            [self.collectionView endFooterRefresh];
        }else {
            [self.collectionView endFooterRefreshWithNoMoreData];
        }
    }];
}
#pragma mark - dataTask
//页面即将消失时 任务终止
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.menuVM.dataTask suspend];
}
//页面即将出现 开始任务
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.menuVM.dataTask resume];
}
//页面消失 任务取消
- (void)dealloc{
    [self.menuVM.dataTask cancel];
}
@end
