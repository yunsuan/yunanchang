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

typedef void(^AddIntentStoreIntentViewPeriod1Block)(void);

typedef void(^AddIntentStoreIntentViewPeriod2Block)(void);

@interface AddIntentStoreIntentView : UIView

@property (nonatomic, copy) AddIntentStoreIntentViewStrBlock addIntentStoreIntentViewStrBlock;

@property (nonatomic, copy) AddIntentStoreIntentViewTimeBlock addIntentStoreIntentViewTimeBlock;

@property (nonatomic, copy) AddIntentStoreIntentViewPeriod1Block addIntentStoreIntentViewPeriod1Block;

@property (nonatomic, copy) AddIntentStoreIntentViewPeriod2Block addIntentStoreIntentViewPeriod2Block;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTextField *codeTF;

@property (nonatomic, strong) UILabel *sincerityL;

@property (nonatomic, strong) BorderTextField *sincerityTF;

@property (nonatomic, strong) UILabel *intentPeriodL;

@property (nonatomic, strong) DropBtn *intentPeriodLBtn1;

@property (nonatomic, strong) DropBtn *intentPeriodLBtn2;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
