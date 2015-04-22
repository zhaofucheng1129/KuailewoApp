//
//  AdShareContext.h
//  AdChinaSDK3
//
//  Created by AdChina on 14-3-11.
//  Copyright (c) 2014年 AdChina. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AdChinaShareImage,
    AdChinaShareHtml,
    AdChinaShareAudio,
    AdChinaShareVideo
}ShareType;

@interface AdShareContext : NSObject
@property(copy,nonatomic) NSString *title;       //分享
@property(copy,nonatomic) NSString *detail;      //分享描述
@property(atomic,assign)  ShareType  ctype;      //分享类型
@property(copy,nonatomic) NSString *conturl;     //分享内容
@property(strong,nonatomic) NSData *ImageData;   //分享图片流
@property(copy,nonatomic) NSString *thumbnail;   //分享缩略图
@property(copy,nonatomic) NSString *clickUrl;    //分享点击url





@end