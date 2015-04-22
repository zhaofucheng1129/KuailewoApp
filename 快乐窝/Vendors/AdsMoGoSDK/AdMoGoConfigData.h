//
//  AdMoGoConfigDataStruct.h
//  mogosdk
//
//  Created by MOGO on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	AMBannerAnimationTypeNone           = 0,
	AMBannerAnimationTypeFlipFromLeft   = 1,
	AMBannerAnimationTypeFlipFromRight  = 2,
	AMBannerAnimationTypeCurlUp         = 3,
	AMBannerAnimationTypeCurlDown       = 4,
	AMBannerAnimationTypeSlideFromLeft  = 5,
	AMBannerAnimationTypeSlideFromRight = 6,
	AMBannerAnimationTypeFadeIn         = 7,
    AMBannerAnimationTypeRandom         = 8,
    AMBannerAnimationTypeFilpFromTop=9,
    AMBannerAnimationTypeFilpFromBottom = 10,

} AMBannerAnimationType;



typedef enum{
    AMBannerAnimationEnhanceTypeNone = 0,
    AMBannerAnimationEnhanceTypeShake = 1,
    AMBannerAnimationEnhanceTypeCrinkle = 2,
    AMBannerAnimationEnhanceTypeRandom = 3,
} AMBannerAnimationEnhanceType;

@interface AdMoGoConfigData : NSObject
{
    /*
        用户信息 头
     */
    NSMutableDictionary *_config_extra;
    
    
    /*
        用户信息 体
     */
    NSMutableArray *_config_rations;
    
    /*
        appkey
     */
    NSString * _app_key;
    
    /*
        广告类型
     */
    NSNumber * _ad_type;
    
    /*
        广告banner动画类型
     */
    AMBannerAnimationType bannerAnimationType;
    
    /*
        国家代码
     */
    NSString *_countryCode;
    
    /*
        城市代码
     */
    NSString *_cityCode;
    
    /*
        效果增强
     */
    AMBannerAnimationEnhanceType bannerAdimationEnhanceType;
}
@property(retain,nonatomic) NSString * app_key;
@property(retain,nonatomic) NSNumber * ad_type;
@property(retain,nonatomic) NSMutableDictionary *config_extra;
@property(retain,nonatomic) NSMutableArray *config_rations;
@property (nonatomic,readonly) AMBannerAnimationType bannerAnimationType;
@property (nonatomic,readonly) NSUInteger isCloseAd;
@property (nonatomic,readonly)  NSUInteger cycle_time;
@property (nonatomic,readonly)  NSUInteger inter_cycle_time;
@property(retain,nonatomic) NSString *countryCode;
@property(retain,nonatomic) NSString *cityCode;
@property(retain,nonatomic) NSString *curLocation;

@property (nonatomic,readonly)AMBannerAnimationEnhanceType bannerAdimationEnhanceType;
@property (nonatomic,assign) BOOL isInterstitialVideo;
/*
    获取用户配置信息
 */
- (id) getMoGoConfigData;

/*
    获取时间戳
 */
- (NSString *) getTimestamp;

/*
    更新用户配置缓存
 */
- (BOOL) refreshConfig;

/*
    用户配置是否存在
 */
- (BOOL) configDataIsExisted;

/*
    此方法有问题 不要使用
    2012-7-24
    建议在适配器中 使用 [self.ration objectForKey:@"type"]
    获取适配器编号
 */
- (int) getMoGonfigNetworkType;

- (UIColor *) getBackgroundColor;

- (UIColor *) getTextColor;

/*
    获取配置中点击优化配置
 */
- (BOOL) getClickOptimized;

/*
    
 */
- (NSString *) getPackage;

/*
 
 */
- (NSString *) getVersion;

- (BOOL) istestMode;

- (BOOL) islocationOn;

///*
//    获取AppID
// */
//- (NSString *) getAppID;
//
///*
//    获取AppSEC
// */
//- (NSString *) getAppSEC;

- (NSString *)getAdPlatforms;

// 是否支持芒果js
- (BOOL) isSupportmogojs;

- (void)setIsInVideo:(BOOL)isVideo;

@end
