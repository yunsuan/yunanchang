//
//  AutoVisitReportVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/10.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AutoVisitReportVC : BaseViewController

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSString *status;

- (instancetype)initWithProjectId:(NSString *)project_id;

@end

NS_ASSUME_NONNULL_END
