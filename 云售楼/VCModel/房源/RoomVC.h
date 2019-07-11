//
//  RoomVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RoomVCBlock)(NSDictionary *dic);

@interface RoomVC : BaseViewController

@property (nonatomic, copy) RoomVCBlock roomVCBlock;

@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END
