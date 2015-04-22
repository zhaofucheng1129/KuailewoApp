//
//  AdMoGoDelegate.h
//  mogosdk
//
//  Created by MOGO on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@class AdMoGoView;


@protocol AdMoGoDelegate <NSObject>

@required
/*
    返回广告rootViewController old code
 */
- (UIViewController *)viewControllerForPresentingModalView;



@optional

#pragma mark notifications old code

/**
 * 广告开始请求回调
 */
- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView;
/**
 * You can get notified when the user receive the ad
 广告接收成功回调
 */
- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView;
/**
 * You can get notified when the user failed receive the ad
 广告接收失败回调
 */
- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error;
/**
 * 点击广告回调
 */
- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView;
/**
 *You can get notified when the user delete the ad 
 广告关闭回调
 */
- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView;
/**
 *You can get notified when the user delete the ad
 返回 YES 表示由开发者处理关闭广告事件
 返回 NO 表示由sdk处理关闭广告事件
 */
- (BOOL)adMoGoDealCloseAd:(AdMoGoView *)adMoGoView;


/**
 *Ad Init Finish
 *You can use this delegate method request a ad in manualrefresh status
 *广告初始化完成
 */
- (void)adMoGoInitFinish:(AdMoGoView *)adMoGoView;

/**
 
 * These notifications will let you know when a user is being shown a full screen
 * webview canvas with an ad because they tapped on an ad.  You should listen to
 * these notifications to determine when to pause/resume your game--if you're
 * building a game app.
 */
- (void)adMoGoWillPresentFullScreenModal;
- (void)adMoGoDidDismissFullScreenModal;

/*Full Screen Notifications*/
- (void)adMoGoFullScreenAdReceivedRequest;
- (void)adMoGoFullScreenAdFailedWithError:(NSError *) error;
- (void)adMoGoWillPresentFullScreenAdModal;
- (void)adMoGoDidDismissFullScreenAdModal;
//Whether popup alertView
-(BOOL)shouldAlertQAView:(UIAlertView *)alertView;
//custom size rotate or not
//YES --> will rotate (default)
//NO --> rotate stop
- (BOOL)adMoGoCustomSizeAdRotateOrNot;
//custom size to request
- (CGSize)adMoGoCustomSize;

-(void)adMogoFullScreenAdClosed;


#pragma mark MoGoWebBrowser Delegate



#pragma mark behavior configurations
/**
 * Request test ads for APIs that supports it. Make sure you turn it to OFF
 * or remove the function before you submit your app to the app store.
 */
- (BOOL)adMoGoTestMode DEPRECATED_ATTRIBUTE;

#pragma mark demographic information optional delegate methods
- (NSString *)phoneNumber; // user's phone number
- (CLLocation *)locationInfo; // user's current location
- (NSString *)postalCode; // user's postal code, e.g. "94401"
- (NSString *)areaCode; // user's area code, e.g. "415"
- (NSDate *)dateOfBirth; // user's date of birth
- (NSString *)gender; // user's gender (e.g. @"m" or @"f")
- (NSString *)keywords; // keywords the user has provided or that are contextually relevant, e.g. @"twitter client iPhone"
- (NSString *)searchString; // a search string the user has provided, e.g. @"Jasmine Tea House San Francisco"
- (NSUInteger)incomeLevel; // return actual annual income


@end
