//
//  YXSearchPageViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXSearchPageViewController.h"
#import "XLPlainFlowLayout.h"
#import "YXSearchCell.h"
#import "YXSearchHeaderView.h"
#import "YXMenuViewModel.h"
#import "YXMyPageViewController.h"
static NSString *const cellIdentify = @"CollectionCell";
static NSString *const headerIdentify = @"HeaderView";
@interface YXSearchPageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** 上方Navi中部TextField */
@property (nonatomic, strong) UITextField *textField;

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

/** ViewModel层解析 */
@property (nonatomic, strong) YXMenuViewModel *menuVM;
@end

@implementation YXSearchPageViewController
#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image = @"launch_back".yx_imageView;
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self collectionView];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:@"menu".yx_image style:UIBarButtonItemStylePlain target:self action:@selector(backToLastPage:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.titleView = self.textField;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:@"my".yx_image style:UIBarButtonItemStylePlain target:self action:@selector(goToNextPage:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - CollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.menuVM.numberForRow;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YXSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.labelTitle.text = [self.menuVM titleForRow:indexPath.row];
    cell.labelDec.text = [self.menuVM detailForRow:indexPath.row];
    cell.labelNum.text = [self.menuVM clickCountForRow:indexPath.row];
    [cell.imageV setImageWithURL:[self.menuVM iconIVForRow:indexPath.row]placeholder:@"default".yx_image];
    return cell;
}
#pragma mark - UICollectionView Delegate
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(!section){
        CGSize size = CGSizeMake(kScreenW, 400);
        return size;
    }else {
        CGSize size = CGSizeMake(kScreenW, 50);
        return size;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        YXSearchHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentify forIndexPath:indexPath];
        reusableView = headerView;
    }
    return reusableView;
}
#pragma mark - LazyLoad 懒加载
- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        XLPlainFlowLayout *layout = [[XLPlainFlowLayout alloc]initWithHeight:64 HeaderHeight:400];
        CGFloat width = (kScreenW - 30)/2.0;
        CGFloat height = width/292.0*200 + width;
        layout.itemSize = CGSizeMake(width, height);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[YXSearchCell class] forCellWithReuseIdentifier:cellIdentify];
        [_collectionView registerClass:[YXSearchHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentify];
        _collectionView.backgroundColor = [UIColor clearColor];
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
- (YXMenuViewModel *)menuVM {
    if(_menuVM == nil) {
        _menuVM = [[YXMenuViewModel alloc] init];
    }
    return _menuVM;
}
- (UITextField *)textField {
    if(_textField == nil) {
        CGFloat width = kScreenW - 160;
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = @"食材/菜谱/菜系";
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        UIImageView *imageV = @"search_log".yx_imageView;
        [view addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
            make.centerY.equalTo(0);
        }];
        _textField.leftView = view;
        _textField.leftViewMode = UITextFieldViewModeUnlessEditing;
    }
    return _textField;
}
#pragma mark - Method 事件
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

//返回上一页
- (void)backToLastPage:sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//去下一页 个人页
- (void)goToNextPage:sender{
    YXMyPageViewController *myPageVC = [YXMyPageViewController new];
    [self.navigationController pushViewController:myPageVC animated:YES];
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
