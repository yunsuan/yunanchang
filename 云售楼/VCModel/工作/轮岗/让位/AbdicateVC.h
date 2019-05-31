//
//  AbdicateVC.h
//  云售楼
//
//  Created by xiaoq on 2019/5/19.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AbdicateVCBlock)(void);

@interface AbdicateVC : BaseViewController

@property (nonatomic, copy) AbdicateVCBlock abdicateVCBlock;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
