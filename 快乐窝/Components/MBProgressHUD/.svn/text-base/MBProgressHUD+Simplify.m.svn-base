//
//  MBProgressHUD+Simplify.m
//  Tagged
//
//  Created by lc on 2/24/14.
//
//

#import "MBProgressHUD+Simplify.h"

#define SHOW_DURATION_DEFAULT 1

@implementation MBProgressHUD (Simplify)


+ (void)showInView:(UIView *)view message:(NSString *)message
{
    [self showInView:view message:message duration:SHOW_DURATION_DEFAULT];
}

+ (void)showInView:(UIView *)view message:(NSString *)message duration:(NSTimeInterval)duration
{
    [self showInView:view message:message mode:MBProgressHUDModeText duration:duration];
}

#pragma mark -
+ (void)showInViewWithIndicator:(UIView *)view
{
    [self showInView:view indicatorMessage:nil];
}

+ (void)showInView:(UIView *)view indicatorMessage:(NSString *)message
{
    [self showInView:view indicatorMessage:message duration:-1];
}

+ (void)showInView:(UIView *)view indicatorMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [self showInView:view message:message mode:MBProgressHUDModeIndeterminate duration:duration];
}

#pragma mark -

+ (void)showInView:(UIView *)view successMessage:(NSString *)message
{
    [self showInView:view successMessage:message duration:SHOW_DURATION_DEFAULT];
}

+ (void)showInView:(UIView *)view successMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    UIImageView *customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MB-Checkmark"]] autorelease];
    [self showInView:view message:message customView:customView duration:duration];
}

#pragma mark -
+ (void)showInView:(UIView *)view errorMessage:(NSString *)message
{
    [self showInView:view errorMessage:message duration:SHOW_DURATION_DEFAULT];
}

+ (void)showInView:(UIView *)view errorMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    UIImageView *customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MB-Error.png"]] autorelease];
    [self showInView:view message:message customView:customView duration:duration];
}

#pragma mark -
+ (void)showInView:(UIView *)view message:(NSString *)message customView:(UIView *)customView
{
    [self showInView:view message:message customView:customView duration:-1];
}

+ (void)showInView:(UIView *)view message:(NSString *)message customView:(UIView *)customView duration:(NSTimeInterval)duration
{
    MBProgressHUD *HUD = [self prepareHUDForView:view];
    [HUD showMessage:message customView:customView duration:duration];
}

#pragma mark -
+ (void)showInView:(UIView *)view message:(NSString *)message mode:(MBProgressHUDMode)mode
{
    [self showInView:view message:message mode:mode];
}

+ (void)showInView:(UIView *)view message:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration
{
    MBProgressHUD *HUD = [self prepareHUDForView:view];
    [HUD showMessage:message mode:mode duration:duration];
}

#pragma mark -
+ (MBProgressHUD *)prepareHUDForView:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:view];
    if (!HUD) {
        HUD = [[[MBProgressHUD alloc] initWithView:view] autorelease];
    }
    [view addSubview:HUD];
    return HUD;
}

+ (BOOL)hideHUDForView:(UIView *)view
{
    MBProgressHUD *HUD = [self HUDForView:view];
    [HUD hide:YES];
    return HUD != nil;
}

#pragma mark -
#pragma mark -

- (void)showMessage:(NSString *)message
{
    [self showMessage:message duration:SHOW_DURATION_DEFAULT];
}

- (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [self showMessage:message mode:MBProgressHUDModeText duration:duration];
}

#pragma mark -
- (void)showindicator
{
    [self showindicatorMessage:nil];
}

- (void)showindicatorMessage:(NSString *)message
{
    [self showindicatorMessage:message duration:-1];
}

- (void)showindicatorMessage:(NSString *)message duration:(NSTimeInterval)duration
{
     [self showMessage:message mode:MBProgressHUDModeIndeterminate duration:duration];
}

#pragma mark -
- (void)showSuccessWithMessage:(NSString *)message
{
    [self showSuccessWithMessage:message duration:SHOW_DURATION_DEFAULT];
}

- (void)showSuccessWithMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    UIImageView *customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MB-Checkmark"]] autorelease];
    [self showMessage:message customView:customView duration:duration];
}

#pragma mark -
- (void)showErrorWithMessage:(NSString *)message
{
    [self showErrorWithMessage:message duration:SHOW_DURATION_DEFAULT];
}

- (void)showErrorWithMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    UIImageView *customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MB-Error.png"]] autorelease];
    [self showMessage:message customView:customView duration:duration];
}


#pragma mark -
- (void)showMessage:(NSString *)message customView:(UIView *)customView
{
    [self showMessage:message customView:customView duration:-1];
}

- (void)showMessage:(NSString *)message customView:(UIView *)customView duration:(NSTimeInterval)duration
{
    self.customView = customView;
    [self showMessage:message mode:MBProgressHUDModeCustomView duration:duration];
}

#pragma mark -
- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode
{
    [self showMessage:message mode:mode duration:-1];
}

- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration
{
    self.mode = mode;
    self.labelText = message;
    [self show:YES];
    if (self.mode == MBProgressHUDModeText)
    {
        self.yOffset = 100;
    }
    if (duration >= 0)
    {
        [self performSelectorOnMainThread:@selector(hideAfterDelay:) withObject:[NSString stringWithFormat:@"%.2f",duration] waitUntilDone:YES];
    }
}

- (void)hideAfterDelay:(NSString *)duration
{
    [self hide:YES afterDelay:[duration floatValue]];
}

@end
