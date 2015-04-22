//
//  AdMoGoCountryCodeHelperIOS5.h
//  wanghaotest
//
//  Created by MOGO on 13-8-31.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoConfigData.h"
#import "AdMoGoLocationDelegate.h"

@interface AdMoGoCountryCodeHelperIOS5 : NSObject<CLLocationManagerDelegate>
{
    //国家代码
    NSString *countryCode;
    //位置管理用于定位
    //    CLLocationManager *locationManager;
    //地理编码
    CLGeocoder *geoCoder;
    //坐标模型
    CLLocation *curLocation;
    /*
     回调判断是否执行
     */
    BOOL isstopLocation;
}
//获取配置所用的Key
@property(nonatomic,assign)NSString * configKey;
@property(nonatomic,assign)id<AdMoGoLocationDelegate> delegate;
@property(assign)CLLocationManager *locationManager;

-(NSString *)currentLocaleCountryCode:(BOOL)locationOn;
- (void)stopLocation;
@end
