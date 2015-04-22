//
//  SoundAlbum.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-16.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "BaseModel.h"

@interface SoundAlbum : BaseModel

@property (nonatomic, copy) NSString *album_url;
@property (nonatomic, copy) NSString *tag_list;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *album_id;
@property (nonatomic, copy) NSString *album_title;
@property (nonatomic, strong) NSNumber *album_play_count;
@property (nonatomic, copy) NSString *album_source;
@property (nonatomic, copy) NSString *album_img;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, strong) NSNumber *sound_count;

@end
