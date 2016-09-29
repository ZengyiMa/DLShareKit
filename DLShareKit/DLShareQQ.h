//
//  DLShareQQ.h
//  Niupu_SNS
//
//  Created by famulei on 8/29/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLShareProtocol.h"
#import "DLShareKitConfig.h"
#import "DLShareKit.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

@interface DLShareQQ : NSObject<DLShareProtocol, QQApiInterfaceDelegate>

@property (nonatomic, strong) id oauth;
@end
