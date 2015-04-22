//
//  AdChinaLocationManager.h
//  AdChinaSDK
//
//  AdChina Publisher Code
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface AdChinaLocationManager : NSObject

// Enable/Disable location service here, default value is YES.
// If you want to return latitude/longitude in AdChinaUserInfoDelegate, please disable location service here.
+ (void)setLocationServiceEnabled:(BOOL)enable;
+ (BOOL)getLocationServiceEnabled;
@end
