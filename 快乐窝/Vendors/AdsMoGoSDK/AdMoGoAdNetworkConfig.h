//
//  File: AdMoGoAdNetworkConfig.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.7
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//


/*
    仅在反射生成对象时使用此类
 */
#import <Foundation/Foundation.h>
//#import "AdMoGoDelegateProtocol.h"

@class AdMoGoError;
@class AdMoGoAdNetworkRegistry;
@class AdMoGoAdAPISDKNetworkRegistry;
@interface AdMoGoAdNetworkConfig : NSObject {
	NSInteger networkType;
	NSString *nid;
	NSString *networkName;
	double trafficPercentage;
	NSInteger priority;
	NSDictionary *credentials;
	Class adapterClass;
    BOOL testMode;
}

- (id)initWithDictionary:(NSDictionary *)adNetConfigDict
       adNetworkRegistry:(AdMoGoAdNetworkRegistry *)registry
                   error:(AdMoGoError **)error
                    info:(NSDictionary *)adapterInfo;

- (id)initWithDictionary:(NSDictionary *)adNetConfigDict
       adAPISDKNetworkRegistry:(AdMoGoAdAPISDKNetworkRegistry *)registry
                   error:(AdMoGoError **)error
                    info:(NSDictionary *)adapterInfo;

@property (nonatomic,readonly) NSInteger networkType;
@property (nonatomic,readonly) NSString *nid;
@property (nonatomic,readonly) NSString *networkName;
@property (nonatomic,readonly) double trafficPercentage;
@property (nonatomic,readonly) NSInteger priority;
@property (nonatomic,readonly) NSDictionary *credentials;
@property (nonatomic,readonly) NSString *pubId;
@property (nonatomic,readonly) Class adapterClass;
@property (nonatomic,readonly) BOOL testMode;

@end