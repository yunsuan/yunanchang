//
//  BrandCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/31.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BrandCollCell.h"

@implementation BrandCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 10 *SIZE, SCREEN_Width - 20 *SIZE, 15 *SIZE)];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 30 *SIZE, SCREEN_Width - 20 *SIZE, 15 *SIZE)];
    _contentL.textColor = CLContentLabColor;
    _contentL.font = FONT(12 *SIZE);
    [self.contentView addSubview:_contentL];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0 *SIZE, 49 *SIZE, SCREEN_Width, 1 *SIZE)];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
}

@end
