//
//  CompanyHeader.m
//  云售楼
//
//  Created by xiaoq on 2019/5/19.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyHeader.h"

@implementation CompanyHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//
//        [self initUI];
//    }
//    return self;
//}

- (void)initUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0*SIZE, 360*SIZE, 37*SIZE)];
    _backView.backgroundColor = CLLineColor;
    [self addSubview:_backView];
    
    _companyL = [[UILabel alloc]initWithFrame:CGRectMake(15*SIZE, 13*SIZE, 360*SIZE, 14*SIZE)];
//    _companyL.text = @"云算科技有限公司";
    _companyL.font = FONT(13);
    _companyL.textColor = CLTitleLabColor;
    [_backView addSubview:_companyL];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(322*SIZE, 7*SIZE, 25*SIZE, 25*SIZE);
    [_addBtn setImage:[UIImage imageNamed:@"add_4"] forState:UIControlStateNormal];
    [_backView addSubview:_addBtn];
    
    _explainL = [[UILabel alloc]initWithFrame:CGRectMake(210*SIZE, 13*SIZE, 360*SIZE, 14*SIZE)];
    _explainL.text = @"（长按后可拖动人员）";
    _explainL.font = FONT(12);
    _explainL.textColor = CLContentLabColor;
    [_backView addSubview:_explainL];
    
}

@end
