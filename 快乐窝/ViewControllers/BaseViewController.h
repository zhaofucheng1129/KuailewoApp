//
//  BaseViewController.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-14.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "CustomLoadingView.h"
#import "ErrorInfo.h"


/**************************************************
 * 内容描述: 基类
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-25
 **************************************************/

typedef enum {
    noRequest = 0,//不请求
    refreshRequest,//刷新请求
    loadmoreRequest,//加载请求
} NeedRequsetType;

@protocol CustomTableViewControllerDelegate;
@interface BaseViewController : UIViewController<UIAlertViewDelegate,UIScrollViewDelegate>
{
    
    UITableView *_tableView;
    
    id<CustomTableViewControllerDelegate> _customTableViewDelegate;
    /**
     是否还有下一页数据标准位
     */
    BOOL _havaNextPage;
    
    /**
     是否支持下拉刷新标志位
     */
    BOOL _needRefresh;
    
    /**
     正在刷新标志位
     */
    BOOL _refreshing;
    
    /**
     正在加载标志位
     */
    BOOL _moreLoading;
    
    /**
     是否需要刷新或者加载标志位
     */
    NeedRequsetType _requestType;
    
    /**
     刷新view
     */
    CustomLoadingView *_headView;
    
    /**
     加载view
     */
    CustomLoadingView *_footView;
    
    /**
     刷新view的类型
     */
    LoadingViewStyle _loadingStyle;
    
    /**
     刷新view的key
     */
    NSString *_loadingTimeKey;
    
    /**
     tableStyle
     */
    UITableViewStyle _tableStyle;
    
    /**
     移动前的offsetY
     */
    float _lastOffsetY;
    
    /**
     正在加载标志位
     */
    BOOL _isAnimating;
}

//@property (nonatomic, retain) RightMenuView *rightMenuView;
#pragma mark - TableView刷新 BEGIN
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) id<CustomTableViewControllerDelegate> customTableViewDelegate;
@property (nonatomic, assign) BOOL needRefresh;
@property (nonatomic, assign, readonly) BOOL refreshing;
@property (nonatomic, assign, readonly) BOOL moreLoading;
@property (nonatomic, assign) LoadingViewStyle loadingStyle;
@property (nonatomic, retain) NSString *loadingTimeKey;
@property (nonatomic, assign) UITableViewStyle tableStyle;

/**
 *  为tableView加上下拉刷新组件
 *
 *  @param tableView 目标tableView对象
 */
- (void)initLoadingViewWithTableView:(UITableView *)tableView;

/**
 发送请求，是否是第一次
 */
- (void)requestData:(BOOL)isFirst;

/**
 请求成功后的操作
 */
- (void)doAfterRequestSuccess:(BOOL)isFirst AndHavaMore:(BOOL)havaMore;

- (void)doAfterRequestSuccess:(BOOL)isFirst AndHavaData:(BOOL)havaData AndNoDataMessage:(NSString *)message AndHavaMore:(BOOL)havaMore;

/**
 请求失败后的操作
 */
- (void)doAfterRequsetFailure:(BOOL)isFirst;

/**
 请求失败后的操作
 */
- (void)doAfterRequsetFailure:(BOOL)isFirst errorInfo:(ErrorInfo *)errorInfo;


/**
 显示加载提示
 */
- (void)showLoadingView;

/**
 隐藏加载提示
 */
- (void)hideLoadingView;

/**
 *隐藏headview
 */
- (void)hideHeadLoadingView;

/**
 调整加载更多view
 */
- (void)modifyMoreLoadingView:(float)height;

/**
 将做动画
 */
- (void)willDoAnimating;

/**
 做完动画
 */
- (void)doneAnimating;

#pragma mark - TableView刷新 End
/**
 *  显示后退按钮
 *
 *  @param backButton BOOL
 */
- (void)viewDidLoadWithBackButtom:(BOOL)backButton;

/**
 * 功能描述: 控制tabbar显示或隐藏
 * 输入参数: hidden 是否隐藏
 * 返 回 值: N/A
 */
- (void) hideTabBar:(BOOL) hidden withTime:(float) time;

/**
 * 功能描述: 控制navbar显示或隐藏
 * 输入参数: hidden 是否隐藏
 * 返 回 值: N/A
 */
- (void) hideNavBar:(BOOL) hidden withTime:(float) time;

@end


@protocol CustomTableViewControllerDelegate <NSObject>

@required
- (void)customTableView:(UITableView *)tableView sendRequset:(BOOL)isFirst;

@optional
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (void)tableMoveUp;
- (void)tableMoveDown;
@end
