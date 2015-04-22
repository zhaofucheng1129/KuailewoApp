//
//  BaseViewController.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-14.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "BaseViewController.h"
#import "ErrorInfo.h"
#import "AppDelegate.h"
#import "MyHelper.h"
#import "UIViewController+ScrollingNavbar.h"
#import "RootPageViewController.h"

@implementation BaseViewController

@synthesize tableView = _tableView;
@synthesize customTableViewDelegate = _customTableViewDelegate;
@synthesize needRefresh = _needRefresh;
@synthesize refreshing = _refreshing;
@synthesize moreLoading = _moreLoading;
@synthesize loadingStyle = _loadingStyle;
@synthesize loadingTimeKey = _loadingTimeKey;
@synthesize tableStyle = _tableStyle;

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**
 *  为tableView加上下拉刷新组件
 *
 *  @param tableView 目标tableView对象
 */
- (void)initLoadingViewWithTableView:(UITableView *)tableView
{
    _tableView = tableView;
    
    
    _havaNextPage = NO;
    
//    _needRefresh = YES;//默认为YES
    
    _refreshing = NO;
    _moreLoading = NO;
    _isAnimating = NO;
    
    _requestType = noRequest;
    
    _loadingStyle = head_none;//默认只有提示
    _loadingTimeKey = nil;
    
    _lastOffsetY = 0.0f;
    
    _tableStyle = UITableViewStylePlain;
    
    if (_needRefresh)
    {
        _headView = [[CustomLoadingView alloc] initWithFrame:CGRectMake(0, -80, 320, 80) andType:_loadingStyle andKey:_loadingTimeKey imageDown:nil imageUp:nil];
        [tableView addSubview:_headView];
        
    }

}

- (void)requestData:(BOOL)isFirst
{
    if (isFirst)
    {
//        [self showLoadingView];
    }
    else
    {
        _refreshing = NO;
        _moreLoading = YES;
        
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 80, 0)];
        [_tableView setContentOffset:CGPointMake(0, _tableView.contentSize.height - _tableView.frame.size.height + 80)];
        [_footView changeState:Loading];
    }
    
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(customTableView:sendRequset:)])
    {
        [_customTableViewDelegate customTableView:_tableView sendRequset:isFirst];
    }
}

- (void)doAfterRequestSuccess:(BOOL)isFirst AndHavaMore:(BOOL)havaMore
{
//    _noServiceErrorView.hidden = YES;
//    _noHaveDataView.hidden = YES;
    [self.view bringSubviewToFront:_tableView];
    _havaNextPage = havaMore;
    if (isFirst)
    {
        if (!_needRefresh)
        {
            [UIView animateWithDuration:0.3f animations:^{
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            } completion:^(BOOL finished){
                if (finished) {
                    _headView.hidden = YES;
                }
            }];
        }
        if (_havaNextPage)
        {
            if (!_footView) {
                _footView = [[CustomLoadingView alloc] initWithFrame:CGRectMake(0, _tableView.contentSize.height, 320, 80) andType:foot_none andKey:nil imageDown:nil imageUp:nil];
                [_tableView addSubview:_footView];
            }else{
                _footView.hidden = NO;
                _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
            }
        }
        else
        {
            if (_footView != nil)
            {
                _footView.hidden = YES;
            }
        }
        
    }
    else
    {
        _moreLoading = NO;
        if (_havaNextPage)
        {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
            [_footView changeState:Normal];
        }
        else
        {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            _footView.hidden = YES;
        }
        
    }
}

- (void)doAfterRequestSuccess:(BOOL)isFirst AndHavaData:(BOOL)havaData AndNoDataMessage:(NSString *)message AndHavaMore:(BOOL)havaMore
{
//    _noServiceErrorView.hidden = YES;
//    _noHaveDataView.hidden = YES;
//    
//    if(self.emptyView != nil)
//    {
//        for (UIView *view in _tableView.subviews)
//        {
//            if (view.tag == self.emptyView.tag)
//            {
//                [view removeFromSuperview];
//            }
//        }
//    }
    
    if (havaData)
    {
        [self.view bringSubviewToFront:_tableView];
        _havaNextPage = havaMore;
        if (isFirst)
        {
            if (!_needRefresh)
            {
                [UIView animateWithDuration:0.3f animations:^{
                    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                } completion:^(BOOL finished){
                    if (finished) {
                        _headView.hidden = YES;
                    }
                }];
            }
            
            if (_havaNextPage)
            {
                if (_footView == nil) {
                    _footView = [[CustomLoadingView alloc] initWithFrame:CGRectMake(0, _tableView.contentSize.height, 320, 80) andType:foot_none andKey:nil imageDown:nil imageUp:nil];
                    [_tableView addSubview:_footView];
                }else{
                    _footView.hidden = NO;
                    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                    _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
                    [_footView changeState:Normal];
                }
            }
            else
            {
                if (_footView != nil)
                {
                    _footView.hidden = YES;
                }
            }
        }
        else
        {
            _moreLoading = NO;
            if (_havaNextPage)
            {
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
                [_footView changeState:Normal];
            }
            else
            {
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                _footView.hidden = YES;
            }
        }
    }
//    else
//    {
//        if(self.emptyView == nil)
//        {
//            _noHaveDataView.frame = CGRectMake(0.0f, 0.0f + _tableView.tableHeaderView.frame.size.height/2, _tableView.frame.size.width,_tableView.frame.size.height);
//            if ([NSString isEmpty:message])
//            {
//                _labelNoData.text = LocalizedString(@"CustomTableViewController_labelNoData",@"暂无相关数据");
//            }
//            else
//            {
//                _labelNoData.text = message;
//            }
//            _noHaveDataView.hidden = NO;
//        }
//        else
//        {
//            [_tableView addSubview:self.emptyView];
//        }
//    }
}

- (void)doAfterRequsetFailure:(BOOL)isFirst{
    
    [self doAfterRequsetFailure:isFirst errorInfo:nil];
}

- (void)doAfterRequsetFailure:(BOOL)isFirst errorInfo:(ErrorInfo *)errorInfo
{
    //第一次请求就出错
    if (errorInfo != nil && isFirst)
    {
        _moreLoading = NO;
        //重置fotter 状态
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
        [_footView changeState:Normal];
        _refreshing = NO;
        _havaNextPage = NO;
        _footView.hidden = YES;
        DLOG(@"%@",_tableView.tableHeaderView);
//        _noServiceErrorView.frame = CGRectMake(0.0f, 0.0f + _tableView.tableHeaderView.frame.size.height/2, _tableView.frame.size.width,_tableView.frame.size.height);
//        _noServiceErrorView.hidden = NO;
//        _errorLabelBottom.text = [NSString stringWithFormat:LocalizedString(@"CustomTableViewController_errorLabelBottom",@" (错误代码:%d) "),errorInfo.code];
//        _errorLabelBottom.textAlignment = UITextAlignmentCenter;
//        _errorLabelBottom.font = [UIFont systemFontOfSize:14];
//        _errorLabelBottom.textColor = [PanliHelper colorWithHexString:@"a4a4a4"];
        [_headView changeState:Normal];
        return;
    }
    if (isFirst)
    {
        if (!_needRefresh)
        {
            [UIView animateWithDuration:0.3f animations:^{
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            } completion:^(BOOL finished){
                if (finished) {
                    _headView.hidden = YES;
                }
            }];
        }
        if (_footView != nil)
        {
            _footView.hidden = YES;
            _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
        }
    }
    else
    {
        _moreLoading = NO;
        
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
        [_footView changeState:Normal];
    }
    [self showHUDErrorMessage:errorInfo.message];
}

- (void)showLoadingView
{
    _refreshing = YES;
    _moreLoading = NO;
    if (_needRefresh)
    {
        if (_headView == nil)
        {
            _headView = [[CustomLoadingView alloc] initWithFrame:CGRectMake(0, -80, 320, 80) andType:_loadingStyle andKey:_loadingTimeKey imageDown:nil imageUp:nil];
            [_tableView addSubview:_headView];
        }
        else
        {
            _headView.hidden = NO;
        }
        [_headView changeState:Loading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [_tableView setContentInset:UIEdgeInsetsMake(80, 0, 0, 0)];
        [_tableView setContentOffset:CGPointMake(0, -80)];
        [UIView commitAnimations];
    }
}

- (void)hideLoadingView
{
    _refreshing = NO;
    _lastOffsetY = 0.0f;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [UIView commitAnimations];
}

- (void)hideHeadLoadingView
{
    _refreshing = NO;
    _lastOffsetY = 0.0f;
    if(_headView)
    {
        _headView.hidden = YES;
    }
}

- (void)modifyMoreLoadingView:(float)height
{
    if (_footView)
    {
        if(height)
        {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            _footView.frame = CGRectMake(0, height, 320, 80);
            [_footView changeState:Normal];
        }
        else
        {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
            [_footView changeState:Normal];
        }
    }
}

- (void)willDoAnimating
{
    _isAnimating = YES;
}

- (void)doneAnimating
{
    _isAnimating = NO;
}

#pragma mark - ScrollView delegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _lastOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!_refreshing && !_moreLoading && !_isAnimating) {
        
        if (scrollView.contentOffset.y > _lastOffsetY){
            
            if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableMoveUp)]) {
                [_customTableViewDelegate tableMoveUp];
            }
            
        } else if (scrollView.contentOffset.y < _lastOffsetY){
            
            if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableMoveDown)]) {
                [_customTableViewDelegate tableMoveDown];
            }
        }
        
        if ([self.parentViewController isKindOfClass:[RootPageViewController class]]) {
            if (scrollView.contentOffset.y != 0) {
                [self.parentViewController setShouldScrollWhenContentFits:YES];
            }
        }
        
        if (scrollView.contentOffset.y < 0) {
            
            if (_needRefresh) {
                
                if (scrollView.contentOffset.y > -60) {
                    
                    [_headView changeState:Normal];
                    _requestType = noRequest;
                    
                    _lastOffsetY = 0.0f;
                }else if (scrollView.contentOffset.y <= -60) {
                    
                    [_headView changeState:Pulling];
                    _requestType = refreshRequest;
                }
            }
            
        }else if (scrollView.contentOffset.y > 0){
            
            if (_havaNextPage && scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) {
                
                if (scrollView.contentOffset.y + scrollView.frame.size.height < scrollView.contentSize.height + 60 ) {
                    
                    [_footView changeState:Normal];
                    _requestType = noRequest;
                    
                    _lastOffsetY = _tableView.contentSize.height - _tableView.frame.size.height;
                }else if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height + 60) {
                    
                    [_footView changeState:Pulling];
                    _requestType = loadmoreRequest;
                }
            }
            
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerat
{
    if (!_refreshing && !_moreLoading && !_isAnimating) {
        
        if (_requestType == refreshRequest) {
            
            _requestType = noRequest;
            
            [self requestData:YES];
            
        }else if (_requestType == loadmoreRequest) {
            
            _requestType = noRequest;
            
            [self requestData:NO];
        }
    }
}


/**
 * 功能描述: 重写viewdidload
 * 输入参数: backButton 是否需要左边返回按钮
 * 返 回 值: N/A
 */
- (void)viewDidLoadWithBackButtom:(BOOL)backButton
{
    [super viewDidLoad];
    self.HUD.yOffset = -50;
    self.view.backgroundColor = [MyHelper colorWithHexString:@"#ededed"];
    [self setBarButtonItem:backButton];
}
- (void)setBarButtonItem:(BOOL)isBack
{
    //是否显示返回按钮
    if (isBack)
    {
        UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 54.0f, 44.0f);
        btn_nav_back.tag = 999;
        [btn_nav_back setImage:[UIImage imageNamed:@"icon_back"]forState:UIControlStateNormal];
        [btn_nav_back setImage:[UIImage imageNamed:@"icon_back_highlighted"] forState:UIControlStateHighlighted];
        btn_nav_back.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, 0, 0, 0) : UIEdgeInsetsZero;
        [btn_nav_back addTarget:self action:@selector(barButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
        self.navigationItem.leftBarButtonItem = btn_Left;
        [btn_Left release];
    }
    else
    {
        [self.navigationItem setHidesBackButton:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (SYSTEM_VERSION_GREATER_THAN(@"6.0"))
    {
        // 非正在使用的视图
        if (![self.view window])
        {
            // 使再次进入时能够重新加载调用loadView,viewDidLoad
//            [self viewDidUnload];
            self.view = nil;
        }
    }
}


/**
 * 功能描述: 导航按钮事件
 * 输入参数: 按钮
 * 返 回 值: N/A
 */
- (void)barButtonItemClick:(UIButton *)btn
{
    if (btn.tag == 999)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - tabbar and navbar
/**
 * 功能描述: 控制tabbar显示或隐藏
 * 输入参数: hidden 是否隐藏
 * 返 回 值: N/A
 */
- (void) hideTabBar:(BOOL) hidden withTime:(float)time
{
    [UIView animateWithDuration:time animations:^{
        for(UIView *view in self.tabBarController.view.subviews)
        {
            if([view isKindOfClass:[UITabBar class]])
            {
                if (hidden)
                {
                    [view setFrame:CGRectMake(view.frame.origin.x, MainScreenFrame_Height + UI_STATUS_BAR_HEIGHT, view.frame.size.width, view.frame.size.height)];
                }
                else
                {
                    [view setFrame:CGRectMake(view.frame.origin.x, MainScreenFrame_Height + UI_STATUS_BAR_HEIGHT - UI_TAB_BAR_HEIGHT, view.frame.size.width, view.frame.size.height)];
                }
            }
            else
            {
                if (hidden)
                {
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, MainScreenFrame_Height + UI_STATUS_BAR_HEIGHT)];
                }
                else
                {
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, MainScreenFrame_Height + UI_STATUS_BAR_HEIGHT - UI_TAB_BAR_HEIGHT)];
                }
            }
        }
    }];
}

/**
 * 功能描述: 控制navbar显示或隐藏
 * 输入参数: hidden 是否隐藏
 * 返 回 值: N/A
 */
- (void) hideNavBar:(BOOL) hidden withTime:(float)time
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:time];    
    for(UIView *view in self.navigationController.view.subviews)
    {
        if([view isKindOfClass:[UINavigationBar class]])
        {
            if (hidden)
            {
                [view setFrame:CGRectMake(view.frame.origin.x, -44.0f, view.frame.size.width, view.frame.size.height)];
            }
            else
            {

                [view setFrame:CGRectMake(view.frame.origin.x, IS_IOS7 ? 20.0f : 0.0f, view.frame.size.width, view.frame.size.height)];

            }
        }
    }
    [UIView commitAnimations];
}


- (void)backToHomePage
{
    if (self.tabBarController)
    {
        self.tabBarController.selectedIndex = 0;
    }
}


@end
