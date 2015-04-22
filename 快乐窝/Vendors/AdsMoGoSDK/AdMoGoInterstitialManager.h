//
//  AdMoGoInterstitialManager.h
//  AdsMogo
//
//  Created by Daxiong on 14-4-28.
//
//

#import "AdMoGoInterstitial.h"
#import <Foundation/Foundation.h>

@interface AdMoGoInterstitialManager : NSObject

+ (void)setAppKey:(NSString *)key;
+ (void)setRootViewController:(UIViewController *)rvc;
+ (void)setDefaultDelegate:(id)delegate;

+ (AdMoGoInterstitialManager *)shareInstance;

- (void)initDefaultInterstitial;
- (AdMoGoInterstitial *)defaultInterstitial;
- (AdMoGoInterstitial *)adMogoInterstitialByAppKey:(NSString *)appKey;
- (AdMoGoInterstitial *)adMogoVideoInterstitialByAppKey:(NSString *)appKey;

- (AdMoGoInterstitial *)adMogoInterstitialByAppKey:(NSString *)appKey isManualRefresh:(BOOL)isManualRefresh;
- (AdMoGoInterstitial *)adMogoVideoInterstitialByAppKey:(NSString *)appKey isManualRefresh:(BOOL)isManualRefresh;

- (void)removeInterstitialInstance;
- (void)removeInterstitialInstanceByAppKey:(NSString *)key;
- (void)removeVideoInterstitialInstanceByAppKey:(NSString *)key;
- (void)removeAllInterstitialInstance;


/*----------------------------------*/
//
//以下方法是对全屏广告实例的封装，直接操作 “default” Interstitial对象
//当然也可以通过- (AdMoGoInterstitial *)adMogoInterstitialByAppKey:(NSString *)appKey获得对应key的对象直接操作
//
//注：通过+ (void)setAppKey:(NSString *)key方法设置设置的key对应的对象
//将被视为“default” Interstitial对象
//
/*----------------------------------*/

/**
 *进入展示时机
 *isWait:如果没有广告展示是否等待
 */
- (void)interstitialShow:(BOOL)isWait;

/**
 *离开展示时机
 */
- (void)interstitialCancel;

@end
