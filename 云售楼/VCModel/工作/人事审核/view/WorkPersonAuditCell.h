//
//  WorkPersonAuditCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkPersonAuditCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *roleL;

@property (nonatomic, strong) UIButton *refuseBtn;

@property (nonatomic, strong) UIButton *agreeBtn;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
