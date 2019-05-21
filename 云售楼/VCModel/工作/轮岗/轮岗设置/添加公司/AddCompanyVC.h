//
//  AddCompanyVC.h
//  云售楼
//
//  Created by xiaoq on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface AddCompanyVC : BaseViewController

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *duty_id;

@property (nonatomic, strong) NSString *sort;

@property (nonatomic,copy) void (^addBtnBlock)(NSMutableDictionary *dic);

@property (nonatomic , strong) NSArray *selectCompany;


@end

NS_ASSUME_NONNULL_END
