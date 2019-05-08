//
//  WorkReceiptDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkReceiptDetailVC.h"

#import "BaseHeader.h"

#import "DropBtn.h"
#import "BorderTextField.h"

@interface WorkReceiptDetailVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) BaseHeader *infoHeader;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *costL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UILabel *remainL;

@property (nonatomic, strong) UIView *receiptView;

@property (nonatomic, strong) BaseHeader *receiptHeader;

@property (nonatomic, strong) UILabel *cashL;

@property (nonatomic, strong) BorderTextField *cashTF;

@property (nonatomic, strong) UILabel *posL;

@property (nonatomic, strong) BorderTextField *posTF;

@property (nonatomic, strong) UILabel *posBankL;

@property (nonatomic, strong) DropBtn *posBankBtn;

@property (nonatomic, strong) UILabel *bankL;

@property (nonatomic, strong) BorderTextField *bankTF;

@property (nonatomic, strong) UILabel *bankInfoL;

@property (nonatomic, strong) DropBtn *bankInfoBtn;

@property (nonatomic, strong) UILabel *otherL;

@property (nonatomic, strong) BorderTextField *otherTF;

@property (nonatomic, strong) UILabel *totalL;

@property (nonatomic, strong) BorderTextField *totalTF;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) DropBtn *typeBtn;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTextField *codeTF;

@property (nonatomic, strong) UIButton *confrimBtn;

@end

@implementation WorkReceiptDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"收款";
    
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    
    _infoView = [[UIView alloc] init];
    _infoView.backgroundColor = CLWhiteColor;
    [_scrollView addSubview:_infoView];
    
    _infoHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _infoHeader.titleL.text = @"基本信息";
    [_infoView addSubview:_infoHeader];
    
    NSArray *infoArr = @[@"客户姓名：",@"项目名称：",@"房间信息：",@"费项名称：",@"应收金额",@"已收金额：",@"代收金额："];
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.numberOfLines = 0;
        label.text = infoArr[i];
        switch (i) {
            case 0:
            {
                _nameL = label;
                [_infoView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _projectL = label;
                [_infoView addSubview:_projectL];
                break;
            }
            case 2:
            {
                _roomL = label;
                [_infoView addSubview:_roomL];
                break;
            }
            case 3:
            {
                _costL = label;
                [_infoView addSubview:_costL];
                break;
            }
            case 4:
            {
                _priceL = label;
                [_infoView addSubview:_priceL];
                break;
            }
            case 5:
            {
                _payL = label;
                [_infoView addSubview:_payL];
                break;
            }
            case 6:
            {
                _remainL = label;
                [_infoView addSubview:_remainL];
                break;
            }
            default:
                break;
        }
    }
    
    _receiptView = [[UIView alloc] init];
    _receiptView.backgroundColor = CLWhiteColor;
    [_scrollView addSubview:_receiptView];
    
    _receiptHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _receiptHeader.titleL.text = @"收款信息";
    [_receiptView addSubview:_receiptHeader];
    
    NSArray *receiptArr = @[@"现金收款：",@"POS机收款：",@"收款信息：",@"银行转账：",@"银行信息：",@"其他方式：",@"合计金额：",@"票据类型：",@"票据编号："];
    for (int i = 0; i < 9; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = receiptArr[i];
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        switch (i) {
            case 0:
            {
                _cashL = label;
                [_receiptView addSubview:_cashL];
                
                _cashTF = tf;
                [_receiptView addSubview:_cashTF];
                
                _posBankBtn = btn;
                [_receiptView addSubview:_posBankBtn];
                break;
            }
            case 1:
            {
                _posL = label;
                [_receiptView addSubview:_posL];
                
                _posTF = tf;
                [_receiptView addSubview:_posTF];
                
                _bankInfoBtn = btn;
                [_receiptView addSubview:_bankInfoBtn];
                break;
            }
            case 2:
            {
                _posBankL = label;
                [_receiptView addSubview:_posBankL];
                
                _bankTF = tf;
                [_receiptView addSubview:_bankTF];
                
                _typeBtn = btn;
                [_receiptView addSubview:_typeBtn];
                break;
            }
            case 3:
            {
                _bankL = label;
                [_receiptView addSubview:_bankL];
                
                _otherTF = tf;
                [_receiptView addSubview:_otherTF];
                break;
            }
            case 4:
            {
                _bankInfoL = label;
                [_receiptView addSubview:_bankInfoL];
                
                _totalTF = tf;
                [_receiptView addSubview:_totalTF];
                break;
            }
            case 5:
            {
                _otherL = label;
                [_receiptView addSubview:_otherL];
                
                _codeTF = tf;
                [_receiptView addSubview:_codeTF];
                break;
            }
            case 6:
            {
                _totalL = label;
                [_receiptView addSubview:_totalL];
                break;
            }
            case 7:
            {
                _typeL = label;
                [_receiptView addSubview:_typeL];
                break;
            }
            case 8:
            {
                _codeL = label;
                [_receiptView addSubview:_codeL];
                break;
            }
            default:
                break;
        }
    }
    
    _confrimBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confrimBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confrimBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confrimBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_confrimBtn setBackgroundColor:CLBlueBtnColor];
    [_scrollView addSubview:_confrimBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
//        make.width.mas_offset(SCREEN_Width);
//        make.height.mas_offset(SCREEN_Height - NAVIGATION_BAR_HEIGHT);
    }];
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0);
        make.width.mas_offset(SCREEN_Width);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(28 *SIZE);
        make.top.equalTo(self->_infoView).offset(48 *SIZE);
        make.right.equalTo(self->_infoView).offset(-28 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(28 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self->_infoView).offset(-28 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(28 *SIZE);
        make.top.equalTo(self->_projectL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self->_infoView).offset(-28 *SIZE);
    }];
    
    [_costL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(28 *SIZE);
        make.top.equalTo(self->_roomL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self->_infoView).offset(-28 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(28 *SIZE);
        make.top.equalTo(self->_costL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self->_infoView).offset(-28 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(28 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self->_infoView).offset(-28 *SIZE);
    }];
    
    [_remainL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(28 *SIZE);
        make.top.equalTo(self->_payL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self->_infoView).offset(-28 *SIZE);
        make.bottom.equalTo(self->_infoView.mas_bottom).offset(-20 *SIZE);
    }];
    
    [_receiptView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_infoView.mas_bottom).offset(6 *SIZE);
        make.width.mas_offset(SCREEN_Width);
    }];
    
    [_cashL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(9 *SIZE);
        make.top.equalTo(self->_receiptView).offset(63 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_cashTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(80 *SIZE);
        make.top.equalTo(self->_receiptView).offset(53 *SIZE);
        make.width.mas_offset(258 *SIZE);
        make.height.mas_offset(33 *SIZE);
    }];
    
    [_posL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(9 *SIZE);
        make.top.equalTo(self->_cashTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_posTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(80 *SIZE);
        make.top.equalTo(self->_cashTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_offset(258 *SIZE);
        make.height.mas_offset(33 *SIZE);
    }];
    
    [_posBankL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(9 *SIZE);
        make.top.equalTo(self->_posTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_posBankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(80 *SIZE);
        make.top.equalTo(self->_posTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_offset(258 *SIZE);
        make.height.mas_offset(33 *SIZE);
    }];
    
    [_bankL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(9 *SIZE);
        make.top.equalTo(self->_posBankBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_bankTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(80 *SIZE);
        make.top.equalTo(self->_posBankBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_offset(258 *SIZE);
        make.height.mas_offset(33 *SIZE);
    }];
    
    [_bankInfoL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(9 *SIZE);
        make.top.equalTo(self->_bankTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_bankInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(80 *SIZE);
        make.top.equalTo(self->_bankTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_offset(258 *SIZE);
        make.height.mas_offset(33 *SIZE);
    }];
    
    [_otherL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(9 *SIZE);
        make.top.equalTo(self->_bankInfoBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_otherTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(80 *SIZE);
        make.top.equalTo(self->_bankInfoBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_offset(258 *SIZE);
        make.height.mas_offset(33 *SIZE);
    }];
    
    [_totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(9 *SIZE);
        make.top.equalTo(self->_otherTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_totalTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(80 *SIZE);
        make.top.equalTo(self->_otherTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_offset(258 *SIZE);
        make.height.mas_offset(33 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(9 *SIZE);
        make.top.equalTo(self->_totalTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(80 *SIZE);
        make.top.equalTo(self->_totalTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_offset(258 *SIZE);
        make.height.mas_offset(33 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(9 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(30 *SIZE);
        make.width.mas_offset(70 *SIZE);
    }];
    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_receiptView).offset(80 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(18 *SIZE);
        make.width.mas_offset(258 *SIZE);
        make.height.mas_offset(33 *SIZE);
        make.bottom.equalTo(self->_receiptView.mas_bottom).offset(-22 *SIZE);
    }];
    
    [_confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(21 *SIZE);
        make.top.equalTo(self->_receiptView.mas_bottom).offset(30 *SIZE);
        make.width.mas_offset(317 *SIZE);
        make.height.mas_offset(40 *SIZE);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(-58 *SIZE);
    }];
}

@end
