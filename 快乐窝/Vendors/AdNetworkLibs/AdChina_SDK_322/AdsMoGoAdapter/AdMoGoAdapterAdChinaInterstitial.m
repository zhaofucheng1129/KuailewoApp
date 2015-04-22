//
//  AdMoGoAdapterAdChinaInterstitial.m
//  wanghaotest
//
//  Created by mogo on 13-12-16.
//
//

#import "AdMoGoAdapterAdChinaInterstitial.h"
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoConfigData.h"
#import "AdChinaLocationManager.h"

@implementation AdMoGoAdapterAdChinaInterstitial
@synthesize interstitialView = _interstitialView;
+ (AdMoGoAdNetworkType)networkType{
    return AdMoGoAdNetworkTypeAdChina;
}

+ (void)load{
    [[AdMoGoAdSDKInterstitialNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    
    isStop = NO;
    isLoaded = NO;
    initAdChinaFrame = CGRectZero;
}

- (void)stopBeingDelegate {
    /*2013*/
    if (self.interstitialView) {
        [_interstitialView removeFromSuperview];
        _interstitialView = nil;
    }
    
}

- (void)stopAd{
    [self stopBeingDelegate];
    [self stopTimer];
    isStop = YES;
}

- (void)dealloc {
    MGLog(MGT,@"remove ad");
    
    [super dealloc];
    
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}


- (BOOL)isReadyPresentInterstitial{
    return YES;
}

-(void)presentInterstitial{
    if (!isLoaded) {
        isLoaded = YES;
    }else{
        return;
    }
    /*
     获取广告类型
     原来代码：AdViewType type = adMoGoView.adType;
     */
    AdMoGoConfigDataCenter *configDataCenter = [AdMoGoConfigDataCenter singleton];
    
    AdMoGoConfigData *configData = [configDataCenter.config_dict objectForKey:[self getConfigKey]];
    
    AdViewType type =[configData.ad_type intValue];
    
	if (type == AdViewTypeFullScreen ||
        type == AdViewTypeiPadFullScreen) {
        if ([configData islocationOn] == FALSE) {
            [AdChinaLocationManager setLocationServiceEnabled:NO];
        }
        self.interstitialView = [AdChinaInterstitialView requestAdWithAdSpaceId:[self.ration objectForKey:@"key" ] delegate:self];
        [self.interstitialView setViewControllerForBrowser:[UIApplication sharedApplication].keyWindow.rootViewController];
//        [self.interstitialView setDebugMode:YES];
        
        [self adapterDidStartRequestAd:self];
        
        id _timeInterval = [self.ration objectForKey:@"to"];
        if ([_timeInterval isKindOfClass:[NSNumber class]]) {
            timer = [[NSTimer scheduledTimerWithTimeInterval:[_timeInterval doubleValue] target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
        }
        else{
            timer = [[NSTimer scheduledTimerWithTimeInterval:AdapterTimeOut15 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
        }
    }
}

/*2013*/
- (void)loadAdTimeOut:(NSTimer*)theTimer {
    if (isStop) {
        return;
    }
    
    [self stopTimer];
    [self stopBeingDelegate];
    [self adapter:self didFailAd:nil];
}

//接收插屏成功代理函数
- (void)didGetInterstitialAd:(AdChinaInterstitialView *)adView{
    if (isStop) {
        return;
    }
    [self stopTimer];
    [self adapter:self didReceiveInterstitialScreenAd:adView];

    
    UIViewController *baseviewController = nil;
    if ([UIApplication sharedApplication].keyWindow.rootViewController) {
        baseviewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }else{
        baseviewController= [self rootViewControllerForPresent];
    }

    if ([[UIDevice currentDevice].systemVersion intValue]<7 &&
        baseviewController.navigationController &&
        [UIScreen mainScreen].bounds.size.height-(44+20)!=baseviewController.view.bounds.size.height) {
        self.interstitialView.frame = CGRectMake(0.0, 20.0, self.interstitialView.frame.size.width, self.interstitialView.frame.size.height);
    }else if([[UIDevice currentDevice].systemVersion intValue]<7){
        self.interstitialView.frame = CGRectMake(0.0, 20.0, self.interstitialView.frame.size.width, self.interstitialView.frame.size.height);
    }
    initAdChinaFrame = baseviewController.view.bounds;
    [baseviewController.view addSubview:self.interstitialView];
    
    [self adapter:self didShowAd:self.interstitialView];
    
}

//接收插屏失败代理函数
- (void)didFailToGetInterstitialAd:(AdChinaInterstitialView *)adView{
    if (isStop) {
        return;
    }
    [self stopTimer];
	[self adapter:self didFailAd:nil];
}

//关闭插屏代理函数
- (void)didCloseInterstitialAd:(AdChinaInterstitialView *)adView{
    UIViewController *baseviewController = nil;
    if ([UIApplication sharedApplication].keyWindow.rootViewController) {
        baseviewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }else{
        baseviewController= [self rootViewControllerForPresent];
    }
    CGRect rect = baseviewController.view.frame;
    [_interstitialView removeFromSuperview];
    baseviewController.view.frame = rect;
    
    _interstitialView = nil;
    [self adapter:self didDismissScreen:adView];
}

// 点击进入landingPage,退出landingPage后的回调函数
- (void)didEnterFullScreenMode{

}
- (void)didExitFullScreenMode{
    if ([[UIDevice currentDevice].systemVersion intValue]<7) {
        UIViewController *baseviewController = nil;
        if ([UIApplication sharedApplication].keyWindow.rootViewController) {
            baseviewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        }else{
            baseviewController= [self rootViewControllerForPresent];
        }
        if (baseviewController.navigationController) {
            self.interstitialView.frame = CGRectMake(0.0, 20.0, self.interstitialView.frame.size.width, self.interstitialView.frame.size.height);
        }
        
    }
}
//点击插屏代理回调函数
- (void)didClickInterstitialView:(AdChinaInterstitialView *)adView{
    [self sendAdFullClick];
}

- (void)sendAdFullClick{
    if (isStop) {
        return;
    }
    [self specialSendRecordNum];
}
@end
