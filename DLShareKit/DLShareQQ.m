//
//  DLShareQQ.m
//  Niupu_SNS
//
//  Created by famulei on 8/29/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import "DLShareQQ.h"
#import "UIImage+DLShareKit.h"


@implementation DLShareQQ


- (BOOL)registerSDKWithConfigure:(NSDictionary *)configure
{
   self.oauth = [[TencentOAuth alloc] initWithAppId:kQQShareAppID andDelegate:nil];
    return YES;
}

- (id)translateMessage:(DLShareMessage *)message type:(DLShareMessageType)type
{
    switch (type) {
        case DLShareMessageTypeText:
        {
            QQApiTextObject *textObject = [QQApiTextObject objectWithText:[(DLShareTextMessage *)message content]];
            return textObject;
        }
            break;
        case DLShareMessageTypeWebPage:
        {
            UIImage *previewData = [(DLShareWebPageMessage *)message thumbnailImage];
            if (previewData) {
                previewData = [previewData dl_imageByResizeToSize:CGSizeMake(120, 120)];
            }
            
            QQApiNewsObject *newsObject = [QQApiNewsObject objectWithURL:[NSURL URLWithString:[(DLShareWebPageMessage *)message shareURL]]
                                                                   title:[(DLShareWebPageMessage *)message title]
                                                             description:[(DLShareWebPageMessage *)message content]
                                                        previewImageData:UIImageJPEGRepresentation(previewData, 0.65)];
            return newsObject;
         }
            break;
            
        default:
            break;
    }
    
    
    return nil;
}

- (void)shareWithObject:(QQApiObject *)object
{
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:object];
   [QQApiInterface sendReq:request];
    
    
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [QQApiInterface handleOpenURL:url delegate:self];
}

#pragma mark - QQ delegate

- (void)onResp:(QQBaseResp *)resp
{
    if (resp.errorDescription.length == 0) {
        //正确的情况
        [[DLShareKit sharedInstance]shareCompletedWithSucceed:YES statusCode:resp.result.integerValue errorMessage:@""];
    }
    else
    {
        [[DLShareKit sharedInstance]shareCompletedWithSucceed:YES statusCode:resp.result.integerValue errorMessage:resp.errorDescription];
    }
}

- (void)onReq:(QQBaseReq *)req
{
    
}


- (void)isOnlineResponse:(NSDictionary *)response
{
    
}





@end
