//
//  OrderChangeRoomVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/8/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderChangeRoomVCBlock)(void);

@interface OrderChangeRoomVC : BaseViewController

@property (nonatomic, copy) OrderChangeRoomVCBlock orderChangeRoomVCBlock;

- (instancetype)initWithSubId:(NSString *)sub_id projectId:(NSString *)project_id info_Id:(NSString *)info_id dataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
