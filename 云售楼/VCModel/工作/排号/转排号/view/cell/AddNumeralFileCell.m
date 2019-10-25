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
        
        self.addNumeralFileCellDeleteBlock(btn.tag);
    }
}

- (void)initUI{
    
    _bigImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 100 *SIZE, 83 *SIZE)];
//    _bigImg.image =[UIImage imageNamed:@"add_3"];
    _bigImg.contentMode = UIViewContentModeScaleAspectFill;
    _bigImg.clipsToBounds = YES;
    [self.contentView addSubview:_bigImg];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_cancelBtn setBackgroundColor:YJGreenColor];
    _deleteBtn.frame = CGRectMake(95 *SIZE, 0, 20 *SIZE, 20 *SIZE);
    [_deleteBtn addTarget:self action:@selector(ActionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn setImage:[UIImage imageNamed:@"fork"] forState:UIControlStateNormal];
    [self.contentView addSubview:_deleteBtn];
}

@end
