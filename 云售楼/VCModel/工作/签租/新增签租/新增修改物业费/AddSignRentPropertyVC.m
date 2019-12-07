//
//  AddSignRentPropertyVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddSignRentPropertyVC.h"

#import "BorderTextField.h"
#import "DropBtn.h"

#import "DateChooseView.h"

@interface AddSignRentPropertyVC ()<UITextFieldDelegate>
{
    
    NSDateFormatter *_formatter;
    
    NSDateFormatter *_formatter2;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) UILabel *periodL;

@property (nonatomic, strong) BorderTextField *periodTF;
//@property (nonatomic, strong) DropBtn *endTimeBtn;

@property (nonatomic, strong) UILabel *unitL;

@property (nonatomic, strong) BorderTextField *unitTF;

@property (nonatomic, strong) UILabel *originL;

@property (nonatomic, strong) UILabel *resultL;

@property (nonatomic, strong) BorderTextField *resultTF;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) BorderTextField *marklTF;

@property (nonatomic, strong) UILabel *payTimeL;

@property (nonatomic, strong) DropBtn *payTimeBtn;

@property (nonatomic, strong) UILabel *remindL;

@property (nonatomic, strong) DropBtn *remindBtn;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddSignRentPropertyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    _formatter2 = [[NSDateFormatter alloc] init];
    [_formatter2 setDateFormat:@"YYYY-MM-dd"];
    
    [self initUI];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.dateblock = ^(NSDate *date) {
            
            self->_timeBtn.content.text = [[self->_formatter stringFromDate:date] componentsSeparatedByString:@" "][0];
        };
        [self.view addSubview:view];
    }else if (btn.tag == 1){
        
        
    }else if (btn.tag == 2){
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.dateblock = ^(NSDate *date) {
            
//            self->_endTimeBtn.content.text = [[self->_formatter stringFromDate:date] componentsSeparatedByString:@" "][0];
        };
        [self.view addSubview:view];
    }else if (btn.tag == 3){
        
        
    }else if (btn.tag == 5){
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
        [view.pickerView setCalendar:[NSCalendar currentCalendar]];
        [view.pickerView setMaximumDate:[NSDate date]];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:15];//设置最大时间为：当前时间推后10天
        [view.pickerView setMinimumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
        view.dateblock = ^(NSDate *date) {
            
            self->_payTimeBtn.content.text = [self->_formatter stringFromDate:date];
        };
        [self.view addSubview:view];
    }else{
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
        [view.pickerView setCalendar:[NSCalendar currentCalendar]];
        [view.pickerView setMaximumDate:[NSDate date]];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:15];//设置最大时间为：当前时间推后10天
        [view.pickerView setMinimumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
        view.dateblock = ^(NSDate *date) {
            
            self->_remindBtn.content.text = [self->_formatter stringFromDate:date];
        };
        [self.view addSubview:view];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_periodTF.textField.text.length && _unitTF.textField.text.length) {
        
        _originL.text = [NSString stringWithFormat:@"计算金额：%.2f元",[self MultiplyingNumber:[_periodTF.textField.text doubleValue] num2:[self MultiplyingNumber:[_unitTF.textField.text doubleValue] num2:self.area]]];
    }else{
        
        _originL.text = @"计算金额：";
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (!_timeBtn.content.text) {
        
        [self showContent:@"请选择物业费开始时间"];
        return;
    }
    
    if (!_periodTF.textField.text.length) {
        
        [self showContent:@"请输入本期时长"];
        return;
    }
    if (!_unitTF.textField.text.length) {
        
        [self showContent:@"请输入单价"];
        return;
    }
    if (!_resultTF.textField.text.length) {
        
        [self showContent:@"请输入实际金额"];
        return;
    }
    if (!_payTimeBtn.content.text) {
        
        [self showContent:@"请选择交款时间"];
        return;
    }
    if (!_remindBtn.content.text) {
        
        [self showContent:@"请选择提醒时间"];
        return;
    }
    
    NSMutableDictionary *tempDic = [@{} mutableCopy];
    
    [tempDic setValue:@"物业费" forKey:@"name"];
    [tempDic setValue:_timeBtn.content.text forKey:@"cost_start_time"];
    [tempDic setValue:_periodTF.textField.text forKey:@"cost_num"];
    [tempDic setValue:[_formatter2 stringFromDate:[self getPriousorLaterDateFromDate:[_formatter2 dateFromString:_timeBtn.content.text] withMonth:[_periodTF.textField.text integerValue]]] forKey:@"cost_end_time"];
    [tempDic setValue:[NSString stringWithFormat:@"%@",_resultTF.textField.text] forKey:@"total_cost"];
    [tempDic setValue:_payTimeBtn.content.text forKey:@"pay_time"];
    [tempDic setValue:_remindBtn.content.text forKey:@"remind_time"];
    [tempDic setValue:self.config forKey:@"config_id"];
    [tempDic setValue:@"物业费" forKey:@"config_name"];
    [tempDic setValue:@"1" forKey:@"quantity"];
    [tempDic setValue:[NSString stringWithFormat:@"%@",_unitTF.textField.text] forKey:@"unit_cost"];
    if ([self.status isEqualToString:@"add"]) {
        
        if (self.addSignRentPropertyVCBlock) {
            
            self.addSignRentPropertyVCBlock(tempDic);
        }
    }else{
        
        if (self.addSignRentPropertyVCBlock) {
            
            self.addSignRentPropertyVCBlock(tempDic);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"修改租金";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    NSArray *titleArr = @[@"计价开始时间：",@"本期时长(月)：",@"计算金额：",@"实际金额：",@"备注：",@"交款时间：",@"单价：",@"提醒时间："];
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
//        label.numberOfLines = 0;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = FONT(13 *SIZE);
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        tf.textField.tag = i;
        tf.textField.delegate = self;
        if (i == 0) {
            
            _timeL = label;
            [_scrollView addSubview:_timeL];
            
            _timeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_timeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _timeBtn.tag = 0;
            if (self.dataDic.count) {
                
                _timeBtn.content.text = self.dataDic[@"cost_start_time"];
            }
            [_scrollView addSubview:_timeBtn];
        }else if (i == 1){
            _periodL = label;
            [_scrollView addSubview:_periodL];
            
            
            _periodTF = tf;
            if (self.dataDic.count) {
                            
                _periodTF.textField.text = [NSString stringWithFormat:@"%@",self.dataDic[@"cost_num"]];
            }
            [_scrollView addSubview:_periodTF];
        }else if (i == 2){
            
            _originL = label;
            _originL.numberOfLines = 0;
            [_scrollView addSubview:_originL];
            
            
            _resultTF = tf;
            _resultTF.textField.keyboardType = UIKeyboardTypeNumberPad;
            if (self.dataDic.count) {
                
                _resultTF.textField.text = self.dataDic[@"total_cost"];
            }
            [_scrollView addSubview:_resultTF];
        }else if (i == 3){
            
            _resultL = label;
            [_scrollView addSubview:_resultL];
            
            
            _marklTF = tf;
            if (self.dataDic.count) {
                
                _marklTF.textField.text = self.dataDic[@"comment"];
            }
            [_scrollView addSubview:_marklTF];
        }else if (i == 4){
            
            _markL = label;
            [_scrollView addSubview:_markL];
            
            
            _payTimeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_payTimeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _payTimeBtn.tag = 5;
            if (self.dataDic.count) {
                
                _payTimeBtn.content.text = self.dataDic[@"pay_time"];
            }
            [_scrollView addSubview:_payTimeBtn];
        }else if (i == 5){
            
            _payTimeL = label;
            [_scrollView addSubview:_payTimeL];
            
            
            _unitTF = tf;
            _unitTF.textField.keyboardType = UIKeyboardTypeNumberPad;
            if (self.dataDic.count) {
                
                _unitTF.textField.text = self.dataDic[@"unit_cost"];
            }
            [_scrollView addSubview:_unitTF];
        }else if (i == 6){
            
            _unitL = label;
            [_scrollView addSubview:_unitL];
        }else{
            
            
            _remindL = label;
            [_scrollView addSubview:_remindL];
            
            _remindBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_remindBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _remindBtn.tag = 6;
            if (self.dataDic.count) {
                
                _remindBtn.content.text = self.dataDic[@"remind_time"];
            }
            [_scrollView addSubview:_remindBtn];
        }
    }
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(9 *SIZE);
        make.top.equalTo(_scrollView).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(80 *SIZE);
        make.top.equalTo(_scrollView).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_periodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_periodTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_periodTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_unitTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_periodTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_originL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_unitTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_resultL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_originL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_resultTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_originL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_resultTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_marklTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_resultTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_marklTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_marklTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_remindL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_payTimeBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_remindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_payTimeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(-10 *SIZE);
    }];
}

@end
