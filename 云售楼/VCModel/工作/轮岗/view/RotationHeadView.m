//
//  RotationHeadView.m
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RotationHeadView.h"

@interface RotationHeadView ()

{
    
    NSTimer *_timer;
    NSDateFormatter *_formatter;
}

@property (nonatomic , assign)  NSInteger day;
@property (nonatomic , assign)  NSInteger hour;
@property (nonatomic , assign)  NSInteger min;
@property (nonatomic , assign)  NSInteger sec;

@end

@implementation RotationHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _timer = [[NSTimer alloc] init];
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"HH:mm:ss"];
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if (dataDic[@"agent_name"]) {
        
        _nameL.text = [NSString stringWithFormat:@"%@",dataDic[@"agent_name"]];
    }else{
        
        _nameL.text = @"暂无开启";
    }
    
    if (dataDic[@"agent_tel"]) {
        
        _phoneL.text = [NSString stringWithFormat:@"%@",dataDic[@"agent_tel"]];
    }
    
    if (dataDic[@"agent_name"]) {
        
        _titleL.text = [NSString stringWithFormat:@"当前A位"];
    }else{
        
        _titleL.text = @"暂无开启";
    }
    
    _beginL.text = [NSString stringWithFormat:@"今日开始时间：%@",dataDic[@"start_time"]];
    _endL.text = [NSString stringWithFormat:@"今日截止时间：%@",dataDic[@"end_time"]];
    
//    _timeL.text = [NSString stringWithFormat:@"自然下位时间：%@",[_formatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:[dataDic[@"finish_time"] doubleValue]]]];
    __block double time = [dataDic[@"finish_time"] doubleValue];
    
    if (time < 1) {
        
        [_timer invalidate];
        if (time == 0) {
            
            if (dataDic[@"agent_name"]) {
                
                if (self.rotationHeadViewBlock) {
                    
                    self.rotationHeadViewBlock();
                }
            }
        }
        
        _timeL.text = [NSString stringWithFormat:@"自然下岗时间：0:0:0"];
    }else{
        
        
        self->_day =  (int)time /86400;
        self->_hour =(int)time%86400/3600;
        self->_min = (int)time%86400%3600/60;
        self->_sec = (int)time%86400%3600%60;
        //     修改倒计时标签及显示内容
        
        _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
        if (!_timer) {
            
            _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerUpdate) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            [_timer fire];
        }
    }
    
    if (dataDic[@"agent_tel"]) {
        
        if ([dataDic[@"agent_tel"] isEqualToString:[UserInfoModel defaultModel].tel]) {
            
            _compleBtn.hidden = NO;
        }else{
            
            _compleBtn.hidden = YES;
        }
    }else{
        
        _compleBtn.hidden = YES;
    }
}

-(void)timerUpdate
{
    if (_sec >0) {
        _sec--;
        _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
    }
    else
    {
        if (_min > 0) {
            _min--;
            _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
            _sec = 59;
            _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
        }
        else{
            if (_hour > 0) {
                _hour--;
                _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
                _min = 59;
                _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
                _sec = 59;
                _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
            }
            else
            {
                if (_day > 0) {
                    _day--;
                    _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
                    _hour= 23;
                    _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
                    _min = 59;
                    _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
                    _sec = 59;
                    _timeL.text = [NSString stringWithFormat:@"自然下岗时间：%ld:%ld:%ld",(long)_hour,(long)_min,(long)_sec];
                }
                else
                {
                    
                    [_timer invalidate];
                    _timer = nil;
                    if (self.rotationHeadViewBlock) {
                        
                        self.rotationHeadViewBlock();
                    }
                }
            }
            
        }
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (self.rotationHeadViewBlock) {
        
        self.rotationHeadViewBlock();
    }
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
    
    _timeL = [[UILabel alloc]initWithFrame:CGRectMake(120*SIZE, 92*SIZE, 140*SIZE, 14*SIZE)];
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
    [_compleBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
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
