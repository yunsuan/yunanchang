//
//  CompanyCommissionReportVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyCommissionReportVC : BaseViewController

@property (nonatomic, strong) NSString *money;

@property (nonatomic, strong) NSString *num;

- (instancetype)initWithRuleId:(NSString *)rule_id project_id:(NSString *)project_id;

@end

NS_ASSUME_NONNULL_END
