//
//  AdChinaBannerView.h
//  AdChinaSDK
//
//  AdChina Publisher Code
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AdChinaBannerViewDelegateProtocol.h"


#define isPhone                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define BannerSizeDefault		(isPhone? CGSizeMake(320, 50) : CGSizeMake(640, 100))     // 8:1
#define BannerSizeSquare        (isPhone? CGSizeMake(320, 50) : CGSizeMake(360, 360))    // 1:1
#define BannerSizeVertical      (isPhone? CGSizeMake(320, 50) : CGSizeMake(336, 480))    // 7:10
#define BannerSizeVideo         (isPhone? CGSizeMake(320, 50) : CGSizeMake(480, 360))    // 4:3

typedef enum {
    AnimationMaskRandom				= -1,
	AnimationMaskNone				= 0,
    AnimationMaskRushAndBreak		= 1 << 0,
	AnimationMaskDropDown			= 1 << 1,
	AnimationMaskAlert				= 1 << 2,
	AnimationMaskChangeAlpha		= 1 << 3,
	AnimationMaskFlipFromRight		= 1 << 4,
	AnimationMaskFlipFromLeft		= 1 << 5
} AnimationMask;

enum {
	DisableRefresh                  = -1,
	MinimumRefreshInterval          = 20,
	DefaultRefreshInterval          = 30
};

@interface AdChinaBannerView : UIView 

// Returns newly created banner ad
+ (AdChinaBannerView *)requestAdWithAdSpaceId:(NSString *)theAdSpaceId delegate:(id<AdChinaBannerViewDelegate>)theDelegate adSize:(CGSize)size;

// Set banner frame to CGRectMake(origin.x, origin.y, size.width, size.height)
- (void)setOrigin:(CGPoint)origin;

// Set view controller for browser, default view controller is delegate
- (void)setViewControllerForBrowser:(UIViewController *)controller;

// Set allowed animation types, default animationMask is AnimationMaskRandom
- (void)setAnimationMask:(AnimationMask)animationMask;

// Set refresh interval, default interval is 30 seconds, minimum interval is 20 seconds
- (void)setRefreshInterval:(int)seconds;

// If your enable accelerometer, the [UIAccelerometer sharedAccelerometer].delegate may be changed by html5 ads.
// The default value is YES, which may cause conflict.
// You may use - accelerometer:detectedAcceleration: to avoid conflict
- (void)setAccelerometerEnabled:(BOOL)enable;
//Set debugMode is YES,log the description in console
- (void)setDebugMode:(BOOL)isDebugging;


@end
