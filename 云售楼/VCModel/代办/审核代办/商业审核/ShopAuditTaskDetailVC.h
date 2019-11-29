//
//  ShopAuditTaskDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShopAuditTaskDetailVCBlock)(void);

@interface ShopAuditTaskDetailVC : BaseViewController

@property (nonatomic, copy) ShopAuditTaskDetailVCBlock shopAuditTaskDetailVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *project_id;;

@property (nonatomic, strong) NSString *requestId;

@end

NS_ASSUME_NONNULL_END
