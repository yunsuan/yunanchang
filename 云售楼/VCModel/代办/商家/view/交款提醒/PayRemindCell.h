//
//  PayRemindCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayRemindCell : UITableViewCell

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *readImg;

@property (nonatomic, strong) UILabel *contractL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UILabel *moneyL;

@property (nonatomic, strong) UILabel *FeeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
