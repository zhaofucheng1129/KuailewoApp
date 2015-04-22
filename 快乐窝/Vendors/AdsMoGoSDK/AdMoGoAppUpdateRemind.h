//
//  AdMoGoAppUpdateRemind.h
//  ADMoGoSDK
//
//  Created by MoGo on 14-1-21.
//  Copyright (c) 2012年 MoGo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdMoGoAppUpdateRemindDelegate.h"

@interface AdMoGoAppUpdateRemind : NSObject{

}

/*
 appkey:开发者的芒果ID
 */
- (id) initWithAppKey:(NSString *)appkey withDelegate:(id<AdMoGoAppUpdateRemindDelegate>) delegate;

/*
 appkey:开发者的芒果ID
 */
- (id) initImmeWithAppKey:(NSString *)appkey withDelegate:(id<AdMoGoAppUpdateRemindDelegate>) delegate;

/*
    appkey:开发者的芒果ID
    delegate:AdMoGoAppUpdateRemindDelegate 代理实例
    version:app版本号
 
    默认获取的版本号是CFBundleVersion
    如果开发者要是获取CFBundleShortVersionString可以使用如下代码；
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    AdMoGoAppUpdateRemind updateremind = [[AdMoGoAppUpdateRemind alloc] initWithAppKey:yourappkey withDelegate:yourdelegate
 withAppVersion:version];
 */

- (id) initWithAppKey:(NSString *)appkey withDelegate:(id<AdMoGoAppUpdateRemindDelegate>) delegate withAppVersion:(NSString *)version;



/*
    appkey:开发者的芒果ID
    delegate:AdMoGoAppUpdateRemindDelegate 代理实例
    version:app版本号
 
    默认获取的版本号是CFBundleVersion
    如果开发者要是获取CFBundleShortVersionString可以使用如下代码；
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    AdMoGoAppUpdateRemind updateremind = [[AdMoGoAppUpdateRemind alloc] initImmeWithAppKey:yourappkey withDelegate:yourdelegate
    withAppVersion:version];
 */
- (id) initImmeWithAppKey:(NSString *)appkey withDelegate:(id<AdMoGoAppUpdateRemindDelegate>) delegate withAppVersion:(NSString *)version;

@end
