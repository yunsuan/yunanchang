//
//  OrderDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailVC : BaseViewController

@property (nonatomic, strong) NSString *project_id;

- (instancetype)initWithSubId:(NSString *)sub_id;

@end

NS_ASSUME_NONNULL_END
