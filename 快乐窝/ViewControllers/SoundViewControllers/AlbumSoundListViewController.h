//
//  AlbumSoundListViewController.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/17.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "BaseViewController.h"
#import "SoundAlbum.h"
#import "AlbumSoundListCell.h"

@interface AlbumSoundListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,CustomTableViewControllerDelegate,AlbumSoundListCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *albumSoundListTable;
@property (nonatomic, strong) SoundAlbum *soundAlbum;

@end
