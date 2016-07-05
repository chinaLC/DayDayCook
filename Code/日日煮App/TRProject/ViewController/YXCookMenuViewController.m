//
//  YXCookMenuViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXCookMenuViewController.h"
#import "YXCookMenuView.h"
@import AVKit;
@import AVFoundation;
@interface YXCookMenuViewController ()<UIScrollViewDelegate>

/** WebView */
@property (nonatomic, strong) UIWebView *webView;

/** img */
@property (nonatomic, strong) UIImageView *img;

/** 上方视图 */
@property (nonatomic, strong) UIView *topView;

/** 左上角返回按钮 */
@property (nonatomic, strong) UIButton *btnBack;

/** 播放按钮 */
@property (nonatomic, strong) UIButton *btnPlay;
@end
@implementation YXCookMenuViewController
#pragma mark - 初始化方法
- (instancetype)initWithData:(MenuDataModel *)data
{
    self = [super init];
    if (self) {
        _data = data;
    }
    return self;
}
//不使用自己写的初始化就会项目崩溃
- (instancetype)init
{
    NSAssert1(NO, @"必须使用(instancetype)initWithID:初始化 %s", __FUNCTION__);
    return nil;
}
#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    [self webView];
    [self img];
    [self btnBack];
    [self btnPlay];
//    img.contentMode = UIViewContentModeScaleAspectFill;
    
}
#pragma mark - Method
//网络请求网址
- (NSURLRequest *)webUrl{
    return [NSURLRequest requestWithURL:[NSString stringWithFormat:kCookMenu, self.data.ID].yx_URL];
}
- (UIWebView *)webView {
	if(_webView == nil) {
		_webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        [_webView loadRequest:[self webUrl]];
        
//       _webView loadRequest:[self webUrl] progress:<#(NSProgress *__autoreleasing  _Nullable * _Nullable)#> success:<#^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML)success#> failure:<#^(NSError * _Nonnull error)failure#>
        _webView.scrollView.contentInset = UIEdgeInsetsMake(390, 0, 0, 0);
        _webView.scrollView.delegate = self;
	}
	return _webView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //通过滑动的遍历距离重新给图片设置大小
    CGFloat yOffset = scrollView.contentOffset.y;
    if(yOffset<-400)
    {
        CGRect imgFrame = self.img.frame;
        imgFrame.origin.y = yOffset+300;
        imgFrame.size.height = -yOffset;
        imgFrame.origin.x = -(-yOffset/300.0*kScreenW - kScreenW)/2.0;
        imgFrame.size.width = -yOffset/300.0*kScreenW;
//        self.btnPlay.center = self.img.center;
//        CGRect btnF = self.btnPlay.frame;
//        btnF.size.width = -yOffset/300.0 * 60;
//        btnF.size.height = -yOffset/300.0 * 60;
        self.img.frame = imgFrame;
//        self.btnPlay.frame = btnF;
    }
}
- (UIImageView *)img {
	if(_img == nil) {
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 300)];
        [_img setImageWithURL:self.data.imageUrl.yx_URL placeholder:@"default".yx_image];
        [self.topView addSubview:_img];
        
	}
	return _img;
}
- (UIButton *)btnPlay {
    if(_btnPlay == nil) {
        _btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.topView addSubview:_btnPlay];
        _btnPlay.frame = CGRectMake(kScreenW/2.0-30, 120, 60, 60);
        [_btnPlay setImage:@"play".yx_image forState:UIControlStateNormal];
        [_btnPlay setImage:@"play_on".yx_image forState:UIControlStateHighlighted];
        [_btnPlay addTarget:self action:@selector(clickTheBtnPlayTheVideo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPlay;
}

- (UIView *)topView {
	if(_topView == nil) {
		_topView = [[UIView alloc] initWithFrame:CGRectMake(0, -390, kScreenW, 390)];
        [_webView.scrollView addSubview:_topView];
        _topView.backgroundColor = kRGBColor(245, 245, 245, 1.0);
        YXCookMenuView *backgroundView = [YXCookMenuView new];
        [_topView addSubview:backgroundView];
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(310);
            make.bottom.equalTo(-10);
        }];
        backgroundView.labelTitle.text = self.data.title;
        backgroundView.labelTime.text = self.data.maketime;
        backgroundView.labelNum.text = @(self.data.clickCount).stringValue;
	}
	return _topView;
}
- (UIButton *)btnBack {
    if(_btnBack == nil) {
        _btnBack = [[UIButton alloc] init];
        [self.view addSubview:_btnBack];
        [_btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(20);
            make.width.height.equalTo(33);
        }];
        [_btnBack setImage:@"back_2".yx_image forState:UIControlStateNormal];
        [_btnBack addTarget:self action:@selector(clickTheBtnBackToLastPage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBack;
}
#pragma mark - View Appear

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Method 点击事件
- (void)clickTheBtnBackToLastPage:sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickTheBtnPlayTheVideo:sender{
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc]init];
    playerVC.player = [AVPlayer playerWithURL:self.data.detailsUrl.yx_URL];
    [playerVC.player play];
    [self presentViewController:playerVC animated:YES completion:nil];
}
@end
