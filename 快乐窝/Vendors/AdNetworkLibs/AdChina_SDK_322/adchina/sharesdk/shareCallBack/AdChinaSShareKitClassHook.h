//
 
//   
//
//  Created by AdChina on 13-12-20.
//  Copyright (c) 2013年 AdChina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
@class WXApiDelegate,QQApiInterfaceDelegate;

@interface AdChinaSShareKitClassHook : NSObject<WXApiDelegate,QQApiInterfaceDelegate>
@property( nonatomic,assign )BOOL haveMethod;
@end
