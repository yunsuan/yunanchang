//
//  AddSignRentOtherDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddSignRentOtherDetailVCBlock)(NSArray *arr);

@interface AddSignRentOtherDetailVC : BaseViewController

@property (nonatomic, copy) AddSignRentOtherDetailVCBlock addSignRentOtherDetailVCBlock;

@property (nonatomic, strong) NSMutableArray *excuteArr;

@property (nonatomic, assign) double area;

- (instancetype)initWithDataArr:(NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END
