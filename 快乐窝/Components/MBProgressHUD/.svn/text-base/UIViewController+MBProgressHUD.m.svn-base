//
//  UIViewController+HUD.m
//  HUDSimplify
//
//  Created by clovelu on 3/6/14.
//  Copyright (c) 2014 lc. All rights reserved.
//

#import "UIViewController+MBProgressHUD.h"

#define SHOW_DURATION_DEFAULT 1.8f

@implementation UIViewController (HUD)

- (void)showHUDMessage:(NSString *)message
{
    [self showHUDMessage:message duration:SHOW_DURATION_DEFAULT];
}

- (void)showHUDMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [self showHUDMessage:message mode:MBProgressHUDModeText duration:duration];
}

#pragma mark - 
- (void)showHUDIndicator
{
    [self showHUDIndicatorMessage:nil];
}

- (void)showHUDIndicatorMessage:(NSString *)message
{
    [self showHUDIndicatorMessage:message duration:-1];
}

- (void)showHUDIndicatorMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [self showHUDMessage:message mode:MBProgressHUDModeIndeterminate duration:duration];
}

#pragma mark -
- (void)showHUDProgress:(CGFloat)progress
{
    [self showHUDProgress:progress message:nil mode:MBProgressHUDModeDeterminate];
}

- (void)showHUDAnnularProgress:(CGFloat)progress
{
     [self showHUDProgress:progress message:nil mode:MBProgressHUDModeAnnularDeterminate];
}

- (void)showHUDHorizontalProgress:(CGFloat)progress
{
    [self showHUDProgress:progress message:nil mode:MBProgressHUDModeDeterminateHorizontalBar];
}

- (void)showHUDProgress:(CGFloat)progress message:(NSString *)message mode:(MBProgressHUDMode)mode
{
    NSTimeInterval duration = progress > 0.99 ? 0 : -1;
    [self showHUDMessage:message mode:mode duration:duration];
    self.HUD.progress = progress;
}

#pragma mark -
- (void)showHUDSuccessMessage:(NSString *)message
{
    [self showHUDSuccessMessage:message duration:SHOW_DURATION_DEFAULT];
}

- (void)showHUDSuccessMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    UIImageView *customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MB-Checkmark"]] autorelease];
    [self showHUDMessage:message customView:customView duration:duration];
}

#pragma mark -
- (void)showHUDErrorMessage:(NSString *)message
{
    [self showHUDErrorMessage:message duration:SHOW_DURATION_DEFAULT];
}

- (void)showHUDErrorMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    UIImageView *customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MB-Error.png"]] autorelease];
    [self showHUDMessage:message customView:customView duration:duration];
}


#pragma mark -
- (void)showHUDMessage:(NSString *)message customView:(UIView *)customView
{
    [self showHUDMessage:message customView:customView duration:-1];
}

- (void)showHUDMessage:(NSString *)message customView:(UIView *)customView duration:(NSTimeInterval)duration
{
    [self.HUD showMessage:message customView:customView duration:duration];
}

#pragma mark -
- (void)showHUDMessage:(NSString *)message mode:(MBProgressHUDMode)mode
{
    [self showHUDMessage:message mode:mode duration:-1];
}

- (void)showHUDMessage:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration
{
    [self.HUD showMessage:message mode:mode duration:duration];
}

#pragma mark -
- (MBProgressHUD *)HUD
{
    return [MBProgressHUD prepareHUDForView:self.view];
}

- (BOOL)hideHUD
{
    return [MBProgressHUD hideHUDForView:self.view];
}

@end
