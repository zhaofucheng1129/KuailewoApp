//
//  AdMoGoAdapterInmobiSDK.h
//  TestMOGOSDKAPP
//
//  Created by Daxiong on 13-9-12.
//  Copyright (c) 2012年 AdsMogo. All rights reserved.
//
#import "InMobi.h"
#import "IMBanner.h"
#import "IMBannerDelegate.h"
#import "AdMoGoAdNetworkAdapter.h"

@interface AdMoGoAdapterInmobiSDK : AdMoGoAdNetworkAdapter<IMBannerDelegate>{
    
    BOOL isStop;
    NSTimer *timer;
    
}
@end
