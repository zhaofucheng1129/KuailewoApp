//
//  NSMutableDictionary+AdsMogoDic.h
//  TestMOGOSDKAPI
//
//  Created by Daxiong on 13-2-5.
//  Copyright (c) 2013年 Daxiong. All rights reserved.
//
#ifndef admogoConfigSuffix
#define admogoConfigSuffix @"mogoDx"
#endif
#import <Foundation/Foundation.h>


@interface NSMutableDictionary (AdsMogoDic)

-(id)objectForKey:(id)aKey;
-(id)objectForKey:(id)aKey andSuffix:(NSString *)suffix;
-(void)mogoRemoveObjectForKey:(id)aKey;
-(void)setObject:(id)object forKey:(id)aKey;

@end
