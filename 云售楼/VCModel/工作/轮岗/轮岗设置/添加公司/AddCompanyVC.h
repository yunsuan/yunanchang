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

@property (nonatomic,copy) void (^addBtnBlock)(NSDictionary *dic);

@property (nonatomic , strong) NSArray *selectCompany;


@end

NS_ASSUME_NONNULL_END
