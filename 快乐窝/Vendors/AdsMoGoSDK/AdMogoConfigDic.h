//
//  AdMogoConfigDic.h
//  AdsMogo
//
//  Created by MOGO on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#define admogoConfigSuffix @"mogoDx"
#import <Foundation/Foundation.h>

//#import <Cocoa/Cocoa.h>

@interface AdMogoConfigDic:NSObject{
    NSMutableDictionary *config_dic;
}

//-(id)init;
//-(id)objectForKey:(id)aKey;
//-(id)objectForKey:(id)aKey andSuffix:(NSString *)suffix;
//-(void)setObject:(id)object forKey:(id)aKey;


/*
    删除内存configdata
 */
//- (void)deleteDataByKey:(id)aKey;

//[configDataCenter.config_dict setObject:configData forKey:configKey];
@end
