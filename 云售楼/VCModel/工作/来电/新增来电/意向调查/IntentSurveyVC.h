//
//  IntentSurveyVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/22.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface IntentSurveyVC : BaseViewController

@property (nonatomic, strong) NSMutableDictionary *allDic;

- (instancetype)initWithData:(NSArray *)data;

//- (instancetype)initWithPropertyId:(NSString *)propertyId;

@end

NS_ASSUME_NONNULL_END
