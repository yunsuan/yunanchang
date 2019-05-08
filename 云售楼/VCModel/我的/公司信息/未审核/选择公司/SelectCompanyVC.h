//
//  SelectCompanyVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectCompanyVCBlock)(NSString *companyId, NSString *name);

@interface SelectCompanyVC : BaseViewController

@property (nonatomic, copy) SelectCompanyVCBlock selectCompanyVCBlock;

@end

NS_ASSUME_NONNULL_END
