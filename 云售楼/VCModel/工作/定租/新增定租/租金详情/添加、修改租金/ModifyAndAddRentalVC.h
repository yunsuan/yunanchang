//
//  ModifyAndAddRentalVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ModifyAndAddRentalVCBlock)(NSDictionary *dic);

@interface ModifyAndAddRentalVC : BaseViewController

@property (nonatomic , copy) ModifyAndAddRentalVCBlock modifyAndAddRentalVCBlock;

@property (nonatomic , assign) double area;

@property (nonatomic , strong) NSString *status;

@property (nonatomic , strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
