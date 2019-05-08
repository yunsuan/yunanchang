//
//  NumeralAuditDetailCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NumeralAuditDetailCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *ordDic;

@end

NS_ASSUME_NONNULL_END
