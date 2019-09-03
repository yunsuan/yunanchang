//
//  SignExitRoomVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/8/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SignExitRoomVCBlock)(void);

@interface SignExitRoomVC : BaseViewController

@property (nonatomic, copy) SignExitRoomVCBlock signExitRoomVCBlock;

- (instancetype)initWithProject_id:(NSString *)project_id dataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
