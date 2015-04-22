//
//  ViewController.m
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/3.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "RootPageViewController.h"
#import "UIViewController+ScrollingNavbar.h"

#import "XHPaggingNavbar.h"

#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoView.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"

#import "ImageMessageViewController.h"

typedef NS_ENUM(NSInteger, XHSlideType) {
    XHSlideTypeLeft = 0,
    XHSlideTypeRight = 1,
};

@interface RootPageViewController ()<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

//contentScrollView 头部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;


@property (strong, nonatomic) AdMoGoView *adMoGoView;

@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adViewHeightConstraint;

/**
 *  显示title集合的容器
 */
@property (nonatomic, strong) XHPaggingNavbar *paggingNavbar;

/**
 *  标识当前页码
 */
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger lastPage;

@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *rightViewController;


@end

@implementation RootPageViewController

- (void)loadAdView {
    //广告日志
    
//    [[AdMoGoLogCenter shareInstance] setLogLeveFlag:AdMoGoLogTemp];
//    [[AdMoGoLogCenter shareInstance] setLogLeveFlag:AdMoGoLogDebug];
    
    self.adMoGoView = [[AdMoGoView alloc] initWithAppKey:MOGO_APPKEY adType:AdViewTypeNormalBanner adMoGoViewDelegate:self autoScale:YES];
    self.adMoGoView.adWebBrowswerDelegate = self;
    self.adView.frame = CGRectMake(0.0, 0, 320.0, 50.0);
    [self.adView addSubview:self.adMoGoView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.472 green:0.509 blue:1.000 alpha:1.000]];
    
    #ifdef DEBUG_FLAG
    
    #else
        //加载广告视图
        [self loadAdView];
    #endif
    
    [self setupNavigationBarForTitleView];
    
    [self.navigationController.navigationBar setBarTintColor:COLOR_WHITE];
    
    [self followScrollView:self.contentScrollView withDelay:60];
    [self setUseSuperview:YES];
    [self setScrollingEnabled:YES];
    [self setScrollableViewConstraint:self.topConstraint withOffset:60];
    [self setShouldScrollWhenContentFits:NO];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ImageMessageViewController *imageMessageViewController = [storyboard instantiateViewControllerWithIdentifier:@"ImageMessageViewController"];
    imageMessageViewController.channel = 1;
    UIViewController *soundAlbumViewController = [storyboard instantiateViewControllerWithIdentifier:@"SoundAlbumViewController"];
    ImageMessageViewController *sexGirlViewController = [storyboard instantiateViewControllerWithIdentifier:@"ImageMessageViewController"];
    sexGirlViewController.channel = 2;
    self.viewControllers = @[imageMessageViewController, soundAlbumViewController,sexGirlViewController];
    
    
    [self setupViews];
    
    [self reloadData];

}

#pragma mark - DataSource

- (NSInteger)getCurrentPageIndex {
    return self.currentPage;
}

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated {
    self.paggingNavbar.currentPage = currentPage;
    self.currentPage = currentPage;
    
    CGFloat pageWidth = CGRectGetWidth(self.contentScrollView.frame);
    
    CGPoint contentOffset = self.contentScrollView.contentOffset;
    contentOffset.x = currentPage * pageWidth;
    [self.contentScrollView setContentOffset:contentOffset animated:animated];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage == currentPage)
        return;
    _lastPage = _currentPage;
    _currentPage = currentPage;
    
    self.paggingNavbar.currentPage = currentPage;
    
    [self setupScrollToTop];
    [self callBackChangedPage];
}


- (void)reloadData {
    if (!self.viewControllers.count) {
        return;
    }
    
    [self.contentScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        CGRect contentViewFrame = viewController.view.frame;
        contentViewFrame.origin.y = 0;
        contentViewFrame.origin.x = idx * CGRectGetWidth(self.view.bounds);
        contentViewFrame.size.height = self.contentScrollView.frame.size.height;
        contentViewFrame.size.width = self.contentScrollView.frame.size.width;
        viewController.view.frame = contentViewFrame;
        [self.contentScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
    
    [self.contentScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds) * self.viewControllers.count, 0)];
    
    self.paggingNavbar.titles = [self.viewControllers valueForKey:@"title"];
    [self.paggingNavbar reloadData];
    
    [self setupScrollToTop];
    
    [self callBackChangedPage];
}

- (XHPaggingNavbar *)paggingNavbar {
    if (!_paggingNavbar) {
        _paggingNavbar = [[XHPaggingNavbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) / 2.0, 44)];
        _paggingNavbar.backgroundColor = [UIColor clearColor];
        
        __weak typeof(self) weakSelf = self;
        _paggingNavbar.didChangedIndex = ^(NSInteger index) {
            [weakSelf setCurrentPage:index animated:YES];
        };
    }
    return _paggingNavbar;
}

- (void)setupNavigationBarForTitleView {
    self.navigationItem.titleView = self.paggingNavbar;
}


- (void)setupTargetViewController:(UIViewController *)targetViewController withSlideType:(XHSlideType)slideType {
    if (!targetViewController)
        return;
    
    [self addChildViewController:targetViewController];
    CGRect targetViewFrame = targetViewController.view.frame;
    switch (slideType) {
        case XHSlideTypeLeft: {
            targetViewFrame.origin.x = -CGRectGetWidth(self.view.bounds);
            break;
        }
        case XHSlideTypeRight: {
            targetViewFrame.origin.x = CGRectGetWidth(self.view.bounds) * 2;
            break;
        }
        default:
            break;
    }
    targetViewController.view.frame = targetViewFrame;
    [self.view insertSubview:targetViewController.view atIndex:0];
    [targetViewController didMoveToParentViewController:self];
}

- (void)setupViews {
    [self.view addSubview:self.contentScrollView];
    
    //    [self.contentScrollView.panGestureRecognizer addTarget:self action:@selector(panGestureRecognizerHandle:)];
    
    [self setupTargetViewController:self.leftViewController withSlideType:XHSlideTypeLeft];
    [self setupTargetViewController:self.rightViewController withSlideType:XHSlideTypeRight];
}


#pragma mark - Block Call Back Method

- (void)callBackChangedPage {
    UIViewController *fromViewController = [self.viewControllers objectAtIndex:self.lastPage];
    UIViewController *toViewController = [self.viewControllers objectAtIndex:self.currentPage];
    
    [fromViewController viewWillDisappear: true];
    [fromViewController viewDidDisappear: true];
    [toViewController viewWillAppear: true];
    [toViewController viewDidAppear: true];
    
    if (self.didChangedPageCompleted) {
        self.didChangedPageCompleted(self.currentPage, [[self.viewControllers valueForKey:@"title"] objectAtIndex:self.currentPage]);
    }
}

#pragma mark - TableView Helper Method

- (void)setupScrollToTop {
    for (int i = 0; i < self.viewControllers.count; i ++) {
        UITableView *tableView = (UITableView *)[self subviewWithClass:[UITableView class] onView:[self getPageViewControllerAtIndex:i].view];
        if (tableView) {
            if (self.currentPage == i) {
                [tableView setScrollsToTop:YES];
            } else {
                [tableView setScrollsToTop:NO];
            }
        }
    }
}

- (UIViewController *)getPageViewControllerAtIndex:(NSInteger)index {
    if (index < self.viewControllers.count) {
        return self.viewControllers[index];
    } else {
        return nil;
    }
}

#pragma mark - View Helper Method

- (UIView *)subviewWithClass:(Class)cuurentClass onView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:cuurentClass]) {
            return subView;
        }
    }
    return nil;
}


#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x!=0) {
        [self setShouldScrollWhenContentFits:NO];
    }
    
//    if (scrollView.contentOffset.y!=0) {
//        [self setShouldScrollWhenContentFits:YES];
//    }
    
    self.paggingNavbar.contentOffset = scrollView.contentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 得到每页宽度
    CGFloat pageWidth = CGRectGetWidth(self.contentScrollView.frame);
    
    // 根据当前的x坐标和页宽度计算出当前页数
    self.currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}



#pragma mark -
#pragma mark AdMoGoDelegate delegate
/*
 返回广告rootViewController
 */
- (UIViewController *)viewControllerForPresentingModalView{
    return self;
}



/**
 * 广告开始请求回调
 */
- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView{
    DLOG(@"广告开始请求回调");
}
/**
 * 广告接收成功回调
 */
- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView{
    [self.adView setHidden:NO];
    [self.adViewHeightConstraint setConstant:50.0f];
    DLOG(@"广告接收成功回调");
}
/**
 * 广告接收失败回调
 */
- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error{
    DLOG(@"广告接收失败回调");
}
/**
 * 点击广告回调
 */
- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView{
    DLOG(@"点击广告回调");
}
/**
 *You can get notified when the user delete the ad
 广告关闭回调
 */
- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView{
    DLOG(@"广告关闭回调");
}

#pragma mark -
#pragma mark AdMoGoWebBrowserControllerUserDelegate delegate

/*
 浏览器将要展示
 */
- (void)webBrowserWillAppear{
    DLOG(@"浏览器将要展示");
}

/*
 浏览器已经展示
 */
- (void)webBrowserDidAppear{
    DLOG(@"浏览器已经展示");
}

/*
 浏览器将要关闭
 */
- (void)webBrowserWillClosed{
    DLOG(@"浏览器将要关闭");
}

/*
 浏览器已经关闭
 */
- (void)webBrowserDidClosed{
    DLOG(@"浏览器已经关闭");
}
/**
 *直接下载类广告 是否弹出Alert确认
 */
-(BOOL)shouldAlertQAView:(UIAlertView *)alertView{
    return NO;
}

- (void)webBrowserShare:(NSString *)url{
    
}
@end
