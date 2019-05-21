//
//  RotationHeadView.m
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RotationHeadView.h"

@implementation RotationHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"%@",dataDic[@""]];
    _beginL.text = [NSString stringWithFormat:@"今日开始时间：%@",dataDic[@"start_time"]];
    _endL.text = [NSString stringWithFormat:@"今日截止时间：%@",dataDic[@"end_time"]];
    _titleL.text = [NSString stringWithFormat:@"当前%@位",dataDic[@""]];
    _timeL.text = [NSString stringWithFormat:@"自然下位时间：%@",dataDic[@"exchange_time_min"]];
    _phoneL.text = [NSString stringWithFormat:@"%@",dataDic[@""]];
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(14*SIZE, 10*SIZE, 60*SIZE, 60*SIZE)];
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = 30*SIZE;
    _headImg.image= [UIImage imageNamed:@"def_head"];
    [self addSubview:_headImg];
    
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(81*SIZE, 30*SIZE, 80*SIZE, 14*SIZE)];
//    _nameL.text = @"小煤球";
    _nameL.font = FONT(13);
    _nameL.textColor = CLTitleLabColor;
    [self addSubview:_nameL];
    
    _beginL = [[UILabel alloc]initWithFrame:CGRectMake(230*SIZE, 30*SIZE, 130*SIZE, 13*SIZE)];
//    _beginL.text = @"今日开始时间：";
    _beginL.font = FONT(12);
    _beginL.textColor = CL86Color;
    [self addSubview:_beginL];
    
    _endL = [[UILabel alloc]initWithFrame:CGRectMake(230*SIZE, 53*SIZE, 130*SIZE, 13*SIZE)];
//    _endL.text = @"今截止始时间：";
    _endL.font = FONT(12);
    _endL.textColor = CL86Color;
    [self addSubview:_endL];
    
    _phoneL  = [[UILabel alloc]initWithFrame:CGRectMake(82*SIZE, 52*SIZE, 100*SIZE, 13*SIZE)];
//    _phoneL.text = @"13459594040";
    _phoneL.font = FONT(12);
    _phoneL.textColor = CL86Color;
    [self addSubview:_phoneL];
    
    _titleL = [[UILabel alloc]initWithFrame:CGRectMake(19*SIZE, 92*SIZE, 60*SIZE, 14*SIZE)];
//    _titleL.text = @"当前A位";
    _titleL.font = FONT(13);
    _titleL.textColor = CLTitleLabColor;
    [self addSubview:_titleL];
    
    _timeL = [[UILabel alloc]initWithFrame:CGRectMake(123*SIZE, 92*SIZE, 140*SIZE, 14*SIZE)];
//    _timeL.text = @"自然下位时间：11:30:33";
    _timeL.font = FONT(13);
    _timeL.textColor = CLBlueBtnColor;
    [self addSubview:_timeL];
    
    _compleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _compleBtn.frame = CGRectMake(290*SIZE, 87*SIZE, 60*SIZE, 23*SIZE);
    _compleBtn.titleLabel.font = FONT(13);
    [_compleBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    [_compleBtn setTitle:@"下位" forState:UIControlStateNormal];
    _compleBtn.backgroundColor = CLBlueBtnColor;
    _compleBtn.layer.masksToBounds = YES;
    _compleBtn.layer.cornerRadius = 2*SIZE;
    [self addSubview:_compleBtn];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 130*SIZE, 360*SIZE, 37*SIZE)];
    _backView.backgroundColor = CLLineColor;
    [self addSubview:_backView];
    
    _companyL = [[UILabel alloc]initWithFrame:CGRectMake(15*SIZE, 13*SIZE, 360*SIZE, 14*SIZE)];
//    _companyL.text = @"云算科技有限公司";
    _companyL.font = FONT(13);
    _companyL.textColor = CLTitleLabColor;
    [_backView addSubview:_companyL];
    
}
@end
