//
//  AddIntentSelectStoreVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentSelectStoreVCBlock)(NSDictionary *dic);

@interface AddIntentSelectStoreVC : BaseViewController

@property (nonatomic, copy) AddIntentSelectStoreVCBlock addIntentSelectStoreVCBlock;

@property (nonatomic, strong) NSDictionary *powerDic;

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
