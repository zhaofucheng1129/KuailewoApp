//
//  AdMoGoAdapterAdChinaVideoAd.m
//  TestMOGOSDKAPI
//
//  Created by Daxiong on 13-8-7.
//  Copyright (c) 2013年 Daxiong. All rights reserved.
//
#import "AdChinaVideoView.h"
#import "AdMoGoAdNetworkRegistry.h"
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoAdapterAdChinaVideoAd.h"
#import "AdChinaLocationManager.h"
#import "AdMoGoAdSDKVideoNetworkRegistry.h"
@interface AdMoGoAdapterAdChinaVideoAd ()<AdChinaVideoViewDelegate>{
    BOOL isStop;
    BOOL isReady;
    BOOL isClosed;
    UIViewController *_viewController;
    AdChinaVideoView *_adChinaVideoView;
      int currentViewControllerIndex;
}

@end

@implementation AdMoGoAdapterAdChinaVideoAd


+ (AdMoGoAdNetworkType)networkType{
    return AdMoGoAdNetworkTypeAdChina;
}

+ (void)load{
    [[AdMoGoAdSDKVideoNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {

    UIViewController *viewController = [self rootViewControllerForPresent];
    currentViewControllerIndex = [viewController.navigationController.viewControllers indexOfObject:self];
    
    isStop = NO;
    isReady = NO;
    isClosed = NO;
    [adMoGoCore adDidStartRequestAd];
    
    AdMoGoConfigDataCenter *configDataCenter = [AdMoGoConfigDataCenter singleton];
    AdMoGoConfigData *configData = [configDataCenter.config_dict objectForKey:[self getConfigKey]];
    AdViewType type =[configData.ad_type intValue];
    if (type != AdViewTypeVideo) {
        MGLog(MGT,@"not video ad type");
        [self adapter:self didFailAd:nil];
        return;
    }
    if ([configData islocationOn] == FALSE) {
        [AdChinaLocationManager setLocationServiceEnabled:NO];
    }
    _viewController = [self rootViewControllerForPresent];
    _adChinaVideoView = [[AdChinaVideoView requestAdWithAdSpaceId:[self.ration objectForKey:@"key"]
                                                        delegate:self
                                                  shouldAutoPlay:NO] retain];
    /* Set Video Size width:height = 4:3 */
    CGSize videoSize = VideoSizeWithAdViewWidth([UIScreen mainScreen].bounds.size.width);
	_adChinaVideoView.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    /* Dock at center */
	_adChinaVideoView.center = _viewController.view.center;
    _adChinaVideoView.autoresizingMask = UIViewAutoresizingNone;
    MGLog(MGT, @"_adChinaVideoView-->%@",_adChinaVideoView);
//    MGLog(MGT,@"view %@",_viewController.view);
    /* Set viewcontroller for browser, default viewcontroller is delegate */
	[_adChinaVideoView setViewControllerForBrowser:_viewController];// presentModalView to show browser
    [self adapterDidStartRequestAd:self];

    
}




- (void)dealloc{
    [super dealloc];
}
- (void)stopBeingDelegate{
    if (_adChinaVideoView && [_adChinaVideoView superview]) {
        [_adChinaVideoView removeFromSuperview];
        _adChinaVideoView = nil;
    }
}
- (void)stopAd{
    
    isStop = YES;
    [self stopBeingDelegate];
}

- (BOOL)isReadyPresentInterstitial{
    return isReady;
}
-(void)playVideoAd{
    if (isReady) {
        [self adapter:self willPresent:nil];
        [_viewController.view addSubview:_adChinaVideoView];
        [_adChinaVideoView startPlaying];
        [self adapter:self didShowAd:_adChinaVideoView];
    }
}
- (void)presentInterstitial{
}


#pragma mark -
#pragma mark AdChinaVideoView Delegate method
- (void)didGetVideoAd:(AdChinaVideoView *)adView{
    if (isStop) {
        return;
    }
    isReady = YES;
    [self adapter:self didReceiveInterstitialScreenAd:adView];
}
- (void)didFailToGetVideoAd:(AdChinaVideoView *)adView{
    if (isStop) {
        return;
    }
    [self adapter:self didFailAd:nil];

}
- (void)didCloseVideoAd:(AdChinaVideoView *)adView{
    if (isStop || isClosed) {
        return;
    }
    isClosed = YES;
    [self adapter:self didDismissScreen:nil];

    
}

// Called when user opens an in-app web browser
// You may use this method to pause game animation, music, etc.
- (void)didEnterFullScreenMode{
    [self adapterAdModal:self willPresent:nil];
}
- (void)didExitFullScreenMode{
    [self adapterAdModal:self didDismissScreen:nil];
}

// You may use these methods to count click/watch number by yourself
- (void)didClickVideoAd:(AdChinaVideoView *)adView{
    [self specialSendRecordNum];
}
- (void)didFinishWatchingVideoAd:(AdChinaVideoView *)adView{
    if (isStop || isClosed) {
        return;
    }
    isClosed = YES;
    [self adapter:self didDismissScreen:nil];
}
@end
