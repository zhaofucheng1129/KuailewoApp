//
//  SoundAlbumViewController.m
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-16.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "SoundAlbumViewController.h"
#import "SoundAlbum.h"
#import "UIViewController+ScrollingNavbar.h"
#import "AlbumSoundListViewController.h"

@interface SoundAlbumViewController ()
{
    BOOL tableIsFirst;
    int loadMorePageNumber;
}

@property (nonatomic, retain) NSMutableArray *soundAlbums;

@end

@implementation SoundAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    loadMorePageNumber = 1;
    
    [self initLoadingViewWithTableView:self.soundAlbumTable];
    [self setCustomTableViewDelegate:self];
    [self.tableView setHidden:YES];
    [self requestData:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    DLOG(@"视图消失");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - NetWork
- (void)getSoundAlbums{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:SELF_SERVER_SOUNDALBUM parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        self.soundAlbums = [[NSMutableArray alloc] initWithCapacity:array.count];
        for (NSDictionary *soundAlbumDic in array) {
            SoundAlbum *soundAlbum = [[SoundAlbum alloc] initWithDictionary:soundAlbumDic error:nil];
            [self.soundAlbums addObject:soundAlbum];
        }
        [self.soundAlbumTable reloadData];
        BOOL havaData = self.soundAlbums != nil && self.soundAlbums.count > 0;
        [self doAfterRequestSuccess:tableIsFirst AndHavaData:havaData AndNoDataMessage:nil AndHavaMore:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLOG(@"Error: %@", error);
    }];
}

#pragma mark - TableViewDelegate && Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.soundAlbums.count / 3 + (self.soundAlbums.count % 3 != 0 ? 1: 0 );
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SoundAlbumViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"soundAlbumCell"];
    cell.delegate = self;
    if (self.soundAlbums.count >= indexPath.row*3+3)
    {
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(indexPath.row*3, 3)];
        [cell setData:[self.soundAlbums objectsAtIndexes:indexSet]];
    }
    else
    {
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(indexPath.row*3, self.soundAlbums.count % 3)];
        [cell setData:[self.soundAlbums objectsAtIndexes:indexSet]];
    }
    return cell;
}

#pragma mark - SoundAlbumCellDelegate
- (void)soundAlbumDidSelected:(SoundAlbum *)soundAlbum
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AlbumSoundListViewController *albumSoundListViewController = [storyboard instantiateViewControllerWithIdentifier:@"AlbumSoundListViewController"];
    self.parentViewController.title = @"声音";
    
    albumSoundListViewController.title = @"专辑";
    albumSoundListViewController.soundAlbum = soundAlbum;
    [self.parentViewController showNavBarAnimated:YES completion:^{
        [self.navigationController pushViewController:albumSoundListViewController animated:YES];
    }];
//    [self.navigationController pushViewController:albumSoundListViewController animated:YES];
}

#pragma mark - CustomTableViewControllerDelegate
- (void)customTableView:(UITableView *)tableView sendRequset:(BOOL)isFirst
{
    tableIsFirst = isFirst;
    if (isFirst) {
        [self showHUDIndicatorMessage:@"正在加载..."];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:SELF_SERVER_SOUNDALBUM parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            loadMorePageNumber = 1;
            NSArray *array = (NSArray *)responseObject;
            self.soundAlbums = [[NSMutableArray alloc] initWithCapacity:array.count];
            for (NSDictionary *soundAlbumDic in array) {
                SoundAlbum *soundAlbum = [[SoundAlbum alloc] initWithDictionary:soundAlbumDic error:nil];
                [self.soundAlbums addObject:soundAlbum];
            }
            [self.soundAlbumTable reloadData];
            [self hideHUD];
            [self.tableView setHidden:NO];
            BOOL havaData = self.soundAlbums != nil && self.soundAlbums.count > 0;
            [self doAfterRequestSuccess:tableIsFirst AndHavaData:havaData AndNoDataMessage:nil AndHavaMore:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLOG(@"Error: %@", error);
            [self showHUDErrorMessage:@"获取数据失败" duration:3];
        }];
    }
    else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *prams = @{@"page":[NSString stringWithFormat:@"%d",loadMorePageNumber]};
        [manager GET:SELF_SERVER_SOUNDALBUM parameters:prams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *array = (NSArray *)responseObject;
            BOOL havaData = self.soundAlbums != nil && self.soundAlbums.count > 0;
            if (array.count > 0) {
                loadMorePageNumber++;
                for (NSDictionary *soundAlbumDic in array) {
                    SoundAlbum *soundAlbum = [[SoundAlbum alloc] initWithDictionary:soundAlbumDic error:nil];
                    [self.soundAlbums addObject:soundAlbum];
                }
                [self.soundAlbumTable reloadData];
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
