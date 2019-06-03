//
//  AddCallTelegramVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddCallTelegramVCBlock)(void);

@interface AddCallTelegramVC : BaseViewController

@property (nonatomic, copy) AddCallTelegramVCBlock addCallTelegramVCBlock;

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
