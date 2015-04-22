//
//  File: AdMoGoAdNetworkAdapter＋Helpers.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.7
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

/*
    所有适配器父类私有方法 old code
 */

#import "AdMoGoAdNetworkAdapter.h"

@interface AdMoGoAdNetworkAdapter (Helpers)

- (void)helperNotifyDelegateOfFullScreenModal;
- (void)helperNotifyDelegateOfFullScreenModalDismissal;

- (void)helperNotifyDelegateOfFullScreenAdModal;
- (void)helperNotifyDelegateOfFullScreenAdModalDismissal;

- (UIColor *)helperBackgroundColorToUse;
- (UIColor *)helperTextColorToUse;
- (UIColor *)helperSecondaryTextColorToUse;
- (NSInteger)helperCalculateAge;

//- (BOOL)helperNotifyDelegateOfFullScreenAutorotate;

- (void)helperNotifyDelegateOfFullScreenAdClosed;
@end