//
//  CustomLoadingView.m
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-14.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "CustomLoadingView.h"
#import "MyHelper.h"

@implementation CustomLoadingView

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_timeKey);
    SAFE_RELEASE(_activityView);
    SAFE_RELEASE(_tipLabel);
    SAFE_RELEASE(_timeLabel);
    SAFE_RELEASE(_string_Down);
    SAFE_RELEASE(_string_UP);
    _arrowImage = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame andType:(LoadingViewStyle)style andKey:(NSString *)key imageDown:(UIImage*)image_Down imageUp:(UIImage*)imageUp
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        _style = style;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = COLOR_CLEAR;
        
        switch (_style)
        {
            case head_none:
            {
                _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, frame.size.width, 40.0f)];
                _tipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                _tipLabel.font = [UIFont boldSystemFontOfSize:13.0f];
                _tipLabel.textColor = [MyHelper colorWithHexString:@"#89afe9"];
                _tipLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
                _tipLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
                _tipLabel.backgroundColor = COLOR_CLEAR;
                _tipLabel.textAlignment = NSTextAlignmentCenter;
                _tipLabel.text = @"下拉刷新...";
                [self addSubview:_tipLabel];
            }
                break;
            case foot_none:
            {
                _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.frame.size.width, 40.0f)];
                _tipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                _tipLabel.font = [UIFont boldSystemFontOfSize:13.0f];
                _tipLabel.textColor = [MyHelper colorWithHexString:@"#89afe9"];
                _tipLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
                _tipLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
                _tipLabel.backgroundColor = COLOR_CLEAR;
                _tipLabel.textAlignment = NSTextAlignmentCenter;
                _tipLabel.text = @"上拉载入更多...";
                [self addSubview:_tipLabel];
            }
                break;
            case head_refreshTime:
            {
                _timeKey = key;
                
                _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, frame.size.width, 20.0f)];
                _tipLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                _tipLabel.font = [UIFont boldSystemFontOfSize:13.0f];
                _tipLabel.textColor = [MyHelper colorWithHexString:@"#89afe9"];
                _tipLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
                _tipLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
                _tipLabel.backgroundColor = COLOR_CLEAR;
                _tipLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:_tipLabel];
                
                _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 40.0f, self.frame.size.width, 20.0f)];
                _timeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                _timeLabel.font = [UIFont boldSystemFontOfSize:13.0f];
                _timeLabel.textColor = [MyHelper colorWithHexString:@"#89afe9"];
                _timeLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
                _timeLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
                _timeLabel.backgroundColor = COLOR_CLEAR;
                _timeLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:_timeLabel];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                NSString *refreshTime = [defaults stringForKey:key];
                
                if (refreshTime != nil && ![refreshTime isEqualToString:@""])
                {
                    _timeLabel.text = refreshTime;
                }
                else
                {
                    
                    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
                    [dateFormatter setDateFormat:@"最近刷新：yyyy-MM-dd HH:mm"];
                    
                    _timeLabel.text = [dateFormatter stringFromDate:[NSDate date]];
                }
            }
                break;
            default:
                break;
        }
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(image_Down ? (style == foot_none ? 100 : 110): 90,
                                     image_Down ? (frame.size.height - image_Down.size.height )/2 : (frame.size.height - 23.0f)/2,
                                     image_Down ? image_Down.size.width : 16.0f,
                                     image_Down ? image_Down.size.height :23.0f);
        layer.contentsGravity = kCAGravityResizeAspect;
        
        if (style != foot_none)
        {
            layer.contents =  image_Down ? (id)image_Down.CGImage : (id)[UIImage imageNamed: @"arrow_down"].CGImage;
        }
        else
        {
            layer.contents =  imageUp ?  (id)imageUp.CGImage : (id)[UIImage imageNamed:@"arrow_up"].CGImage;
        }
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
	
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
		
		_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityView.frame = CGRectMake(image_Down ? 100 : 80.f,(frame.size.height - 20.0f)/2, 20.0f, 20.0f);
		[self addSubview:_activityView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andType:(LoadingViewStyle)style andKey:(NSString *)key andFont:(UIFont *)font
{
    self = [self initWithFrame:frame andType:style andKey:key imageDown:nil imageUp:nil];
    _tipLabel.font = font;
    _tipLabel.shadowColor = COLOR_CLEAR;
    _tipLabel.textColor = [MyHelper colorWithHexString:@"#89afe9"];
    _arrowImage.frame = CGRectMake(0, 0, 0, 0);
    [_activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    return self;
}

- (void)updateRefreshTimeAndLocation{
    if (_style == head_refreshTime) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"最近刷新：yyyy-MM-dd HH:mm"];
        [defaults setValue:[dateFormatter stringFromDate:[NSDate date]] forKey:_timeKey];
        
        _timeLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    }
}

- (void)changeState:(LoadingState)state
{
    switch (state) {
		case Pulling:
            
            if (_style != foot_none) {
                _tipLabel.text = @"松开刷新...";
            }else{
                _tipLabel.text = @"松开载入更多...";
            }
			
			[CATransaction begin];
			[CATransaction setAnimationDuration:0.18f];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			
			break;
		case Normal:
            
            if (_style != foot_none) {
                _tipLabel.text = @"下拉刷新...";
            }else{
                _tipLabel.text = @"上拉载入更多...";
            }
			
			if (_state == Pulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:0.18f];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			break;
		case Loading:
			
            if (_style != foot_none) {
                _tipLabel.text = @"正在刷新...";
            }else{
                _tipLabel.text = @"正在载入更多...";
            }
            
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = YES;
			[CATransaction commit];
            
            [self updateRefreshTimeAndLocation];
			
			break;
		default:
			break;
	}
	
	_state = state;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
