//
//  RoomDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

#import "KyoRowIndexView.h"
#import "KyoCenterLineView.h"

#import "SMCinameSeatScrollViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoomDetailVC : BaseViewController

@property (weak, nonatomic) id<SMCinameSeatScrollViewDelegate> SMCinameSeatScrollViewDelegate;

@property (nonatomic , strong)NSMutableArray *LDinfo;
//status 0 有返回按钮

@property (nonatomic , strong)NSString  *LDtitle;



@property(nonatomic,strong)NSString * statusStr;

@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END
