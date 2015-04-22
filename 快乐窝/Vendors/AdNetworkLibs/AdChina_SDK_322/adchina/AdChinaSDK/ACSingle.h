/************************************************
 *fileName:     ACSingle.h
 *description:  单例，处理公共参数
 *function detail:单例，处理公共参数
 *delegate:
 *Created:Joson Ma on 2013-1-23
 *Copyright 2011-2013 AdChina. All rights reserved.
 ************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    ACChinaSDKDebugModeNone = 0,
    ACChinaSDKDebugModeError = 1,
    ACChinaSDKDebugModeDebug = 2,
    ACChinaSDKDebugModeDetail = 3
} ACChinaSDKDebugMode;
@interface ACSingle : NSObject {
    
}
@property  ACChinaSDKDebugMode debugMode;              //判断全局log是否显示
//0 代表 sdk
//1 代表 芒果聚合
//2 代表 Adview聚合
//3 代表 果合聚合
//4 代表 抓猫聚合
//5 代表 艾德聚合
//6 代表 其他聚合

@property  int                 nAppSDKSource;           //来源
@property  BOOL                bChangeOritation;        //是否更改转屏响应
@property  BOOL                bHiddenStatusBar;        //是否更改隐藏了statusBar
@property  BOOL                bStatusBarHidden;        //媒体app是否显示statusBar
@property  Boolean             bExpandLandingpageToolbar;//是否默认展开landingPage的toolbar
@property  (nonatomic, copy) NSString *strTestServerECType;            //加密方式
@property  (nonatomic, copy) NSString *strBaseUrl;      //adServer网址
@property  (nonatomic, copy) NSString *strImpURL;
@property  (nonatomic, copy) NSString *strMraidURL;
@property  (nonatomic, copy) NSString *strMraidVersion;
@property  (nonatomic, copy) NSString *strAdURL;
@property (nonatomic, strong) NSMutableDictionary *dictAdSpace;

@property  BOOL                bTest;        //是否测试状态
@property  (nonatomic, strong) NSDictionary *dictTest;//测试文档

//singleTon类
+ (ACSingle *)sharedSingle;

+(void)runSingleMethod;

+ (void)logEvent:(NSString*)event ofType:(ACChinaSDKDebugMode)type func:(const char*)func line:(int)line;
+(NSString *)getInitUrl;
+(NSString *)getImpUrl;
+(NSString *)getRequestUrl;
+(NSString *)getLocationUrl;
+(NSString *)getRefreshTimeUrl;
+(NSString *)getMraidURL;
+(NSString *)getTestUrl;
+(Boolean)loadTestFile;
+(NSString *)getInitSnsUrl;
+(NSString*)getSnsTrack;
+(Boolean)reJS:(NSString *)strTemp inWeb:(UIWebView *)webView;
//+(NSString *)getTestServerInterfaceRequestUrl;
@end
