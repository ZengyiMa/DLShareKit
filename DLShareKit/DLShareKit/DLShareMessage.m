//
//  DLShareMessage.m
//  Niupu_SNS
//
//  Created by famulei on 8/26/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import "DLShareMessage.h"

@implementation DLShareMessage


- (void)shareWithCompletedBlock:(DLShareCompletedBlock)block
{
    NSAssert(self.shareServiceName, @"shareServiceName can not be nil");
    self.completedBlock = block;
    [[DLShareKit sharedInstance]shareWithMessage:self];
}



@end

@implementation DLShareTextMessage
- (DLShareMessageType)messageType
{
    return DLShareMessageTypeText;
}
@end

@implementation DLShareImageMessage
- (DLShareMessageType)messageType
{
    return DLShareMessageTypeImage;
}
@end

@implementation DLShareAudioMessage
- (DLShareMessageType)messageType
{
    return DLShareMessageTypeAudio;
}
@end

@implementation DLShareVideoMessage
- (DLShareMessageType)messageType
{
    return DLShareMessageTypeVideo;
}
@end

@implementation DLShareWebPageMessage
- (DLShareMessageType)messageType
{
    return DLShareMessageTypeWebPage;
}
@end



@implementation DLShareMessage (DLShareMessageService)

+ (NSString *)serviceNameOfWeibo
{
    return @"DLShareWeibo";
}

+ (NSString *)serviceNameOfWeChatTimeline
{
    return @"DLShareWeChatTimeLine";
}

+ (NSString *)serviceNameOfWeChatSession
{
    return @"DLShareWeChatSession";
}

+ (NSString *)serviceNameOfQQ
{
    return @"DLShareQQ";
}




@end






