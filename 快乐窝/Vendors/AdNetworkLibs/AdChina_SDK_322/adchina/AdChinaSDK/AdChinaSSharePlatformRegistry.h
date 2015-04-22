//
//  AdChinaSSharePlatformRegistry.h
//  AdChinaSShareKit
//
//  Created by Daxiong on 13-11-18.
//  Copyright (c) 2013年 Daxiong. All rights reserved.
//
#import "AdChinaSShareAdapter.h"
#import <Foundation/Foundation.h>

@interface AdChinaSSharePlatformRegistry : NSObject
+ (AdChinaSSharePlatformRegistry *)sharedRegistry;
// register class
// all adapter should call it
- (void)registerClass:(Class)adapterClass;
// get sns adapter by type
- (AdChinaSShareAdapter *)getInstanceAdapterByType:(NSNumber *)type;
//get sns adapter
-(NSDictionary*)getAllSnsAdapter;
@end
