//
//  YXCookMenuViewController.m
//  TRProject
//
//  Created by 李晨 on 16/7/2.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXCookMenuViewController.h"
#import "YXCookMenuView.h"
#import "YXLoginViewController.h"
#import <WebKit/WebKit.h>
#define kBtnDistance ((kScreenW - 4 * 24)/4.0)
@import AVKit;
@import AVFoundation;
@interface YXCookMenuViewController ()<UIScrollViewDelegate, UIAlertViewDelegate>

/** WebView */
@property (nonatomic, strong) WKWebView *webView;

/** img */
@property (nonatomic, strong) UIImageView *img;

/** 上方视图 */
@property (nonatomic, strong) UIView *topView;

/** 左上角返回按钮 */
@property (nonatomic, strong) UIButton *btnBack;

/** 播放按钮 */
@property (nonatomic, strong) UIButton *btnPlay;

/** 回到顶部 */
@property (nonatomic, strong) UIControl *upToTop;

/** 底部白图 */
@property (nonatomic, strong) UIView *bottomView;

/** 评论 */
@property (nonatomic, strong) UIButton *btnTalk;

/** 喜欢 */
@property (nonatomic, strong) UIButton *btnLove;

/** 文字大小 */
@property (nonatomic, strong) UIButton *btnFont;

/** 分享 */
@property (nonatomic, strong) UIButton *btnShare;
@end
@implementation YXCookMenuViewController{
    BOOL isLove;
    BOOL isFont;
}
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
    [self bottomView];
    [self btnTalk];
    [self btnLove];
    [self btnFont];
    [self btnShare];
    //    img.contentMode = UIViewContentModeScaleAspectFill;
    
}
#pragma mark - Method
//网络请求网址
- (NSURLRequest *)webUrl{
    return [NSURLRequest requestWithURL:[NSString stringWithFormat:kCookMenu, self.data.ID].yx_URL];
}
#pragma mark - UIScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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
    if(yOffset>kScreenH-400){
        self.upToTop.layer.hidden = NO;
    }else{
        self.upToTop.layer.hidden = YES;
    }
    
}
#pragma mark - LazyLoad 懒加载
- (WKWebView *)webView {
    if(_webView == nil) {
        _webView = [[WKWebView alloc] init];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.view showBusyHUD];
            [[NSOperationQueue new]addOperationWithBlock:^{
                [_webView loadRequest:[self webUrl]];
                [self.view hideBusyHUD];
            }];
        }];
        
        //        [self.view showBusyHUD];
        //       [_webView loadRequest:[self webUrl] progress:nil success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        //           [self.view hideBusyHUD];
        //            NSString *str = [NSString stringWithCString:[HTML UTF8String] encoding:NSUTF8StringEncoding];
        //           return str;
        //       } failure:^(NSError * _Nonnull error) {
        //           
        //       }];
        
        _webView.scrollView.contentInset = UIEdgeInsetsMake(390, 0, 50, 0);
        _webView.scrollView.delegate = self;
    }
    return _webView;
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
- (UIControl *)upToTop {
    if(_upToTop == nil) {
        _upToTop = [[UIControl alloc] init];
        [self.view addSubview:_upToTop];
        [_upToTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-20);
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
- (UIView *)bottomView {
    if(_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(50);
        }];
        _bottomView.backgroundColor = kRGBColor(251, 249, 247, 1.0);
    }
    return _bottomView;
}
- (UIButton *)btnTalk {
    if(_btnTalk == nil) {
        _btnTalk = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bottomView addSubview:_btnTalk];
        [_btnTalk mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kBtnDistance/2);
            make.centerY.equalTo(0);
            make.height.with.equalTo(24);
        }];
        [_btnTalk setImage:@"Details_tabcommentIcon".yx_image forState:UIControlStateNormal];
        [_btnTalk addTarget:self action:@selector(clickBtnToTalk:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTalk;
}

- (UIButton *)btnLove {
    if(_btnLove == nil) {
        _btnLove = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bottomView addSubview:_btnLove];
        [_btnLove mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnTalk.mas_right).equalTo(kBtnDistance);
            make.centerY.equalTo(0);
            make.height.with.equalTo(24);
        }];
        [_btnLove setImage:@"Details_tabfavIcon".yx_image forState:UIControlStateNormal];
        [_btnLove addTarget:self action:@selector(clickBtnToLove:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLove;
}

- (UIButton *)btnFont {
    if(_btnFont == nil) {
        _btnFont = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bottomView addSubview:_btnFont];
        [_btnFont mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnLove.mas_right).equalTo(kBtnDistance);
            make.centerY.equalTo(0);
            make.height.with.equalTo(24);
        }];
        [_btnFont setImage:@"Details_font".yx_image forState:UIControlStateNormal];
        [_btnFont addTarget:self action:@selector(clickBtnToFont:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnFont;
}

- (UIButton *)btnShare {
    if(_btnShare == nil) {
        _btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bottomView addSubview:_btnShare];
        [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnFont.mas_right).equalTo(kBtnDistance);
            make.centerY.equalTo(0);
            make.height.with.equalTo(24);
        }];
        [_btnShare setImage:@"Details_tabshare".yx_image forState:UIControlStateNormal];
        [_btnShare addTarget:self action:@selector(clickBtnToShare:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnShare;
}
#pragma mark - View Appear

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
#warning 离开界面时, 要将scrollView的代理设置为空, 不然无法释放内存, 会崩溃.
    self.webView.scrollView.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self play];
    }
}
#pragma mark - Method 点击事件
//返回上一页
- (void)clickTheBtnBackToLastPage:sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//播放按钮
- (void)clickTheBtnPlayTheVideo:sender{
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown||AFNetworkReachabilityStatusNotReachable) {
            [self.view showWarning:@"当前没有网络"];
            return;
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"当前使用的是蜂窝数据流量" message:@"确定使用数据流量?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alertView.delegate = self;
            [alertView show];
            return;
        }
    }];
    [self play];
}
//开始播放视频
- (void)play{
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc]init];
    playerVC.player = [AVPlayer playerWithURL:self.data.detailsUrl.yx_URL];
    [playerVC.player play];
    [self presentViewController:playerVC animated:YES completion:nil];
}
//回到顶部
- (void)clickItWillToTop:sender{
    [self.webView.scrollView scrollToTop];
}
//评论
- (void)clickBtnToTalk:sender{
    DDLogInfo(@"评论");
//    [self presentViewController:[YXLoginViewController new] animated:YES completion:nil];
}
//喜欢
- (void)clickBtnToLove:(UIButton *)sender{
    if (!isLove) {
        [self.view showWarning:@"已关注"];
        [sender setImage:@"Details_on_tabfavIcon".yx_image forState:UIControlStateNormal];
        isLove = YES;
    }else {
        [self.view showWarning:@"已取消关注"];
        [sender setImage:@"Details_tabfavIcon".yx_image forState:UIControlStateNormal];
        isLove = NO;
    }
}
//文字大小
- (void)clickBtnToFont:(UIButton *)sender{
    
    if (!isFont) {
        [sender setImage:@"Details_selectFont".yx_image forState:UIControlStateNormal];
        isFont = YES;
        NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",150.0];
//        [self.webView stringByEvaluatingJavaScriptFromString:str1];
        [self.webView evaluateJavaScript:str1 completionHandler:nil];
    }else {
        [sender setImage:@"Details_font".yx_image forState:UIControlStateNormal];
        isFont = NO;
        NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",100.0];
//        [self.webView stringByEvaluatingJavaScriptFromString:str1];
        [self.webView evaluateJavaScript:str1 completionHandler:nil];
    }
}
//分享
- (void)clickBtnToShare:sender{
    DDLogInfo(@"分享");
}
@end
