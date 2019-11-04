//
//  AddIntentStoreRoomCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddIntentStoreRoomCollCell.h"

@implementation AddIntentStoreRoomCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
    if (self.addIntentStoreRoomCollCellDeleteBlock) {
        
        self.addIntentStoreRoomCollCellDeleteBlock(self.tag);
    }
}

- (void)initUI{
    
    _roomL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 10 *SIZE, SCREEN_Width - 100 *SIZE, 15 *SIZE)];
    _roomL.textColor = CLTitleLabColor;
    _roomL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_roomL];
    
    _areaL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 30 *SIZE, SCREEN_Width - 100 *SIZE, 15 *SIZE)];
    _areaL.textColor = CLContentLabColor;
    _areaL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_areaL];
    
    _priceL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 50 *SIZE, SCREEN_Width - 100 *SIZE, 15 *SIZE)];
    _priceL.textColor = CLContentLabColor;
    _priceL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_priceL];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(SCREEN_Width - 100 *SIZE, 0, 100 *SIZE, 70 *SIZE);
    [_deleteBtn setBackgroundColor:[UIColor redColor]];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(ActionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0 *SIZE, 69 *SIZE, SCREEN_Width, 1 *SIZE)];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
}

@end
