//
//  File: AdMoGoAdNetworkRegistry.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.7
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

/*
    反射工具类 old code
 */
#import <Foundation/Foundation.h>

@class AdMoGoAdNetworkAdapter;
@class AdMoGoClassWrapper;

@interface AdMoGoAdNetworkRegistry : NSObject {
	NSMutableDictionary *adapterDict;
}

+ (AdMoGoAdNetworkRegistry *)sharedRegistry;
- (void)registerClass:(Class)adapterClass;
- (NSArray *)adapterClassFor:(NSInteger)adNetworkType;

@end