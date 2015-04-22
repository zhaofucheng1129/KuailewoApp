//
//  AdChinaSShareAdapterQQ.m
//  AdChinaSShareKit
//
//  Created by mogo_wenyand on 13-12-6.
//  Copyright (c) 2013年 Daxiong. All rights reserved.
//

#import "AdChinaSShareAdapterQQ.h"
#import "AdChinaSSharePlatformRegistry.h"
 

#define  NOTFONTQQMESSAGE   @"您未安装QQ"
#define  NOTFONTOPENAPIMESSAGE   @"您安装的QQ版本不支持OpenApi"

#define showMessageAlert(title,msg,del,cancelTitle,otherTitle)			[[[[UIAlertView alloc] initWithTitle:title message:msg delegate:del cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil] autorelease] show]


@interface AdChinaSShareAdapterQQ()<TencentSessionDelegate,QQApiInterfaceDelegate>{
     id  thumImageTmp;
}
@end


@implementation AdChinaSShareAdapterQQ
+ (void)load{
    [[AdChinaSSharePlatformRegistry sharedRegistry] registerClass:self];
}

+ (int)registryType{
    return AdChinaSShareAdapterTypeSinaQQfriend;
    
}
 static AdChinaSShareAdapterQQ * adapterQQ;
+(AdChinaSShareAdapterQQ*)shareMyClass{
    return adapterQQ;
}

- (void)share{
    adapterQQ =self;
    if([self.infoData objectForKey:k_AdChinaSShareKitQQClientId]){
       tencentOAuth = [[TencentOAuth alloc] initWithAppId:[self.infoData objectForKey:k_AdChinaSShareKitQQClientId] andDelegate:self];
    }
    
    NSString * thumImage =[self.infoData objectForKey:k_AdChinaSSahreKitQQThumbImage];
   
    if ([thumImage isEqualToString:@""]&& thumImage==nil) {
        thumImageTmp=nil;
    }else{
        thumImageTmp=[NSURL URLWithString:thumImage];
    }
 
    NSString *shareType=[[self.infoData objectForKey:k_AdChinaSShareKitQQShareType]lowercaseString];
    switch (shareType.intValue) {
        case AdShareImage:
            [self shareImage];
            break;
        case AdShareAudio:
            [self shareAudio];
            break;
        case AdShareVideo:
            [self shareVideo];
            break;
        case AdShareHtml:
            [self shareHtml];
            break;
        default:
            break;
    }
}

- (void)shareText{
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:[self.infoData objectForKey:k_AdChinaSShareKitQQImage]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    [QQApiInterface sendReq:req];
}
- (void)shareImage{
    NSData * shareImage=nil;
    if ([self.infoData objectForKey:k_AdChinaSShareKitQQImage]!=nil&&[[self.infoData objectForKey:k_AdChinaSShareKitQQImage] isKindOfClass:[NSString class]]) {
        shareImage =[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQQImage]]];
    }else{
      shareImage  =[self.infoData objectForKey:k_AdChinaSShareKitQQImageData];
    }
    QQApiImageObject *imgObj = [QQApiImageObject objectWithData:shareImage
                                               previewImageData:shareImage
                                                          title:nil
                                                    description:nil ];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
    [QQApiInterface sendReq:req];
}

-(void)shareAudio{
    QQApiAudioObject *audioObj =
    [QQApiAudioObject objectWithURL:[NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQQClickurl]]
                              title:[self.infoData objectForKey:k_AdChinaSShareKitQQShareTitle]
                        description:[self.infoData objectForKey:k_AdChinaSSahreKitQQDetail]
                    previewImageURL:thumImageTmp];
    
   [audioObj setFlashURL:[NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQQImage]]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:audioObj];
    [QQApiInterface sendReq:req];
}
-(void)shareVideo{
    QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL: [NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQQImage]]
                                                           title:[self.infoData objectForKey:k_AdChinaSShareKitQQShareTitle]
                                                     description:[self.infoData objectForKey:k_AdChinaSSahreKitQQDetail]
                                                previewImageURL:thumImageTmp];
    [videoObj setFlashURL: [NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQQImage]]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:videoObj];
    [QQApiInterface sendReq:req];
}

-(void)shareHtml{
   QQApiNewsObject *newsObj = [QQApiNewsObject
                               objectWithURL:[NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQQImage]]
                                title:[self.infoData objectForKey:k_AdChinaSShareKitQQShareTitle]
                                description:[self.infoData objectForKey:k_AdChinaSSahreKitQQDetail]
                                previewImageURL:thumImageTmp];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    [QQApiInterface sendReq:req];   
}


#pragma mark -
#pragma mark TencentSessionDelegate
- (void)tencentDidLogin{
    if (tencentOAuth.accessToken && [tencentOAuth.accessToken length] != 0 ) {
            //登陆成功，记录登陆用户的openid、token以及过期时间
        [AdChinaSShareKit MogoLog:@"登陆成功"];

    }else{
        [AdChinaSShareKit MogoLog:@"登陆不成功"];
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}
/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}
/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    NSString *strLog = [NSString stringWithFormat:@"%@",response];
    [AdChinaSShareKit MogoLog:strLog];
}

@end
