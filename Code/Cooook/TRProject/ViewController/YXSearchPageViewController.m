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
#import "YXCookMenuViewController.h"
#import "KxMenu.h"
#import "YXSearchSomeThingViewController.h"
static NSString *const cellIdentify = @"CollectionCell";
static NSString *const headerIdentify = @"HeaderView";
@interface YXSearchPageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UIScrollViewDelegate>

/** 上方Navi中部TextField */
@property (nonatomic, strong) UITextField *textField;

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

/** ViewModel层解析 */
@property (nonatomic, strong) YXMenuViewModel *menuVM;

/** 回到顶部 */
@property (nonatomic, strong) UIControl *upToTop;
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    YXCookMenuViewController *cookMenuVC = [[YXCookMenuViewController alloc]initWithData:[self.menuVM dataForRow:indexPath.row]];
    [self.navigationController pushViewController:cookMenuVC animated:YES];
}
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeZero;
    if(!section){
        size = CGSizeMake(kScreenW, kScreenW/2.0+64);
    }
    return size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        YXSearchHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentify forIndexPath:indexPath];
        NSMutableArray *icList = @[].mutableCopy;
        for (MenuDataModel *obj in self.menuVM.firstDate) {
            if (obj.clickCount>10000) {
                [icList addObject:obj];
            }
        }
        [headerView reloadViewWithIcList:icList CompletionHandler:^{
            [headerView.ic reloadData];
        }];
        [headerView.conFlavor addTarget:self action:@selector(clickUpTheTitleMenu:) forControlEvents:UIControlEventTouchUpInside];
        [headerView.conTechnic addTarget:self action:@selector(clickUpTheTitleMenu:) forControlEvents:UIControlEventTouchUpInside];
        [headerView.conCookTime addTarget:self action:@selector(clickUpTheTitleMenu:) forControlEvents:UIControlEventTouchUpInside];
        headerView.conFlavor.tag = 0;
        headerView.conTechnic.tag = 1;
        headerView.conCookTime.tag = 2;
        reusableView = headerView;
    }
    return reusableView;
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
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.textField) {
        [self keyBoardSelectReturn];
        [self.textField resignFirstResponder];
    }
    return YES;
}
#pragma mark - LazyLoad 懒加载
- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        XLPlainFlowLayout *layout = [[XLPlainFlowLayout alloc]initWithHeight:64 HeaderHeight:kScreenW/2.0+64];
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
//        [_textField addTarget:self action:@selector(controlEventEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeySearch;
    }
    return _textField;
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
//回到顶部
- (void)clickItWillToTop:sender{
    [self.collectionView scrollToTop];
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
//搜索选项选择
- (void)clickUpTheTitleMenu:(ControlList *)sender{
    if (self.collectionView.contentOffset.y < kScreenW/2.0) {
        [self.collectionView setContentOffset:CGPointMake(0, kScreenW/2.0) animated:YES];
        self.collectionView.bouncesZoom = NO;
    }
    NSString *path = [kMyBundlePath stringByAppendingPathComponent:@"SearchCook.plist"];
    NSArray *searchList = [NSArray arrayWithContentsOfFile:path];
    NSArray *list = searchList[sender.tag];
    NSMutableArray *menuItems = @[].mutableCopy;
    for (NSString *name in list) {
        if ([name isEqualToString:@"不限"]) {
            [menuItems addObject:[KxMenuItem menuItem:name image:nil target:nil action:nil]];
        }else{
            [menuItems addObject:[KxMenuItem menuItem:name image:nil target:self action:@selector(pushMenuItem:)]];
        }
    }
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor blueColor];
    first.alignment = NSTextAlignmentCenter;
    [KxMenu showMenuInView:self.view fromRect:sender.frame menuItems:menuItems];
}
- (void)pushMenuItem:(KxMenuItem *)sender
{
    self.textField.text = sender.title;
}
//点击回车跳转界面
- (void)keyBoardSelectReturn{
    YXSearchSomeThingViewController *searchVC = [[YXSearchSomeThingViewController alloc]initWithKey:self.textField.text];
    searchVC.navigationItem.title = self.textField.text;
    [self.navigationController pushViewController:searchVC animated:NO];
}
#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
