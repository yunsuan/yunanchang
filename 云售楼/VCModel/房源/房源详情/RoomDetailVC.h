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

@property (nonatomic , strong)NSMutableArray *myarr;
@property (nonatomic , strong)NSMutableArray *LDinfo;
@property (nonatomic , strong)NSString *project_id;
@property (nonatomic , strong)NSString *build_id;
@property (nonatomic , strong)NSString *unit_id;
@property (nonatomic , strong)NSDictionary *LDdic;
@property (nonatomic , strong)NSString *titleinfo;

@property (nonatomic, strong) NSString *titleStr;

//status 0 有返回按钮
@property(nonatomic,strong)NSString * statusStr;

@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END
