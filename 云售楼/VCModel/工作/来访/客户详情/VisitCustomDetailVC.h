//
//  VisitCustomDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VisitCustomDetailVC : BaseViewController

@property (nonatomic, strong) NSString *project_id;

- (instancetype)initWithGroupId:(NSString *)groupId;

@end

NS_ASSUME_NONNULL_END
