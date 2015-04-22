//
//  ImageMessageCell.m
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-14.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "ImageMessageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define MARGIN 6.0F
@implementation ImageMessageCell

- (void)awakeFromNib {
//    self.backgroundColor = [MyHelper colorWithHexString:@"#ededed"];
    UIImage *normal = [UIImage imageNamed:@"duanzi_button_normal"];
    [MyHelper setButtonBackgroundImageSize:self.upBtn left:0 right:0 normalImage:normal highlightedImage:normal];
    [MyHelper setButtonBackgroundImageSize:self.downBtn left:0 right:0 normalImage:normal highlightedImage:normal];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)setImageMessage:(ImageMessage *)imageMessage
{
    self.title.text = [NSString stringWithFormat:@"%@",imageMessage.title];
    self.titleHeightContraint.constant = [MyHelper heightForString:[NSString stringWithFormat:@"%@",imageMessage.title] fontSize:[UIFont systemFontOfSize:17.0f] andWidth:MainScreenFrame_Width-8-8];
    UIImage *placeholder = [UIImage imageNamed:@"imageMsd_placeholder"];
    [self.image setImage:placeholder];
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageMessage.img_url] placeholderImage:placeholder options:SDWebImageProgressiveDownload];
    [self.upBtn setTitle:[NSString stringWithFormat:@"%d",[imageMessage.up_vote integerValue]] forState:UIControlStateNormal];
    [self.downBtn setTitle:[NSString stringWithFormat:@"%d",[imageMessage.down_vote integerValue]] forState:UIControlStateNormal];
    
}

- (void)setBeautyGirl:(BeautyGirl *)beautyGirl
{
    self.titleHeightContraint.constant = 0;
    UIImage *placeholder = [UIImage imageNamed:@"imageMsd_placeholder"];
    [self.image setImage:placeholder];
    [self.image sd_setImageWithURL:[NSURL URLWithString:beautyGirl.thumbLargeTnUrl] placeholderImage:placeholder options:SDWebImageProgressiveDownload];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
