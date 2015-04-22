//
//  SoundAlbumViewController.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-16.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundAlbumViewCell.h"

@interface SoundAlbumViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CustomTableViewControllerDelegate,SoundAlbumCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *soundAlbumTable;

@end
