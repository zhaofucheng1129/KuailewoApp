//
//  AdMoGoAdAPISDKNetworkRegistry.h
//  wanghaotest
//
//  Created by mogo on 13-11-28.
//
//

#import <Foundation/Foundation.h>
#import "AdMoGoClassWrapper.h"


@class AdMoGoAdNetworkAdapter;

@interface AdMoGoAdAPISDKNetworkRegistry : NSObject{
    NSMutableDictionary *adapterDict;
}
- (NSMutableDictionary *)getAdapterDict;
- (void)setAdapterDict:(NSMutableDictionary *)adapterDict;
- (void)registerClass:(Class)adapterClass;

- (AdMoGoClassWrapper *)adapterClassFor:(NSInteger)adNetworkType;
@end
