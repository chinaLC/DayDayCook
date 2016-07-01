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
static NSString *const identify = @"Cell";

@interface YXFirstPageViewController ()

/** ViewModel层解析 */
@property (nonatomic, strong) YXMenuViewModel *menuVM;
@end
@implementation YXFirstPageViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[YXFirstPageCell class] forCellWithReuseIdentifier:identify];
    WK(weakSelf);
    [self.collectionView addHeaderRefresh:^{
        [weakSelf.menuVM getDataWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            if (error) {
                DDLogError(@"error: %@",error);
                return ;
            }
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView endHeaderRefresh];
            if (weakSelf.menuVM.isLoadMore) {
                [weakSelf.collectionView endFooterRefresh];
            }else {
                [weakSelf.collectionView endFooterRefreshWithNoMoreData];
            }
        }];
    }];
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
    [cell.imageV sd_setImageWithURL:[self.menuVM iconIVForRow:indexPath.row]placeholderImage:@"default".yx_image];
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
#pragma mark - 初始化方式
- (instancetype)init
{
    self = [super initWithCollectionViewLayout:[StickCollectionViewFlowLayout new]];
    if (self) {
    }
    return self;
}
#pragma mark - LazyLoad 懒加载
- (YXMenuViewModel *)menuVM {
	if(_menuVM == nil) {
		_menuVM = [[YXMenuViewModel alloc] init];
	}
	return _menuVM;
}

@end
