//
//  AdChinaShareSDK.h
//  AdChinaSShareKitTest
//
//  Created by Chasel on 14-1-20.
//  Copyright (c) 2014年 Chasel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AdShareContext.h"
@protocol AdChinaShareSDKDelegate<NSObject>
@required
//开始分享
-(void)shareStart:(NSNumber*)shareType;
//开始授权
-(void)oAuthStart:(NSNumber*)shareType;
//授权结束
-(void)oAuthFinish:(NSNumber*)isSucceed  shareType:(NSNumber*)shareType;
//分享结束
-(void)shareFinish:(NSNumber*)isSucceed  shareType:(NSNumber*)shareType;
//ViewController
- (UIViewController *)AdChinaSShareKitViewControllerForPresent;

@optional

-(AdShareContext*)AdChinaShareContext;

@end

@interface AdChinaShareSDK : UIView

+(void)registerAdChinaApp:(NSString *)appKey;
/**
 *  一键分享按钮
 *
 *  @param point 按钮位置
 *
 *  @return 分享按钮
 */
-(void)createShareBtn:(CGPoint)point appKey:(NSString*)appkey delegate:(id<AdChinaShareSDKDelegate>)delegate inView:(UIView*)view  shareContext:(AdShareContext*)shareContext;
/**
 自定义接口
 */
-(void)createShareViewByAppKey:(NSString*)appkey delegate:(id<AdChinaShareSDKDelegate>)delegate shareContext:(AdShareContext*)shareContext;

-(void)showInView:(UIView*)view;
//创建自定义按钮
-(void)createShareIcon:(NSString*)title  iconImageName:(NSString*)str  shareType:(int) sharetype  iconClick: (SEL)iconClick;


@end





