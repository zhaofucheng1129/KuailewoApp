//
//  ImageMessageCell.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-14.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageMessage.h"
#import "BeautyGirl.h"
@interface ImageMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (nonatomic, strong) ImageMessage *imageMessage;

@property (nonatomic ,strong) BeautyGirl *beautyGirl;

@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightContraint;
@end
