//
//  AdChinaSShareKit.h
//  AdChinaSShareKit
//
//  Created by Daxiong on 13-11-8.
//  Copyright (c) 2013年 Daxiong. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AdChinaSShareKitDelegate;
typedef enum {
    AdChinaSShareAdapterTypeSinaWeiWx             = 1,
    AdChinaSShareAdapterTypeSinaWeiWxFriend       = 2,
    AdChinaSShareAdapterTypeSinaQQfriend          = 3,
    AdChinaSShareAdapterTypeSinaQzone             = 4,
    AdChinaSShareAdapterTypeSinaWeibo             = 6,
    AdChinaSShareAdapterTypeSinaEmail             = 7,
    AdChinaSShareAdapterTypeSinaMessage           = 8,
    AdChinaSShareAdapterTypeSinaPassbook          = 9
} AdChinaSShareAdapterType;

@interface AdChinaSShareKit : NSObject

//one kit one delegate
@property(nonatomic,assign) id<AdChinaSShareKitDelegate>delegate;
@property Boolean debugMode;
@property id netType;
+ (AdChinaSShareKit *)sharedRegistry;
+(void)MogoLog:(NSString *)strLog;
/**
 *share info with shareKit
 *infoData keys in AdChinaSShareKitSnsInfo.h file
 */
- (void)shareWithInfoData:(NSDictionary *)infoData;

- (NSDictionary *)getAllSnsPlatform;


-(void)setinShare:(BOOL)isShare;

@end

@protocol AdChinaSShareKitDelegate <NSObject>

@required
- (UIViewController *)AdChinaSShareKitViewControllerForPresent:(AdChinaSShareKit *)shareKit;
//开始分享
-(void)shareStart:(NSNumber*)shareType;
//开始授权
-(void)oAuthStart:(NSNumber*)shareType;
-(void)oAuthFinish:(NSNumber*)isSucceed  shareType:(NSNumber*)shareType;
-(void)shareFinish:(NSNumber*)isSucceed  shareType:(NSNumber*)shareType;
//start share
//- (void)AdChinaSShareKit
@end
