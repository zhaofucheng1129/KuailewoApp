//
//  AdMoGoAdSDKInterstitialNetworkRegistry.h
//  wanghaotest
//
//  Created by mogo on 13-11-28.
//
//

#import <Foundation/Foundation.h>
#import "AdMoGoAdAPISDKNetworkRegistry.h"



@interface AdMoGoAdSDKInterstitialNetworkRegistry : AdMoGoAdAPISDKNetworkRegistry{
//    NSMutableDictionary *adapterDict;
}

+ (AdMoGoAdSDKInterstitialNetworkRegistry *)sharedRegistry;

@end
