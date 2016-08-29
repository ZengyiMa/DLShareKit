//
//  DLShareMessage.h
//  Niupu_SNS
//
//  Created by famulei on 8/26/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLShareKit.h"

@class DLShareKit;

typedef void(^DLShareCompletedBlock)(BOOL isSucceed, NSInteger statusCode, NSString *errorMessage);


typedef NS_ENUM(NSUInteger, DLShareMessageType) {
    DLShareMessageTypeText,
    DLShareMessageTypeImage,
    DLShareMessageTypeAudio,
    DLShareMessageTypeVideo,
    DLShareMessageTypeWebPage,
};

@interface DLShareMessage : NSObject
@property (nonatomic, assign) DLShareMessageType messageType;
@property (nonatomic, copy) NSString *shareServiceName;
@property (nonatomic, copy) DLShareCompletedBlock completedBlock;

- (void)shareWithCompletedBlock:(DLShareCompletedBlock)block;
@end

@interface DLShareTextMessage : DLShareMessage
@property (nonatomic, copy) NSString *content;
@end

@interface DLShareImageMessage : DLShareTextMessage
@end


@interface DLShareAudioMessage : DLShareTextMessage
@end


@interface DLShareVideoMessage : DLShareTextMessage
@end

/**
 网页链接分享， 如果是微博的分享，会忽略了title，因为微博没有标题
 */
@interface DLShareWebPageMessage : DLShareTextMessage
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, copy) NSString *shareURL;
@end



@interface DLShareMessage (DLShareMessageService)

+ (NSString *)serviceNameOfWeibo;
+ (NSString *)serviceNameOfWeChatTimeline;
+ (NSString *)serviceNameOfWeChatSession;
+ (NSString *)serviceNameOfQQ;

@end







