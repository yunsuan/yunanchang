//
//  SelectCompanyTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyModel.h"

@interface SelectCompanyTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) CompanyModel *model;

@end
