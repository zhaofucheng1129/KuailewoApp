//
//  AdChinaSShareAdapter.h
//  AdChinaSShareKit
//
//  Created by Daxiong on 13-11-18.
//  Copyright (c) 2013年 Daxiong. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AdChinaSShareKitSnsInfo.h"
#import "AdChinaSShareKit.h"

typedef enum {
    AdShareImage,
    AdShareHtml,
    AdShareAudio,
    AdShareVideo
}AdShareType;


@interface NSObject (ShareAdapter)
- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4;
@end
@implementation NSObject (ShareAdapter)

- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4{
    
    NSMethodSignature *sig = [self methodSignatureForSelector:aSelector];
    if (!sig){
        return nil;
    }
    
    NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
    [invo setTarget:self];
    [invo setSelector:aSelector];
    [invo setArgument:&object1 atIndex:2];
    [invo setArgument:&object2 atIndex:3];
    [invo setArgument:&object3 atIndex:4];
    [invo setArgument:&object4 atIndex:5];
    [invo retainArguments];
    
    return [invo performSelector:@selector(invoke) withObject:nil];
}

@end

typedef enum {
    AdChinaSImgPng     = 1 << 0,
    AdChinaSImgJpg     = 1 << 1,
    AdChinaSImgGif     = 1 << 2,
    AdChinaSImgUnknown = 1 << 3
}AdChinaSImgType;

@interface AdChinaSShareAdapter : NSObject

@property( nonatomic,retain ,setter = setInfoData:) NSDictionary *infoData;
@property( nonatomic,assign )AdChinaSShareKit *shareKit;
@property(assign,nonatomic) BOOL isShowViewController;
@property(strong,nonatomic) NSString * shareContext;

+ (AdChinaSShareAdapter *)sharedRegistry;
- (void)showShareViewController;
- (void)startOAuthProgess;
- (void)startEditProgess:(NSString*)title  context:(NSDictionary*)infoData;

- (void)saveAccessTokenWithType:(int)type andInfoDict:(NSDictionary *)info;

- (id)getAccessTokenWithType:(int)type;

- (void)parametersFromJSCall:(NSString *)parameterString andAdContentRef:(NSDictionary **)adContent;
- (AdChinaSImgType)checkImageType:(NSData *)imgData;

-(BOOL)isCheckToKen:(id)token;
-(double)getToKenTime:(NSTimeInterval)addTime;

-(int)getSharePlatformsType;


-(void)presentModalSharingViewController:(UIViewController*)viewController;
- (void)share;
-(NSData*)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent;

@end








