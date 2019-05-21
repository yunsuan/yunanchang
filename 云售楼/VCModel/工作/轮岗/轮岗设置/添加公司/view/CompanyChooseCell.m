//
//  CompanyChooseCell.m
//  云售楼
//
//  Created by xiaoq on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyChooseCell.h"

@implementation CompanyChooseCell

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
    _headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"company"]];
    _headerImg.frame = CGRectMake(39*SIZE, 10*SIZE, 67*SIZE, 67*SIZE);
    //    _headerImg.layer.masksToBounds = YES;
    //    _headerImg.layer.cornerRadius = 24*SIZE;
    [self addSubview:_headerImg];
    _companyL = [[UILabel alloc]initWithFrame:CGRectMake(118*SIZE, 20*SIZE, 200*SIZE, 14*SIZE)];
//    _nameL.text = @"云算科技";
    _companyL.textColor = CLTitleLabColor;
    _companyL.font = FONT(13);
    [self addSubview:_companyL];
    
    
//    [self addSubview:_headerImg];
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(118*SIZE, 40*SIZE, 200*SIZE, 14*SIZE)];
//    _nameL.text = @"负责人：张三";
    _nameL.textColor = CLContentLabColor;
    _nameL.font = FONT(12);
    [self addSubview:_nameL];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(118*SIZE, 58*SIZE, 200*SIZE, 13*SIZE)];
//    _phoneL.text = @"联系电话：13433224433";
    _phoneL.font = FONT(12);
    _phoneL.textColor = CLContentLabColor;
    [self addSubview:_phoneL];
    
    
}
@end
