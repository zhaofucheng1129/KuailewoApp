//
//  AdMoGoAdSDKVideoNetworkRegistry.h
//  wanghaotest
//
//  Created by mogo on 13-11-28.
//
//

#import <Foundation/Foundation.h>
#import "AdMoGoAdAPISDKNetworkRegistry.h"

@class AdMoGoAdNetworkAdapter;
@class AdMoGoClassWrapper;

@interface AdMoGoAdSDKVideoNetworkRegistry : AdMoGoAdAPISDKNetworkRegistry{
}

+ (AdMoGoAdSDKVideoNetworkRegistry *)sharedRegistry;
@end
