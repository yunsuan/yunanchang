//
//  AuditTaskDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AuditTaskDetailVCBlock)(void);

@interface AuditTaskDetailVC : BaseViewController

@property (nonatomic, copy) AuditTaskDetailVCBlock auditTaskDetailVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *project_id;;

@property (nonatomic, strong) NSString *requestId;

@end

NS_ASSUME_NONNULL_END
