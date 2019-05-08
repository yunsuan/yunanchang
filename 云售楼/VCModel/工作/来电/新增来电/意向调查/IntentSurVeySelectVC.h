//
//  IntentSurVeySelectVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^IntentSurVeySelectVCBlock)(NSArray *array);

@interface IntentSurVeySelectVC : BaseViewController

@property (nonatomic, copy) IntentSurVeySelectVCBlock intentSurVeySelectVCBlock;

- (instancetype)initWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
