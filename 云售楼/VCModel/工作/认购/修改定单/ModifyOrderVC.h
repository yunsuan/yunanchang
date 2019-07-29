//
//  ModifyOrderVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/24.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ModifyOrderVCBlock)(void);

@interface ModifyOrderVC : BaseViewController

@property (nonatomic, copy) ModifyOrderVCBlock modifyOrderVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *from_type;

@property (nonatomic, strong) NSString *projectName;

- (instancetype)initWithSubId:(NSString *)sub_id projectId:(NSString *)project_id info_Id:(NSString *)info_id dataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
