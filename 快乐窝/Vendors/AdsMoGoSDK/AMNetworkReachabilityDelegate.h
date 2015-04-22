//
//  File: AMNetworkReachabilityDelegate.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.7
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

@class AMNetworkReachabilityWrapper;

@protocol AMNetworkReachabilityDelegate <NSObject>

@optional
- (void)reachabilityBecameReachable:(AMNetworkReachabilityWrapper *)reachability;
- (void)reachabilityNotReachable:(AMNetworkReachabilityWrapper *)reachability;
@end