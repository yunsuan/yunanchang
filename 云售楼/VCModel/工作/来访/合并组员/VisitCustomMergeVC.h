//
//  VisitCustomMergeVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/8/28.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^VisitCustomMergeVCBlock)(void);

@interface VisitCustomMergeVC : BaseViewController

@property (nonatomic, copy) VisitCustomMergeVCBlock visitCustomMergeVCBlock;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
