//
//  Header.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/3.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//
/**************************************************
 * 内容描述: 公共宏命令
 * 创 建 人: Tommy
 * 创建日期: 2015-01-03
 **************************************************/

#ifndef ____Header_h
#define ____Header_h

/**
 *  友盟分析AppKey
 */
#define UMENG_APPKEY @"54a80041fd98c5256a000503"

/**
 *  InMobi广告property-ID
 */
#define INMOBI_PROPERTYID @"c2b7df1350d9460fb7adccde2f281ee0"

/**
 *  广点通
 */
#define GDT_APPKEY @"1103956810"
#define GDT_PLACEMENTID @"6060907029670698"

/**
 *  芒果广告AppKey
 */
#define MOGO_APPKEY @"3231bda97f674ae5acb0f9f4fd57bff5"

/**
 *  百度开放平台
 */
#define BAIDU_ID @"5196806"
#define BAIDU_API_KEY @"8REmxZ9b1GID3edckYWQSSND"
#define BAIDU_SECRET_KEY @"51qItcR6D376kffWtI0XSAiBSAWyXw1T"

/**
 *  优酷开放平台
 */
#define YOUKU_CLIENT_ID @"1f5646a18842efd1"
#define YOUKU_CLIENT_SECRET @"74c0ddcf9e32f0d24a209d3b929c6571"

/***************MRC释放**************/
#define SAFE_RELEASE(x) [x release]; x = nil;

/***************常用路径**************/
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/***************常用尺寸**************/
#define MainScreenFrame         [[UIScreen mainScreen] bounds]
#define MainScreenFrame_Width   MainScreenFrame.size.width
#define MainScreenFrame_Height  MainScreenFrame.size.height
#define UI_NAVIGATION_BAR_HEIGHT    44.0f
#define UI_TAB_BAR_HEIGHT           49.0f
#define UI_STATUS_BAR_HEIGHT        20.0f

/***************常用字体**************/
#define DEFAULT_FONT(s) [UIFont fontWithName:@"Arial" size:s]
#define DEFAULT_BOLD_FONT(s) [UIFont fontWithName:@"Arial-BoldMT" size:s]

/***************常用颜色**************/
#define COLOR_CLEAR [UIColor clearColor]
#define COLOR_GRAY  [UIColor grayColor]
#define COLOR_WHITE [UIColor whiteColor]
#define COLOR_BLACK [UIColor blackColor]
#define COLOR_RED   [UIColor redColor]
#define COLOR_LOW_GRAY [PanliHelper colorWithHexString:@"#5d5d5d"]
#define COLOR_NAVBAR_TITLE [PanliHelper colorWithHexString:@"#4B4B4B"]

/***************系统版本检测**************/
//ios7以后
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

/**
 *判断是否大于等于ios7
 */
#define IS_IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
/**
 *判断是否大于等于ios8
 */
#define IS_IOS8 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
/*
 *获取系统版本号
 */
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
/*
 *判断系统版本是否与v相等
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
/*
 *判断系统版本是否大于v
 */
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
/*
 *判断系统版本是否大于等于v
 */
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
/*
 *判断系统版本是否小于v
 */
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

/*
 *判断系统版本是否小于等于v
 */
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



/***************设备检测**************/
//是iPad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//是iPhoneOriTouch
#define isIPhoneOrITouch ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#endif
