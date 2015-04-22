//
//  AlbumSoundListCell.m
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/18.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "AlbumSoundListCell.h"
#import <QuartzCore/QuartzCore.h>
#import <UIImageView+WebCache.h>
#import "AudioStreamer.h"

@implementation AlbumSoundListCell

- (void)awakeFromNib {
    [self.myContentView setBackgroundColor:COLOR_WHITE];
    self.myContentView.layer.borderWidth = 0.5;
    self.myContentView.layer.borderColor = [[UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:0.3] CGColor];
    [self.audioButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithSound:(Sound *)sound andPlayer:(AudioPlayer *)player
{
    self.sound = sound;
    
    CGFloat titleHeight = [MyHelper heightForString:sound.title fontSize:[UIFont systemFontOfSize:13.0f] andWidth:255.0f];
    if (titleHeight > self.titleHeightConstraint.constant) {
        [self.contentBorderHeightConstraint setConstant:self.contentBorderHeightConstraint.constant + titleHeight - self.titleHeightConstraint.constant];
        [self.coverToTop setConstant:(self.contentBorderHeightConstraint.constant - 60.0f) / 2];
        [self.titleHeightConstraint setConstant:titleHeight];
    }
    
    [self.title setText:sound.title];
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:sound.cover_url_142] placeholderImage:[UIImage imageNamed:@"soundAlbum_placeholder_98"]];
    [self.time_until_now setText:sound.time_until_now];
    [self.nickname setText:sound.nickname];
    if ([sound.play_count floatValue] >= 10000) {
        [self.play_count setText:[NSString stringWithFormat:@"%.1f万",[sound.play_count floatValue] / 10000]];
    }
    else
    {
        [self.play_count setText:[sound.play_count stringValue]];
    }
    if ([sound.favorites_count floatValue] >= 10000) {
        [self.favorites_count setText:[NSString stringWithFormat:@"%.1f万",[sound.favorites_count floatValue] / 10000]];
    }
    else
    {
        [self.favorites_count setText:[sound.favorites_count stringValue]];
    }
    if ([sound.comments_count floatValue] >= 10000) {
        [self.comments_count setText:[NSString stringWithFormat:@"%.1f万",[sound.comments_count floatValue] / 10000]];
    }
    else
    {
        [self.comments_count setText:[sound.comments_count stringValue]];
    }
    
    [self.duration setText:[NSString stringWithFormat:@"%d:%@",
                            [sound.duration intValue] / 60,
                            [sound.duration intValue] % 60 < 10?
                            [NSString stringWithFormat:@"0%d",[sound.duration intValue] % 60]:
                            [NSString stringWithFormat:@"%d",[sound.duration intValue] % 60]]];
    //播放按钮状态
    if (player != nil && [sound.id isEqualToString:player.playId] && [player.streamer isPlaying])
    {
        [self.audioButton setImage:[UIImage imageNamed:@"cell_sound_pause_n"] forState:UIControlStateNormal];
        [self.audioButton setImage:[UIImage imageNamed:@"cell_sound_pause_h"] forState:UIControlStateHighlighted];
    }
    else
    {
        [self.audioButton setImage:[UIImage imageNamed:@"cell_sound_play_n"] forState:UIControlStateNormal];
        [self.audioButton setImage:[UIImage imageNamed:@"cell_sound_play_h"] forState:UIControlStateHighlighted];
    }
}

- (void)playButtonClick:(UIButton *)button
{
    switch (button.tag)
    {
        case 2001:
        {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(playAudio:andButton:)]) {
                [self.delegate playAudio:self.sound andButton:button];
            }
            break;
        }
        default:
            break;
    }
}

@end
