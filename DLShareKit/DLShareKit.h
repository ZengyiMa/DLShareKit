//
//  DLShareKit.h
//  Niupu_SNS
//
//  Created by famulei on 8/23/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLShareMessage.h"

@class DLShareMessage;

@interface DLShareKit : NSObject

@property (nonatomic, assign) BOOL enableDebug;
@property (nonatomic, copy) NSDictionary *registerConfigure;
+ (DLShareKit *)sharedInstance;



- (void)shareWithMessage:(DLShareMessage *)message;

- (void)shareCompletedWithSucceed:(BOOL)isSucceed statusCode:(NSInteger)statusCode errorMessage:(NSString *)errorMessage;

- (BOOL)handleOpenURL:(NSURL *)URL;

@end
