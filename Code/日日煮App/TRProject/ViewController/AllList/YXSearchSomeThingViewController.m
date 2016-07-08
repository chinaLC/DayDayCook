//
//  YXSearchSomeThingViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXSearchSomeThingViewController.h"
#import "YXSearchViewModel.h"
#import "YXSearchCell.h"
#import "YXCookMenuViewController.h"
static NSString *const SearchIdentify = @"SearchCell";
@interface YXSearchSomeThingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

/** SearchViewModel */
@property (nonatomic, strong) YXSearchViewModel *searchVM;

/** 回到顶部 */
@property (nonatomic, strong) UIControl *upToTop;
@end

@implementation YXSearchSomeThingViewController
#pragma mark - init
- (instancetype)initWithKey:(NSString *)key
{
    self = [super init];
    if (self) {
        _key = key;
    }
    return self;
}
- (instancetype)init
{
    NSAssert1(NO, @"必须使用(instancetype)initWithKey:初始化 %s", __FUNCTION__);
    return nil;
}
#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self collectionView];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:@"back_white".yx_image style:UIBarButtonItemStyleDone target:self action:@selector(clickTheBtnBackToLastPage:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.searchVM.numberForRow;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YXSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SearchIdentify forIndexPath:indexPath];
    cell.labelTitle.text = [self.searchVM titleForRow:indexPath.row];
    cell.labelDec.text = [self.searchVM detailForRow:indexPath.row];
    cell.labelNum.text = [self.searchVM clickCountForRow:indexPath.row];
    [cell.imageV setImageWithURL:[self.searchVM iconIVForRow:indexPath.row]placeholder:@"default".yx_image];
    return cell;
}
#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    YXCookMenuViewController *cookMenuVC = [[YXCookMenuViewController alloc]initWithData:[self.searchVM dataForRow:indexPath.row]];
    [self.navigationController pushViewController:cookMenuVC animated:YES];
}
#pragma mark - ScrollView Delegate
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
- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
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
        [_collectionView registerClass:[YXSearchCell class] forCellWithReuseIdentifier:SearchIdentify];
        _collectionView.backgroundColor = [UIColor clearColor];
        WK(weakSelf);
        [self.view showBusyHUD];
        [self.searchVM getDataWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            if (error) {
                DDLogError(@"error: %@",error);
                return ;
            }
            [self.collectionView reloadData];
            [self.view hideBusyHUD];
            if (self.searchVM.isLoadMore) {
                [self.collectionView endFooterRefresh];
            }else {
                [self.collectionView endFooterRefreshWithNoMoreData];
            }
        }];
        [self.collectionView addBackFooterRefresh:^{
            [weakSelf.searchVM getDataWithRequestMode:VMRequestModeMore completionHandler:^(NSError *error) {
                if (error) {
                    DDLogError(@"error: %@",error);
                    return ;
                }
                [weakSelf.collectionView reloadData];
                if (weakSelf.searchVM.isLoadMore) {
                    [weakSelf.collectionView endFooterRefresh];
                }else {
                    [weakSelf.collectionView endFooterRefreshWithNoMoreData];
                }
            }];
        }];
    }
    return _collectionView;
}

- (YXSearchViewModel *)searchVM {
	if(_searchVM == nil) {
		_searchVM = [[YXSearchViewModel alloc] initWithKey:self.key];
	}
	return _searchVM;
}
- (UIControl *)upToTop {
    if(_upToTop == nil) {
        _upToTop = [[UIControl alloc] init];
        [self.view addSubview:_upToTop];
        [_upToTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-30);
            make.bottom.equalTo(-60);
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
#pragma mark - Method
//返回上一页
- (void)clickTheBtnBackToLastPage:sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//回到顶部
- (void)clickItWillToTop:sender{
    [self.collectionView scrollToTop];
}
#pragma mark - dataTask
//页面即将消失时 任务终止
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchVM.dataTask suspend];
}
//页面即将出现 开始任务
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.searchVM.dataTask resume];
}
//页面消失 任务取消
- (void)dealloc{
    [self.searchVM.dataTask cancel];
}

@end
