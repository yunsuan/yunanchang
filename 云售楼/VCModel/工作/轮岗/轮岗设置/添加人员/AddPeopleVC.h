//
//  AddPeopleVC.h
//  云售楼
//
//  Created by xiaoq on 2019/5/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddPeopleVC : BaseViewController

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *duty_id;

@property (nonatomic, strong) NSString *sort;

@property (nonatomic,copy) void (^addBtnBlock)(NSDictionary *dic);

@property (nonatomic , strong) NSString *company_id;

@property (nonatomic , strong) NSArray *selectPeople;

@end

NS_ASSUME_NONNULL_END
