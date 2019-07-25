//
//  ModifyNumeralVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/24.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ModifyNumeralVCBlock)(void);

@interface ModifyNumeralVC : BaseViewController

@property (nonatomic, copy) ModifyNumeralVCBlock modifyNumeralVCBlock;

@property (nonatomic, strong) NSString *projectName;

@property (nonatomic, strong) NSString *advicer_id;

@property (nonatomic, strong) NSString *advicer_name;

- (instancetype)initWithRowId:(NSString *)row_id projectId:(NSString *)project_id info_Id:(NSString *)info_id dataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
