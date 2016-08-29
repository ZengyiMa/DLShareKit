//
//  DLShareWeChat.h
//  Niupu_SNS
//
//  Created by famulei on 8/29/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLShareProtocol.h"
#import "DLShareKitConfig.h"
#import "DLShareKit.h"
#import "WXApi.h"

@interface DLShareWeChat : NSObject<DLShareProtocol, WXApiDelegate>

- (NSInteger)scene;

@end
