//
//  CallTelegramSimpleCustomVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallTelegramSimpleCustomVCEditBlock)(NSDictionary *dic);

@interface CallTelegramSimpleCustomVC : BaseViewController

@property (nonatomic, copy) CallTelegramSimpleCustomVCEditBlock callTelegramSimpleCustomVCEditBlock;

@property (nonatomic, strong) NSDictionary *configDic;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *trans;

@property (nonatomic, strong) NSString *hiddenAdd;

@property (nonatomic, strong) NSString *merge;

@property (nonatomic, strong) NSString *group_id;

//@property (nonatomic, strong) NSString *client_id;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic projectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
