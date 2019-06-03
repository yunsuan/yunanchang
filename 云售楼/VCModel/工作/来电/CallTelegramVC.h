//
//  CallTelegramVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallTelegramVCBlock)(void);

@interface CallTelegramVC : BaseViewController

@property (nonatomic, copy) CallTelegramVCBlock callTelegramVCBlock;

@property (nonatomic, strong) NSDictionary *powerDic;

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
