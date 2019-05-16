//
//  FollowRecordVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FollowRecordVC : BaseViewController

@property (nonatomic, strong) NSMutableDictionary *allDic;

@property (nonatomic, strong) NSMutableDictionary *followDic;

@property (nonatomic, strong) NSString *status;

- (instancetype)initWithGroupId:(NSString *)groupId;

@end

NS_ASSUME_NONNULL_END
