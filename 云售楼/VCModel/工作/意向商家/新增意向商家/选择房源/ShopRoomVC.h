//
//  ShopRoomVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShopRoomVCBlock)(NSDictionary *dic, NSString *chargeId);

@interface ShopRoomVC : BaseViewController

@property (nonatomic, strong) NSArray *roomArr;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *isIntent;

@property (nonatomic, copy) ShopRoomVCBlock shopRoomVCBlock;

@end

NS_ASSUME_NONNULL_END
