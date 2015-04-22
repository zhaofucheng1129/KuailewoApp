//
//  AdMoGoSplashAds.h
//  wanghaotest
//
//  Created by mogo on 13-11-12.
//
//

#import <Foundation/Foundation.h>
#import "AdMoGoSplashAdsDelegate.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"
#import "AdMoGoAdNetworkAdapter.h"


@interface AdMoGoSplashAds : NSObject

//@property (nonatomic, assign) BOOL isReady; // 可以通过该属性获知开屏广告是否可以展现
@property (nonatomic, assign) id<AdMoGoSplashAdsDelegate> delegate; // 指定开屏广告的委派
@property (nonatomic, assign) id<AdMoGoWebBrowserControllerUserDelegate> adWebBrowswerDelegate;
@property (nonatomic, retain) UIViewController *appViewController;

@property(nonatomic,retain) NSString *config_key;


/*
    初始化开屏聚合
    ak:芒果ID
    delegate:AdMoGoSplashAdsDelegate 回调
    window:App window
 */
- (id) initWithAppKey:(NSString *)ak
 adMoGoSplashAdsDelegate:(id<AdMoGoSplashAdsDelegate>) delegate
               window:(UIWindow *)window;

/*
 阻塞app启动
 初始化开屏聚合
 ak:芒果ID
 delegate:AdMoGoSplashAdsDelegate 回调
 window:App window
 firstObj,...:App parmas，需要设置在开屏完成后使用的参数
 */
- (id) bolckAppLaunchinitWithAppKey:(NSString *)ak
            adMoGoSplashAdsDelegate:(id<AdMoGoSplashAdsDelegate>) delegate
                             window:(UIWindow *)window
                        WithObjects:(id)firstObj, ...;
/*
    返回阻塞app启动初始化中的参数
 暨- (id) bolckAppLaunchinitWithAppKey:(NSString *)ak
 adMoGoSplashAdsDelegate:(id<AdMoGoSplashAdsDelegate>) delegate
 window:(UIWindow *)window
 WithObjects:(id)firstObj, ...中WithObjects中设置的参数。
 */
- (NSArray *)getBolckAppLanuchObjects;

/*
    请求开屏广告
 */
- (void)requestSplashAd;

/*
    返回开屏中使用的window对象
 */
- (UIWindow *)getWindow;

/*
    返回开屏背景图片
 */
- (NSString *)getBackgroundImageName;

/*
    返回开屏广告的MoGoID
 */
- (NSString *)getMogoID;

/*
    返回芒果开屏的背景View
 */
-(UIView *)getBackgroundView;

- (void)adapterDidStartRequestSplashAd:(AdMoGoAdNetworkAdapter *)_adapter;

- (void)adSplashSuccess:(AdMoGoAdNetworkAdapter *)_adapter withSplash:(id)splashAd;

- (void)adSplashFail:(AdMoGoAdNetworkAdapter *)_adapter withError:(NSError *)error;

- (void)adSplash:(AdMoGoAdNetworkAdapter *)_adapter WillPresent:(id)splashAd;

- (void)adSplash:(AdMoGoAdNetworkAdapter *)_adapter DidPresent:(id)splashAd;

- (void)adSplash:(AdMoGoAdNetworkAdapter *)_adapter WillDismiss:(id)splashAd;

- (void)adSplash:(AdMoGoAdNetworkAdapter *)_adapter didDismiss:(id)splashAd;
- (void) sendClickCountWithAdAdpter:(AdMoGoAdNetworkAdapter *)_adapter;
@end
