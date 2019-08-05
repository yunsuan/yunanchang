//
//  NumeralChangeNameVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NumeralChangeNameVCBlock)(void);

@interface NumeralChangeNameVC : BaseViewController

@property (nonatomic, copy) NumeralChangeNameVCBlock numeralChangeNameVCBlock;

- (instancetype)initWithProject_id:(NSString *)project_id personArr:(NSArray *)personArr dataDic:(NSDictionary *)dataDic info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
