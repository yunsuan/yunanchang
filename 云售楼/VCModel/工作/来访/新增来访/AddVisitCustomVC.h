//
//  AddVisitCustomVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddVisitCustomVCBlock)(void);

@interface AddVisitCustomVC : BaseViewController

@property (nonatomic, copy) AddVisitCustomVCBlock addVisitCustomVCBlock;

//@property (nonatomic, strong) NSString *visit_id;

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
