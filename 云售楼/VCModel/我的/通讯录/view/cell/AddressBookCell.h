//
//  AddressBookCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddressBookCellPhoneBlock)(void);

@interface AddressBookCell : UITableViewCell

@property (nonatomic, copy) AddressBookCellPhoneBlock addressBookCellPhoneBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *departmentL;

@property (nonatomic, strong) UILabel *positionL;

@property (nonatomic, strong) UIImageView *phoneImg;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
