//
//  AdMoGoFullScreenAdapterCustomEvent.h
//  TestMOGOSDKAPI
//
//  Created by Daxiong on 14-3-17.
//  Copyright (c) 2014年 Daxiong. All rights reserved.
//
#import "AdMoGoAdNetworkInterstitialAdapter.h"
#import "AdMoGoAdNetworkAdapter.h"

#define APPID_FS_F @"APPID-1"
#define APPID_FS_S @"APPID-2"

@interface AdMoGoFullScreenAdapterCustomEvent : AdMoGoAdNetworkInterstitialAdapter{
    
    BOOL isStop;
    NSDictionary *key;
    BOOL isTestModel;
    
}

#pragma mark custom overwrite method
/*---------------------------------*/
//重新实现下列方法 (注:下列方法属于SDK回调方法,芒果SDK会在适当时机调用这些方法,需要在实现文件中重新实现)
//+(AdMoGoAdNetworkType)networkType;
//-(void)getAd;
//- (BOOL)isReadyPresentInterstitial;
//- (void)presentInterstitial;
/*---------------------------------*/
+ (AdMoGoAdNetworkType)networkType;
- (void)getAd;
- (BOOL)isReadyPresentInterstitial;
- (void)presentInterstitial;

#pragma mark custom use method
/*---------------------------------*/
//下列方法需要在对于的时机调用
/*---------------------------------*/
+(void)registerClass:(id)clazz;
-(AdViewType)customAdapterWillgetAdAndGetAdViewType;

//did start
- (void)adMoGoFSCustom:(AdMoGoFullScreenAdapterCustomEvent *)adapter didStartRequestAd:(id)ad;
//did receive
- (void)adMoGoFSCustom:(AdMoGoFullScreenAdapterCustomEvent *)adapter didReceiveInterstitialScreenAd:(id)ad;
//did fail
- (void)adMoGoFSCustom:(AdMoGoFullScreenAdapterCustomEvent *)adapter didFailAd:(NSError *)error;
// did close
- (void)adMoGoFSCustom:(AdMoGoFullScreenAdapterCustomEvent *)adapter didDismissScreen:(id)ad;
//will present
- (void)adMoGoFSCustom:(AdMoGoFullScreenAdapterCustomEvent *)adapter willPresent:(id)ad;
//did show
- (void)adMoGoFSCustom:(AdMoGoFullScreenAdapterCustomEvent *)adapter didAdShow:(id)ad;
//did click
- (void)adMoGoFSCustomCountClick;

@end
