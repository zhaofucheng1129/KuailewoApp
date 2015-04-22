//
//  GDTSDKConfig.h
//  GDTMobApp
//
//  Created by GaoChao on 14/8/25.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDTSDKConfig : NSObject
/**
 * 提供给聚合平台用来设定SDK 流量分类
 */
+ (void) setSdkSrc:(NSString *)sdkSrc;

/**
 * 查看SDK流量来源
 */
+ (NSString *) sdkSrc;

@end
