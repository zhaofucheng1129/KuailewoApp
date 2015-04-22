//
//  AlbumSoundListCell.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/18.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"
#import "AudioPlayer.h"

@protocol AlbumSoundListCellDelegate <NSObject>

- (void)playAudio:(Sound *)sound andButton:(UIButton *)button;

@end

@interface AlbumSoundListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *myContentView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

@property (weak, nonatomic) IBOutlet UILabel *time_until_now;

@property (weak, nonatomic) IBOutlet UILabel *nickname;

@property (weak, nonatomic) IBOutlet UILabel *play_count;

@property (weak, nonatomic) IBOutlet UILabel *favorites_count;

@property (weak, nonatomic) IBOutlet UILabel *comments_count;

@property (weak, nonatomic) IBOutlet UILabel *duration;

@property (nonatomic, assign) id<AlbumSoundListCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *audioButton;

@property (nonatomic, strong) Sound *sound;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBorderHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverToTop;
- (void)setDataWithSound:(Sound *)sound andPlayer:(AudioPlayer *)player;

@end
