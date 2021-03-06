//
//  CallTelegramCustomDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallTelegramCustomDetailModifyBlock)(void);

@interface CallTelegramCustomDetailVC : BaseViewController

@property (nonatomic, copy) CallTelegramCustomDetailModifyBlock callTelegramCustomDetailModifyBlock;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *info_id;

@property (nonatomic, strong) NSDictionary *powerDic;

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithGroupId:(NSString *)groupId;

@end

NS_ASSUME_NONNULL_END
