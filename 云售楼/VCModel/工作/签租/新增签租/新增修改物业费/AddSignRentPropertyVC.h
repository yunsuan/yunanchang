//
//  AddSignRentPropertyVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddSignRentPropertyVCBlock)(NSDictionary *dic);

@interface AddSignRentPropertyVC : BaseViewController

@property (nonatomic , copy) AddSignRentPropertyVCBlock addSignRentPropertyVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *config;

@property (nonatomic, assign) double area;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
