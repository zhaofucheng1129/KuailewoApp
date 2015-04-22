//
//  AlbumSoundListViewController.m
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/17.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "AlbumSoundListViewController.h"
#import "AlbumSoundListHeaderCell.h"

#import "Sound.h"
#import "AudioPlayer.h"

#define LISTCELL_HEIGHT 95
#define MARGECELL_HEIGHT 8
#define BUTTINCELL_HEIGHT 34

@interface AlbumSoundListViewController ()
{
    BOOL tableIsFirst;
    int loadMorePageNumber;
    AudioPlayer *_audioPlayer;
}
@property (nonatomic, strong) NSMutableArray *sounds;
@end

@implementation AlbumSoundListViewController

- (void)dealloc
{
    [_audioPlayer stop];
    _audioPlayer = nil;
    _soundAlbum = nil;
    _albumSoundListTable = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    loadMorePageNumber = 1;
    
//    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [playButton setFrame:CGRectMake(0, 0, 28, 28)];
//    [playButton setBackgroundImage:[UIImage animatedImageWithImages:
//                                    @[[UIImage imageNamed:@"cm2_top_icn_playing_prs"],
//                                      [UIImage imageNamed:@"cm2_top_icn_playing2_prs"],
//                                      [UIImage imageNamed:@"cm2_top_icn_playing3_prs"],
//                                      [UIImage imageNamed:@"cm2_top_icn_playing4_prs"],
//                                      [UIImage imageNamed:@"cm2_top_icn_playing5_prs"],
//                                      [UIImage imageNamed:@"cm2_top_icn_playing6_prs"],
//                                      [UIImage imageNamed:@"cm2_top_icn_playing5_prs"],
//                                      [UIImage imageNamed:@"cm2_top_icn_playing4_prs"],
//                                      [UIImage imageNamed:@"cm2_top_icn_playing3_prs"],
//                                      [UIImage imageNamed:@"cm2_top_icn_playing2_prs"]] duration:1.0f] forState:UIControlStateNormal];
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:playButton];
//    [self.navigationItem setRightBarButtonItem:rightButton];
    
//    [self setNeedRefresh:YES];
    [self initLoadingViewWithTableView:self.albumSoundListTable];
    [self setCustomTableViewDelegate:self];
    
    [self.tableView setHidden:YES];
    
    [self requestData:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate && Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sounds.count*3+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 185;
    }
    else if (indexPath.row > 1 && indexPath.row % 3 ==2 && indexPath.row != 1)
    {
        return BUTTINCELL_HEIGHT;
    }
    else if (indexPath.row > 1 && indexPath.row % 3 ==0 && indexPath.row != 1)
    {
        return MARGECELL_HEIGHT;
    }
    else
    {
        Sound *sound = [self.sounds objectAtIndex:(indexPath.row - 1) / 3];
        CGFloat titleHeight = [MyHelper heightForString:sound.title fontSize:[UIFont systemFontOfSize:13.0f] andWidth:255.0f];
        return LISTCELL_HEIGHT + titleHeight - 16.0f;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell  = [tableView dequeueReusableCellWithIdentifier:@"AlbumHeaderCell"];
    }
    else if (indexPath.row > 1 && indexPath.row % 3 ==2 && indexPath.row != 1)
    {
        cell  = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
    }
    else if (indexPath.row > 1 && indexPath.row % 3 ==0 && indexPath.row != 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MargeCell"];
        cell.backgroundColor = [MyHelper colorWithHexString:@"#ededed"];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumSoundListCell"];
    }
    
    if (indexPath.row == 0) {
        AlbumSoundListHeaderCell *albumSoundListHeaderCell = (AlbumSoundListHeaderCell *)cell;
        [albumSoundListHeaderCell setDataWithAlbum:self.soundAlbum];
        cell = albumSoundListHeaderCell;
    }
    else if (indexPath.row > 1 && indexPath.row % 3 ==2 && indexPath.row != 1)
    {
    }
    else if (indexPath.row > 1 && indexPath.row % 3 ==0 && indexPath.row != 1)
    {
    }
    else
    {
        AlbumSoundListCell *albumSoundListCell = (AlbumSoundListCell *)cell;
        Sound *sound = [self.sounds objectAtIndex:(indexPath.row - 1) / 3];
        [albumSoundListCell setDataWithSound:sound andPlayer:_audioPlayer];
        albumSoundListCell.delegate = self;
        cell = albumSoundListCell;
    }

    
    return cell;
}

- (void)playAudio:(Sound *)sound andButton:(UIButton *)button
{
    if (_audioPlayer == nil) {
        _audioPlayer = [[AudioPlayer alloc] init];
    }
    
    if ([_audioPlayer.playId isEqualToString:sound.id]) {
        [_audioPlayer play];
    } else {
        [_audioPlayer stop];
        _audioPlayer.button = button;
        _audioPlayer.url = [NSURL URLWithString:sound.play_path];
        _audioPlayer.playId = sound.id;
        [_audioPlayer play];
    }
    
    [self.albumSoundListTable reloadData];
}

#pragma mark - CustomTableViewControllerDelegate
- (void)customTableView:(UITableView *)tableView sendRequset:(BOOL)isFirst
{
    tableIsFirst = isFirst;
    if (isFirst) {
        [self showHUDIndicatorMessage:@"正在加载..."];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *prams = @{@"album_id":self.soundAlbum.album_id};
        [manager GET:SELF_SERVER_SOUND parameters:prams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            loadMorePageNumber = 1;
            NSArray *array = (NSArray *)responseObject;
            self.sounds = [[NSMutableArray alloc] initWithCapacity:array.count];
            for (NSDictionary *soundDic in array) {
                Sound *sound = [[Sound alloc] initWithDictionary:soundDic error:nil];
                [self.sounds addObject:sound];
            }
            [self.albumSoundListTable reloadData];
            [self hideHUD];
            [self.tableView setHidden:NO];
            BOOL havaData = self.sounds != nil && self.sounds.count > 0;
            [self doAfterRequestSuccess:tableIsFirst AndHavaData:havaData AndNoDataMessage:nil AndHavaMore:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLOG(@"Error: %@", error);
            [self showHUDErrorMessage:@"获取数据失败" duration:3];
        }];
    }
    else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *prams = @{@"album_id":self.soundAlbum.album_id,@"page":[NSString stringWithFormat:@"%d",loadMorePageNumber]};
        [manager GET:SELF_SERVER_SOUND parameters:prams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *array = (NSArray *)responseObject;
            BOOL havaData = self.sounds != nil && self.sounds.count > 0;
            if (array.count > 0) {
                loadMorePageNumber++;
                for (NSDictionary *soundDic in array) {
                    Sound *sound = [[Sound alloc] initWithDictionary:soundDic error:nil];
                    [self.sounds addObject:sound];
                }
                [self.albumSoundListTable reloadData];
                [self doAfterRequestSuccess:tableIsFirst AndHavaData:havaData AndNoDataMessage:nil AndHavaMore:YES];
            }
            else
            {
                [self doAfterRequestSuccess:tableIsFirst AndHavaData:havaData AndNoDataMessage:nil AndHavaMore:NO];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLOG(@"Error: %@", error);
            [self showHUDErrorMessage:@"获取数据失败" duration:3];
        }];
    }

}

@end
