//
//  ProjectRoleVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ProjectRoleVCBlock)(NSString *roleId, NSString *name);

@interface ProjectRoleVC : BaseViewController

@property (nonatomic, copy) ProjectRoleVCBlock projectRoleVCBlock;

@property (nonatomic, strong) NSString *roleId;

- (instancetype)initWithCompanyId:(NSString *)companyId;

@end

NS_ASSUME_NONNULL_END
