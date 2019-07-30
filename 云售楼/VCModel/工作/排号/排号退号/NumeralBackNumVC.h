//
//  NumeralBackNumVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NumeralBackNumVCBlock)(void);

@interface NumeralBackNumVC : BaseViewController

@property (nonatomic, copy) NumeralBackNumVCBlock numeralBackNumVCBlock;

- (instancetype)initWithProject_id:(NSString *)project_id dataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
