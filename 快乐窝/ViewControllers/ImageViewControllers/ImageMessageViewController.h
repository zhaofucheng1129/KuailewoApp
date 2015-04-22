//
//  ImageMessageViewController.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-14.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageMessageViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CustomTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *imageTableView;

@property (nonatomic, assign) int channel; //1：趣图 2：美女

@end
