//
//  AddIntentStoreVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreVCBlock)(void);

@interface AddIntentStoreVC : BaseViewController

@property (nonatomic, copy)AddIntentStoreVCBlock addIntentStoreVCBlock;

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
