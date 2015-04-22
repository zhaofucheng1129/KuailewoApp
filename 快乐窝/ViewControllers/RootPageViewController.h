//
//  ViewController.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/3.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XHDidChangedPageBlock)(NSInteger currentPage, NSString *title);

@interface RootPageViewController : UIViewController

/**
 *  改变页码的回调
 */
@property (nonatomic, copy) XHDidChangedPageBlock didChangedPageCompleted;

/**
 *  对于iOS的Cocotouch的设计，UITabbarController，最做支持5个控制器，多余的会以more来代替，可以见的5个是比较正常的内存管理方案，所以这里提倡最大5个控制器的使用
 */
@property (nonatomic, strong) NSArray *viewControllers;


/**
 *  获取当前页码
 *
 *  @return 返回当前页码
 */
- (NSInteger)getCurrentPageIndex;

/**
 *  设置当前页面为你想要的页码
 *
 *  @param currentPage 目标页码
 *  @param animated    是否动画的设置
 */
- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

@end

