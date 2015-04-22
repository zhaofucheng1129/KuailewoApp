//
//  AdMoGoInterstitialDelegate.h
//  AdsMogo
//
//  Created by Daxiong on 14-4-28.
//
//
#import <Foundation/Foundation.h>

@class AdMoGoInterstitial;

@protocol AdMoGoInterstitialDelegate <NSObject>

@optional

/*
 返回广告rootViewController
 */
- (UIViewController *)viewControllerForPresentingInterstitialModalView;
/*
    全屏广告将要展示
 */
- (void)adsMoGoInterstitialAdWillPresent;

/*
    全屏广告消失
 */
- (void)adsMoGoInterstitialAdDidDismiss;

/**
 *广告过期 
 *是否立即重新轮换广告
 *return YES-->立即轮换 NO-->等待下一次进入展示机会轮换
 */
- (BOOL)adsMogoInterstitialAdDidExpireAd;

/*
    全屏广告浏览器展示
 */
- (void)adsMoGoWillPresentInterstitialAdModal;

/*
    全屏广告浏览器消失
 */
- (void)adsMoGoDidDismissInterstitialAdModal;

/**
 *芒果全屏 关闭按钮被点击
 *return YES/NO 来确定是否可关闭 default YES
 */
- (BOOL)adsMogoInterstitialAdClosedButtonTap;
/*
    芒果广告关闭
 */
- (void)adsMogoInterstitialAdClosed:(BOOL)isAutoClose;


-(BOOL)interstitialShouldAlertQAView:(UIAlertView *)alertView;

-(BOOL)isFullScreen;

/*
    芒果插屏初始化完成
 */
- (void)adMoGoInterstitialInitFinish;

/*
    手动轮换下，广告轮空回调
 */
- (void)adMoGoInterstitialInMaualfreshAllAdsFail;

@end
