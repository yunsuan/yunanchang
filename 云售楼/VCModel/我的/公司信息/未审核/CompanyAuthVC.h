//
//  CompanyAuthVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompanyAuthVCBlock)(void);

@interface CompanyAuthVC : BaseViewController

@property (nonatomic, copy) CompanyAuthVCBlock companyAuthVCBlock;

@property (nonatomic, strong) NSString *authId;

@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END
