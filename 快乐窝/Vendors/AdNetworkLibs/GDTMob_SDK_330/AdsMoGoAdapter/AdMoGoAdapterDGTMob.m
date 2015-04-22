//
//  AdMoGoAdapterDGTMob.m
//  TestMOGOSDKAPI
//
//  Created by  Darren 2014-8-26
//
#import "GDTMobBannerView.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoConfigData.h"
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoDeviceInfoHelper.h"
#import "AdMoGoAdapterDGTMob.h"

@interface AdMoGoAdapterDGTMob()<GDTMobBannerViewDelegate>{
    
    BOOL isStop;
    AdMoGoConfigData *configData;
    NSTimer *timer;
}

@end

@implementation AdMoGoAdapterDGTMob
+ (AdMoGoAdNetworkType)networkType{
    return AdMoGoAdNetworkTypeGDTMob;
}

+ (void)load{
    [[AdMoGoAdSDKBannerNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd{
    isStop = NO;
    [adMoGoCore adapter:self didGetAd:@"GDTMob"];
    [adMoGoCore adDidStartRequestAd];
    AdMoGoConfigDataCenter *configDataCenter = [AdMoGoConfigDataCenter singleton];
    configData = [configDataCenter.config_dict objectForKey:adMoGoCore.config_key];
    AdViewType type = [configData.ad_type intValue];
    CGSize size = CGSizeZero;
    switch (type) {
        case AdViewTypeNormalBanner:
        case AdViewTypeiPadNormalBanner:
            size = GDTMOB_AD_SUGGEST_SIZE_320x50;
            break;
        case AdViewTypeLargeBanner:
            size = GDTMOB_AD_SUGGEST_SIZE_728x90;
            break;
        case AdViewTypeMediumBanner:
            size = GDTMOB_AD_SUGGEST_SIZE_468x60;
            break;

    
        default:
            [adMoGoCore adapter:self didFailAd:nil];
            return;
            break;
    }
    
    NSString *appid = [[self.ration objectForKey:@"key"] objectForKey:@"appid"];
    NSString *pid = [[self.ration objectForKey:@"key"] objectForKey:@"pid"];
    
    GDTMobBannerView *bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0,
                                                                                      0,
                                                                                      size.width,
                                                                                      size.height)
                                                                    appkey:appid
                                                               placementId:pid];
    
    
    self.adNetworkView = bannerView;
    [bannerView release];
    bannerView.delegate = self; // 设置Delegate
    bannerView.currentViewController = [adMoGoDelegate viewControllerForPresentingModalView]; //设置当前的ViewController
    bannerView.interval = 0; //【可选】设置刷新频率;默认30秒,0s 不刷新
    bannerView.isGpsOn = [configData islocationOn]; //【可选】开启GPS定位;默认关闭
    [GDTSDKConfig setSdkSrc:@"ADSMOGO"];
    [bannerView loadAdAndShow]; //加载广告并展示
    
    id _timeInterval = [self.ration objectForKey:@"to"];
    if ([_timeInterval isKindOfClass:[NSNumber class]]) {
        timer = [[NSTimer scheduledTimerWithTimeInterval:[_timeInterval doubleValue] target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    }
    else{
        timer = [[NSTimer scheduledTimerWithTimeInterval:AdapterTimeOut8 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    }
    
}

- (void)stopBeingDelegate{
    GDTMobBannerView *bannerView = (GDTMobBannerView *)self.adNetworkView;
    if (bannerView) {
        bannerView.delegate = nil;
        bannerView.currentViewController = nil;
    }
}

- (void)stopAd{
    isStop = YES;
    [self stopTimer];
    [self stopBeingDelegate];
}

- (void)stopTimer {
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (timer) {
            [timer invalidate];
            [timer release];
            timer = nil;
        }
    });
    
}
- (void)loadAdTimeOut:(NSTimer*)theTimer {

    if (isStop) {
        return;
    }
    [self stopTimer];
    [self stopBeingDelegate];
    [adMoGoCore adapter:self didFailAd:nil];
}
#pragma mark -
#pragma mark GDTMobBannerViewDelegate

// 请求广告条数据成功后调用
//
// 详解:当接收服务器返回的广告数据成功后调用该函数
- (void)bannerViewDidReceived{
    MGLog(MGD, @"广点通横幅接受返回数据成功");
    if (isStop) {
        return;
    }
    [self stopTimer];
    [adMoGoCore adapter:self didReceiveAdView:self.adNetworkView];
}

// 请求广告条数据失败后调用
//
// 详解:当接收服务器返回的广告数据失败后调用该函数
- (void)bannerViewFailToReceived:(int)errCode{
    if (isStop) {
        return;
    }
    NSLog(@"%s errCode-->%d",__FUNCTION__,errCode);
    MGLog(MGD, @"广点通横幅接受返回数据失败 errCode:%d",errCode);
    [self stopTimer];
    [adMoGoCore adapter:self didFailAd:nil];
    
}
/**
 *  banner条点击回调
 */
- (void)bannerViewClicked{
    if (isStop) {
        return;
    }
    [adMoGoCore sdkplatformSendCLK:self];
}

- (BOOL)isSDKSupportClickDelegate{
    return YES;
}

@end
