//
//  AdMoGoCore.h
//  mogosdk
//
//  Created by MOGO on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "AdMoGoAdNetworkAdapter.h"
#import "AdMoGoView.h"

#import "AdMoGoCoreTimerFireDelegate.h"
#import "AdMoGoViewAnimationDelegate.h"


typedef  enum{
    AdShowSuccess = 0, // 展示成功
    AdShowError, // 展示失败
    AdShowNull   // 展示轮空
}AdShowStatus;
@class AdMoGoAdNetworkAdapter;

@interface AdMoGoCore : NSObject<AdMoGoViewAnimationDelegate>
{
    /*
     用户配置信息key
     */
    NSString  *config_key;
    
    id<AdMoGoWebBrowserControllerUserDelegate> adWebBrowswerDelegate;
}
@property(nonatomic,assign) AdMoGoView *mainView;
@property(nonatomic,retain) AdMoGoAdNetworkAdapter *adapter;
@property(nonatomic,retain) NSTimer *timer;
@property(nonatomic,copy) NSString *config_key;
@property(nonatomic,assign) id<AdMoGoCoreTimerFireDelegate> timerFireDelegate;
@property(nonatomic,assign) BOOL isStop;

@property(nonatomic,assign) id<AdMoGoWebBrowserControllerUserDelegate> adWebBrowswerDelegate;



/*
 轮换广告启动
 */
- (void) core;
- (void) core:(NSNumber *)number;
/*
    无法获取广告
    调用此方法
 */
- (void) showError;

/*
    成功获取广告
    调用此方法
 */
- (void) showSuccess;

/*
 添加广告视图
 */
- (void) pushView:(UIView *) subview;

/*
    停止定时器线程
 */
- (void) stopTimer;

/*
    重新启动定时器线程
 */
- (void) fireTimer;

/*
    立即触发定时器
 */
- (void) immediatelyFireTimer;

- (void) stopCurrentThread;

/*
    是否触发点击优化
 */
- (void) disableImmediatelyFireTimer:(Boolean)enable;
#pragma mark Adapter callbacks old code



- (void)adRequestReturnsForAdapter:(AdMoGoAdNetworkAdapter *)adapter;

- (void)adapter:(AdMoGoAdNetworkAdapter *)adapter didGetAd:(NSString *)adType;

/*随宗SDK单独使用*/
- (void)adapter:(AdMoGoAdNetworkAdapter *)_adapter didReceiveAdView:(UIView *)view withTime:(NSInteger)refreshTime;

- (void)adapter:(AdMoGoAdNetworkAdapter *)adapter didReceiveAdView:(UIView *)view;

- (void)adapter:(AdMoGoAdNetworkAdapter *)_adapter didReceiveAdView:(UIView *)view waitUntilDone:(BOOL)isWait;

- (void)adapter:(AdMoGoAdNetworkAdapter *)adapter didFailAd:(NSError *)error ;

- (void)adapterDidFinishAdRequest:(AdMoGoAdNetworkAdapter *)adapter;

/*
    单击芒果广告是否弹出alertview  
    默认弹出
 */
-(BOOL)shouldAlertQAView:(UIAlertView *)alertView;
/*
    发送点击计数
 */
- (void)sendRecordNum;
- (void)premiumADClickDict:(NSMutableDictionary *)receiveValue;
- (void)premiumADAdvanceClickDict:(NSMutableDictionary *)receiveValue;
/*
    亿动智道专用点击
 */
- (void)premiumADClick_SmartAd;
/*
    特殊发送
 */
- (void)specialSendRecordNum;


- (void)adDidStartRequestAd;

/**
 *获取适配器集合
 */
-(NSMutableArray *)getUsedAdaptersArray;

//- (void)adMoGoDidReceiveAd;

/*
    添加百度广告
 */
- (void)baiduAddAdViewAdapter:(AdMoGoAdNetworkAdapter *)adapter didReceiveAdView:(UIView *)view;

/*
    添加百度广告
 */
- (void)baiduSendRIB;

///*
//    百度SDK发送点击
// */
//- (void)baiduSendCLK:(AdMoGoAdNetworkAdapter *)baiduAdapter;
//
///*
//    mobisage适配器发送点击统计
// */
//- (void)mobisageSendCLK:(AdMoGoAdNetworkAdapter *)mobisageAdapter;
//
//
///*
//    多盟适配器发送点击统计
// */
//- (void)domobSendCLK:(AdMoGoAdNetworkAdapter *)domobAdapter;
//
///*
//    广点通适配器发送点击统计
// */
//- (void)gdtSendCLK:(AdMoGoAdNetworkAdapter *)gdtAdapter;
//
///*
// 广点通适配器发送点击统计
// */
//- (void)gdtSendCLK:(AdMoGoAdNetworkAdapter *)gdtAdapter;
//
///*
// tanx移动适配器发送点击统计
// */
//- (void)tanxSendCLK:(AdMoGoAdNetworkAdapter *)gdtAdapter;

/*
    第三方SDK点击回调
    SDK中提供点击回调可以调用这个方法 向芒果聚合发送点击统计
 */
- (void)sdkplatformSendCLK:(AdMoGoAdNetworkAdapter *)sdkAdapter;

/*
    至美适配器发送点击统计
 
- (void)zmediaSendCLK:(AdMoGoAdNetworkAdapter *)domobAdapter;
*/
/*
    特殊适配器请求回调
 */
//- (void)specialAdapter:(AdMoGoAdNetworkAdapter *)adapter didGetAd:(NSString *)adType;
/*
    特殊适配器请求成功回调
 */
//- (void)specialAdapter:(AdMoGoAdNetworkAdapter *)adapter didReceiveAdView:(UIView *)view ;
/*
    特殊适配器请求失败回调
 */
//- (void)specialAdapter:(AdMoGoAdNetworkAdapter *)adapter didFailAd:(NSError *)error ;


-(void) stopAuto_AderAdapter;
/**
 *自定义尺寸广告轮换标记
 */
- (BOOL)isCustomSizeRotate;
/**
 *自定义广告尺寸
 */
- (CGSize)adMoGoCustomSize;
/**
 *自定义尺寸广告关闭
 */
- (void)customSizeAdClose:(id)sender;

/*
    广告暂停轮换
 */
- (void) pauseAd;
/*
    广告继续轮换
 */
- (void) continueAd;
/**
 *显示被隐藏的关闭按钮
 */
- (void)showCloseButton:(UIView *)btn;
/**
 *隐藏关闭按钮
 */
- (UIView *)hideCloseButton;

- (void)requestnextAd;

/*
    是否已经启动轮换广告
 */
- (BOOL)isbeginrequestAd;

// 芒果驱动专用
- (void)adapter:(AdMoGoAdNetworkAdapter *)_adapter didReceiveAdViewMogoJS:(UIView *)view;

@end
