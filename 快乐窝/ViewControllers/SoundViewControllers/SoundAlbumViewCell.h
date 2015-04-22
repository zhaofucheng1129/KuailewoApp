//
//  SoundAlbumViewCell.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-16.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundAlbum.h"

@protocol SoundAlbumCellDelegate <NSObject>

- (void)soundAlbumDidSelected:(SoundAlbum *)product;

@end

@interface SoundAlbumViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *middleButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (weak, nonatomic) IBOutlet UILabel *leftTitle;
@property (weak, nonatomic) IBOutlet UILabel *middleTitle;
@property (weak, nonatomic) IBOutlet UILabel *rightTitle;

@property (nonatomic, assign) id<SoundAlbumCellDelegate> delegate;
@property (nonatomic, strong) NSArray *soundAlbums;
- (void)setData:(NSArray *)soundAlbums;

@end
