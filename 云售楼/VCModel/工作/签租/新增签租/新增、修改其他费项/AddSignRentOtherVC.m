//
//  AddSignRentOtherVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddSignRentOtherVC.h"

#import "BorderTextField.h"
#import "DropBtn.h"

#import "DateChooseView.h"
#import "SinglePickView.h"

@interface AddSignRentOtherVC ()<UITextFieldDelegate>
{
    
    NSString *_type;
    
    NSDateFormatter *_formatter;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTextField *nameTF;

@property (nonatomic, strong) UILabel *payTimeL;

@property (nonatomic, strong) DropBtn *payTimeBtn;

@property (nonatomic, strong) UILabel *remindL;

@property (nonatomic, strong) DropBtn *remindBtn;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropBtn *typeBtn;

@property (nonatomic, strong) UILabel *periodL;

@property (nonatomic, strong) DropBtn *periodBtn;

@property (nonatomic, strong) DropBtn *periodBtn2;

@property (nonatomic, strong) UILabel *unitL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) BorderTextField *numTF;

@property (nonatomic, strong) UILabel *originL;

@property (nonatomic, strong) UILabel *resultL;

@property (nonatomic, strong) BorderTextField *resultTF;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) BorderTextField *marklTF;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddSignRentOtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _type = @"4";
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    
    [self initUI];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    if (btn.tag == 1) {
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.dateblock = ^(NSDate *date) {
            
            self->_payTimeBtn.content.text = [self->_formatter stringFromDate:date];
        };
        [self.view addSubview:view];
    }else if (btn.tag == 2){
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.dateblock = ^(NSDate *date) {
            
            self->_remindBtn.content.text = [self->_formatter stringFromDate:date];
        };
        [self.view addSubview:view];
    }else if (btn.tag == 3){
    
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (int i = 0; i < self.excuteArr.count; i++) {
            
            if ([self.excuteArr[i][@"is_execute"] integerValue] == 1) {
                
                [tempArr addObject:@{@"id":[NSString stringWithFormat:@"%@",self.excuteArr[i][@"config_id"]],@"param":self.excuteArr[i][@"name"]}];
            }
        }
        SinglePickView *view= [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:tempArr];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            self.typeBtn.content.text = MC;
            self.typeBtn->str = [NSString stringWithFormat:@"%@",ID];
            for (int i = 0; i < self.excuteArr.count; i++) {
                
                if ([ID integerValue] == [self.excuteArr[i][@"config_id"] integerValue]) {
                    
                    if ([self.excuteArr[i][@"formula"] integerValue] == 1) {
                       
                        self->_type = @"1";
                
                        self.periodL.hidden = YES;
                        self.periodBtn.hidden = YES;
                        self.periodBtn2.hidden = YES;
                        self->_unitL.hidden = NO;
                        self->_numL.hidden = NO;
                        self->_numTF.hidden = NO;
                        self->_originL.hidden = NO;
                        
                        self->_resultTF.userInteractionEnabled = NO;
                        
                        self->_resultL.text = @"实际金额";
                        
                        [self->_originL mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                            make.top.equalTo(self->_numTF.mas_bottom).offset(9 *SIZE);
                            make.width.mas_equalTo(258 *SIZE);
                        }];
                        
                        [self->_unitL mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                            make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
                            make.width.mas_equalTo(258 *SIZE);
                        }];
                        
                        
                        [self->_resultL mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                            make.top.equalTo(self->_originL.mas_bottom).offset(12 *SIZE);
                            make.width.mas_equalTo(70 *SIZE);
                        }];
                        
                        [self->_resultTF mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(80 *SIZE);
                            make.top.equalTo(self->_originL.mas_bottom).offset(9 *SIZE);
                            make.width.mas_equalTo(258 *SIZE);
                            make.height.mas_equalTo(33 *SIZE);
                        }];
                    }else if ([self.excuteArr[i][@"formula"] integerValue] == 2){
                        
                        self->_type = @"2";
                        
                        self.periodL.hidden = NO;
                        self.periodBtn.hidden = NO;
                        self.periodBtn2.hidden = NO;
                        self->_unitL.hidden = NO;
                        self->_numL.hidden = YES;
                        self->_numTF.hidden = YES;
                        self->_originL.hidden = NO;
                        
                        self->_resultTF.userInteractionEnabled = NO;
                        self->_resultL.text = @"实际金额";
                        [self->_originL mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                            make.top.equalTo(self->_unitL.mas_bottom).offset(9 *SIZE);
                            make.width.mas_equalTo(258 *SIZE);
                        }];
                        
                        [self->_unitL mas_remakeConstraints:^(MASConstraintMaker *make) {
                                
                                make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                                make.top.equalTo(self->_periodBtn.mas_bottom).offset(9 *SIZE);
                                make.width.mas_equalTo(258 *SIZE);
                        //        make.height.mas_equalTo(33 *SIZE);
                            }];
                        
                        [self->_resultL mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                            make.top.equalTo(self->_originL.mas_bottom).offset(12 *SIZE);
                            make.width.mas_equalTo(70 *SIZE);
                        }];
                        
                        [self->_resultTF mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(80 *SIZE);
                            make.top.equalTo(self->_originL.mas_bottom).offset(9 *SIZE);
                            make.width.mas_equalTo(258 *SIZE);
                            make.height.mas_equalTo(33 *SIZE);
                        }];
                    }else if ([self.excuteArr[i][@"formula"] integerValue] == 3){
                        
                        self->_type = @"3";
                        
                        self->_resultTF.userInteractionEnabled = NO;
                        self->_resultL.text = @"费项金额";
                        
                        self.periodL.hidden = YES;
                        self.periodBtn.hidden = YES;
                        self.periodBtn2.hidden = YES;
                        self->_unitL.hidden = YES;
                        self->_numL.hidden = YES;
                        self->_numTF.hidden = YES;
                        self->_originL.hidden = YES;
                        
                        [self->_originL mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                            make.top.equalTo(self->_numTF.mas_bottom).offset(9 *SIZE);
                            make.width.mas_equalTo(258 *SIZE);
                        }];
                        
                        [self->_resultL mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                            make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
                            make.width.mas_equalTo(70 *SIZE);
                        }];
                        
                        [self->_resultTF mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(80 *SIZE);
                            make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
                            make.width.mas_equalTo(258 *SIZE);
                            make.height.mas_equalTo(33 *SIZE);
                        }];
                    }else{
                        
                        self->_type = @"4";
                        
                        self.periodL.hidden = YES;
                        self.periodBtn.hidden = YES;
                        self.periodBtn2.hidden = YES;
                        self->_unitL.hidden = YES;
                        self->_numL.hidden = YES;
                        self->_numTF.hidden = YES;
                        self->_originL.hidden = YES;
                        
                        self->_resultTF.userInteractionEnabled = YES;
                        self->_resultL.text = @"费项金额";
                        
                        [self->_originL mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                            make.top.equalTo(self->_numTF.mas_bottom).offset(9 *SIZE);
                            make.width.mas_equalTo(258 *SIZE);
                        }];
                        
                        [self->_resultL mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                            make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
                            make.width.mas_equalTo(70 *SIZE);
                        }];
                        
                        [self->_resultTF mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_scrollView).offset(80 *SIZE);
                            make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
                            make.width.mas_equalTo(258 *SIZE);
                            make.height.mas_equalTo(33 *SIZE);
                        }];
                    }
                }
            }
        };
        [self.view addSubview:view];
    }else if (btn.tag == 4){
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.dateblock = ^(NSDate *date) {
            
            self->_periodBtn.content.text = [self->_formatter stringFromDate:date];
        };
        [self.view addSubview:view];
    }else{
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.dateblock = ^(NSDate *date) {
            
            self->_periodBtn2.content.text = [self->_formatter stringFromDate:date];
        };
        [self.view addSubview:view];
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (!_nameTF.textField.text.length) {
        
        [self showContent:@"请输入费项名称"];
        return;
    }
    if (!_payTimeBtn.content.text.length) {
        
        [self showContent:@"请选择交款时间"];
        return;
    }
    if (!_remindBtn.content.text.length) {
        
        [self showContent:@"请选择提醒时间"];
        return;
    }
    if (!_resultTF.textField.text.length) {
        
        if ([_type integerValue] < 3) {
            
            [self showContent:@"请输入实际金额"];
        }else{
            
            [self showContent:@"请输入费项金额"];
        }
        
        return;
    }
    if (!_typeBtn.content.text.length) {
        
        [self showContent:@"请选择费项类别"];
        return;
    }
    if ([_type integerValue] == 1) {
        
        
    }else if ([_type integerValue] == 2){
        
        
    }else if ([_type integerValue] == 3){
        
        
    }else{
        
        
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"修改租金";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    NSArray *titleArr = @[@"费项名称：",@"交款时间：",@"提醒时间：",@"费项类别：",@"费用周期：",@"单价：",@"用量：",@"计算金额：",@"实际金额：",@"备注："];
    
    for (int i = 0; i < 10; i++) {
        
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
            
            _nameL = label;
            [_scrollView addSubview:_nameL];
            
            _nameTF = tf;
            [_scrollView addSubview:_nameTF];
        }else if (i == 1){
            
            _payTimeL = label;
            [_scrollView addSubview:_payTimeL];
            
            _payTimeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_payTimeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _payTimeBtn.tag = i;
            [_scrollView addSubview:_payTimeBtn];
        }else if (i == 2){
            
            _remindL = label;;
            [_scrollView addSubview:_remindL];
            
            _remindBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_remindBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _remindBtn.tag = i;
            [_scrollView addSubview:_remindBtn];
        }else if (i == 3){
            
            _typeL = label;
            [_scrollView addSubview:_typeL];
            
            _typeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_typeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _typeBtn.tag = i;
            [_scrollView addSubview:_typeBtn];
        }else if (i == 4){
            
            _periodL = label;
            _periodL.hidden = YES;
            [_scrollView addSubview:_periodL];
            
            _periodBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 110 *SIZE, 33 *SIZE)];
            [_periodBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _periodBtn.hidden = YES;
            _periodBtn.tag = i;
            [_scrollView addSubview:_periodBtn];
        }else if (i == 5){
            
            _unitL = label;
            _unitL.hidden = YES;
            [_scrollView addSubview:_unitL];
            
            _periodBtn2 = [[DropBtn alloc] initWithFrame:_periodBtn.frame];
            [_periodBtn2 addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            _periodBtn2.hidden = YES;
            _periodBtn2.tag = i;
            [_scrollView addSubview:_periodBtn2];
        }else if (i == 6){
            
            _numL = label;
            _numL.hidden = YES;
            [_scrollView addSubview:_numL];
            
            _numTF = tf;
            _numTF.hidden = YES;
            _numTF.textField.keyboardType = UIKeyboardTypeNumberPad;
            [_scrollView addSubview:_numTF];
        }else if (i == 7){
            
            _originL = label;
            _originL.hidden = YES;
            [_scrollView addSubview:_originL];
        }else if (i == 8){
            
            _resultL = label;
            [_scrollView addSubview:_resultL];
            
            _resultTF = tf;
            _resultTF.textField.keyboardType = UIKeyboardTypeNumberPad;
            [_scrollView addSubview:_resultTF];
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
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(9 *SIZE);
        make.top.equalTo(_scrollView).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(80 *SIZE);
        make.top.equalTo(_scrollView).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_remindL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_payTimeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_remindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_payTimeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_remindBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_remindBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_periodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_periodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(110 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_periodBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(228 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(110 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_periodBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
    }];

    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_unitL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_numTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_unitL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_originL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_numTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
    }];
    
    [_resultL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_resultTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_resultTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_marklTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_resultTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(-10 *SIZE);
    }];
}

@end
