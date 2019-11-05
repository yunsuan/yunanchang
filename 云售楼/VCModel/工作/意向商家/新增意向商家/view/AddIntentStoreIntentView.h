//
//  AddIntentStoreIntentView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddIntentStoreIntentViewStrBlock)(NSString *str, NSInteger idx);

typedef void(^AddIntentStoreIntentViewTimeBlock)(void);

typedef void(^AddIntentStoreIntentViewPeriodBlock)(void);

@interface AddIntentStoreIntentView : UIView

@property (nonatomic, copy) AddIntentStoreIntentViewStrBlock addIntentStoreIntentViewStrBlock;

@property (nonatomic, copy) AddIntentStoreIntentViewTimeBlock addIntentStoreIntentViewTimeBlock;

@property (nonatomic, copy) AddIntentStoreIntentViewPeriodBlock addIntentStoreIntentViewPeriodBlock;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTextField *codeTF;

@property (nonatomic, strong) UILabel *sincerityL;

@property (nonatomic, strong) BorderTextField *sincerityTF;

@property (nonatomic, strong) UILabel *intentPeriodL;

@property (nonatomic, strong) DropBtn *intentPeriodLBtn;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@end

NS_ASSUME_NONNULL_END
