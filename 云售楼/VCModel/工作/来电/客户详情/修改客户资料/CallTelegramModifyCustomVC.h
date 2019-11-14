//
//  CallTelegramModifyCustomVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallTelegramModifyCustomVCBlock)(void);

@interface CallTelegramModifyCustomVC : BaseViewController

@property (nonatomic, strong) CallTelegramModifyCustomVCBlock callTelegramModifyCustomVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *telOrVisit;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic projectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
