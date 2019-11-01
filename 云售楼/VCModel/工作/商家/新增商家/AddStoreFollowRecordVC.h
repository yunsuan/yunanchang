//
//  AddStoreFollowRecordVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/10/31.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddStoreFollowRecordVCBlock)(void);

@interface AddStoreFollowRecordVC : BaseViewController

@property (nonatomic, copy) AddStoreFollowRecordVCBlock addStoreFollowRecordVCBlock;

@property (nonatomic, strong) NSMutableDictionary *allDic;

@property (nonatomic, strong) NSMutableDictionary *followDic;

@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END
