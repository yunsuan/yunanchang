//
//  SignRentDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignRentDetailVC : BaseViewController

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *info_id;

@property (nonatomic, strong) NSString *need_check;

@property (nonatomic, strong) NSDictionary *powerDic;

- (instancetype)initWithBusinessId:(NSString *)businessId;

@end

NS_ASSUME_NONNULL_END
