//
//  OrderAddDepositVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/8/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderAddDepositVCBlock)(void);

@interface OrderAddDepositVC : BaseViewController

@property (nonatomic, copy) OrderAddDepositVCBlock orderAddDepositVCBlock;

- (instancetype)initWithProject_id:(NSString *)project_id sincerity:(NSString *)sincerity dataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
