//
//  LoginVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginVCBlock)(void);

@interface LoginVC : BaseViewController

@property (nonatomic, copy) LoginVCBlock loginVCBlock;

@end

NS_ASSUME_NONNULL_END
