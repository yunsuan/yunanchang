//
//  AddCallTelegramGroupMemberVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddCallTelegramGroupMemberVCBlock)(NSString *group);

@interface AddCallTelegramGroupMemberVC : BaseViewController

@property (nonatomic, copy) AddCallTelegramGroupMemberVCBlock addCallTelegramGroupMemberVCBlock;

@end

NS_ASSUME_NONNULL_END
