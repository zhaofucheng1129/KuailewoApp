//
//  AdChinaSShareNetworkAdapter.h
//  AdChinaSShareKit
//
//  Created by Daxiong on 13-11-18.
//  Copyright (c) 2013年 Daxiong. All rights reserved.
//

#import "AdChinaSShareAdapter.h"


@interface AdChinaSShareNetworkAdapter : AdChinaSShareAdapter
/**
 * start request and return connection
 */
- (NSURLConnection *) urlConnectionWithType:(NSString *)type andUrl:(NSURL *)url andParam:(NSDictionary *)paramDict;
@end
