//
//  RotationVC.h
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RotationVC : BaseViewController

@property (nonatomic, assign) NSInteger status;

- (instancetype)initWithProjectId:(NSString *)projectId;
@end

NS_ASSUME_NONNULL_END
