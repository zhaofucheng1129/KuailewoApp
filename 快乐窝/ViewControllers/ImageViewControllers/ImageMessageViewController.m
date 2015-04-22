//
//  ImageMessageViewController.m
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-14.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "ImageMessageViewController.h"
#import "ImageMessage.h"
#import "ImageMessageCell.h"
#import "BeautyGirl.h"

@interface ImageMessageViewController ()
{
    BOOL tableIsFirst;
    int loadMorePageNumber;
}

@property (nonatomic, retain) NSMutableArray *imageMessages;

@end

@implementation ImageMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.channel) {
        case 1:
            self.title = @"段子";
            break;
        case 2:
            self.title = @"美女";
        default:
            break;
    }
    
    [self.imageTableView setScrollsToTop:YES];
    
    [self setNeedRefresh:YES];
    [self initLoadingViewWithTableView:self.imageTableView];
    [self setCustomTableViewDelegate:self];
    
    [self.imageTableView setHidden:YES];
    
    [self requestData:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - NetWork
- (void)getImageMessages
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:SELF_SERVER_IMG parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        self.imageMessages = [[NSMutableArray alloc] initWithCapacity:array.count];
        for (NSDictionary *imageDic in array) {
            ImageMessage *image = [[ImageMessage alloc] initWithDictionary:imageDic error:nil];
            [self.imageMessages addObject:image];
        }
        [self.imageTableView reloadData];
        BOOL havaData = self.imageMessages != nil && self.imageMessages.count > 0;
        [self doAfterRequestSuccess:tableIsFirst AndHavaData:havaData AndNoDataMessage:nil AndHavaMore:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLOG(@"Error: %@", error);
    }];
}

#pragma mark - TableViewDelegate && Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageMessages.count*2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (self.channel == 1 || self.channel == 2) {
        if (indexPath.row % 2 == 0) {
            ImageMessage *imageMsg = [self.imageMessages objectAtIndex:(indexPath.row)/2];
            CGFloat textHeight = [MyHelper heightForString:[NSString stringWithFormat:@"%@",imageMsg.title] fontSize:[UIFont systemFontOfSize:17.0f] andWidth:(MainScreenFrame_Width-8-8)];
            //title的上边距+下边距+image的实际高度*宽度的比例+image的下边距
            height = 8+textHeight+8+[imageMsg.height floatValue]*((MainScreenFrame_Width-8-8)/[imageMsg.width floatValue])+8 + 38;

        }
        else
        {
            height = 8;
        }
    }

    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (self.channel == 1 || self.channel == 2) {
        if (indexPath.row % 2 == 0) {
            cell  = [tableView dequeueReusableCellWithIdentifier:@"imageCellIdentifier"];
            ((ImageMessageCell *)cell).imageMessage = [self.imageMessages objectAtIndex:(indexPath.row)/2];
        }
        else
        {
            cell  = [tableView dequeueReusableCellWithIdentifier:@"MargeCell"];
            [cell setBackgroundColor:[MyHelper colorWithHexString:@"#ededed"]];
        }
        
    }
    
    return cell;
}

#pragma mark - CustomTableViewControllerDelegate
- (void)customTableView:(UITableView *)tableView sendRequset:(BOOL)isFirst
{
    tableIsFirst = isFirst;
    if (self.channel == 1) {
        if (isFirst) {
            [self showHUDIndicatorMessage:@"正在加载..."];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:SELF_SERVER_IMG parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSArray *array = (NSArray *)responseObject;
                self.imageMessages = [[NSMutableArray alloc] initWithCapacity:array.count];
                for (NSDictionary *imageDic in array) {
                    ImageMessage *image = [[ImageMessage alloc] initWithDictionary:imageDic error:nil];
                    [self.imageMessages addObject:image];
                }
                [self.imageTableView reloadData];
                [self.imageTableView setHidden:NO];
                [self hideHUD];
                BOOL havaData = self.imageMessages != nil && self.imageMessages.count > 0;
                [self doAfterRequestSuccess:tableIsFirst AndHavaData:havaData AndNoDataMessage:nil AndHavaMore:YES];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DLOG(@"Error: %@", error);
                [self showHUDErrorMessage:@"获取数据失败" duration:3];
            }];
        }
        else
        {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSDictionary *prams = @{@"before_id":[[self.imageMessages lastObject] item_id]};
            [manager GET:SELF_SERVER_IMG parameters:prams success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSArray *array = (NSArray *)responseObject;
                BOOL havaData = self.imageMessages != nil && self.imageMessages.count > 0;
                if (array.count > 0) {
                    for (NSDictionary *imageDic in array) {
                        ImageMessage *image = [[ImageMessage alloc] initWithDictionary:imageDic error:nil];
                        [self.imageMessages addObject:image];
                    }
                    [self.imageTableView reloadData];
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
    else if (self.channel == 2) {
        if (isFirst) {
            [self showHUDIndicatorMessage:@"正在加载..."];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:SELF_SERVER_BEAUTYIMG parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSArray *array = (NSArray *)responseObject;
                self.imageMessages = [[NSMutableArray alloc] initWithCapacity:array.count];
                for (NSDictionary *imageDic in array) {
                    ImageMessage *image = [[ImageMessage alloc] initWithDictionary:imageDic error:nil];
                    [self.imageMessages addObject:image];
                }
                [self.imageTableView reloadData];
                [self.imageTableView setHidden:NO];
                [self hideHUD];
                BOOL havaData = self.imageMessages != nil && self.imageMessages.count > 0;
                [self doAfterRequestSuccess:tableIsFirst AndHavaData:havaData AndNoDataMessage:nil AndHavaMore:YES];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DLOG(@"Error: %@", error);
                [self showHUDErrorMessage:@"获取数据失败" duration:3];
            }];
        }
        else
        {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSDictionary *prams = @{@"before_id":[[self.imageMessages lastObject] item_id]};
            [manager GET:SELF_SERVER_BEAUTYIMG parameters:prams success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSArray *array = (NSArray *)responseObject;
                BOOL havaData = self.imageMessages != nil && self.imageMessages.count > 0;
                if (array.count > 0) {
                    for (NSDictionary *imageDic in array) {
                        ImageMessage *image = [[ImageMessage alloc] initWithDictionary:imageDic error:nil];
                        [self.imageMessages addObject:image];
                    }
                    [self.imageTableView reloadData];
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
}

@end
