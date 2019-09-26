//
//  TaskReportVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/9/26.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskReportVC : BaseViewController

@property (nonatomic, strong) NSString *tit;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
