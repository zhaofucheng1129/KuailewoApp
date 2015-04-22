//
//  File: AdMoGoAdapterAdChina.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.2.1
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//
//AdChina v2.5.2

#import "AdMoGoAdNetworkAdapter.h"
#import "AdChinaBannerView.h"

@interface AdMoGoAdapterAdChina : AdMoGoAdNetworkAdapter <AdChinaBannerViewDelegate,AdChinaUserInfoDelegate>{
    
    BOOL isStop;
    NSTimer *timer;
    
}
+ (AdMoGoAdNetworkType)networkType;
//+ (NSDictionary *)networkType;
@end
