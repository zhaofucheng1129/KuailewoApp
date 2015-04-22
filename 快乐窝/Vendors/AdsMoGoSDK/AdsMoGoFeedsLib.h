//
//  AdsMoGoFeedsLib.h
//  AdsMoGoFeedsLib
//
//  Created by mogo on 13-12-5.
//  Copyright (c) 2013年 mogo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdFeed.h"

typedef enum
{
    FeedAdIPhone=1,
	FeedAdIPad=3,
}AdsMoGoFeedType;

typedef enum {
    FeedAdImage=1, // 图片
    FeedAdImageAndText=2, // 图文
    FeedAdHtml=6, // Html
    FeedAdGif=7, // Gif
    FeedAdCustom=9, // 自定义
}AdsMoGoFeedRequestType;
@class AdsMoGoFeedsLib;
@protocol AdsMoGoFeedsLibDelegate <NSObject>
@required

/*
    信息流广告类型
    在requestFeedList时调用
 */
-(AdsMoGoFeedType) feedAdRequestType;


/*
    信息流广告的尺寸
    在requestFeedList时调用
 */
-(CGSize) adSize;

/*
    需要信息流广告的物料数量
    在requestFeedList时调用
    返回O 表示返回所有广告
 */
-(int) feedAdMaxNum;

/*
    获取芒果信息流广告请求类型
 */
- (AdsMoGoFeedRequestType) getAdFeedRequestType;

/*
    是否返回广告内容
    如果返回NO,需要调用AdFeed中getAdConent 获取广告内容。
 */
- (BOOL)isResturnAdContent;
@optional

/*
 获取芒果信息流广告成功回调
 feedsLib:信息流广告库对象
 */
-(void) getAdMoGoFeedsListSuccess:(AdsMoGoFeedsLib *)feedsLib;

/*
    获取芒果信息流广告失败回调
 */
-(void)getAdMoGoFeedsListWithError:(NSError *)error;

-(void) getAdMoGoFeedSuccess:(AdFeed *)feed;

-(void) getAdMoGoFeedError:(NSError *)error;
@end


@interface AdsMoGoFeedsLib : NSObject
@property(nonatomic,assign) id<AdsMoGoFeedsLibDelegate> delegate;
/*
    初始化请求信息流
    mogoID:芒果ID
 */
- (id)initAdsMoGoFeedWithMoGoID:(NSString *)mogoid;

/*
    请求信息流广告
 */
-(void)requestFeedList;

/*
    获取信息流广告内容
    feedIndex：信息流广告编号 从0开始
 */
- (void)getFeedByIndex:(int)feedIndex;

/*
    随机获取信息流广告
 */
- (void)getFeedRandom;

/*
    返回实际获取的feed数量
 */
- (int) getCountForFeeds;

- (NSString *) debugResultJSON;
@end
