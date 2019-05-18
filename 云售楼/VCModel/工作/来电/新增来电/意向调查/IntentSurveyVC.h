//
//  IntentSurveyVC.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/22.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^IntentSurveyVCBlock)(void);

@interface IntentSurveyVC : BaseViewController

@property (nonatomic, copy) IntentSurveyVCBlock intentSurveyVCBlock;

@property (nonatomic, strong) NSMutableDictionary *allDic;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *property_id;

- (instancetype)initWithData:(NSArray *)data;

//- (instancetype)initWithPropertyId:(NSString *)propertyId;

@end

NS_ASSUME_NONNULL_END
