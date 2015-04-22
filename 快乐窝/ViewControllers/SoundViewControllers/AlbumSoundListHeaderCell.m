//
//  AlbumSoundListHeaderCell.m
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/17.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "AlbumSoundListHeaderCell.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation AlbumSoundListHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithAlbum:(SoundAlbum *)soundAlbum
{
    [self.coverButton sd_setBackgroundImageWithURL:[NSURL URLWithString:soundAlbum.album_img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cm2_default_cover_112"]];
    [self.title setText:soundAlbum.album_title];
    [self.playCount setText:[NSString stringWithFormat:@"%@次播放",[soundAlbum.album_play_count stringValue]]];
    [self.soundCount setText:[soundAlbum.sound_count stringValue]];
    [self.tags setText:[soundAlbum.tag_list trim]];
}

@end
