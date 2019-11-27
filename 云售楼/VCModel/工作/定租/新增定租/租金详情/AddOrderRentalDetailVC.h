//
//  AddOrderRentalDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddOrderRentalDetailVCBlock)(NSArray *arr);

@interface AddOrderRentalDetailVC : BaseViewController

@property (nonatomic, copy) AddOrderRentalDetailVCBlock addOrderRentalDetailVCBlock;

@property (nonatomic, assign) double area;

- (instancetype)initWithStageArr:(NSArray *)stageArr;

@end

NS_ASSUME_NONNULL_END
