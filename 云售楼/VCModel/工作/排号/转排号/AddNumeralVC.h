//
//  AddNumeralVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/2.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNumeralVCBlock)(void);

@interface AddNumeralVC : BaseViewController

@property (nonatomic, copy) AddNumeralVCBlock addNumeralVCBlock;

@property (nonatomic, strong) NSString *projectName;

- (instancetype)initWithProject_id:(NSString *)project_id personArr:(NSArray *)personArr info_id:(NSString *)info_id group_id:(NSString *)group_id;

@end

NS_ASSUME_NONNULL_END
