//
//  AddressTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddressTableCell.h"

@implementation AddressTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
 
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 100 *SIZE, 11 *SIZE)];
    _titleL.textColor = CL86Color;
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_titleL];

}

@end
