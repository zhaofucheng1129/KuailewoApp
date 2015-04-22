//
//  AdMoGoAdapterInmobiSDK.m
//  TestMOGOSDKAPP
//
//  Created by Daxiong on 13-9-12.
//  Copyright (c) 2012年 AdsMogo. All rights reserved.
//


#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoView.h"
#import "AdMoGoAdNetworkConfig.h" 
#import "AdMoGoAdNetworkAdapter+Helpers.h"
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoConfigData.h"
#import "AdMoGoDeviceInfoHelper.h"
#import "AdMoGoAdapterInmobiSDK.h"

@implementation AdMoGoAdapterInmobiSDK


+ (AdMoGoAdNetworkType)networkType{
    return AdMoGoAdNetworkTypeInMobi;
}

+ (void)load {
	[[AdMoGoAdSDKBannerNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    isStop = NO;
    [adMoGoCore adDidStartRequestAd];
    [adMoGoCore adapter:self didGetAd:@"inmobisdk"];
    /*
     获取广告类型
     原来代码：AdViewType type = adMoGoView.adType;
     */
    AdMoGoConfigDataCenter *configDataCenter = [AdMoGoConfigDataCenter singleton];
    AdMoGoConfigData *configData = [configDataCenter.config_dict objectForKey:adMoGoCore.config_key];
    AdViewType type = [configData.ad_type intValue];
//    rect = CGRectZero;
    CGRect rect = CGRectZero;
    int sizetype;
    switch (type) {
        case AdViewTypeiPadNormalBanner: 
        case AdViewTypeNormalBanner:

            sizetype = IM_UNIT_320x48;
            rect = CGRectMake(0, 0, 320, 48);
            break;
        case AdViewTypeRectangle:
        case AdViewTypeiPhoneRectangle:
            sizetype = IM_UNIT_300x250;
            rect = CGRectMake(0, 0, 300, 250);
            break;
        case AdViewTypeMediumBanner:
            sizetype = IM_UNIT_468x60;
            rect = CGRectMake(0, 0, 468, 60);
            break;
        case AdViewTypeLargeBanner:

            sizetype = IM_UNIT_728x90;
            rect = CGRectMake(0, 0, 728, 90);
            break;
        default:
            [adMoGoCore adapter:self didFailAd:nil];
            return;
            break;
    }

    
    [InMobi setLogLevel:IMLogLevelNone];
//    [InMobi setLogLevel:IMLogLevelDebug];
    [InMobi initialize:[self.ration objectForKey:@"key"]];
    IMBanner *inmobiAdView = [[IMBanner alloc] initWithFrame:rect
                                                       appId:[self.ration objectForKey:@"key"]
                                                      adSize:sizetype];
    
    inmobiAdView.refreshInterval = REFRESH_INTERVAL_OFF;
    inmobiAdView.delegate = self;
    [inmobiAdView loadBanner];
    
    self.adNetworkView = inmobiAdView;
    [inmobiAdView release];
    

    id _timeInterval = [self.ration objectForKey:@"to"];
    if ([_timeInterval isKindOfClass:[NSNumber class]]) {
        timer = [[NSTimer scheduledTimerWithTimeInterval:[_timeInterval doubleValue] target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    }
    else{
        timer = [[NSTimer scheduledTimerWithTimeInterval:AdapterTimeOut8 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    }
}

- (void)stopAd{
    [self stopBeingDelegate];
    isStop = YES;
    [self stopTimer];
}

- (void)stopBeingDelegate {
    if (self.adNetworkView && [self.adNetworkView isKindOfClass:[IMBanner class]]) {
        [(IMBanner *)self.adNetworkView setDelegate:nil];
    }
}

- (void)dealloc{
    [super dealloc];
}



#pragma mark InMobiAdDelegate methods

/**
 * Callback sent when an ad request loaded an ad. This is a good opportunity
 * to add this view to the hierarchy if it has not yet been added.
 * @param banner The IMBanner instance which finished loading the ad request.
 */
- (void)bannerDidReceiveAd:(IMBanner *)banner{
    if (isStop) {
        return;
    }
    MGLog(MGD,@"inMobi接收横幅广告数据获取成功");
    [self stopTimer];
    [adMoGoCore adapter:self didReceiveAdView:self.adNetworkView];

}
/**
 * Callback sent when an ad request failed. Normally this is because no network
 * connection was available or no ads were available (i.e. no fill).
 * @param banner The IMBanner instance that failed to load the ad request.
 * @param error The error that occurred during loading.
 */
- (void)banner:(IMBanner *)banner didFailToReceiveAdWithError:(IMError *)error{
    if (isStop) {
        return;
    }
    MGLog(MGD,@"inMobi接收横幅广告数据失败");
    MGLog(MGE, @"inMobi error %@",error);
    [self stopTimer];
    [adMoGoCore adapter:self didFailAd:error];
    banner.delegate = nil;
}
/**
 * Called when the banner is tapped or interacted with by the user
 * Optional data is available to publishers to act on when using
 * monetization platform to render promotional ads.
 * @param banner The IMBanner instance that presents the screen.
 * @param dictionary The NSDictionary containing the parameters as passed by the creative
 */
-(void)bannerDidInteract:(IMBanner *)banner withParams:(NSDictionary *)dictionary{
    MGLog(MGD,@"inMobi接收横幅广告被点击");
    MGLog(MGT,@"%s",__FUNCTION__);
}
/**
 * Callback sent just before when the banner is presenting a full screen view
 * to the user. Use this opportunity to stop animations and save the state of
 * your application in case the user leaves while the full screen view is on
 * screen (e.g. to visit the App Store from a link on the full screen view).
 * @param banner The IMBanner instance that presents the screen.
 */
- (void)bannerWillPresentScreen:(IMBanner *)banner{
    MGLog(MGD,@"inMobi接收横幅广告将要展示");
}
/**
 * Callback sent just before dismissing the full screen view.
 * @param banner The IMBanner instance that dismisses the screen.
 */
- (void)bannerWillDismissScreen:(IMBanner *)banner{
    MGLog(MGD,@"inMobi接收横幅广告将要消失");
    MGLog(MGT,@"%s",__FUNCTION__);
}
/**
 * Callback sent just after dismissing the full screen view.
 * Use this opportunity to restart anything you may have stopped as part of
 * bannerWillPresentScreen: callback.
 * @param banner The IMBanner instance that dismissed the screen.
 */
- (void)bannerDidDismissScreen:(IMBanner *)banner{
    MGLog(MGD,@"inMobi接收横幅广告已经消失");
}
/**
 * Callback sent just before the application goes into the background because
 * the user clicked on a link in the ad that will launch another application
 * (such as the App Store). The normal UIApplicationDelegate methods like
 * applicationDidEnterBackground: will immediately be called after this.
 * @param banner The IMBanner instance that is launching another application.
 */
- (void)bannerWillLeaveApplication:(IMBanner *)banner{
    MGLog(MGD,@"inMobi接收横幅广告将要离开应用");
    MGLog(MGT,@"%s",__FUNCTION__);
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    MGLog(MGD,@"inMobi接收横幅广告超时");
    
    if (isStop) {
        return;
    }
    
    [self stopTimer];
    if (self.adNetworkView && [self.adNetworkView isKindOfClass:[IMBanner class]]) {
        
        [(IMBanner *)self.adNetworkView setDelegate:nil];
        
    }
    [adMoGoCore adapter:self didFailAd:nil];
}
@end
