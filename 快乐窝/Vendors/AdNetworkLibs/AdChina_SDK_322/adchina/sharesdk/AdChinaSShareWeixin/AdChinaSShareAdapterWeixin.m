//
//  AdChinaSShareWeixin.m
//  AdChinaSShareKit
//
//  Created by mogo_wenyand on 13-12-2.
//  Copyright (c) 2013年 Daxiong. All rights reserved.
//

#import "AdChinaSShareAdapterWeixin.h"
#import "AdChinaSSharePlatformRegistry.h"
#import "WXApi.h"
#import "WXApiObject.h"

#define showMessageAlert(title,msg,del,cancelTitle,otherTitle)			[[[[UIAlertView alloc] initWithTitle:title message:msg delegate:del cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil] autorelease] show]


@interface AdChinaSShareAdapterWeixin ()<WXApiDelegate>
{
    WXMediaMessage *message;
}
@end

@implementation AdChinaSShareAdapterWeixin
+ (void)load{
    [[AdChinaSSharePlatformRegistry sharedRegistry] registerClass:self];
}
static AdChinaSShareAdapterWeixin* adapterwx;
+(AdChinaSShareAdapterWeixin*)shareMyClass{
    return adapterwx;
}
+ (int)registryType{
    return AdChinaSShareAdapterTypeSinaWeiWx;
}
- (void)share{
 
    adapterwx =self;
    NSString *shareType=[[self.infoData objectForKey:k_AdChinaSShareKitWeixinShareType]lowercaseString];
    if ([self.infoData objectForKey:k_AdChinaSShareKitWeixinClientId]) {
        [WXApi registerApp:[self.infoData objectForKey:k_AdChinaSShareKitWeixinClientId]];
    }
    if (![WXApi isWXAppInstalled]) {
        NSString *strMsg = @"您未安装微信";
        [AdChinaSShareKit MogoLog:strMsg];
        showMessageAlert(@"",strMsg,self, @"OK", nil);
        [[AdChinaSShareKit sharedRegistry]setinShare:NO];
        return;
    }else if (![WXApi isWXAppSupportApi]){
        NSString *strMsg = @"您安装的微信版本不支持OpenApi";
        [AdChinaSShareKit MogoLog:strMsg];
        showMessageAlert(@"",strMsg,self, @"OK", nil);
        [[AdChinaSShareKit sharedRegistry]setinShare:NO];
        return;
    }
    
    message=[WXMediaMessage message];
    message.title=[self.infoData objectForKey:k_AdChinaSShareKitWeixinTitle];
    message.description=[self.infoData objectForKey:k_AdChinaSSahreKitWeixinDetail];
    NSString * thumbDataURL=[self.infoData objectForKey:k_AdChinaSSahreKitWeixinThumbImage];
    if (thumbDataURL!=nil&&![thumbDataURL isEqualToString:@""]) {
        NSData * bdata=   [NSData dataWithContentsOfURL:[NSURL URLWithString:thumbDataURL]];
        if ([bdata length] >32*1024) {
            do {
                UIImage * baseImage =[UIImage imageWithData:bdata];
                bdata =   [self createThumbImage:baseImage size:CGSizeMake(baseImage.size.width-20,baseImage.size.height-20) percent:0.1];
            } while ([bdata length] > 32*1024);
        }
         message.thumbData=bdata;
    }
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
    if ([self.infoData objectForKey:k_AdChinaSShareKitWeixinContext]) {
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init] autorelease];
        req.text = [self.infoData objectForKey:k_AdChinaSShareKitWeixinContext];
        req.bText = YES;
        req.scene = WXSceneSession;
        [WXApi sendReq:req];
    }
}

-(void)shareImage{
    NSString * shareurl=[self.infoData objectForKey:k_AdChinaSShareKitWeixinContext];
      NSData * shareImage  =[self.infoData objectForKey:k_AdChinaSShareKitQQImageData];
         WXImageObject *ext = [WXImageObject object];
    if (!shareImage) {
        shareImage=[NSData dataWithContentsOfURL:[NSURL URLWithString:shareurl]];
    }
    
    if (shareImage) {
     [ext setImageData:shareImage];
        NSData * tmp =shareImage;
            if ([tmp length] >32*1024) {
                do {
                    UIImage * baseImage =[UIImage imageWithData:tmp];
                    tmp =   [self createThumbImage:baseImage size:CGSizeMake(baseImage.size.width-20,baseImage.size.height-20) percent:0.1];
                } while ([tmp length] > 32*1024);
            }
            message.thumbData=tmp;
    }
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];

}
-(void)shareVideo{
    NSString * shareurl=[self.infoData objectForKey:k_AdChinaSShareKitWeixinContext];
    if (shareurl) {
        WXVideoObject *ext = [WXVideoObject object];
 
       [ext setVideoUrl:shareurl];
        message.mediaObject = ext;
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;
        
        [WXApi sendReq:req];
    }
}

-(void)shareAudio{
    NSString * shareurl=[self.infoData objectForKey:k_AdChinaSShareKitWeixinContext];
    NSString * clickshareurl=[self.infoData objectForKey:k_AdChinaSSahreKitWeixinclickurl];
    if (shareurl) {
    WXMusicObject *ext = [WXMusicObject object];
    [ext setMusicUrl:clickshareurl];
    [ext setMusicDataUrl:shareurl];
    message.mediaObject=ext;
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    }
}
-(void)shareHtml{
    NSString * shareurl=[self.infoData objectForKey:k_AdChinaSShareKitWeixinContext];
    if (shareurl) {
    WXWebpageObject *ext = [WXWebpageObject object];
    [ext setWebpageUrl:shareurl];
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    }
}

 




@end
