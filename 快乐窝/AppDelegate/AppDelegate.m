//
//  AppDelegate.m
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/3.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "AppDelegate.h"
#import "AdMoGoLogCenter.h"
#import "AdMoGoLogCenter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
-(void)dealloc
{
    [_window release];
    [super dealloc];
}

- (void)umengTrack {
    
    [MobClick setCrashReportEnabled:YES]; // 如果不需要捕捉异常，注释掉此行
    
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
//    reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
//    channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道

//    [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
//    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
    // 社会化分享
    [UMSocialData setAppKey:UMENG_APPKEY];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //  友盟的方法本身是异步执行，所以不需要再异步调用    
    #ifdef DEBUG_FLAG
//        [self umengTrack];
//        [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
//        //广告日志
//        [[AdMoGoLogCenter shareInstance] setLogLeveFlag:AdMoGoLogTemp];
//        [[AdMoGoLogCenter shareInstance] setLogLeveFlag:AdMoGoLogDebug];
    #else
        [self umengTrack];
    
        //开屏广告
        AdMoGoSplashAds *splashAds = [[AdMoGoSplashAds alloc]
                                      initWithAppKey:MOGO_APPKEY
                                      adMoGoSplashAdsDelegate:self
                                      window:self.window];
        [splashAds requestSplashAd];
    #endif
    

    
//    NSManagedObjectContext *context = [self managedObjectContext];
//    Test *test = [NSEntityDescription
//                                      insertNewObjectForEntityForName:@"Test"
//                                      inManagedObjectContext:context];
//    test.name = @"Test Bank";
//    test.age = @11;
//    test.sex = @"man";
//    NSError *error;
//    if (![context save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }
//    
//    // Test listing all FailedBankInfos from the store
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test"
//                                              inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    for (Test *info in fetchedObjects) {
//        NSLog(@"Name: %@", info.name);
//    }
    
    //得到测试deviceid
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if(cls && [cls respondsToSelector:deviceIDSelector]){
//        deviceID = [cls performSelector:deviceIDSelector];
//    }
//    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//    
//    DLOG(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
//    
    
    return YES;
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    DLOG(@"online config has fininshed and note = %@", note.userInfo);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

#pragma mark - AdMoGoSplashAdsDelegate Methods

- (UIViewController *)adsMoGoSplashAdsViewControllerForPresentingModalView{
    return self.window.rootViewController;
}


- (NSString *)adsMoGoSplashAdsiPhone5Image{
    return @"Default-568h";
}

- (NSString *)adsMoGoSplashAdsiPhoneImage{
    return @"Default";
}

- (NSString *)adsMoGoSplashAdsiPadLandscapeImage{
    return @"Default-Landscape";
}

- (NSString *)adsMoGoSplashAdsiPadPortraitImage{
    return @"Default-Portrait";
}

- (void)adsMoGoSplashAdsSuccess:(AdMoGoSplashAds *)splashAds{
    DLOG(@"AdsMoGoSplashAds Success");
}

- (void)adsMoGoSplashAdsFail:(AdMoGoSplashAds *)splashAds withError:(NSError *)err{
    DLOG(@"AdsMoGoSplashAds fail %@",err);
}

- (void)adsMoGoSplashAdsAllAdFail:(AdMoGoSplashAds *)splashAds withError:(NSError *)err{
    DLOG(@"AdsMoGoSplashAdsAllAd fail %@",err);
}

- (void)adsMoGoSplashAdsFinish:(AdMoGoSplashAds *)splashAds{
    DLOG(@"AdsMoGoSplashAdsAllAd Finish");
}

- (void)adsMoGoSplashAdsWillPresent:(AdMoGoSplashAds *)splashAds{
    DLOG(@"AdsMoGoSplashAdsAllAd will Present");
}

- (void)adsMoGoSplashAdsDidPresent:(AdMoGoSplashAds *)splashAds{
    DLOG(@"AdsMoGoSplashAdsAllAd did present");
}

- (void)adsMoGoSplashAdsWillDismiss:(AdMoGoSplashAds *)splashAds{
    DLOG(@"AdsMoGoSplashAdsAllAd will dismiss");
}

- (void)adsMoGoSplashAdsDidDismiss:(AdMoGoSplashAds *)splashAds{
    DLOG(@"AdsMoGoSplashAdsAllAd did dismiss");
}

/*
 返回芒果自售广告尺寸
 */
//- (CGRect)adMoGoSplashAdSize{
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
//
//
//    float w = 300.0f;
//    float h = 300.0f;
//
//    float x = (screenSize.width - w) / 2;
//    float y = (screenSize.height - h) /2;
//
//    return  CGRectMake(x, y, w, h);
//}

// 仅在芒果自售广告中使用
//ipad 屏幕适配 (旋转相关)
//设备旋转 需更换开屏广告的default图片
- (NSString *)adsMoGoSplash:(AdMoGoSplashAds *)splashAd OrientationDidChangeGetImageName:(UIInterfaceOrientation)interfaceOri{
    return [self getCurDefaultName];
}

// 仅在芒果自售广告中使用
//如果已展示广告旋转的过程需要调整广告的位置
- (CGPoint)adsMogoSplash:(AdMoGoSplashAds *)splashAd OrientationDidChangeGetAdPoint:(UIInterfaceOrientation)interfaceOri{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    float w =320, h = 480, x = 0, y = 0;
    if (interfaceOri == UIInterfaceOrientationPortrait || interfaceOri == UIInterfaceOrientationPortraitUpsideDown) {
        x = (screenSize.width - w) / 2;
        y = (screenSize.height - h) /2;
    }else{
        x = (screenSize.height - w) / 2;
        y = (screenSize.width - h) /2;
    }
    return CGPointMake(x, y);
}

-(NSString *)getCurDefaultName{
    
    BOOL _isPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    
    NSString *name = @"Default";
    int scale = [UIScreen mainScreen].scale;
    if (!_isPad) {
        if (scale > 1 ) {
            
            if ([UIScreen mainScreen].bounds.size.height > 480) {
                name = @"Default-568h@2x";
            }else{
                name = @"Default@2x";
            }
            
        }else{
            name = @"Default";
        }
    }else{
        UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
        if (scale > 1) {
            if (io == UIInterfaceOrientationPortrait || io == UIInterfaceOrientationPortraitUpsideDown) {
                name = @"Default-Portrait@2x";
            }else{
                name = @"Default-Landscape@2x";
            }
        }else{
            if (io == UIInterfaceOrientationPortrait || io == UIInterfaceOrientationPortraitUpsideDown) {
                name = @"Default-Portrait";
            }else{
                name = @"Default-Landscape";
            }
        }
        
    }
    return name;
}

//返回芒果开屏显示类型 1 全屏 2居上 3居下
- (SplashAdShowType)adMoGoSplashShowType{
    return SplashAdShowTypeOn;
}
@end
