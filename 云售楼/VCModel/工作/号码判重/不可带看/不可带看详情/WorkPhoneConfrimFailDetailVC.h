//
//  WorkPhoneConfrimFailDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^WorkPhoneConfrimFailDetailVCVCBlock)(void);

@interface WorkPhoneConfrimFailDetailVC : BaseViewController

@property (nonatomic, copy) WorkPhoneConfrimFailDetailVCVCBlock workPhoneConfrimFailDetailVCVCBlock;

- (instancetype)initWithClientId:(NSString *)clientId;

@end

NS_ASSUME_NONNULL_END
