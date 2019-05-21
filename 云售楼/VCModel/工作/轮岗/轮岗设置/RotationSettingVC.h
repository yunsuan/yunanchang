//
//  RotationSettingVC.h
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RotationSettingVCBlock)(void);

@interface RotationSettingVC : BaseViewController

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, copy) RotationSettingVCBlock rotationSettingVCBlock;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
