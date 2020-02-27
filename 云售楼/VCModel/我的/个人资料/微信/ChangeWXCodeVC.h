//
//  ChangeWXCodeVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/20.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChangeWXCodeVCBlock)(NSString *str);

@interface ChangeWXCodeVC : BaseViewController

@property (nonatomic, copy) ChangeWXCodeVCBlock changeWXCodeVCBlock;

- (instancetype)initWithWX:(NSString *)wxCode;
@end

NS_ASSUME_NONNULL_END
