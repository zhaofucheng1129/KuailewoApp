//
//  ErrorInfo.h
//  PanliApp
//
//  Created by Liubin on 13-4-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

/**************************************************
 * 内容描述: 请求响应异常类
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-10
 **************************************************/
@interface ErrorInfo : NSObject
{
    NSString* _message;
    int _code;
}

/**
 *错误消息
 */
@property (nonatomic, retain) NSString* message;

/**
 *错误编码
 */
@property (nonatomic, assign) int code;

+ (id)initWithCode:(int)code message:(NSString*)messageString;

@end
