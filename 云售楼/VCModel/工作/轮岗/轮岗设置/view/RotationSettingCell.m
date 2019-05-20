//
//  RotationSettingCell.m
//  云售楼
//
//  Created by xiaoq on 2019/5/19.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RotationSettingCell.h"

@implementation RotationSettingCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    //    _selectImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"default"]];
    //    _selectImg.frame = CGRectMake(10*SIZE, 29*SIZE, 15*SIZE, 15*SIZE);
    //    [self addSubview:_selectImg];
    _headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"laifang"]];
    _headerImg.frame = CGRectMake(39*SIZE, 13*SIZE, 48*SIZE, 48*SIZE);
    _headerImg.layer.masksToBounds = YES;
    _headerImg.layer.cornerRadius = 24*SIZE;
    [self addSubview:_headerImg];
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(100*SIZE, 22*SIZE, 200*SIZE, 14*SIZE)];
    _nameL.text = @"小煤球";
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = FONT(13);
    [self addSubview:_nameL];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(100*SIZE, 43*SIZE, 200*SIZE, 13*SIZE)];
    _phoneL.text = @"13433224433";
    _phoneL.font = FONT(12);
    _phoneL.textColor = CLContentLabColor;
    [self addSubview:_phoneL];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(220*SIZE, 40*SIZE, 60*SIZE, 23*SIZE);
    _deleteBtn.backgroundColor = COLOR(232, 78, 78, 1);
    [_deleteBtn setTitle:@"移除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _deleteBtn.layer.masksToBounds = YES;
    _deleteBtn.layer.cornerRadius = 2*SIZE;
    _deleteBtn.titleLabel.font =  FONT(13);
    [self addSubview:_deleteBtn];
    
    _sleepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sleepBtn.frame = CGRectMake(290*SIZE, 40*SIZE, 60*SIZE, 23*SIZE);
    _sleepBtn.backgroundColor = COLOR(27, 152, 255, 1);
    [_sleepBtn setTitle:@"休息" forState:UIControlStateNormal];
    [_sleepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sleepBtn.layer.masksToBounds = YES;
    _sleepBtn.layer.cornerRadius = 2*SIZE;
    _sleepBtn.titleLabel.font =  FONT(13);
    [self addSubview:_sleepBtn];
    
}

@end
