//
//  ModifySignVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ModifySignVCBlock)(void);

@interface ModifySignVC : BaseViewController

@property (nonatomic, copy) ModifySignVCBlock modifySignVCBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *from_type;

- (instancetype)initWithSubId:(NSString *)sub_id projectId:(NSString *)project_id info_Id:(NSString *)info_id dataDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
