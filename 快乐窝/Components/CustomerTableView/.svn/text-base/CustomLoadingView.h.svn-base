//
//  CustomLoadingView.h
//  PanliApp
//
//  Created by liubin on 13-4-28.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum
{
	Pulling = 0,
	Normal,
	Loading,	
} LoadingState;

typedef enum{
	head_none = 0,//只有提示语，头部加载view
    head_refreshTime,//刷新时间，头部加载view
    foot_none//底部加载view	
} LoadingViewStyle;

@interface CustomLoadingView : UIView {
    
    LoadingState _state;
    LoadingViewStyle _style;
    NSString *_timeKey;
    
    CALayer *_arrowImage;
    UIActivityIndicatorView *_activityView;
    UILabel *_tipLabel;
    UILabel *_timeLabel;
}

@property (nonatomic, retain) NSString * string_UP;
@property (nonatomic, retain) NSString * string_Down;

- (id)initWithFrame:(CGRect)frame andType:(LoadingViewStyle)style andKey:(NSString *)key imageDown:(UIImage*)image_Down imageUp:(UIImage*)imageUp;
- (id)initWithFrame:(CGRect)frame andType:(LoadingViewStyle)style andKey:(NSString *)key andFont:(UIFont*)font;
- (void)changeState:(LoadingState)state;

@end
