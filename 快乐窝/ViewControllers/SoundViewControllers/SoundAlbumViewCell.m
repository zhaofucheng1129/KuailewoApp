//
//  SoundAlbumViewCell.m
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-16.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import <SDWebImage/UIButton+WebCache.h>
#import "SoundAlbumViewCell.h"


@implementation SoundAlbumViewCell

- (void)awakeFromNib {
    self.backgroundColor = [MyHelper colorWithHexString:@"#ededed"];
    [self.leftButton addTarget:self action:@selector(soundAlbumClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.middleButton addTarget:self action:@selector(soundAlbumClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(soundAlbumClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSArray *)soundAlbums
{
    UIImage *placeholder = [UIImage imageNamed:@"soundAlbum_placeholder_98"];
    self.soundAlbums = soundAlbums;
    switch ([soundAlbums count]) {
        case 1:
        {
            [self.leftButton setHidden:NO];
            [self.leftButton setHidden:NO];
            SoundAlbum *leftSoundAlbum = [soundAlbums objectAtIndex:0];
            [self.leftButton sd_setBackgroundImageWithURL:[NSURL URLWithString:leftSoundAlbum.album_img] forState:UIControlStateNormal placeholderImage:placeholder];
            [self.leftTitle setText:[NSString stringWithFormat:@"%@",leftSoundAlbum.album_title]];
            [self.middleButton setHidden:YES];
            [self.middleTitle setHidden:YES];
            [self.rightButton setHidden:YES];
            [self.rightTitle setHidden:YES];
            break;
        }
        case 2:
        {
            [self.leftButton setHidden:NO];
            [self.leftButton setHidden:NO];
            [self.middleButton setHidden:NO];
            [self.middleTitle setHidden:NO];
            SoundAlbum *leftSoundAlbum = [soundAlbums objectAtIndex:0];
            SoundAlbum *middleSoundAlbum = [soundAlbums objectAtIndex:1];
            [self.leftButton sd_setBackgroundImageWithURL:[NSURL URLWithString:leftSoundAlbum.album_img] forState:UIControlStateNormal placeholderImage:placeholder];
            [self.middleButton sd_setBackgroundImageWithURL:[NSURL URLWithString:middleSoundAlbum.album_img] forState:UIControlStateNormal placeholderImage:placeholder];
            [self.leftTitle setText:[NSString stringWithFormat:@"%@",leftSoundAlbum.album_title]];
            [self.middleTitle setText:[NSString stringWithFormat:@"%@",middleSoundAlbum.album_title]];
            [self.rightButton setHidden:YES];
            [self.rightTitle setHidden:YES];
            break;
        }
        case 3:
        {
            [self.leftButton setHidden:NO];
            [self.leftButton setHidden:NO];
            [self.middleButton setHidden:NO];
            [self.middleTitle setHidden:NO];
            [self.rightButton setHidden:NO];
            [self.rightTitle setHidden:NO];
            SoundAlbum *leftSoundAlbum = [soundAlbums objectAtIndex:0];
            SoundAlbum *middleSoundAlbum = [soundAlbums objectAtIndex:1];
            SoundAlbum *rightSoundAlbum = [soundAlbums objectAtIndex:2];
            [self.leftButton sd_setBackgroundImageWithURL:[NSURL URLWithString:leftSoundAlbum.album_img] forState:UIControlStateNormal placeholderImage:placeholder];
            [self.middleButton sd_setBackgroundImageWithURL:[NSURL URLWithString:middleSoundAlbum.album_img] forState:UIControlStateNormal placeholderImage:placeholder];
            [self.rightButton sd_setBackgroundImageWithURL:[NSURL URLWithString:rightSoundAlbum.album_img] forState:UIControlStateNormal placeholderImage:placeholder];
            [self.leftTitle setText:[NSString stringWithFormat:@"%@",leftSoundAlbum.album_title]];
            [self.middleTitle setText:[NSString stringWithFormat:@"%@",middleSoundAlbum.album_title]];
            [self.rightTitle setText:[NSString stringWithFormat:@"%@",rightSoundAlbum.album_title]];
        }
            
        default:
            break;
    }
}

- (void)soundAlbumClick:(UIButton *)button
{
    switch (button.tag)
    {
        case 1001:
        {
            SoundAlbum *leftSoundAlbum = [self.soundAlbums objectAtIndex:0];
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(soundAlbumDidSelected:)]) {
                [self.delegate soundAlbumDidSelected:leftSoundAlbum];
            }
            break;
        }
        case 1002:
        {
            SoundAlbum *middleSoundAlbum = [self.soundAlbums objectAtIndex:1];
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(soundAlbumDidSelected:)]) {
                [self.delegate soundAlbumDidSelected:middleSoundAlbum];
            }
            break;
        }
        case 1003:
        {
            SoundAlbum *rightSoundAlbum = [self.soundAlbums objectAtIndex:2];
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(soundAlbumDidSelected:)]) {
                [self.delegate soundAlbumDidSelected:rightSoundAlbum];
            }
            break;
        }
            
        default:
            break;
    }
}

@end
