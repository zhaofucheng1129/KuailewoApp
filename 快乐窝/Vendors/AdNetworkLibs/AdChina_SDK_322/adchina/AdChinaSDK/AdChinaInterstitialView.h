//
//  AdChinaInterstitialView.h
//  AdChinaSDK_NARC
//
//  Created by AdChina on 13-8-23.
//  Copyright (c) 2013年 AdChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdChinaInterstitialViewDelegateProtocol.h"
@interface AdChinaInterstitialView : UIView

+ (AdChinaInterstitialView *)requestAdWithAdSpaceId:(NSString *)theAdSpaceId delegate:(id<AdChinaInterstitialViewDelegate>)theDelegate;

- (void)setViewControllerForBrowser:(UIViewController *)controller;

@end