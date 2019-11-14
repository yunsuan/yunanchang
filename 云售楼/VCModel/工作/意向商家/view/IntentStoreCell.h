//
//  IntentStoreCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^IntentStoreCellBlock)(NSInteger index);

@interface IntentStoreCell : UITableViewCell

@property (nonatomic, copy) IntentStoreCellBlock intentStoreCellBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contractL;

@property (nonatomic, strong) UILabel *registerL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UILabel *buildL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *auditL;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
