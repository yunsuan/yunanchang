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
    
    NSDateFormatter *_formatter;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) UILabel *periodL;

@property (nonatomic, strong) BorderTextField *periodTF;

@property (nonatomic, strong) UILabel *freeL;

@property (nonatomic, strong) DropBtn *freeBtn;

@property (nonatomic, strong) UILabel *freePeriodL;

@property (nonatomic, strong) BorderTextField *freePeriodTF;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) BorderTextField *totalTF;

@property (nonatomic, strong) UILabel *unitL;

@property (nonatomic, strong) UILabel *originL;

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
    [_formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [self initUI];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {

        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.dateblock = ^(NSDate *date) {

            self->_timeBtn.content.text = [[self->_formatter stringFromDate:date] componentsSeparatedByString:@" "][0];
        };
        [self.view addSubview:view];
    }else if (btn.tag == 2){

        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.dateblock = ^(NSDate *date) {

            self->_freeBtn.content.text = [[self->_formatter stringFromDate:date] componentsSeparatedByString:@" "][0];
        };
        [self.view addSubview:view];
    }else if (btn.tag == 8){

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

- (void)ActionNextBtn:(UIButton *)btn{
    
    if ([self.status isEqualToString:@"add"]) {
        
        
    }else{
        
        
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
    
    NSArray *titleArr = @[@"租金开始时间：",@"本期时长：",@"免租期开始时间：",@"免租期时长：",@"总租金（无免租期金额）：",@"单价：",@"免租金额：",@"实付金额：",@"交款时间：",@"提醒时间：",@"备注："];
    
    for (int i = 0; i < 11; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = FONT(13 *SIZE);
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        tf.textField.tag = i;
        tf.textField.delegate = self;
        if (i == 0) {
            
            _timeL = label;
            [_scrollView addSubview:_timeL];
            
            _timeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_timeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _timeBtn.tag = 0;
            [_scrollView addSubview:_timeBtn];
        }else if (i == 1){
            
            _periodL = label;
            [_scrollView addSubview:_periodL];
            
            _periodTF = tf;
            [_scrollView addSubview:_periodTF];
        }else if (i == 2){
            
            _freeL = label;
            [_scrollView addSubview:_freeL];
            
            _freeBtn = [[DropBtn alloc] initWithFrame:_timeBtn.frame];
            [_freeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _freeBtn.tag = 2;
            [_scrollView addSubview:_freeBtn];
        }else if (i == 3){
            
            _freePeriodL = label;
            [_scrollView addSubview:_freePeriodL];

            
            _freePeriodTF = tf;
            _freePeriodTF.textField.keyboardType = UIKeyboardTypeNumberPad;
            [_scrollView addSubview:_freePeriodTF];
        }else if (i == 4){
            
            _totalL = label;
            _totalL.numberOfLines = 0;
            [_scrollView addSubview:_totalL];

            
            _totalTF = tf;
            _totalTF.textField.keyboardType = UIKeyboardTypeNumberPad;
            [_scrollView addSubview:_totalTF];
        }else if (i == 5){
            
            _unitL = label;
            [_scrollView addSubview:_unitL];
        }else if (i == 6){
            
            _originL = label;
            [_scrollView addSubview:_originL];
        }else if (i == 7){
            
            _resultL = label;
            [_scrollView addSubview:_resultL];
        }else if (i == 8){
            
            _payTimeL = label;
            [_scrollView addSubview:_payTimeL];
            
            _payTimeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_payTimeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _payTimeBtn.tag = 8;
            [_scrollView addSubview:_payTimeBtn];
        }else if (i == 9){
            
            _remindL = label;
            [_scrollView addSubview:_remindL];
            
            _remindBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_remindBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _remindBtn.tag = 9;
            [_scrollView addSubview:_remindBtn];
        }else{
            
            _markL = label;
            [_scrollView addSubview:_markL];
            
            _marklTF = tf;
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
    
    [_freeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_periodTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_freeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_periodTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_freePeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_freeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_freePeriodTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_freeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_freePeriodTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_totalTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_freePeriodTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_totalTF.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self->_scrollView).offset(-9 *SIZE);
    }];
    
    [_originL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_unitL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self->_scrollView).offset(-9 *SIZE);
    }];
    
    [_resultL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_originL.mas_bottom).offset(18 *SIZE);
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
