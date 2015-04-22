//
//  AdFeed.h
//  AdsMoGoFeedsLib
//
//  Created by mogo on 13-12-5.
//  Copyright (c) 2013年 mogo. All rights reserved.
//


@interface AdFeed : NSObject{

}

-(id)initWithAdInf:(NSDictionary *)dict withMoGoID:(NSString *)mogoID;

- (void)perfectionAdContent:(NSDictionary *)dict;
/*
    广告ID
 */
@property(nonatomic,retain,readonly) NSString *adID;


/*
    用户自定义代码
    可为NULL
 */
@property(nonatomic,retain) NSString *customCode;



@property(nonatomic,assign) CGSize adSize;
@property(nonatomic,retain) NSNumber *adType;
@property(nonatomic,retain) NSString *w;
@property(nonatomic,retain) NSString *h;

@property(nonatomic,retain) NSString *imageURL;
@property(nonatomic,retain) NSString *imageHDURL;
@property(nonatomic,retain) NSString *gifURL;
@property(nonatomic,retain) NSString *gifHDURL;
@property(nonatomic,retain) NSString *txtICONURL;
@property(nonatomic,retain) NSString *txtContent;
@property(nonatomic,retain) NSString *htmlContent;

/*
 统计第三方监控的展示URL 数组
 */
@property(nonatomic,retain) NSArray *impURL_ary;
/*
 统计第三方监控的点击URL 数组
 */
@property(nonatomic,retain) NSArray *clkURL_ary;

/*
    返回广告 SIZE
    广告尺寸 单位point
    如果不清楚point，请查看apple IOS开发文档。
 */
-(CGSize)getAdFeedSize;





-(AdFeed *)getAdConent:(NSString *)mogoAuthorKey;

/*
    只返回ADID 调用这个获取广告内容
 */
-(AdFeed *)getAdConentByAdID:(NSString *)mogoAuthorKey;

- (NSString *)getClickURL;
@end
