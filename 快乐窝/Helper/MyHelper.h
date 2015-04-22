//
//  PanliHelper.h
//  PanliApp
//
//  Created by Liubin on 14-4-2.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Helper.h"

@interface MyHelper : NSObject

/**
 * 功能描述: 获取程序版本号
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (NSString *)getVersion;

/**
 * 功能描述: 获取本地当前资源文件路径
 * 输入参数: string 资源名称
 * 返 回 值: 转换成功的本地路径
 */
+ (UIImage*)getImageFileByName:(NSString*)sourceName;

/**
 * 功能描述: 判断网络状况
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-网络连接正常，NO-无网络
 */
+ (BOOL)connectedToNetwork;

/**
 * 功能描述: 十六进制转换成color
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (UIColor *)colorWithHexString: (NSString *)iStringToConvert;

/**
 * 功能描述: 清除TableView多余线条
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (void)setExtraCellLineHidden: (UITableView *)iTableView;

/**
 * 功能描述: 根据图片大小拉伸按钮大小
 * 输入参数: 需要拉伸的button 左偏移 右偏移 默认图片 高亮图片
 * 返 回 值: void
 */
+ (void)setButtonBackgroundImageSize:(UIButton*)button left:(float)left right:(float)right normalImage:(UIImage*)imageNormal highlightedImage:(UIImage*)imageHighlighted;

/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value fontSize:(UIFont *)myfont andWidth:(float)width;
@end
