//
//  ModifyAndAddRentalVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ModifyAndAddRentalVC.h"

#import "BorderTextField.h"
#import "DropBtn.h"

#import "DateChooseView.h"

@interface ModifyAndAddRentalVC ()<UITextFieldDelegate>
{
    
    double _unit;
    double _result;
    double _free;
    
    NSDateFormatter *_formatter;
    NSDateFormatter *_formatter2;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) UILabel *endTimeL;

@property (nonatomic, strong) DropBtn *endTimeBtn;

@property (nonatomic, strong) UILabel *periodL;

//@property (nonatomic, strong) BorderTextField *periodTF;

@property (nonatomic, strong) UILabel *freeBeginL;

@property (nonatomic, strong) DropBtn *freeBeginBtn;

@property (nonatomic, strong) UILabel *freeEndL;

@property (nonatomic, strong) DropBtn *freeEndBtn;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) BorderTextField *totalTF;

@property (nonatomic, strong) UILabel *freeL;

@property (nonatomic, strong) BorderTextField *freeTF;

@property (nonatomic, strong) UILabel *unitL;

@property (nonatomic, strong) UILabel *resultL;

@property (nonatomic, strong) UILabel *payTimeL;

@property (nonatomic, strong) DropBtn *payTimeBtn;

@property (nonatomic, strong) UILabel *remindL;

@property (nonatomic, strong) DropBtn *remindBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) BorderTextField *marklTF;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation ModifyAndAddRentalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    _formatter2 = [[NSDateFormatter alloc] init];
    [_formatter2 setDateFormat:@"yyyy-MM-dd"];
    
    [self initUI];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {

        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        
        view.dateblock = ^(NSDate *date) {

            if (self->_endTimeBtn.content.text) {
                
                NSComparisonResult result = [date compare:[self->_formatter2 dateFromString:self->_endTimeBtn.content.text]];
                if (result == NSOrderedDescending) {
                    
                    [self showContent:@"开始时间不能大于结束时间"];
                }else{
                    
                    self->_timeBtn.content.text = [[self->_formatter stringFromDate:date] componentsSeparatedByString:@" "][0];
                    
                    NSDateComponents *delta = [self getMonthAndDayFromDate:[self->_formatter2 dateFromString:self->_timeBtn.content.text] withDate2:[self getNextDateFromDate:[self->_formatter2 dateFromString:self->_endTimeBtn.content.text]]];
                    if (delta.day == 0) {
                        
                        self->_periodL.text = [NSString stringWithFormat:@"本期时长：%ld月",(long)delta.month];
                    }else{
                    
                        self->_periodL.text = [NSString stringWithFormat:@"本期时长：%ld月%ld天",(long)delta.month,(long)delta.day];
                    }
                    if (_totalTF.textField.text) {
                        
            
                        double month = 1.0;
                        if (delta.day == 0) {
                            
                            month = delta.month;
                        }else{
                            
                            month = [self AddNumber:delta.month num2:delta.day / 30.0];
                        }
                        _unit = [_totalTF.textField.text doubleValue] / month / self.area;

                        _unitL.text = [NSString stringWithFormat:@"单价：%.2f元/月/㎡",_unit];
                        _result = [self DecimalNumber:[_totalTF.textField.text doubleValue] num2:[_freeTF.textField.text doubleValue]];
                        _resultL.text = [NSString stringWithFormat:@"应付金额：%.2f元",_result];
                    }
                }
            }else{
                
                self->_timeBtn.content.text = [[self->_formatter stringFromDate:date] componentsSeparatedByString:@" "][0];
            }
        };
        [self.view addSubview:view];
    }else if (btn.tag == 1){
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        
        view.dateblock = ^(NSDate *date) {

            if (self->_timeBtn.content.text) {
                
                NSComparisonResult result = [[self->_formatter2 dateFromString:self->_timeBtn.content.text] compare:date];
                if (result == NSOrderedDescending) {
                    
                    [self showContent:@"结束时间不能小于开始时间"];
                }else{
                    
                    self->_endTimeBtn.content.text = [[self->_formatter stringFromDate:date] componentsSeparatedByString:@" "][0];
                    
                    NSDateComponents *delta = [self getMonthAndDayFromDate:[self->_formatter2 dateFromString:self->_timeBtn.content.text] withDate2:[self getNextDateFromDate:[self->_formatter2 dateFromString:self->_endTimeBtn.content.text]]];
                    if (delta.day == 0) {
                        
                        self->_periodL.text = [NSString stringWithFormat:@"本期时长：%ld月",(long)delta.month];
                    }else{
                    
                        self->_periodL.text = [NSString stringWithFormat:@"本期时长：%ld月%ld天",(long)delta.month,(long)delta.day];
                    }
                    if (_totalTF.textField.text) {
                                
                    
                                double month = 1.0;
                                if (delta.day == 0) {
                                    
                                    month = delta.month;
                                }else{
                                    
                                    month = [self AddNumber:delta.month num2:delta.day / 30.0];
                                }
                                _unit = [_totalTF.textField.text doubleValue] / month / self.area;

                                _unitL.text = [NSString stringWithFormat:@"单价：%.2f元/月/㎡",_unit];
                                _result = [self DecimalNumber:[_totalTF.textField.text doubleValue] num2:[_freeTF.textField.text doubleValue]];
                                _resultL.text = [NSString stringWithFormat:@"应付金额：%.2f元",_result];
                            }
                }
            }else{
                
                self->_endTimeBtn.content.text = [[self->_formatter stringFromDate:date] componentsSeparatedByString:@" "][0];
            }
        };
        [self.view addSubview:view];
    }else if (btn.tag == 3){

        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [view.pickerView setCalendar:calendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:1];
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:[self->_formatter2 dateFromString:self->_timeBtn.content.text] options:0];
        [view.pickerView setMinimumDate:minDate];
        
        view.dateblock = ^(NSDate *date) {

            self->_freeBeginBtn.content.text = [[self->_formatter stringFromDate:date] componentsSeparatedByString:@" "][0];
        };
        [self.view addSubview:view];
    }else if (btn.tag == 4){

        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [view.pickerView setCalendar:calendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:1];
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:[self->_formatter2 dateFromString:self->_timeBtn.content.text] options:0];
        [view.pickerView setMinimumDate:minDate];
        
        view.dateblock = ^(NSDate *date) {

            self->_freeEndBtn.content.text = [[self->_formatter stringFromDate:date] componentsSeparatedByString:@" "][0];
        };
        [self.view addSubview:view];
    }else if (btn.tag == 9){

        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [view.pickerView setCalendar:calendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:1];
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:[self->_formatter2 dateFromString:self->_timeBtn.content.text] options:0];
        [view.pickerView setMinimumDate:minDate];
        
//        [view.pickerView setCalendar:[NSCalendar currentCalendar]];
//        [view.pickerView setMaximumDate:[NSDate date]];
//        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setDay:15];//设置最大时间为：当前时间推后10天
//        [view.pickerView setMinimumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
        view.dateblock = ^(NSDate *date) {

            self->_payTimeBtn.content.text = [self->_formatter stringFromDate:date];
            
        };
        [self.view addSubview:view];
    }else{

        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [view.pickerView setCalendar:calendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:1];
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:[self->_formatter2 dateFromString:self->_timeBtn.content.text] options:0];
        [view.pickerView setMinimumDate:minDate];
        
//        [view.pickerView setCalendar:[NSCalendar currentCalendar]];
//        [view.pickerView setMaximumDate:[NSDate date]];
//        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setDay:15];//设置最大时间为：当前时间推后10天
//        [view.pickerView setMinimumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
        view.dateblock = ^(NSDate *date) {

            self->_remindBtn.content.text = [self->_formatter stringFromDate:date];
        };
        [self.view addSubview:view];
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (!_timeBtn.content.text) {
        
        [self showContent:@"请选择租金开始时间"];
        return;
    }
    if (!_endTimeBtn.content.text) {
        
        [self showContent:@"请选择租金结束时间"];
        return;
    }
    if (!_totalTF.textField.text.length) {
        
        [self showContent:@"请输入总租金"];
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
    
    [tempDic setValue:_timeBtn.content.text forKey:@"stage_start_time"];
    [tempDic setValue:_endTimeBtn.content.text forKey:@"stage_end_time"];
    [tempDic setValue:[NSString stringWithFormat:@"%@",self.dataDic[@"stage_num"]] forKey:@"stage_num"];
//    [tempDic setValue:[_formatter2 stringFromDate:[self getPriousorLaterDateFromDate:[_formatter2 dateFromString:_timeBtn.content.text] withMonth:[_periodTF.textField.text integerValue]]] forKey:@"stage_end_time"];
    [tempDic setValue:[NSString stringWithFormat:@"%@",_totalTF.textField.text] forKey:@"total_rent"];
    [tempDic setValue:_payTimeBtn.content.text forKey:@"pay_time"];
    [tempDic setValue:_remindBtn.content.text forKey:@"remind_time"];
    
    [tempDic setValue:[NSString stringWithFormat:@"%.2f",_unit] forKey:@"unit_rent"];
//    [tempDic setValue:[NSString stringWithFormat:@"%.2f",_result] forKey:@"unit_rent"];
    if (_freeBeginBtn.content.text) {
        
        [tempDic setValue:_freeBeginBtn.content.text forKey:@"free_start_time"];
    }else{
        
        [tempDic setValue:_timeBtn.content.text forKey:@"free_start_time"];
    }
    if (_freeEndBtn.content.text) {
        
        [tempDic setValue:_freeEndBtn.content.text forKey:@"free_end_time"];
    }else{
        
        [tempDic setValue:_timeBtn.content.text forKey:@"free_end_time"];
    }
    [tempDic setValue:[NSString stringWithFormat:@"%ld",[self getMonthFromDate:[_formatter2 dateFromString:tempDic[@"free_start_time"]] withDate2:[_formatter2 dateFromString:tempDic[@"free_end_time"]]] + 1] forKey:@"free_month_num"];

    if (_freeTF.textField.text.length) {
        
        [tempDic setValue:[NSString stringWithFormat:@"%@",_freeTF.textField.text] forKey:@"free_rent"];
    }else{
        
        [tempDic setValue:@"0" forKey:@"free_rent"];
    }
    if (_marklTF.textField.text.length) {
        
        [tempDic setValue:[NSString stringWithFormat:@"%@",_marklTF.textField.text] forKey:@"comment"];
    }else{
        
        [tempDic setValue:@" " forKey:@"comment"];
    }
    if (_result < 0) {
        
        [self showContent:@"应付金额有误，检查数据是否正确"];
        return;
    }
    if ([self.status isEqualToString:@"add"]) {
        
        if (self.modifyAndAddRentalVCBlock) {
            
            self.modifyAndAddRentalVCBlock(tempDic);
        }
    }else{
        
        if (self.modifyAndAddRentalVCBlock) {
            
            self.modifyAndAddRentalVCBlock(tempDic);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _totalTF.textField) {
        
//        if (_totalTF.textField.text.length && _periodTF.textField.text) {
//
        NSDateComponents *delta = [self getMonthAndDayFromDate:[self->_formatter dateFromString:self->_timeBtn.content.text] withDate2:[self getNextDateFromDate:[self->_formatter dateFromString:self->_endTimeBtn.content.text]]];
        double month = 1.0;
        if (delta.day == 0) {
            
            month = delta.month;
        }else{
            
            month = [self AddNumber:delta.month num2:delta.day / 30.0];
        }
        _unit = [_totalTF.textField.text doubleValue] / month / self.area;

        _unitL.text = [NSString stringWithFormat:@"单价：%.2f元/月/㎡",_unit];
        _result = [self DecimalNumber:[_totalTF.textField.text doubleValue] num2:[_freeTF.textField.text doubleValue]];
        _resultL.text = [NSString stringWithFormat:@"应付金额：%.2f元",_result];
    }else if (textField == _freeTF.textField){
        
        if (_freeTF.textField.text.length) {
          
        }
//            _free = [self MultiplyingNumber:[self MultiplyingNumber:_unit num2:self.area] num2:[_freePeriodTF.textField.text doubleValue]];
//        }else{
//
//            _free = 0;
//        }
//        _originL.text = [NSString stringWithFormat:@"免租金额：%.2f元",_free];
        if (_totalTF.textField.text.length) {
            
            _result = [self DecimalNumber:[_totalTF.textField.text doubleValue] num2:[_freeTF.textField.text doubleValue]];
        }
        _resultL.text = [NSString stringWithFormat:@"应付金额：%.2f元",_result];
    }
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField == _freeTF.textField) {
        
//        if (_totalTF.textField.text.length && _periodTF.textField.text) {
//
//            if (self.area) {
//
//                _unit = [_totalTF.textField.text doubleValue] / [_periodTF.textField.text integerValue] / self.area;
//            }else{
//
//                _unit = [_totalTF.textField.text doubleValue] / [_periodTF.textField.text integerValue];
//            }
//        }else{
//
//            _unit = 0;
//        }
//        _unitL.text = [NSString stringWithFormat:@"单价：%.2f元/月/㎡",_unit];
//    }else if (textField == _freeTF.textField){
        
//        if (_freeTF.textField.text.length) {
//
//            _free = [self MultiplyingNumber:[self MultiplyingNumber:_unit num2:self.area] num2:[_freePeriodTF.textField.text doubleValue]];
//        }else{
//
//            _free = 0;
//        }
//        _originL.text = [NSString stringWithFormat:@"免租金额：%.2f元",_free];
        if (_totalTF.textField.text.length) {
            
            _result = [self DecimalNumber:[_totalTF.textField.text doubleValue] num2:[_freeTF.textField.text doubleValue]];
        }
        _resultL.text = [NSString stringWithFormat:@"应付金额：%.2f元",_result];
    }else if (textField == _totalTF.textField){
        
        NSDateComponents *delta = [self getMonthAndDayFromDate:[self->_formatter dateFromString:self->_timeBtn.content.text] withDate2:[self getNextDateFromDate:[self->_formatter dateFromString:self->_endTimeBtn.content.text]]];
        double month = 1.0;
        if (delta.day == 0) {
            
            month = delta.month;
        }else{
            
            month = [self AddNumber:delta.month num2:delta.day / 30.0];
        }
        _unit = [_totalTF.textField.text doubleValue] / month / self.area;

        _unitL.text = [NSString stringWithFormat:@"单价：%.2f元/月/㎡",_unit];
//        _result = [self DecimalNumber:[_totalTF.textField.text doubleValue] num2:[_freeTF.textField.text doubleValue]];
//        _resultL.text = [NSString stringWithFormat:@"应付金额：%.2f元",_result];
        _result = [self DecimalNumber:[_totalTF.textField.text doubleValue] num2:[_freeTF.textField.text doubleValue]];
        _resultL.text = [NSString stringWithFormat:@"应付金额：%.2f元",_result];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _totalTF.textField) {
        
        BOOL isHaveDian;
        
        //判断是否有小数点
        if ([textField.text containsString:@"."]) {
            isHaveDian = YES;
        }else{
            isHaveDian = NO;
        }
        
        if (string.length > 0) {
            
            //当前输入的字符
            unichar single = [string characterAtIndex:0];
            NSLog(@"single = %c",single);
            
            //不能输入.0~9以外的字符
            if (!((single >= '0' && single <= '9') || single == '.')){
                NSLog(@"您输入的格式不正确");
                return NO;
            }
            
            //只能有一个小数点
            if (isHaveDian && single == '.') {
                NSLog(@"只能输入一个小数点");
                return NO;
            }
            
            //如果第一位是.则前面加上0
            if ((textField.text.length == 0) && (single == '.')) {
                textField.text = @"0";
            }
            
            //如果第一位是0则后面必须输入.
            if ([textField.text hasPrefix:@"0"]) {
                if (textField.text.length > 1) {
                    NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                    if (![secondStr isEqualToString:@"."]) {
                        NSLog(@"第二个字符必须是小数点");
                        return NO;
                    }
                }else{
                    if (![string isEqualToString:@"."]) {
                        NSLog(@"第二个字符必须是小数点");
                        return NO;
                    }
                }
            }
            
            //小数点后最多能输入两位
            if (isHaveDian) {
                NSRange ran = [textField.text rangeOfString:@"."];
                //由于range.location是NSUInteger类型的，所以不能通过(range.location - ran.location) > 2来判断
                if (range.location > ran.location) {
                    if ([textField.text pathExtension].length > 1) {
                        NSLog(@"小数点后最多有两位小数");
                        return NO;
                    }
                }
            }
            
        }
        
        return YES;
    }else{
        
        return YES;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"修改租金";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    NSArray *titleArr = @[@"租金开始时间：",@"租金结束时间：",@"本期时长：",@"免租开始时间：",@"免租结束时间：",@"总租金：",@"免租金额：",@"单价：",@"应付金额：",@"交款时间：",@"提醒时间：",@"备注："];
    
    for (int i = 0; i < 12; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = FONT(13 *SIZE);
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        tf.textField.tag = i;
        [tf.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        tf.textField.delegate = self;
        if (i == 0) {
            
            _timeL = label;
            [_scrollView addSubview:_timeL];
            
            _timeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_timeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (self.dataDic.count) {
                
                _timeBtn.content.text = self.dataDic[@"stage_start_time"];
            }
            _timeBtn.tag = 0;
            [_scrollView addSubview:_timeBtn];
        }else if (i == 1){
            
            _endTimeL = label;
            [_scrollView addSubview:_endTimeL];
            
            _endTimeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_endTimeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (self.dataDic.count) {
                
                _endTimeBtn.content.text = self.dataDic[@"stage_end_time"];
            }
            _endTimeBtn.tag = 1;
            [_scrollView addSubview:_endTimeBtn];
        }else if (i == 2){
            
            _periodL = label;
            NSDateComponents *delta = [self getMonthAndDayFromDate:[self->_formatter2 dateFromString:self.dataDic[@"stage_start_time"]] withDate2:[self getNextDateFromDate:[self->_formatter2 dateFromString:self.dataDic[@"stage_end_time"]]]];
            if (delta.day == 0) {
                
                self->_periodL.text = [NSString stringWithFormat:@"本期时长：%ld月",(long)delta.month];
            }else{
            
                self->_periodL.text = [NSString stringWithFormat:@"本期时长：%ld月%ld天",(long)delta.month,(long)delta.day];
            }
            [_scrollView addSubview:_periodL];
            
        }else if (i == 3){
            
            _freeBeginL = label;
            [_scrollView addSubview:_freeBeginL];
            
            _freeBeginBtn = [[DropBtn alloc] initWithFrame:_timeBtn.frame];
            [_freeBeginBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (self.dataDic.count) {
                
                if (![self.dataDic[@"free_start_time"] isKindOfClass:[NSNull class]]) {
                    
                    _freeBeginBtn.content.text = self.dataDic[@"free_start_time"];
                }
            }
            _freeBeginBtn.tag = 3;
            [_scrollView addSubview:_freeBeginBtn];
        }else if (i == 4){
            
            _freeEndL = label;
            [_scrollView addSubview:_freeEndL];

            
            _freeEndBtn = [[DropBtn alloc] initWithFrame:_timeBtn.frame];
            [_freeEndBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (self.dataDic.count) {
                
                if (![self.dataDic[@"free_end_time"] isKindOfClass:[NSNull class]]) {
                    
                    _freeEndBtn.content.text = self.dataDic[@"free_end_time"];
                }
            }
            _freeEndBtn.tag = 4;
            [_scrollView addSubview:_freeEndBtn];
        }else if (i == 5){
            
            _totalL = label;
            _totalL.numberOfLines = 0;
            [_scrollView addSubview:_totalL];

            
            _totalTF = tf;
            _totalTF.textField.keyboardType = UIKeyboardTypeNumberPad;
            if (self.dataDic.count) {
                
                _totalTF.textField.text = self.dataDic[@"total_rent"];
            }
            [_scrollView addSubview:_totalTF];
        }else if (i == 6){
            
            _freeL = label;
            _freeL.numberOfLines = 0;
            [_scrollView addSubview:_freeL];

            
            _freeTF = tf;
            _freeTF.textField.keyboardType = UIKeyboardTypeNumberPad;
            if (self.dataDic.count) {
                
                _freeTF.textField.text = self.dataDic[@"free_rent"];
            }
            [_scrollView addSubview:_freeTF];
        }else if (i == 7){
            
            _unitL = label;
            if (self.dataDic.count) {
            
                _unitL.text = [NSString stringWithFormat:@"单价：%@元/月/㎡",self.dataDic[@"unit_rent"]];
                _unit = [self.dataDic[@"unit_rent"] doubleValue];
//                _unit = [self.dataDic[@"total_rent"] doubleValue] / [_periodTF.textField.text integerValue] / self.area;
            }
            [_scrollView addSubview:_unitL];
        }else if (i == 8){
            
            _resultL = label;
            if (self.dataDic.count) {
                
                _resultL.text = [NSString stringWithFormat:@"实付金额：%.2f元",[self DecimalNumber:[self.dataDic[@"total_rent"] doubleValue] num2:[self.dataDic[@"free_rent"] doubleValue]]];
            }
            [_scrollView addSubview:_resultL];
        }else if (i == 9){
            
            _payTimeL = label;
            [_scrollView addSubview:_payTimeL];
            
            _payTimeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_payTimeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (self.dataDic.count) {
                
                _payTimeBtn.content.text = self.dataDic[@"pay_time"];
            }
            _payTimeBtn.tag = 9;
            [_scrollView addSubview:_payTimeBtn];
        }else if (i == 10){
            
            _remindL = label;
            [_scrollView addSubview:_remindL];
            
            _remindBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_remindBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (self.dataDic.count) {
                
                _remindBtn.content.text = self.dataDic[@"remind_time"];
            }
            _remindBtn.tag = 10;
            [_scrollView addSubview:_remindBtn];
        }else{
            
            _markL = label;
            [_scrollView addSubview:_markL];
            
            _marklTF = tf;
            if (self.dataDic.count) {
                
                _marklTF.textField.text = self.dataDic[@"comment"];
            }
            [_scrollView addSubview:_marklTF];
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
    
    [_endTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
            make.top.equalTo(self->_timeBtn.mas_bottom).offset(12 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
    [_endTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_periodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_endTimeBtn.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self->_scrollView).offset(-9 *SIZE);
    }];
    
//    [_periodTF mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
//        make.top.equalTo(self->_timeBtn.mas_bottom).offset(9 *SIZE);
//        make.width.mas_equalTo(258 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
//    }];
    
    [_freeBeginL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_periodL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_freeBeginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_periodL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_freeEndL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_freeBeginBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_freeEndBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_freeBeginBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_freeEndBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_totalTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_freeEndBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_freeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_totalTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_freeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_totalTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_freeTF.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self->_scrollView).offset(-9 *SIZE);
    }];
    
    [_resultL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_unitL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self->_scrollView).offset(-9 *SIZE);
    }];
    
    
    [_payTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_resultL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_resultL.mas_bottom).offset(9 *SIZE);
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
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_remindBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_marklTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_remindBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(-10 *SIZE);
    }];
}

@end
