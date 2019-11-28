//
//  AddSignRentPropertyDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddSignRentPropertyDetailVCBlock)(NSArray *arr);

@interface AddSignRentPropertyDetailVC : BaseViewController

@property (nonatomic, copy) AddSignRentPropertyDetailVCBlock addSignRentPropertyDetailVCBlock;

@property (nonatomic, strong) NSString *config;

- (instancetype)initWithDataArr:(NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END
