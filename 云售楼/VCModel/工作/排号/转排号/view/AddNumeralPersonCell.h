//
//  AddNumeralPersonCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/2.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZQFlowLayout.h"
#import "BorderTextField.h"
#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNumeralPersonCellAddPhoneBlock)(NSInteger num);

typedef void(^AddNumeralPersonCellCollBlock)(NSInteger num);

typedef void(^AddNumeralPersonCellDropBtnBlock)(NSInteger num);

typedef void(^AddNumeralPersonCellStrBlock)(NSString *str ,NSInteger num);

@interface AddNumeralPersonCell : UITableViewCell

@property (nonatomic, copy) AddNumeralPersonCellAddPhoneBlock addNumeralPersonCellAddPhoneBlock;

@property (nonatomic, copy) AddNumeralPersonCellCollBlock addNumeralPersonCellCollBlock;

@property (nonatomic, copy) AddNumeralPersonCellDropBtnBlock addNumeralPersonCellDropBtnBlock;

@property (nonatomic, copy) AddNumeralPersonCellStrBlock addNumeralPersonCellStrBlock;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger phoneNum;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UIButton *personBtn;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTextField *nameTF;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) UIButton *maleBtn;

@property (nonatomic, strong) UIButton *femaleBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) BorderTextField *phoneTF;

@property (nonatomic, strong) BorderTextField *phoneTF2;

@property (nonatomic, strong) BorderTextField *phoneTF3;

@property (nonatomic, strong) UIButton *addBtn;

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

@property (nonatomic, strong) NSArray *cerArr;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END
