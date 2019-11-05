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

@interface ModifyAndAddRentalVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) UILabel *rentL;

@property (nonatomic, strong) DropBtn *rentBtn;

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

@implementation ModifyAndAddRentalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"修改租金";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    NSArray *titleArr = @[@"计价起止时间：",@"免租期起止时间：",@"计算金额：",@"实际金额：",@"备注：",@"交款时间：",@"提醒时间："];
    
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
            [_scrollView addSubview:_timeBtn];
        }else if (i == 1){
            
            _rentL = label;
            [_scrollView addSubview:_rentL];
            
            _rentBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_rentBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:_rentBtn];
        }else if (i == 2){
            
            _originL = label;
            _originL.numberOfLines = 0;
            [_scrollView addSubview:_originL];
        }else if (i == 3){
            
            _resultL = label;
            [_scrollView addSubview:_resultL];
            
            _resultTF = tf;
            [_scrollView addSubview:_resultTF];
        }else if (i == 4){
            
            _markL = label;
            [_scrollView addSubview:_markL];
            
            _marklTF = tf;
            [_scrollView addSubview:_marklTF];
        }else if (i == 5){
            
            _payTimeL = label;
            [_scrollView addSubview:_payTimeL];
            
            _payTimeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_payTimeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:_payTimeBtn];
        }else{
            
            _remindL = label;
            [_scrollView addSubview:_remindL];
            
            _remindBtn = [[DropBtn alloc] initWithFrame:tf.frame];
            [_remindBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [_rentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_rentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_originL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_rentBtn.mas_bottom).offset(12 *SIZE);
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
        make.top.equalTo(self->_resultTF.mas_bottom).offset(12 *SIZE);
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
        make.top.equalTo(self->_marklTF.mas_bottom).offset(12 *SIZE);
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
        make.top.equalTo(self->_payTimeBtn.mas_bottom).offset(12 *SIZE);
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
