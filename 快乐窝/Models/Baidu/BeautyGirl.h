//
//  BeautyGirl.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/24.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

#import "BaseModel.h"

@interface BeautyGirl : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSDictionary *owner;
@property (nonatomic, copy) NSString *fromPageTitle;
@property (nonatomic, copy) NSString *column;
@property (nonatomic, copy) NSString *parentTag;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *downloadUrl;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) NSNumber *imageWidth;
@property (nonatomic, strong) NSNumber *imageHeight;
@property (nonatomic, copy) NSString *thumbnailUrl;
@property (nonatomic, strong) NSNumber *thumbnailWidth;
@property (nonatomic, strong) NSNumber *thumbnailHeight;
@property (nonatomic, copy) NSString *thumbLargeUrl;
@property (nonatomic, strong) NSNumber *thumbLargeWidth;
@property (nonatomic, strong) NSNumber *thumbLargeHeight;
@property (nonatomic, copy) NSString *thumbLargeTnUrl;
@property (nonatomic, strong) NSNumber *thumbLargeTnWidth;
@property (nonatomic, strong) NSNumber *thumbLargeTnHeight;
@property (nonatomic, copy) NSString *siteName;
@property (nonatomic, copy) NSString *siteLogo;
@property (nonatomic, copy) NSString *siteUrl;
@property (nonatomic, copy) NSString *fromUrl;
@property (nonatomic, copy) NSString *isBook;
@property (nonatomic, copy) NSString *bookId;
@property (nonatomic, copy) NSString *objUrl;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *setId;
@property (nonatomic, copy) NSString *albumId;
@property (nonatomic, strong) NSNumber *isAlbum;
@property (nonatomic, copy) NSString *albumName;
@property (nonatomic, strong) NSNumber *albumNum;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, strong) NSNumber *isVip;
@property (nonatomic, strong) NSNumber *isDapei;
@property (nonatomic, copy) NSString *dressId;
@property (nonatomic, copy) NSString *dressBuyLink;
@property (nonatomic, strong) NSNumber *dressPrice;
@property (nonatomic, strong) NSNumber *dressDiscount;
@property (nonatomic, copy) NSString *dressExtInfo;
@property (nonatomic, copy) NSString *dressTag;
@property (nonatomic, strong) NSNumber *dressNum;
@property (nonatomic, copy) NSString *objTag;
@property (nonatomic, strong) NSNumber *dressImgNum;
@property (nonatomic, copy) NSString *hostName;
@property (nonatomic, copy) NSString *pictureId;
@property (nonatomic, copy) NSString *pictureSign;
@property (nonatomic, copy) NSString *dataSrc;
@property (nonatomic, copy) NSString *contentSign;
@property (nonatomic, copy) NSString *albumDi;
@property (nonatomic, copy) NSString *canAlbumId;
@property (nonatomic, copy) NSString *albumObjNum;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *photoId;
@property (nonatomic, strong) NSNumber *fromName;
@property (nonatomic, copy) NSString *fashion;
@property (nonatomic, copy) NSString *title;




@end
