//
//  YXSearchHeaderView.m
//  TRProject
//
//  Created by 李晨 on 16/7/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXSearchHeaderView.h"

#import "YXCookMenuViewController.h"
@interface YXSearchHeaderView ()<iCarouselDelegate, iCarouselDataSource>

/** 下方搜索栏 */
@property (nonatomic, strong) UIView *bottomView;


/** 上方滚动视图页数 */
@property (nonatomic, strong) UIPageControl *pc;

@end
@implementation YXSearchHeaderView{
    NSTimer *_timer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self bottomView];
        [self conTechnic];
        [self conFlavor];
        [self conCookTime];
    }
    return self;
}
#pragma mark - LazyLoad 懒加载
- (iCarousel *)ic {
    
    _ic = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW/ 2)];
    [self addSubview:_ic];
    _ic.delegate = self;
    _ic.dataSource = self;
    _pc = [UIPageControl new];
    _pc.numberOfPages = self.icList.count;
    [_ic addSubview:_pc];
    [_pc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.centerX.equalTo(0);
    }];
    [_timer invalidate];
    _timer = nil;
    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:2 block:^(NSTimer *timer) {
        [_ic scrollToItemAtIndex:_ic.currentItemIndex + 1 animated:YES];
    } repeats:YES];
    _ic.scrollSpeed = .2;
    
    return _ic;
}

- (UIView *)bottomView {
    if(_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        [self addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(64);
        }];
        _bottomView.backgroundColor = kRGBColor(253, 183, 154, 1.0);
    }
    return _bottomView;
}
- (ControlList *)conTechnic {
    if(_conTechnic == nil) {
        _conTechnic = [[ControlList alloc] initWithImage:@"technic".yx_image highlightedImage:@"technic_on".yx_image];
        [self.bottomView addSubview:_conTechnic];
        _conTechnic.lab.text = @"烹饪技术";
        [_conTechnic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.conFlavor.mas_right).equalTo(20);
            make.centerY.equalTo(0);
            make.width.equalTo(self.conFlavor);
            make.height.equalTo(self.conFlavor);
        }];
        _conTechnic.backgroundColor = kRGBColor(255, 255, 255, 0.6);
    }
    return _conTechnic;
}

- (ControlList *)conCookTime {
    if(_conCookTime == nil) {
        _conCookTime = [[ControlList alloc] initWithImage:@"cooktime".yx_image highlightedImage:@"cooktime_on".yx_image];
        [self.bottomView addSubview:_conCookTime];
        _conCookTime.lab.text = @"烹饪时间";
        [_conCookTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.conTechnic.mas_right).equalTo(20);
            make.centerY.equalTo(0);
            make.width.equalTo(self.conFlavor);
            make.height.equalTo(self.conFlavor);
        }];
        _conCookTime.backgroundColor = kRGBColor(255, 255, 255, 0.6);
    }
    return _conCookTime;
}

- (ControlList *)conFlavor {
    if(_conFlavor == nil) {
        _conFlavor = [[ControlList alloc] initWithImage:@"flavor".yx_image highlightedImage:@"flavor_on".yx_image];
        [self.bottomView addSubview:_conFlavor];
        _conFlavor.lab.text = @"味道";
        CGFloat width = (kScreenW - 80)/3.0;
        [_conFlavor mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(0);
            make.width.equalTo(width);
            make.height.equalTo(35);
        }];
        _conFlavor.backgroundColor = kRGBColor(255, 255, 255, 0.6);
    }
    return _conFlavor;
}
#pragma mark - iCarousel Delegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.icList.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view) {
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        UIImageView *img = [UIImageView new];
        [view addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        UIView *darkView = [UIView new];
        [img addSubview:darkView];
        [darkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        darkView.backgroundColor = kRGBColor(0, 0, 0, 0.4);
        UILabel *title = [UILabel new];
        [darkView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        img.tag = 101;
        title.tag = 102;
        title.textColor = [UIColor whiteColor];
    }
    UIImageView *img = (UIImageView *)[view viewWithTag:101];
    UILabel *title = (UILabel *)[view viewWithTag:102];
    [img setImageWithURL:self.icList[index].imageUrl.yx_URL placeholder:@"default".yx_image];
    title.text = self.icList[index].title;
    return view;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    YXCookMenuViewController *cookMenuVC = [[YXCookMenuViewController alloc]initWithData:self.icList[index]];
    [self.viewController.navigationController pushViewController:cookMenuVC animated:YES];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        value = YES;
    }
    return value;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _pc.currentPage = carousel.currentItemIndex;
}
#pragma mark - Method reloadView
- (void)reloadViewWithIcList:(NSArray *)icList CompletionHandler:(void (^)())completionHandler{
    _icList = icList;
    !completionHandler ?: completionHandler();
}
@end

@implementation ControlList
- (instancetype)initWithImage:(UIImage *)nomImg highlightedImage:(UIImage *)highlightImg
{
    self = [super init];
    if (self) {
        _nomImg = nomImg;
        _highlightImg = highlightImg;
        [self lab];
        [self img];
    }
    return self;
}
#pragma mark - LazyLoad 懒加载
- (UILabel *)lab {
    if(_lab == nil) {
        _lab = [[UILabel alloc] init];
        [self addSubview:_lab];
        [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).equalTo(-5);
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
        }];
        
        _lab.textColor = kRGBColor(167, 130, 78, 1.0);
        
        _lab.font = [UIFont systemFontOfSize:14];
        _lab.adjustsFontSizeToFitWidth = YES;
//        _lab.minimumFontSize = 6;
        
    }
    return _lab;
}

- (UIImageView *)img {
    if(_img == nil) {
        _img = [[UIImageView alloc] initWithImage:_nomImg highlightedImage:_highlightImg];
        [self addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
            make.width.equalTo(14);
            make.height.equalTo(15);
        }];
    }
    return _img;
}



@end