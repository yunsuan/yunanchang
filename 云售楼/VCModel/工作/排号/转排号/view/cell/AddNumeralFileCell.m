//
//  AddNumeralFileCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddNumeralFileCell.h"

@implementation AddNumeralFileCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
    if (self.addNumeralFileCellDeleteBlock) {
        
        self.addNumeralFileCellDeleteBlock(self.tag);
    }
}

- (void)initUI{
    
    _bigImg = [[UIImageView alloc] initWithFrame:CGRectMake(5 *SIZE, 3 *SIZE, 100 *SIZE, 83 *SIZE)];
//    _bigImg.image =[UIImage imageNamed:@"add_3"];
    _bigImg.contentMode = UIViewContentModeScaleAspectFill;
    _bigImg.clipsToBounds = YES;
    [self.contentView addSubview:_bigImg];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(5 *SIZE, 90 *SIZE, 100 *SIZE, 30 *SIZE)];
    _titleL.numberOfLines = 2;
    _titleL.adjustsFontSizeToFitWidth = YES;
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_cancelBtn setBackgroundColor:YJGreenColor];
    _deleteBtn.frame = CGRectMake(85 *SIZE, 0, 25 *SIZE, 25 *SIZE);
    [_deleteBtn addTarget:self action:@selector(ActionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn setImage:[UIImage imageNamed:@"fork"] forState:UIControlStateNormal];
    [self.contentView addSubview:_deleteBtn];
}

@end
