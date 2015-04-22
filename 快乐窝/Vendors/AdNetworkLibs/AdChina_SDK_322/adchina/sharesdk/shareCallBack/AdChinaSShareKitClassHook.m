 
//  Created by AdChina on 13-12-20.
//  Copyright (c) 2013年 AdChina. All rights reserved.
//
#import <objc/runtime.h>
#import <objc/message.h>
#import "AdChinaSShareKitClassHook.h"
#import "AdChinaSShareKit.h"
static AdChinaSShareKitClassHook *adsMogoShareKitClassHook;

@interface AdChinaSShareKitClassHook (){
    
}

@end

@implementation AdChinaSShareKitClassHook
@synthesize haveMethod;

+ (void)load{
    if (!adsMogoShareKitClassHook) {
        adsMogoShareKitClassHook = [[AdChinaSShareKitClassHook alloc] init];
    }
    
}

+ (AdChinaSShareKitClassHook *)shareClassHook{
    
    if (!adsMogoShareKitClassHook) {
        adsMogoShareKitClassHook = [[AdChinaSShareKitClassHook alloc] init];
    }
    return adsMogoShareKitClassHook;
    
}


- (id)init{
    
    if ( (self = [super init]) ) {
        self.haveMethod = NO;
        [self replaceAppDelegateMethod];
    }
    return self;
    
}

- (void)replaceAppDelegateMethod{
    //replace setDelegate method
    [self methodHook:[UIApplication class] toClass:[self class] fromSEL:@selector(setDelegate:) toSEL:NSSelectorFromString(@"setMyDelegate:") originalSEL:NSSelectorFromString(@"setMyDelegateOriginal:")];
}

- (void)methodHook:(Class)fromClass toClass:(Class)toClass fromSEL:(SEL)fromSEL toSEL:(SEL)toSEL originalSEL:(SEL)originalSEL{
    
    
    Method fromEvent = class_getInstanceMethod(fromClass, fromSEL);
    Method toEvent = class_getInstanceMethod(toClass, toSEL);
    
    IMP fromEventImp = method_getImplementation(fromEvent);
    IMP toEventImp = method_getImplementation(toEvent);
    
    class_addMethod(fromClass, originalSEL, fromEventImp, method_getTypeEncoding(fromEvent));
    
    class_replaceMethod(fromClass, fromSEL, toEventImp, method_getTypeEncoding(fromEvent));
    
}

#pragma mark -
#pragma mark methods
- (void)setMyDelegate:(id)delegate{
    //get app delegate and replace respondsToSelector method
//    NSString *strLog = [NSString stringWithFormat:@"delegate-->%@",[delegate class]];
    //    [AdsMogoShareKit MogoLog:strLog];
    [[AdChinaSShareKitClassHook shareClassHook] methodHook:[delegate class] toClass:[AdChinaSShareKitClassHook class] fromSEL:@selector(respondsToSelector:) toSEL:NSSelectorFromString(@"myRespondsToSelector:") originalSEL:NSSelectorFromString(@"respondsToSelectorOriginal:")];
    [self performSelector:NSSelectorFromString(@"setMyDelegateOriginal:") withObject:delegate];
    
}

- (BOOL)myRespondsToSelector:(SEL)sel{
    BOOL (*isRespondsToSelector)(id, SEL,SEL) = NULL;
    SEL regTypeSel = NSSelectorFromString(@"respondsToSelectorOriginal:");
    isRespondsToSelector = (BOOL (*)(id, SEL,SEL))[[self class] instanceMethodForSelector:regTypeSel];
    BOOL isReturn = isRespondsToSelector(self, regTypeSel,sel);
    if (sel == NSSelectorFromString(@"application:openURL:sourceApplication:annotation:")) {
        [AdChinaSShareKitClassHook shareClassHook].haveMethod = isReturn;
        [[AdChinaSShareKitClassHook shareClassHook] methodHook:[self class] toClass:[AdChinaSShareKitClassHook class] fromSEL:@selector(application:openURL:sourceApplication:annotation:) toSEL:NSSelectorFromString(@"myapplication:openURL:sourceApplication:annotation:") originalSEL:NSSelectorFromString(@"applicationOriginal:openURL:sourceApplication:annotation:")];
        return YES;
    }
    return isReturn;
    
}
-(BOOL)myapplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([AdChinaSShareKitClassHook shareClassHook].haveMethod) {
        NSMethodSignature *sig = [self methodSignatureForSelector:NSSelectorFromString(@"applicationOriginal:openURL:sourceApplication:annotation:")];
        
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:NSSelectorFromString(@"applicationOriginal:openURL:sourceApplication:annotation:")];
        [invo setArgument:&application atIndex:2];
        [invo setArgument:&url atIndex:3];
        if (sourceApplication != nil) {
            [invo setArgument:&sourceApplication atIndex:4];
            if (annotation) {
                [invo setArgument:&annotation atIndex:5];
            }
        }
        [invo retainArguments];
        [invo performSelector:@selector(invoke) withObject:nil];
    }
    [WXApi handleOpenURL:url delegate:[AdChinaSShareKitClassHook shareClassHook]];
    [QQApiInterface handleOpenURL:url delegate:[AdChinaSShareKitClassHook shareClassHook]];
    
    
    return YES;
}

- (void)onResp:(id)resp{
    BOOL  success = NO;
    if ([resp isKindOfClass:[BaseResp class]]) {   //微信
        BaseResp* resp_tmp =(BaseResp*)resp;
        if([resp_tmp isKindOfClass:[SendMessageToWXResp class]])
        {
            switch (resp_tmp.errCode) {
                case WXSuccess:
                    success=YES;
                    break;
                case WXErrCodeCommon:
                    success=NO;
                    break;
                case WXErrCodeUserCancel:
                    success=NO;
                    break;
                case WXErrCodeSentFail:
                    success=NO;
                    break;
                case WXErrCodeAuthDeny:
                    success=NO;
                    break;
                case WXErrCodeUnsupport:
                    success=NO;
                    break;
                default:
                    success=NO;
                    break;
            }
        }
    }else if ([resp isKindOfClass:[QQBaseResp class]]){  //QQ
        QQBaseResp* resp_tmp =(QQBaseResp*)resp;
        switch (resp_tmp.type)
        {
            case ESENDMESSAGETOQQRESPTYPE:
            {
                if (resp_tmp.errorDescription==nil||[resp_tmp.errorDescription isEqualToString:@""]) {
                    success=YES;
                }else{
                    success=NO;
                }
            }
        }
    }
    id netType= [AdChinaSShareKit sharedRegistry].netType;
    if (netType&&[netType isKindOfClass:[NSNumber class]]) {
        NSNumber *netType_tmp =(NSNumber*)netType;
        if ( [AdChinaSShareKit sharedRegistry].delegate && [ [AdChinaSShareKit sharedRegistry].delegate respondsToSelector:@selector(shareFinish:shareType:)]) {
            [ [AdChinaSShareKit sharedRegistry].delegate performSelector:@selector(shareFinish:shareType:) withObject:[NSNumber numberWithBool:success] withObject:netType_tmp];
        }

    }
}
 

@end
