//
//  AdMoGoAdapterCustom.h
//  AdsMogo
//
//  Created by Daxiong on 12-11-22.
//
//

#import "AdMoGoAdNetworkAdapter.h"

#define APPID_F @"APPID-1"
#define APPID_S @"APPID-2"

@interface AdMoGoAdapterCustomEvent : AdMoGoAdNetworkAdapter{
    BOOL isStop;
    NSDictionary *key;
    BOOL isTestModel;
}



#pragma mark custom overwrite method
/*---------------------------------*/
//重新实现下列方法
//+(AdMoGoAdNetworkType)networkType;
//-(void)getAd;
/*---------------------------------*/
//+(NSDictionary *)networkType;
+ (AdMoGoAdNetworkType)networkType;
-(void)getAd;
#pragma mark custom use method
+(void)registerClass:(id)clazz;
-(AdViewType)customAdapterWillgetAdAndGetAdViewType;

-(void)adMoGoCustom:(AdMoGoAdNetworkAdapter *)adapter didReceiveAdView:(UIView *)adView;
-(void)adMoGoCustom:(AdMoGoAdNetworkAdapter *)adapter didReceiveAdView:(UIView *)adView waitUntilDone:(BOOL)isWait;
-(void)adMoGoCustom:(AdMoGoAdNetworkAdapter *)adapter didFailAd:(NSError *)error;
@end


