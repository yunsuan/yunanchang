//
//  VisitCustomDetailVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^VisitCustomDetailModifyBlock)(void);

@interface VisitCustomDetailVC : BaseViewController

@property (nonatomic, copy) VisitCustomDetailModifyBlock visitCustomDetailModifyBlock;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *info_id;

@property (nonatomic, strong) NSDictionary *powerDic;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *projectName;

- (instancetype)initWithGroupId:(NSString *)groupId;

@end

NS_ASSUME_NONNULL_END
