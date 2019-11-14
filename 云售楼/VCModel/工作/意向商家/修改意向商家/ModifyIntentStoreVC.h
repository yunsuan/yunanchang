//
//  ModifyIntentStoreVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ModifyIntentStoreVCBlock)(void);

@interface ModifyIntentStoreVC : BaseViewController

@property (nonatomic, copy) ModifyIntentStoreVCBlock modifyIntentStoreVCBlock;

@property (nonatomic, strong) NSString *trans;

@property (nonatomic, strong) NSString *projectName;

@property (nonatomic, strong) NSString *advicer_id;

@property (nonatomic, strong) NSString *advicer_name;

- (instancetype)initWithRowId:(NSString *)row_id projectId:(NSString *)project_id info_Id:(NSString *)info_id dataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
