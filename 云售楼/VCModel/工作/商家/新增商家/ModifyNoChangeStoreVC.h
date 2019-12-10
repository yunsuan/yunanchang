//
//  ModifyNoChangeStoreVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/12/10.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ModifyNoChangeStoreVCBlock)(NSDictionary *dic);

@interface ModifyNoChangeStoreVC : BaseViewController

//@property (nonatomic, copy) AddStoreVCBlock addStoreVCBlock;

@property (nonatomic, copy) ModifyNoChangeStoreVCBlock modifyNoChangeStoreVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSDictionary *storeDic;

@property (nonatomic, strong) NSString *business_id;

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
