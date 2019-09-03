//
//  OrderPayWayChangeVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/8/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderPayWayChangeVCBlock)(void);

@interface OrderPayWayChangeVC : BaseViewController

@property (nonatomic, copy) OrderPayWayChangeVCBlock orderPayWayChangeVCBlock;

- (instancetype)initWithSubId:(NSString *)sub_id projectId:(NSString *)project_id info_Id:(NSString *)info_id dataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
