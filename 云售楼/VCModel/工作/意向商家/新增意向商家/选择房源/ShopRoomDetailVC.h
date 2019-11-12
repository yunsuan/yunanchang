//
//  ShopRoomDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

#import "KyoRowIndexView.h"
#import "KyoCenterLineView.h"

#import "SMCinameSeatScrollViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShopRoomDetailVCBlock)(NSDictionary *dic, NSString *chargeId);

@interface ShopRoomDetailVC : BaseViewController

@property (weak, nonatomic) id<SMCinameSeatScrollViewDelegate> SMCinameSeatScrollViewDelegate;

@property (nonatomic, copy) ShopRoomDetailVCBlock shopRoomDetailVCBlock;

@property (nonatomic , strong) NSMutableArray *LDinfo;
//status 0 有返回按钮
@property (nonatomic , strong) NSString *LDtitle;

@property (nonatomic,strong) NSString *statusStr;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSArray *roomArr;

@end

NS_ASSUME_NONNULL_END
