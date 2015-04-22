//
//  AdMoGoView.h
//  mogosdk
//
//  Created by MOGO on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"
#import "AdViewType.h"
#import "AdMoGoViewAnimationDelegate.h"


typedef NS_OPTIONS(NSUInteger, AdMoGoViewPointType) {
    AdMoGoViewPointTypeTop_left       = 1 << 0,
    AdMoGoViewPointTypeTop_middle     = 1 << 1,
    AdMoGoViewPointTypeTop_right      = 1 << 2,
    
    AdMoGoViewPointTypeMiddle_left    = 1 << 3,
    AdMoGoViewPointTypeMiddle_middle  = 1 << 4,
    AdMoGoViewPointTypeMiddle_right   = 1 << 5,
    
    AdMoGoViewPointTypeDown_left      = 1 << 6,
    AdMoGoViewPointTypeDown_middle    = 1 << 7,
    AdMoGoViewPointTypeDown_right     = 1 << 8,
    AdMoGoViewPointTypeCustom         = 1 << 9,
};

@interface AdMoGoView : UIView{
    
    BOOL isStop;
    
}
@property (nonatomic, assign) BOOL  autoScale;
@property(nonatomic,assign) id<AdMoGoDelegate> delegate;



@property(nonatomic,assign) id<AdMoGoWebBrowserControllerUserDelegate> adWebBrowswerDelegate;

@property(nonatomic,assign) id<AdMoGoViewAnimationDelegate> adAnimationDelegate;

/*
    ak:开发appkey
    type:请求广告类型
    delegate:代理对象
    自动轮换
 */
- (id) initWithAppKey:(NSString *)ak
               adType:(AdViewType)type
   adMoGoViewDelegate:(id<AdMoGoDelegate>) delegate
    ;

- (id) initWithAppKey:(NSString *)ak
               adType:(AdViewType)type
   adMoGoViewDelegate:(id<AdMoGoDelegate>) delegate
            autoScale:(BOOL)isAutoScale
;

/*
 ak:开发appkey
 type:请求广告类型
 delegate:代理对象
 AdPointType:广告位置
 自动轮换
 */
-(id)initWithAppKey:(NSString *)ak adType:(AdViewType)type adMoGoViewDelegate:(id<AdMoGoDelegate>)delegate adViewPointType:(AdMoGoViewPointType) AdPointType;



/*
 ak:开发appkey
 type:请求广告类型
 delegate:代理对象
 isManualRefresh:是否手动轮换 YES手动轮换 NO自动轮换
 */
- (id) initWithAppKey:(NSString *)ak
               adType:(AdViewType)type
   adMoGoViewDelegate:(id<AdMoGoDelegate>) delegate
      isManualRefresh:(BOOL)isManualRefresh;

/*
 ak:开发appkey
 type:请求广告类型
 delegate:代理对象
 AdPointType:广告位置
 isManualRefresh:是否手动轮换 YES手动轮换 NO自动轮换
 */
-(id)initWithAppKey:(NSString *)ak
             adType:(AdViewType)type adMoGoViewDelegate:(id<AdMoGoDelegate>)delegate adViewPointType:(AdMoGoViewPointType) AdPointType isManualRefresh:(BOOL)isManualRefresh;

/*
    返回位置类型
 */
-(AdMoGoViewPointType)getViewPointType;

/*
    设置位置类型
 */
-(void)setViewPointType:(AdMoGoViewPointType)viewPointType;

/*
    手动刷新接口 在芒果后台配置刷新时间为不刷新
    调用这个接口手动刷新横幅广告;
    如果设置的轮换时间不是不刷新,调用此接口无效.
 */
-(void)refreshAd;

/*
    返回是否是手动刷新
    YES:手动刷新
    NO:非手动刷新
 */
-(BOOL)isManualRefresh;

@end


