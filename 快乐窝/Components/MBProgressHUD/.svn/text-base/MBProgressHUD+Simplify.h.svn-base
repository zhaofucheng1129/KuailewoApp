//
//  MBProgressHUD+Simplify.h
//  Tagged
//
//  Created by lc on 2/24/14.
//
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Simplify)

+ (void)showInView:(UIView *)view message:(NSString *)message;
+ (void)showInView:(UIView *)view message:(NSString *)message duration:(NSTimeInterval)duration;


+ (void)showInView:(UIView *)view indicatorMessage:(NSString *)message;
+ (void)showInView:(UIView *)view indicatorMessage:(NSString *)message duration:(NSTimeInterval)duration;


+ (void)showInView:(UIView *)view successMessage:(NSString *)message;
+ (void)showInView:(UIView *)view successMessage:(NSString *)message duration:(NSTimeInterval)duration;


+ (void)showInView:(UIView *)view errorMessage:(NSString *)message;
+ (void)showInView:(UIView *)view errorMessage:(NSString *)message duration:(NSTimeInterval)duration;


+ (void)showInView:(UIView *)view message:(NSString *)message customView:(UIView *)customView;
+ (void)showInView:(UIView *)view message:(NSString *)message customView:(UIView *)customView duration:(NSTimeInterval)duration;


+ (void)showInView:(UIView *)view message:(NSString *)message mode:(MBProgressHUDMode)mode;
+ (void)showInView:(UIView *)view message:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration;

+ (BOOL)hideHUDForView:(UIView *)view;
+ (MBProgressHUD *)prepareHUDForView:(UIView *)view;

//////////////////////////////////////
//////////////////////////////////////
- (void)showMessage:(NSString *)message;
- (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration;


- (void)showindicatorMessage:(NSString *)message;
- (void)showindicatorMessage:(NSString *)message duration:(NSTimeInterval)duration;


- (void)showSuccessWithMessage:(NSString *)message;
- (void)showSuccessWithMessage:(NSString *)message duration:(NSTimeInterval)duration;


- (void)showErrorWithMessage:(NSString *)message;
- (void)showErrorWithMessage:(NSString *)message duration:(NSTimeInterval)duration;


- (void)showMessage:(NSString *)message customView:(UIView *)customView;
- (void)showMessage:(NSString *)message customView:(UIView *)customView duration:(NSTimeInterval)duration;

- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode;
- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration;

@end
