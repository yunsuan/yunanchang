//
//  AddOrderRentVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddOrderRentVCBlock)(void);

@interface AddOrderRentVC : BaseViewController

@property (nonatomic, strong) AddOrderRentVCBlock addOrderRentVCBlock;

@property (nonatomic, strong) NSString *from_type;

@property (nonatomic, strong) NSDictionary *dataDic;

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
