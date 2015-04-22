//
//  PanliHelper.m
//  PanliApp
//
//  Created by Liubin on 14-4-2.
//  Copyright (c) 2014年 Panli. All rights reserved.
//


#import "MyHelper.h"
#include <netdb.h>
@implementation MyHelper

/**
 * 功能描述: 获取程序版本号
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (NSString *)getVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *oAppVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return oAppVersion;
}

/**
 * 功能描述: 判断网络状况
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-网络连接正常，NO-无网络
 */
+ (BOOL)connectedToNetwork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        DLOG(@"Error. Could not recover network reachability flags");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 * 功能描述: 根据格式将时间戳转换成字符串
 * 输入参数: timestamp 接口返回的时间戳字符串 /Date(1365661065760)/
 * 返 回 值: 字符串形式的时间
 */
+ (NSString *)timestampToDateString:(NSString*)iTimestamp formatterString:(NSString*)iFormatStr
{
    if([NSString isEmpty:iTimestamp])
    {
        return @"";
    }
    
    //截取时间戳
    NSRange range = NSMakeRange(6, [iTimestamp length] - 8);
    iTimestamp = [iTimestamp substringWithRange:range];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[iTimestamp doubleValue]/1000];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:iFormatStr];
    return [formatter stringFromDate:date];
}

/**
 * 功能描述: 将本地日期字符串转为UTC日期字符串
 * 输入参数: 本地时间
 * 返 回 值: UTC时间
 */
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate formatterString:(NSString*)formatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:formatterStr];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:formatterStr];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    [dateFormatter release];
    return dateString;
}

/**
 * 功能描述: 将UTC日期字符串转为本地时间字符串
 * 输入参数: UTC时间
 * 返 回 值: 本地时间
 */
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate formatterString:(NSString*)formatterStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:[NSString stringWithFormat:@"%@Z",formatterStr]];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:formatterStr];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    [dateFormatter release];
    return dateString;
}

/**
 * 功能描述: 清除TableView多余线条
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (void)setExtraCellLineHidden: (UITableView *)iTableView
{
    UIView *view = [UIView new];
    view.backgroundColor = COLOR_CLEAR;
    [iTableView setTableFooterView:view];
    [view release];
}

/**
 * 功能描述: 清除ios7 cell 向右多20像素
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (void)setExtraCellPixelExcursion :(UITableView*)iTableView
{
    if([iTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [iTableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

/**
 * 功能描述: 十六进制转换成color
 * 输入参数: N/A
 * 返 回 值: N/A
 */
+ (UIColor *)colorWithHexString: (NSString *)iStringToConvert
{
    NSString *cString = [[iStringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor yellowColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


/**
 * 功能描述: 获取千分位显示状态
 * 输入参数: string 数据源
 * 返 回 值: 转换成功的数据
 */
+ (NSString*)getCurrencyStyle:(float)iNumber
{
    if(iNumber <= 0)
    {
        return [NSString stringWithFormat:@"￥%.2f",iNumber];
    }
    NSString *resultString = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:iNumber] numberStyle:NSNumberFormatterCurrencyStyle];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"CN" withString:@""];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"US" withString:@""];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"$" withString:@"￥"];
    return resultString;
}

/**
 * 功能描述: 获取本地当前资源文件路径
 * 输入参数: string 资源名称
 * 返 回 值: 转换成功的本地路径
 */
+ (UIImage*)getImageFileByName:(NSString*)sourceName
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:sourceName ofType:@""];
    return  [UIImage imageWithContentsOfFile:imagePath];
}

/**
 * 功能描述: 通用按钮
 * 输入参数: colorType 颜色(0-绿色 1-橙色) round 是否带椭圆圆角 title 标题
 * 返 回 值: button
 */
+ (UIButton *)getCommonButtonWithColor:(int)colorType isRound:(BOOL)round title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = nil;
    UIImage *highlightedImage = nil;
    switch (colorType) {
            //绿色按钮(up:#65ca07 on:#53ad00)
        case 0:
        {
            //带圆角
            if(round)
            {
                normalImage = [UIImage imageNamed:@"btn_green_round"];
                highlightedImage = [UIImage imageNamed:@"btn_green_round_on"];
            }
            else
            {
                normalImage = [UIImage imageNamed:@"btn_green"];
                highlightedImage = [UIImage imageNamed:@"btn_green_on"];
            }
            break;
        }
            //橙色按钮(up:#ff6600 on:#ff4f00)
        case 1:
        {
            if(round)
            {
                normalImage = [UIImage imageNamed:@"btn_orange_round"];
                highlightedImage = [UIImage imageNamed:@"btn_orange_round_on"];
            }
            else
            {
                normalImage = [UIImage imageNamed:@"btn_orange"];
                highlightedImage = [UIImage imageNamed:@"btn_orange_on"];
            }
            break;
        }
        default:
            normalImage = [UIImage imageNamed:@"btn_green"];
            highlightedImage = [UIImage imageNamed:@"btn_green_on"];
            break;
    }
    
    normalImage = [normalImage stretchableImageWithLeftCapWidth:floorf(normalImage.size.width/2) topCapHeight:floorf(normalImage.size.height/2)];
    highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:floorf(highlightedImage.size.width/2) topCapHeight:floorf(highlightedImage.size.height/2)];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    return button;
}

/**
 * 功能描述: 返回string中url数组
 * 输入参数: string
 * 返 回 值: array
 */
+ (NSArray*)getCorrectUrlString:(NSString*)string
{
    if([NSString isEmpty:string])
    {
        return nil;
    }
    NSError *error;
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0,[string length])];
    BOOL isMatching = (arrayOfAllMatches == nil || arrayOfAllMatches.count < 1 ? NO:YES);
    if(isMatching)
    {
        return arrayOfAllMatches;
    }
    return nil;
}


/**
 * 功能描述: color 转换成UIImage
 * 输入参数: UIColor
 * 返 回 值: UIImage
 */
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 * 功能描述: 根据图片大小拉伸按钮大小
 * 输入参数: 需要拉伸的button 左偏移 右偏移 默认图片 高亮图片
 * 返 回 值: void
 */
+ (void)setButtonBackgroundImageSize:(UIButton*)button left:(float)left right:(float)right normalImage:(UIImage*)imageNormal highlightedImage:(UIImage*)imageHighlighted
{
    UIImage *normalImage = imageNormal;
    UIImage *highlightedImage = imageHighlighted;
    if(normalImage)
    {
        normalImage = [normalImage stretchableImageWithLeftCapWidth:floorf(normalImage.size.width/2)+left topCapHeight:floorf(normalImage.size.height/2)+right];
        [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    }
    else
    {
        highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:floorf(highlightedImage.size.width/2)+left topCapHeight:floorf(highlightedImage.size.height/2)+right];
        [button setBackgroundImage:highlightedImage forState:UIControlStateNormal];
    }
    
    if(highlightedImage)
    {
        highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:floorf(highlightedImage.size.width/2)+left topCapHeight:floorf(highlightedImage.size.height/2)+right];
        [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    }
    else
    {
        normalImage = [normalImage stretchableImageWithLeftCapWidth:floorf(normalImage.size.width/2)+left topCapHeight:floorf(normalImage.size.height/2)+right];
        [button setBackgroundImage:normalImage forState:UIControlStateHighlighted];
    }
}

/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value fontSize:(UIFont *)myfont andWidth:(float)width
{
    UIFont *font = myfont;//跟label的字体大小一样
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);//跟label的宽设置一样
    if (IS_OS_7_OR_LATER)
    {
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        
        size =[value boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    }
    else
    {
        size = [value sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
    }
    return ceilf(size.height);
}

@end
