//
//  SignDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SignDetailVCBlock)(void);

@interface SignDetailVC : BaseViewController

@property (nonatomic, copy) SignDetailVCBlock signDetailVCBlock;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *info_id;

@property (nonatomic, strong) NSDictionary *powerDic;

@property (nonatomic, strong) NSString *need_check;

@property (nonatomic, strong) NSString *projectName;

- (instancetype)initWithSubId:(NSString *)sub_id;

- (instancetype)initWithHouseId:(NSString *)house_id;

@end

NS_ASSUME_NONNULL_END
