//
//  DLShareWeChat.m
//  Niupu_SNS
//
//  Created by famulei on 8/29/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import "DLShareWeChat.h"
#import "WXApi.h"
#import "UIImage+DLShareKit.h"

@implementation DLShareWeChat

- (BOOL)registerSDKWithConfigure:(NSDictionary *)configure
{
   return [WXApi registerApp:kWeChatShareAppID];
}


- (id)translateMessage:(DLShareMessage *)message type:(DLShareMessageType)type
{
    SendMessageToWXReq *wxReq = [[SendMessageToWXReq alloc] init];
    WXMediaMessage *mediaMessage = [WXMediaMessage message];
    wxReq.message = mediaMessage;
    switch (type) {
        case DLShareMessageTypeText:
        {
            wxReq.bText = YES;
            wxReq.text = [(DLShareTextMessage *)message content];
        }
            break;
        case DLShareMessageTypeWebPage:
        {
            mediaMessage.title = [(DLShareWebPageMessage *)message title];
            mediaMessage.description = [(DLShareWebPageMessage *)message content];
            
            UIImage *thumbImage = [(DLShareWebPageMessage *)message thumbnailImage];
            if (thumbImage) {
                mediaMessage.thumbData = UIImageJPEGRepresentation([thumbImage dl_imageByResizeToSize:CGSizeMake(120, 120) ], 0.65);
            }
            WXWebpageObject *webPageObject = [WXWebpageObject object];
            webPageObject.webpageUrl = [(DLShareWebPageMessage *)message shareURL];
            mediaMessage.mediaObject = webPageObject;
        }
            break;
            
        default:
            break;
    }
    
    wxReq.scene = [self scene];
    
    return wxReq;
}


- (NSInteger)scene
{
    return WXSceneTimeline;
}


- (void)shareWithObject:(SendMessageToWXReq *)object
{
    [WXApi sendReq:object];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onReq:(BaseReq*)req
{
    
}


- (void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (resp.errCode == WXSuccess)
        {
            [[DLShareKit sharedInstance]shareCompletedWithSucceed:YES statusCode:resp.errCode errorMessage:@""];
        }
        else
        {
            NSString *errorMessage = @"未知错误";
            switch (resp.errCode) {
                case WXErrCodeCommon:
                    errorMessage = @"普通错误类型";
                    break;
                case WXErrCodeUserCancel:
                    errorMessage = @"用户点击取消并返回";
                    break;
                case WXErrCodeSentFail:
                    errorMessage = @"发送失败";
                    break;
                case WXErrCodeAuthDeny:
                    errorMessage = @"授权失败";
                    break;
                case WXErrCodeUnsupport:
                    errorMessage = @"微信不支持";
                    break;
                default:
                    break;
            }
            [[DLShareKit sharedInstance]shareCompletedWithSucceed:NO statusCode:resp.errCode errorMessage:errorMessage];
        }
    }
}






@end
