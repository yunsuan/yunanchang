//
//  PersonalVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PersonalVCBlock)(void);

@interface PersonalVC : BaseViewController

@property (nonatomic, copy) PersonalVCBlock personalVCBlock;

@end

NS_ASSUME_NONNULL_END
