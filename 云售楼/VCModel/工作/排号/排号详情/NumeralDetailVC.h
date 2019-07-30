//
//  NumeralDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NumeralDetailVCBlock)(void);

@interface NumeralDetailVC : BaseViewController

@property (nonatomic, copy) NumeralDetailVCBlock numeralDetailVCBlock;

@property (nonatomic, strong) NSString *need_check;

@property (nonatomic, strong) NSDictionary *powerDic;

@property (nonatomic, strong) NSString *projectName;

- (instancetype)initWithRowId:(NSString *)row_id project_id:(NSString *)project_id info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
