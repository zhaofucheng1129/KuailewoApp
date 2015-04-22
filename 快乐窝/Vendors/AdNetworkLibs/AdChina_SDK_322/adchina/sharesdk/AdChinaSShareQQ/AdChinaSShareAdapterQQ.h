//
//  AdChinaSShareAdapterQQ.h
//  AdChinaSShareKit
//
//  Created by mogo_wenyand on 13-12-6.
//  Copyright (c) 2013年 Daxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "AdChinaSShareNetworkAdapter.h"

@interface AdChinaSShareAdapterQQ : AdChinaSShareNetworkAdapter{
    TencentOAuth *tencentOAuth;
}

@end
