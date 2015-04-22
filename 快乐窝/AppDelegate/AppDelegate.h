//
//  AppDelegate.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/3.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdMoGoSplashAds.h"
#import "AdMoGoSplashAdsDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,AdMoGoSplashAdsDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

