//
//  AddNumeralInfoView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNumeralInfoViewDropBlock)(void);

typedef void(^AddNumeralInfoViewStrBlock)(NSString *str ,NSInteger num);

typedef void(^AddNumeralInfoViewInfoTimeBlock)(void);

typedef void(^AddNumeralInfoViewFailTimeBlock)(void);

@interface AddNumeralInfoView : UIView

@property (nonatomic, copy) AddNumeralInfoViewDropBlock addNumeralInfoViewDropBlock;

@property (nonatomic, copy) AddNumeralInfoViewStrBlock addNumeralInfoViewStrBlock;

@property (nonatomic, copy) AddNumeralInfoViewInfoTimeBlock addNumeralInfoViewInfoTimeBlock;

@property (nonatomic, copy) AddNumeralInfoViewFailTimeBlock addNumeralInfoViewFailTimeBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTextField *nameTF;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropBtn *typeBtn;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) BorderTextField *numTF;

@property (nonatomic, strong) UILabel *freeL;

@property (nonatomic, strong) BorderTextField *freeTF;

@property (nonatomic, strong) UILabel *infoTimeL;

@property (nonatomic, strong) DropBtn *infoTimeBtn;

@property (nonatomic, strong) UILabel *failTimeL;

@property (nonatomic, strong) DropBtn *failTimeBtn;

@property (nonatomic, strong) NSMutableArray *typeArr;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
