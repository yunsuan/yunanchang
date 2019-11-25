//
//  ModifyOrderRentVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ModifyOrderRentVCBlock)(void);

@interface ModifyOrderRentVC : BaseViewController

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) ModifyOrderRentVCBlock modifyOrderRentVCBlock;

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
