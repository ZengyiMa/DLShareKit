//
//  DLShareKit.m
//  Niupu_SNS
//
//  Created by famulei on 8/23/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import "DLShareKit.h"
#import "DLShareProtocol.h"


@interface DLShareKit ()

@property (nonatomic, strong) NSMutableDictionary *services;

@property (nonatomic, strong) DLShareMessage *sharingMessage;

@end
@implementation DLShareKit

+ (DLShareKit *)sharedInstance
{
    static DLShareKit *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [DLShareKit new];
    });
    return sharedInstance;
}

- (void)shareWithMessage:(DLShareMessage *)message
{
    id<DLShareProtocol> service = self.services[message.shareServiceName];
    if (service == nil) {
        service = [NSClassFromString(message.shareServiceName) new];
        self.services[message.shareServiceName] = service;
        [service registerSDKWithConfigure:self.registerConfigure];
    }
   self.sharingMessage = message;
   id objetc = [service translateMessage:message type:message.messageType];
   [service shareWithObject:objetc];
}



- (BOOL)handleOpenURL:(NSURL *)URL
{
    if (!self.sharingMessage) {
        return NO;
    }
    id<DLShareProtocol> service = self.services[self.sharingMessage.shareServiceName];
   return [service handleOpenURL:URL];
}

- (void)shareCompletedWithSucceed:(BOOL)isSucceed statusCode:(NSInteger)statusCode errorMessage:(NSString *)errorMessage
{
    if (self.sharingMessage.completedBlock) {
        self.sharingMessage.completedBlock(isSucceed, statusCode, errorMessage);
    }
    self.sharingMessage.completedBlock = nil;
    self.sharingMessage = nil;
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.services = [NSMutableDictionary dictionary];
    }
    return self;
}


@end
