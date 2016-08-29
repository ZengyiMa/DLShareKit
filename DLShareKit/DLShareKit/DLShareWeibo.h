//
//  DLShareWeibo.h
//  Niupu_SNS
//
//  Created by famulei on 8/23/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLShareProtocol.h"
#import "DLShareKitConfig.h"
#import "DLShareKit.h"
#import "WeiboSDK.h"


@interface DLShareWeibo : NSObject<DLShareProtocol, WeiboSDKDelegate>

@end
