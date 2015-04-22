//
//  AdMoGoSplashAdsDelegate.h
//  wanghaotest
//
//  Created by mogo on 13-11-12.
//
//

#import <Foundation/Foundation.h>

// 1 全屏 2居上 3居下
typedef enum{
    SplashAdShowTypeFull = 1,
    SplashAdShowTypeOn =2,
    SplashAdShowTypeUnder=3,
}SplashAdShowType;


@class AdMoGoSplashAds;
@protocol AdMoGoSplashAdsDelegate <NSObject>



@required
- (UIViewController *)adsMoGoSplashAdsViewControllerForPresentingModalView;
@optional

- (NSString *)adsMoGoSplashAdsiPhone5Image;

- (NSString *)adsMoGoSplashAdsiPhoneImage;

- (NSString *)adsMoGoSplashAdsiPadLandscapeImage;

- (NSString *)adsMoGoSplashAdsiPadPortraitImage;

- (void)adsMoGoSplashAdsSuccess:(AdMoGoSplashAds *)splashAds;

- (void)adsMoGoSplashAdsFail:(AdMoGoSplashAds *)splashAds withError:(NSError *)err;

- (void)adsMoGoSplashAdsAllAdFail:(AdMoGoSplashAds *)splashAds withError:(NSError *)err;

- (void)adsMoGoSplashAdsWillPresent:(AdMoGoSplashAds *)splashAds;

- (void)adsMoGoSplashAdsDidPresent:(AdMoGoSplashAds *)splashAds;

- (void)adsMoGoSplashAdsWillDismiss:(AdMoGoSplashAds *)splashAds;

- (void)adsMoGoSplashAdsDidDismiss:(AdMoGoSplashAds *)splashAds;

- (void)adsMoGoSplashAdsFinish:(AdMoGoSplashAds *)splashAds;

/*
    返回芒果自售广告尺寸
 */
- (CGRect)adMoGoSplashAdSize;


//返回芒果开屏显示类型 1 全屏 2居上 3居下
- (SplashAdShowType)adMoGoSplashShowType;


// 仅在芒果自售广告中使用
//ipad 屏幕适配 (旋转相关)
//设备旋转 需更换开屏广告的default图片
- (NSString *)adsMoGoSplash:(AdMoGoSplashAds *)splashAd OrientationDidChangeGetImageName:(UIInterfaceOrientation)interfaceOri;

// 仅在芒果自售广告中使用
//如果已展示广告旋转的过程需要调整广告的位置
- (CGPoint)adsMogoSplash:(AdMoGoSplashAds *)splashAd OrientationDidChangeGetAdPoint:(UIInterfaceOrientation)interfaceOri;



@end
