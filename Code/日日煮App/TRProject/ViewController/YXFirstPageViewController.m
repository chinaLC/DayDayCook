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
static NSString *const identify = @"Cell";

@interface YXFirstPageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** 回到顶部 */
@property (nonatomic, strong) UIControl *upToTop;

/** ViewModel层解析 */
@property (nonatomic, strong) YXMenuViewModel *menuVM;

/** 滚动视图 */
@property (nonatomic, strong) UICollectionView *collectionView;

/** 搜索 */
@property (nonatomic, strong) UIView *searchView;
@end
@implementation YXFirstPageViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self collectionView];
    [self upToTop];
    [self searchView];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:@"find_off".yx_image style:UIBarButtonItemStylePlain target:self action:@selector(clickUpTheButton:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.titleView = @"TitleLogo".yx_imageView;
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
    //    return CGSizeMake(CGRectGetWidth(self.view.bounds), kCellHeight);
    if (collectionView.frame.origin.y == kScreenH/2) {
        return CGSizeMake(kScreenW, kScreenH/4);
    }
    return CGSizeMake(kScreenW, kScreenH/2);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
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
            make.right.equalTo(0);
            make.bottom.equalTo(-90);
            make.height.equalTo(45);
            make.width.equalTo(100);
        }];
        _searchView.backgroundColor = [UIColor redColor];
    }
    return _searchView;
}

#pragma mark - Method 按钮
//左上方按钮
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
