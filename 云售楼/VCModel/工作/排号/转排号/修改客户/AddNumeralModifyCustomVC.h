//
//  AddNumeralModifyCustomVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNumeralModifyCustomVCEditBlock)(NSDictionary *dic);

@interface AddNumeralModifyCustomVC : BaseViewController

@property (nonatomic, copy) AddNumeralModifyCustomVCEditBlock addNumeralModifyCustomVCEditBlock;

@property (nonatomic, strong) NSDictionary *configDic;

- (instancetype)initWithDataDic:(NSDictionary *)dataDic projectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
