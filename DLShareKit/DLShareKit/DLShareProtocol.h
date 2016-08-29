//
//  DLShareProtocol.h
//  Niupu_SNS
//
//  Created by famulei on 8/23/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLShareKit.h"
#import "DLShareMessage.h"
@class DLShareMessage;


@protocol DLShareProtocol <NSObject>

@required
/**
 注册SDK，会自动调用，无需手动
 
 @param configure 配置信息可以shareKit中配置
 
 @return 是否注册成功
 */
- (BOOL)registerSDKWithConfigure:(NSDictionary *)configure;

/**
 将 DLShareMessage 转换到各平台的消息对象
 
 @param message DLShareMessage 实例
 @param type    message 类型（有text， video， image 等）
 
 @return 返回转换好的类型
 */
- (id)translateMessage:(DLShareMessage *)message type:(DLShareMessageType)type;

/**
 分享的回调，转换好对象后SDK会立即调用这个方法，可以在此方法实现各个平台的分享发送。
 
 @param object 各个平台的message对象实例
 */
- (void)shareWithObject:(id)object;

/**
 处理openURL的回调
 
 @param url SDK传入
 
 @return 返回时候成功处理
 */
- (BOOL)handleOpenURL:(NSURL *)url;

@optional


@end
