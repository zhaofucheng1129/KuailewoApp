//
//  ImageMessage.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-14.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

/**************************************************
* 内容描述: 自定义的搞笑图片信息对象
* 创 建 人: Tommy
* 创建日期: 2015-04-14
**************************************************/
#import "BaseModel.h"

@interface ImageMessage : BaseModel

@property (nonatomic, strong) NSNumber *item_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *source_url;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *format;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *up_vote;
@property (nonatomic, strong) NSNumber *down_vote;


@end
