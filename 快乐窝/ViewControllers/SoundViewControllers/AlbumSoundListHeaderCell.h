//
//  AlbumSoundListHeaderCell.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/17.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundAlbum.h"

@interface AlbumSoundListHeaderCell : UITableViewCell

//专辑封面按钮
@property (weak, nonatomic) IBOutlet UIButton *coverButton;
//专辑标题
@property (weak, nonatomic) IBOutlet UILabel *title;
//播放数
@property (weak, nonatomic) IBOutlet UILabel *playCount;
//音频数
@property (weak, nonatomic) IBOutlet UILabel *soundCount;
//标签
@property (weak, nonatomic) IBOutlet UILabel *tags;

- (void)setDataWithAlbum:(SoundAlbum *)soundAlbum;

@end
