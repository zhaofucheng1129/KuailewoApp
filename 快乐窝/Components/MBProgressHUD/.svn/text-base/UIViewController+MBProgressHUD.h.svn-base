//
//  UIViewController+MBProgressHUD.h
//  MBProgressHUDSimplify
//
//  Created by clovelu on 3/6/14.
//  Copyright (c) 2014 lc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+Simplify.h"

@interface UIViewController (MBProgressHUD)
- (void)showHUDMessage:(NSString *)message;
- (void)showHUDMessage:(NSString *)message duration:(NSTimeInterval)duration;

- (void)showHUDIndicator;
- (void)showHUDIndicatorMessage:(NSString *)message;
- (void)showHUDIndicatorMessage:(NSString *)message duration:(NSTimeInterval)duration;


- (void)showHUDSuccessMessage:(NSString *)message;
- (void)showHUDSuccessMessage:(NSString *)message duration:(NSTimeInterval)duration;


- (void)showHUDErrorMessage:(NSString *)message;
- (void)showHUDErrorMessage:(NSString *)message duration:(NSTimeInterval)duration;

- (void)showHUDProgress:(CGFloat)progress;
- (void)showHUDAnnularProgress:(CGFloat)progress;
- (void)showHUDHorizontalProgress:(CGFloat)progress;
- (void)showHUDProgress:(CGFloat)progress message:(NSString *)message mode:(MBProgressHUDMode)mode;

- (void)showHUDMessage:(NSString *)message customView:(UIView *)customView;
- (void)showHUDMessage:(NSString *)message customView:(UIView *)customView duration:(NSTimeInterval)duration;

- (void)showHUDMessage:(NSString *)message mode:(MBProgressHUDMode)mode;
- (void)showHUDMessage:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration;

- (MBProgressHUD *)HUD;
- (BOOL)hideHUD;

@end
