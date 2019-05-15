//
//  CallTelegramCustomDetailHeaderCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramCustomDetailHeaderCollCell.h"

@implementation CallTelegramCustomDetailHeaderCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setIsSelect:(NSInteger)isSelect{
    
    if (isSelect) {
        
        self.contentView.backgroundColor = CLOrangeColor;
        _titleL.textColor = CLWhiteColor;
    }else{
        
        self.contentView.backgroundColor = CLBackColor;
        _titleL.textColor = CL86Color;
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBackColor;
    
    self.contentView.layer.cornerRadius = 3 *SIZE;
    self.contentView.clipsToBounds = YES;
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CL86Color;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_titleL];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.width.mas_equalTo(67 *SIZE);
    }];
}


@end
