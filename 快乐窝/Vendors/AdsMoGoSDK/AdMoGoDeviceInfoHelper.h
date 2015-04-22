//
//  DeviceInfoHelper.h
//  GetDeviceInfo
//
//  Created by MOGO on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <sys/sysctl.h>
#import <sys/socket.h> 
#import <net/if.h>
#import <net/if_dl.h>

#import "sys/utsname.h"
#import "AdMoGoCountryCodeHelper.h"
#import "AdMoGoReachability.h"
#import "AdMoGoView.h"

#import "AdMoGoCountryCodeHelperIOS5.h"
#define EPSILON 0.000001
#define FLOAT_EQ(x,v) (((v - EPSILON) < x) && (x < ( v + EPSILON)))
#define FLOAT_EQ_ZERO(x) (((0.0 - EPSILON) < x) && (x < ( 0.0 + EPSILON)))

@interface AdMoGoDeviceInfoHelper : NSObject{
    NSString *countryCode;
    AdMoGoCountryCodeHelper *countryCodeHelper;
    AdMoGoCountryCodeHelperIOS5 *countryCodeHelperIOS5;
}
//获取配置所用的Key
@property(nonatomic,assign)NSString * configKey;
//定位成功delegate
@property(nonatomic,assign)id<AdMoGoLocationDelegate> delegate;
/**
 *获得外网IP
 */
-(NSString *) getOutsideIp;
/**
 *  获得设备类型
 *  设备类型对照表
 *  "i386"          simulator
 *  "iPod1,1"       iPod Touch
 *  "iPod2,1"       iPod Touch2
 *  "iPod3,1"       iPod Touch3
 *  "iPod4,1"       iPod Touch4
 *  "iPhone1,1"     iPhone
 *  "iPhone1,2"     iPhone3G
 *  "iPhone2,1"     iPhone3GS
 *  "iPad1,1"       iPad WiFi
 *  "iPad2,1"       iPad2 WiFi
 *  "iPad2,2"       iPad2 GSM 3G
 *  "iPad2,3"       iPad2 CDMA
 *  "iPhone3,1"     iPhone4 GSM
 *  "iPhone3,3"     iPhone4 CDMA
 *  "iPhone4,1"     iPhone 4S
 */
-(NSString *)getDeviceDetailMode;
/**
 *获得设备类型
 */
-(NSString *)getDeviceMode;
/**
 *获得UUID
 */
-(NSString *)getDeviceUUID;
/**
 *获得Vendor
 *Available in iOS 6.0 and later.
 */
-(NSString *)getVendor;
/**
 *获得AdvertisingIdentifier
 */
-(NSString *)getAdvertisingIdentifier;
/**
 *获得MAC地址
 */
-(NSString *)getMacAddress;
/**
 *获得ODIN1
 *refence http://code.google.com/p/odinmobile/wiki/ODIN1
 */
-(NSString *)getODIN1;
/**
 *获得国家代码
 *locationOn:是否开启定位
 */
-(NSString *)currentLocaleCountryCode:(BOOL)locationOn;
/**
 *获得本机现在用的语言
 * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
- (NSString*)getPreferredLanguage;
/**
 *获得当前系统版本
 */
-(NSString *)getCurrentVersion;

/**
 *获得CarrierCode
 */
-(NSString *)getSIMCarrierCode;
/**
 *是否未高分辨率
 */
-(BOOL)isHighResolution;
/**
 *获得屏幕尺寸
 */
-(NSString *)getScreenSize;
/**
 *获得用户包版本号
 */
-(NSString *)getUserVersion;
/**
 *获得包名
 */
-(NSString *)getBundleName;
/**
 *是否是第一次安装
 */
- (BOOL)isFirstInstall;
/**
 *获取新增受众类型
 */
- (int)getNewAudienceTypeByAppKey:(NSString *)appKey;
/**
 *获得网络状态
 */
-(AdMoGoNetworkStatus)getNetworkStatus;
/*
    将adViewType转换为请求类型
    返回请求类型
    
    注意请求前要将adViewType 转换为int
 */
-(NSString *) transformadViewTypeToRequestType:(int) adViewType;
/**
 *绘制圆角图片
 */
-(id) createRoundedRectImage:(UIImage*)image size:(CGSize)size;
/**
 *停止定位服务
 */
-(void) stopLocation;

/*
    返回屏幕像素
    宽*高
 */
-(NSString *)getScreenPt;

/*
    v1.3.4 添加openudid
 */
-(NSString *)getDeviceOpenUDID;

 /*
    v1.3.5 添加AdMoGoSecureUDID
    使用SecureUDID 生成一个替代udid的标识
  */
- (NSString *)getSecureUDID:(NSString *)key;

- (NSString *)getMoGoSDKVersion;


@end
