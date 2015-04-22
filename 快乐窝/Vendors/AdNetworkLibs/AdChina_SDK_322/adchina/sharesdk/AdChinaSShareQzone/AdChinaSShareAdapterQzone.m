//
//  AdChinaSShareAdapterQzone.m
//  AdChinaSShareKit
//
//  Created by Jome Chen on 13-12-11.
//  Copyright (c) 2013年 Daxiong. All rights reserved.
//

#import "AdChinaSShareAdapterQzone.h"
#import "AdChinaSSharePlatformRegistry.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
 

#define  NOTFONTQQMESSAGE   @"您未安装QQ"
#define  NOTFONTOPENAPIMESSAGE   @"您安装的QQ版本不支持OpenApi"

#define showMessageAlert(title,msg,del,cancelTitle,otherTitle)			[[[[UIAlertView alloc] initWithTitle:title message:msg delegate:del cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil] autorelease] show]

@interface AdChinaSShareAdapterQzone()<QQApiInterfaceDelegate,TencentSessionDelegate>{

    id  thumImageTmp;
}
@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@end


@implementation AdChinaSShareAdapterQzone
-(void)dealloc {
    [_tencentOAuth release];
    [super dealloc];
}

+(void)load
{
    [[AdChinaSSharePlatformRegistry sharedRegistry]registerClass:self];
}

+(int)registryType
{
    return AdChinaSShareAdapterTypeSinaQzone;
}

static AdChinaSShareAdapterQzone *adapterQzone;
+(AdChinaSShareAdapterQzone*)shareMyClass{
    return adapterQzone;
}

-(void)share{
    adapterQzone=self;
    if([self.infoData objectForKey:k_AdChinaSShareKitQzoneClientId]){
        self.tencentOAuth = [[[TencentOAuth alloc] initWithAppId:[self.infoData objectForKey:k_AdChinaSShareKitQzoneClientId] andDelegate:self] autorelease];
    }
    NSString * shareType=[self.infoData objectForKey:k_AdChinaSShareKitQzoneShareType];
    
    NSString * thumImage =[self.infoData objectForKey:k_AdChinaSSahreKitQzoneThumbImage];
    
    if ([thumImage isEqualToString:@""]&& thumImage==nil) {
        thumImageTmp=nil;
    }else{
        thumImageTmp=[NSURL URLWithString:thumImage];
    }
    
    switch (shareType.intValue) {
        case AdShareImage:
            [self shareHtml];
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



-(void)shareAudio{
    QQApiAudioObject *audioObj =
    [QQApiAudioObject objectWithURL:[NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQQClickurl]]
                              title:[self.infoData objectForKey:k_AdChinaSShareKitQzoneTitle]
                        description:[self.infoData objectForKey:k_AdChinaSSahreKitQzoneDetail]
                    previewImageURL:thumImageTmp];
     [audioObj setFlashURL:[NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQzoneContext]]];
    
    
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:audioObj];
    [QQApiInterface SendReqToQZone:req];
}
-(void)shareVideo{
    QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQzoneContext]]
                                                           title:[self.infoData objectForKey:k_AdChinaSShareKitQzoneTitle]
                                                     description:[self.infoData objectForKey:k_AdChinaSSahreKitQzoneDetail]
                                                previewImageURL:thumImageTmp];
    [videoObj setFlashURL:[NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQzoneContext]]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:videoObj];
    [QQApiInterface SendReqToQZone:req];
}

-(void)shareHtml{
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:[self.infoData objectForKey:k_AdChinaSShareKitQzoneContext]]
                                title:[self.infoData objectForKey:k_AdChinaSShareKitQzoneTitle]
                                description:[self.infoData objectForKey:k_AdChinaSSahreKitQzoneDetail]
                                previewImageURL:thumImageTmp];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    [QQApiInterface SendReqToQZone:req];
}



/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

#pragma  mark --TencentLoginDelegate


/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
   
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];}






/**
 * 退出登录的回调
 */
- (void)tencentDidLogout{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 因用户未授予相应权限而需要执行增量授权。在用户调用某个api接口时，如果服务器返回操作未被授权，则触发该回调协议接口，由第三方决定是否跳转到增量授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \param permissions 需增量授权的权限列表。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启增量授权流程。若需要增量授权请调用\ref TencentOAuth#incrAuthWithPermissions: \n注意：增量授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions{
    
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
    return YES;
}

/**
 * [该逻辑未实现]因token失效而需要执行重新登录授权。在用户调用某个api接口时，如果服务器返回token失效，则触发该回调协议接口，由第三方决定是否跳转到登录授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启重新登录授权流程。若需要重新登录授权请调用\ref TencentOAuth#reauthorizeWithPermissions: \n注意：重新登录授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
    return YES;
}

/**
 * 用户通过增量授权流程重新授权登录，token及有效期限等信息已被更新。
 * \param tencentOAuth token及有效期限等信息更新后的授权实例对象
 * \note 第三方应用需更新已保存的token及有效期限等信息。
 */
- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 用户增量授权过程中因取消或网络问题导致授权失败
 * \param reason 授权失败原因，具体失败原因参见sdkdef.h文件中\ref UpdateFailType
 */
- (void)tencentFailedUpdate:(UpdateFailType)reason{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 获取用户QZone相册列表回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getListAlbumResponse.exp success
 *          错误返回示例: \snippet example/getListAlbumResponse.exp fail
 */
- (void)getListAlbumResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 获取用户QZone相片列表
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getListPhotoResponse.exp success
 *          错误返回示例: \snippet example/getListPhotoResponse.exp fail
 */
- (void)getListPhotoResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 检查是否是QZone某个用户的粉丝回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/checkPageFansResponse.exp success
 *          错误返回示例: \snippet example/checkPageFansResponse.exp fail
 */
- (void)checkPageFansResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 分享到QZone回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/addShareResponse.exp success
 *          错误返回示例: \snippet example/addShareResponse.exp fail
 */
- (void)addShareResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 在QZone相册中创建一个新的相册回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/addAlbumResponse.exp success
 *          错误返回示例: \snippet example/addAlbumResponse.exp fail
 */
- (void)addAlbumResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 上传照片到QZone指定相册回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/uploadPicResponse.exp success
 *          错误返回示例: \snippet example/uploadPicResponse.exp fail
 */
- (void)uploadPicResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}


/**
 * 在QZone中发表一篇日志回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/addOneBlogResponse.exp success
 *          错误返回示例: \snippet example/addOneBlogResponse.exp fail
 */
- (void)addOneBlogResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 在QZone中发表一条说说回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/addTopicResponse.exp success
 *          错误返回示例: \snippet example/addTopicResponse.exp fail
 */
- (void)addTopicResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 获取QQ会员信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getVipInfoResponse.exp success
 *          错误返回示例: \snippet example/getVipInfoResponse.exp fail
 */
- (void)getVipInfoResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 获取QQ会员详细信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 */
- (void)getVipRichInfoResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 获取微博好友名称输入提示回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/matchNickTipsResponse.exp success
 *          错误返回示例: \snippet example/matchNickTipsResponse.exp fail
 */
- (void)matchNickTipsResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 获取最近的微博好友回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getIntimateFriendsResponse.exp success
 *          错误返回示例: \snippet example/getIntimateFriendsResponse.exp fail
 */
- (void)getIntimateFriendsResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * 设置QQ头像回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/setUserHeadpicResponse.exp success
 *          错误返回示例: \snippet example/setUserHeadpicResponse.exp fail
 */
- (void)setUserHeadpicResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * sendStory分享的回调（已废弃，使用responseDidReceived:forMessage:）
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 */
- (void)sendStoryResponse:(APIResponse*) response{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}
/**
 * 社交API统一回调接口
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \param message 响应的消息，目前支持‘SendStory’,‘AppInvitation’，‘AppChallenge’，‘AppGiftRequest’
 */
- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}

/**
 * post请求的上传进度
 * \param tencentOAuth 返回回调的tencentOAuth对象
 * \param bytesWritten 本次回调上传的数据字节数
 * \param totalBytesWritten 总共已经上传的字节数
 * \param totalBytesExpectedToWrite 总共需要上传的字节数
 * \param userData 用户自定义数据
 */
- (void)tencentOAuth:(TencentOAuth *)tencentOAuth didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite userData:(id)userData{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
    
}


/**
 * 通知第三方界面需要被关闭
 * \param tencentOAuth 返回回调的tencentOAuth对象
 * \param viewController 需要关闭的viewController
 */
- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController{
    NSString *strLog = [NSString stringWithFormat:@"%s",__FUNCTION__];
    [AdChinaSShareKit MogoLog:strLog];
}















@end
