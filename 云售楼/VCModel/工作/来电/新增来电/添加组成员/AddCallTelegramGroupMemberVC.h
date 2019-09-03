//
//  AddCallTelegramGroupMemberVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddCallTelegramGroupMemberVCBlock)(NSString *group, NSDictionary *dic);

typedef void(^AddCallTelegramGroupMemberDirectVCBlock)(void);

@interface AddCallTelegramGroupMemberVC : BaseViewController

@property (nonatomic, copy) AddCallTelegramGroupMemberVCBlock addCallTelegramGroupMemberVCBlock;

@property (nonatomic, copy) AddCallTelegramGroupMemberDirectVCBlock addCallTelegramGroupMemberDirectVCBlock;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *trans;

@property (nonatomic, strong) NSString *merge;

@property (nonatomic, strong) NSString *group_id;

@property (nonatomic, strong) NSDictionary *configDic;

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
