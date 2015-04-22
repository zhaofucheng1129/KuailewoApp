//
//  ErrorInfo.m
//  PanliApp
//
//  Created by Liubin on 13-4-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ErrorInfo.h"

@implementation ErrorInfo

@synthesize message = _message;
@synthesize code = _code;


+ (ErrorInfo *)initWithCode:(int)code message:(NSString*)messageString
{
    ErrorInfo* errorInfo = [[[self alloc] init] autorelease];
    if(errorInfo)
    {
        errorInfo.code = code;
        errorInfo.message = messageString;
    }
    return errorInfo;
}


- (void)dealloc
{
    SAFE_RELEASE(_message);
    [super dealloc];
}
@end
