//
//  CountryCodeHelper.h
//  GetDeviceInfo
//
//  Created by MOGO on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <MapKit/MKPlacemark.h>
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoConfigData.h"
#import "AdMoGoLocationDelegate.h"

@interface AdMoGoCountryCodeHelper : NSObject<CLLocationManagerDelegate,MKReverseGeocoderDelegate>{
    //国家代码
    NSString *countryCode;
    //位置管理用于定位
//    CLLocationManager *locationManager;
    //地理编码
    MKReverseGeocoder *geoCoder;
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
