//
//  TypeTagCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TypeTagCollCell.h"

@implementation TypeTagCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 14 *SIZE, SCREEN_Width / 4, 11 *SIZE)];
    _titleL.textColor = CL86Color;
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(31 *SIZE, 38 *SIZE, 28 *SIZE, 2 *SIZE)];
    _line.backgroundColor = COLOR(27, 152, 255, 1);
    _line.hidden = YES;
    [self.contentView addSubview:_line];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        _titleL.textColor = CLTitleLabColor;
        _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
        _line.hidden = NO;
    }else{
        
        _titleL.textColor = CL86Color;
        _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
        _line.hidden = YES;
    }
}

@end
