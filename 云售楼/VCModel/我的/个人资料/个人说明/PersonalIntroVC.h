//
//  PersonalIntroVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PersonalIntroVCBlock)(NSString *str);

@interface PersonalIntroVC : BaseViewController

@property (nonatomic, copy) PersonalIntroVCBlock personalIntroVCBlock;

- (instancetype)initWithIntro:(NSString *)intro;

@end

NS_ASSUME_NONNULL_END
