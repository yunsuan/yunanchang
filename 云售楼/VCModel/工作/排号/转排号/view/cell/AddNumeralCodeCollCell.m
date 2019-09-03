//
//  AddNumeralCodeCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddNumeralCodeCollCell.h"

@implementation AddNumeralCodeCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBackColor;
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 9.5 *SIZE, 238 *SIZE, 14 *SIZE)];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:14 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 32 *SIZE, 258 *SIZE, SIZE)];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
}

@end
