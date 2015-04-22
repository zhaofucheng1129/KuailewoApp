//
//  AdMoGoFullScreen.h
//  AdsMogo
//
//  Created by MOGO on 13-2-19.
//
//

#import <Foundation/Foundation.h>
#import "AdMoGoWebBrowserControllerUserDelegate.h"
#import "AdViewType.h"
#import "AdMoGoAdNetworkAdapter.h"
#import "AdMoGoInterstitialDelegate.h"

@class AdMoGoAdNetworkAdapter;



@interface AdMoGoInterstitial : NSObject{
    
}

@property(nonatomic,assign) id<AdMoGoInterstitialDelegate> delegate;
@property(nonatomic,assign) id<AdMoGoWebBrowserControllerUserDelegate> adWebBrowswerDelegate;

/**
 *进入展示时机
 *isWait:如果没有广告展示是否等待
 */
- (void)interstitialShow:(BOOL)isWait;
//- (void)showInterstitialWhenComplate;

/**
 *离开展示时机
 */
- (void)interstitialCancel;

/*
    暂支持安沃插屏旋转
 */
- (void)interstitialorientationChanged:(UIInterfaceOrientation)orientation;

- (BOOL)isFullScreen;

/*
    手动刷新
 */
- (void)refreshAd;

@end
