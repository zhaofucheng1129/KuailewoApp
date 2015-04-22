//
//  Sound.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/18.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "BaseModel.h"

@interface Sound : BaseModel

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *album_id;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *short_intro;
@property (nonatomic, copy) NSString *cover_url;
@property (nonatomic, strong) NSNumber *shares_count;
@property (nonatomic, copy) NSString *cover_url_142;
@property (nonatomic, copy) NSString *play_path_64;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, strong) NSNumber *play_count;
@property (nonatomic, strong) NSNumber *favorites_count;
@property (nonatomic, copy) NSString *play_path;
@property (nonatomic, copy) NSString *time_until_now;
@property (nonatomic, strong) NSNumber *comments_count;
@property (nonatomic, copy) NSString *album_title;
@property (nonatomic, copy) NSString *category_title;

@end
