//
//  File: AMNetworkReachabilityWrapper.h
//  Project: AdsMOGO iOS SDK
//  Version: 1.1.7
//
//  Copyright 2011 AdsMogo.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <netdb.h>
#import "AMNetworkReachabilityDelegate.h"

@class AMNetworkReachabilityWrapper;

// Created for ease of mocking (hence testing)
@interface AMNetworkReachabilityWrapper : NSObject {
	NSString *hostname_;
	SCNetworkReachabilityRef reachability_;
	id<AMNetworkReachabilityDelegate> delegate_;
}

@property (nonatomic,readonly) NSString *hostname;
@property (nonatomic,assign) id<AMNetworkReachabilityDelegate> delegate;

+ (AMNetworkReachabilityWrapper *) reachabilityWithHostname:(NSString *)host
										   callbackDelegate:(id<AMNetworkReachabilityDelegate>)delegate;

- (id)initWithHostname:(NSString *)host
      callbackDelegate:(id<AMNetworkReachabilityDelegate>)delegate;

- (BOOL)scheduleInCurrentRunLoop;

- (BOOL)unscheduleFromCurrentRunLoop;
@end