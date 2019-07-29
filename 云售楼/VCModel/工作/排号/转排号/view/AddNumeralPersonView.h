//
//  AddNumeralPersonView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CallTelegramCustomDetailHeaderCollCell.h"

#import "GZQFlowLayout.h"
#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNumeralPersonViewArrBlock)(NSInteger num);

typedef void(^AddNumeralPersonViewCollBlock)(NSInteger num);

typedef void(^AddNumeralPersonViewDeleteBlock)(NSInteger num);

typedef void(^AddNumeralPersonViewEditBlock)(NSInteger num);

typedef void(^AddNumeralPersonViewAddBlock)(NSInteger num);

typedef void(^AddNumeralPersonViewStrBlock)(NSString *str ,NSInteger num);

@interface AddNumeralPersonView : UIView

@property (nonatomic, copy) AddNumeralPersonViewArrBlock addNumeralPersonViewArrBlock;

@property (nonatomic, copy) AddNumeralPersonViewCollBlock addNumeralPersonViewCollBlock;

@property (nonatomic, copy) AddNumeralPersonViewEditBlock addNumeralPersonViewEditBlock;

@property (nonatomic, copy) AddNumeralPersonViewAddBlock addNumeralPersonViewAddBlock;

@property (nonatomic, copy) AddNumeralPersonViewStrBlock addNumeralPersonViewStrBlock;

@property (nonatomic, copy) AddNumeralPersonViewDeleteBlock addNumeralPersonViewDeleteBlock;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UIButton *personBtn;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTextField *nameTF;

@property (nonatomic, strong) UIButton *topBtn;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) UIButton *maleBtn;

@property (nonatomic, strong) UIButton *femaleBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) BorderTextField *phoneTF;

@property (nonatomic, strong) BorderTextField *phoneTF2;

@property (nonatomic, strong) BorderTextField *phoneTF3;

@property (nonatomic, strong) UILabel *certTypeL;

@property (nonatomic, strong) DropBtn *certTypeBtn;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, strong) BorderTextField *certNumTF;

@property (nonatomic, strong) UILabel *birthL;

@property (nonatomic, strong) DropBtn *birthBtn;

@property (nonatomic, strong) UILabel *mailCodeL;

@property (nonatomic, strong) BorderTextField *mailCodeTF;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) BorderTextField *addressBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UILabel *proportionL;

@property (nonatomic, strong) BorderTextField *proportionTF;

@property (nonatomic, strong) NSString *proportion;

@property (nonatomic, strong) NSArray *dataArr;

@end

NS_ASSUME_NONNULL_END
