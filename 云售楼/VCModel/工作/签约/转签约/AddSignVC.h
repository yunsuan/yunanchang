//
//  AddSignVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddSignVCBlock)(void);

@interface AddSignVC : BaseViewController

@property (nonatomic, copy) AddSignVCBlock addSignVCBlock;

@property (nonatomic, strong) NSString *trans;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *merge;

@property (nonatomic, strong) NSString *from_type;

@property (nonatomic, strong) NSString *advicer_id;

@property (nonatomic, strong) NSString *advicer_name;

- (instancetype)initWithRow_id:(NSString *)row_id personArr:(NSArray *)personArr project_id:(NSString *)project_id info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
