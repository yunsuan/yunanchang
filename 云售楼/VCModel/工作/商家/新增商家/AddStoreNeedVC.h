//
//  AddStoreNeedVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddStoreNeedVCBlock)(void);

@interface AddStoreNeedVC : BaseViewController

@property (nonatomic, copy) AddStoreNeedVCBlock addStoreNeedVCBlock;

@property (nonatomic, strong) NSString *status;

- (instancetype)initWithData:(NSArray *)data;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
