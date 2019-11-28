//
//  AddSignRentOtherVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddSignRentOtherVCBlock)(NSDictionary *dic);

@interface AddSignRentOtherVC : BaseViewController

@property (nonatomic, strong) NSMutableArray *excuteArr;

@property (nonatomic, copy) AddSignRentOtherVCBlock addSignRentOtherVCBlock;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
