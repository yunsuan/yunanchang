//
//  CompanyAuthVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyAuthVC.h"

@interface CompanyAuthVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *companyTL;

@property (nonatomic, strong) UIView *compantLine;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UIButton *companyBtn;

@property (nonatomic, strong) UILabel *roleTL;

@property (nonatomic, strong) UIView *roleLine;

@property (nonatomic, strong) UILabel *roleL;

@property (nonatomic, strong) UIButton *roleBtn;

@property (nonatomic, strong) UILabel *departTL;

@property (nonatomic, strong) UIView *departLine;

@property (nonatomic, strong) UITextField *departTextField;

@property (nonatomic, strong) UILabel *positionTL;

@property (nonatomic, strong) UIView *positionLine;

@property (nonatomic, strong) UITextField *positionTextField;

@property (nonatomic, strong) UIButton *commitBtn;
@end

@implementation CompanyAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"公司申请";
    
    _scrollView = [[UIScrollView alloc] init];//WithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE - TAB_BAR_MORE)];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width, 672 *SIZE);
    _scrollView.bounces = NO;
    _scrollView.userInteractionEnabled = NO;
    [self.view addSubview:_scrollView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(37 *SIZE, 14 *SIZE, 200 *SIZE, 13 *SIZE)];
    label.textColor = CLTitleLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"⚠️认证需要审核 请仔细填写信息";
    [_scrollView addSubview:label];
    
    _whiteView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 361 *SIZE)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_whiteView];
    
    NSArray *titleArr = @[@"所属公司",@"所属部门",@"所属岗位",@"项目角色"];
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = CLLineColor;
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.textColor = CLTitleLabColor;
        label1.textAlignment = NSTextAlignmentRight;
        label1.font = [UIFont systemFontOfSize:13 *SIZE];
        
//        UIImageView *img = [[UIImageView alloc] init];
//        img.image = [UIImage imageNamed:@"rightarrow"];
//        [_whiteView addSubview:img];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        switch (i) {
            case 0:
            {
                _companyTL = label;
                [_whiteView addSubview:_companyTL];
                _compantLine = line;
                [_whiteView addSubview:_compantLine];
                
                _companyL = label1;
                [_whiteView addSubview:_companyL];
                _companyBtn = button;
                [_whiteView addSubview:_companyBtn];
                break;
            }
            case 1:
            {
                UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(100 *SIZE, 50 *SIZE * i, 230 *SIZE, 49 *SIZE)];
                textFiled.textAlignment = NSTextAlignmentRight;
                _departTextField = textFiled;
                [_whiteView addSubview:_departTextField];
                
                _departTL = label;
                [_whiteView addSubview:_departTL];
                _departLine = line;
                [_whiteView addSubview:_departLine];
                
                break;
            }
            case 2:
            {
                UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(100 *SIZE, 50 *SIZE * i, 230 *SIZE, 49 *SIZE)];
                textFiled.textAlignment = NSTextAlignmentRight;
                _positionTextField = textFiled;
                [_whiteView addSubview:_positionTextField];
                
                _positionTL = label;
                [_whiteView addSubview:_positionTL];
                _positionLine = line;
                [_whiteView addSubview:_positionLine];
                break;
            }
            case 3:
            {
                _roleTL = label;
                [_whiteView addSubview:_roleTL];
                _roleLine = line;
                [_whiteView addSubview:_roleLine];
                
                _roleL = label1;
                [_whiteView addSubview:_roleL];
//                _role = @"1";
//                _roleL.text = @"经纪人";
                
                _roleBtn = button;
                [_whiteView addSubview:_roleBtn];
                break;
            }
            default:
                break;
        }
    }
    
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.frame = CGRectMake(0, SCREEN_Height - 50 *SIZE - TAB_BAR_MORE, 360 *SIZE, 50 *SIZE + TAB_BAR_MORE);
    _commitBtn.backgroundColor = CLBlueBtnColor;
    [_commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];

    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE - TAB_BAR_MORE);
    }];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0 *SIZE);
        make.top.equalTo(self->_scrollView).offset(40 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
    }];
    
    [_companyTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_whiteView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_whiteView).offset(16 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
    }];
    
    [_companyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_whiteView).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_compantLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_companyBtn.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_departTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_compantLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_departTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_compantLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_departLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_departTextField.mas_bottom).offset(SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_positionTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_departLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_positionTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_departLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_positionLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_positionTextField.mas_bottom).offset(SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    
    [_roleTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_positionLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_roleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_positionLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
    }];
    
    [_roleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_positionLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_roleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_roleBtn.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(0 *SIZE);
    }];
    
}
@end
