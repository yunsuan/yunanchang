//
//  ChangeOrderVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/19.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChangeOrderVCBlock)(void);

@interface ChangeOrderVC : BaseViewController

@property (nonatomic, copy) ChangeOrderVCBlock changeOrderVCBlock;

@property (nonatomic, strong) NSString *change;

@property (nonatomic, strong) NSString *status;

- (instancetype)initWithRow_id:(NSString *)row_id personArr:(NSArray *)personArr project_id:(NSString *)project_id info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
