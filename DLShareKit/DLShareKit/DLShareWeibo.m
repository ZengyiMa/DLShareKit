//
//  DLShareWeibo.m
//  Niupu_SNS
//
//  Created by famulei on 8/23/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import "DLShareWeibo.h"
#import "WBHttpRequest+WeiboShare.h"

@implementation DLShareWeibo


- (BOOL)registerSDKWithConfigure:(NSDictionary *)configure
{
    [WeiboSDK enableDebugMode:YES];
   return [WeiboSDK registerApp:kWeiboShareAppID];
}


- (id)translateMessage:(DLShareMessage *)message type:(DLShareMessageType)type
{
    WBMessageObject *wbMessage = [WBMessageObject message];
    switch (type) {
        case DLShareMessageTypeText:
            wbMessage.text = [(DLShareTextMessage *)message content];
            break;
        case DLShareMessageTypeWebPage:
        {
            DLShareWebPageMessage *pageMessage = (DLShareWebPageMessage *)message;
            wbMessage.text = [NSString stringWithFormat:@"%@%@", pageMessage.content, pageMessage.shareURL];
            if (pageMessage.thumbnailImage) {
                WBImageObject *imageObject = [WBImageObject object];
                imageObject.imageData = UIImageJPEGRepresentation(pageMessage.thumbnailImage, 0.75);
                wbMessage.imageObject = imageObject;
            }
        }
        break;

        default:
            break;
    }
    return wbMessage;
}


- (void)shareWithObject:(WBMessageObject *)object
{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kWeiboShareRedirectUrl;
    authRequest.scope = @"all";
    authRequest.userInfo = @{@"request_from": @"share_auth"};
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:object authInfo:authRequest access_token:nil];
    request.userInfo = @{@"request_from": @"share"};
    [WeiboSDK sendRequest:request];
}


- (BOOL)handleOpenURL:(NSURL *)url
{
   return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark - weibo delegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([DLShareKit sharedInstance].enableDebug) {
        NSLog(@"DLShareKit \n ===  %@\n", response);
    }
    
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        [[DLShareKit sharedInstance]shareCompletedWithSucceed:YES statusCode:WeiboSDKResponseStatusCodeSuccess  errorMessage:@""];
        return;
    }
    NSString *errorMessage = @"未知错误";
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeUserCancel :
            errorMessage = @"用户取消发送";
            break;
        case WeiboSDKResponseStatusCodeSentFail :
            errorMessage = @"发送失败";
            break;
        case WeiboSDKResponseStatusCodeAuthDeny :
            errorMessage = @"授权失败";
            break;
        case WeiboSDKResponseStatusCodeUserCancelInstall :
            errorMessage = @"用户取消安装微博客户端";
            break;
        case WeiboSDKResponseStatusCodeShareInSDKFailed :
            errorMessage = @"分享失败";
            break;
        case WeiboSDKResponseStatusCodeUnsupport :
            errorMessage = @"不支持的请求";
            break;

        default:
            break;
    }
    [[DLShareKit sharedInstance]shareCompletedWithSucceed:NO statusCode:response.statusCode  errorMessage:errorMessage];
}

@end
