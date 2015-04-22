//
//  NSString+Helper.h
//  PanliApp
//
//  Created by Liubin on 14-4-2.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

- (NSString *)MD5;
- (NSString *)sha1;
- (NSString *)reverse;
- (NSUInteger)wordCount;
- (NSString *)trim;
- (NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
- (NSString *)replaceAll:(NSString*)origin with:(NSString*)replacement;
- (NSArray *)split:(NSString*)separator;
- (NSInteger)indexOfString:(NSString*)str;
- (NSInteger)lastIndexOfString:(NSString*)str;
- (NSDate*)formatToDateWithString:(NSString*)string;
- (NSDate*)formatToDateWithStyle:(NSDateFormatterStyle)style;
- (NSString *)stringReplaceEmoji:(NSString *)contentString;

/**
 * 功能描述: 去掉String当中的emjoi表情
 * 输入参数: N/A
 * 返 回 值: 不带emjoi表情的String
 */
- (NSString *)truncateContainsEmoji;

- (BOOL)stringContainsEmoji;

+ (BOOL)isEmpty:(NSString*)string;
- (BOOL)contains:(NSString *)string;
- (BOOL)startsWith:(NSString*)prefix;
- (BOOL)endsWith:(NSString*)suffix;
- (BOOL)isNumeric;
- (BOOL)isTelephone;
- (BOOL)isValidEmail;


@end
