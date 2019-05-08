//
//  CallTelegramModifyCustomVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramModifyCustomVC.h"

#import "BoxSelectCollCell.h"
#import "BaseHeader.h"

#import "BorderTextField.h"
#import "DropBtn.h"

@interface CallTelegramModifyCustomVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTextField *nameTF;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) UIButton *maleBtn;

@property (nonatomic, strong) UIButton *femaleBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) BorderTextField *phoneTF;

@property (nonatomic, strong) BorderTextField *phoneTF2;

@property (nonatomic, strong) BorderTextField *phoneTF3;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *certTypeL;

@property (nonatomic, strong) DropBtn *certTypeBtn;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, strong) BorderTextField *certNumTF;

@property (nonatomic, strong) UILabel *birthL;

@property (nonatomic, strong) DropBtn *birthBtn;

@property (nonatomic, strong) UILabel *mailCodeL;

@property (nonatomic, strong) BorderTextField *mailCodeTF;

@property (nonatomic, strong) UILabel *customSourceL;

@property (nonatomic, strong) DropBtn *customSourceBtn;

@property (nonatomic, strong) UILabel *approachL;

@property (nonatomic, strong) DropBtn *approachBtn;

@property (nonatomic, strong) UILabel *sourceTypeL;

@property (nonatomic, strong) DropBtn *sourceTypeBtn;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) DropBtn *addressBtn;

@property (nonatomic, strong) UITextView *addressTV;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation CallTelegramModifyCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    
}

- (void)ActionNextBtn:(UIButton *)btn{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxSelectCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxSelectCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BoxSelectCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 20 *SIZE)];
    }
    
    cell.titleL.text = @"写字楼";
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"新增来电";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    BaseHeader *header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    header.titleL.text = @"客户信息";
    [_scrollView addSubview:header];
    
    NSArray *btnArr = @[@"男",@"女"];
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:CL95Color forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"selected1") forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"disabled1") forState:UIControlStateNormal];
        
        switch (i) {
            case 0:
            {
                _maleBtn = btn;
                [_scrollView addSubview:_maleBtn];
                
                break;
            }
            case 1:
            {
                _femaleBtn = btn;
                [_scrollView addSubview:_femaleBtn];
                
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 6; i++) {
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        switch (i) {
            case 0:
            {
                _nameTF = tf;
                _nameTF.textField.delegate = self;
                [_scrollView addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _phoneTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 217 *SIZE, 33 *SIZE)];
                [_scrollView addSubview:_phoneTF];
                break;
            }
            case 2:
            {
                _phoneTF2 = tf;
                _phoneTF2.hidden = YES;
                [_scrollView addSubview:_phoneTF2];
                break;
            }
            case 3:
            {
                _phoneTF3 = tf;
                _phoneTF3.hidden = YES;
                [_scrollView addSubview:_phoneTF3];
                break;
            }
            case 4:
            {
                _certNumTF = tf;
                [_scrollView addSubview:_certNumTF];
                break;
            }
            case 5:
            {
                _mailCodeTF = tf;
                [_scrollView addSubview:_mailCodeTF];
                break;
            }
            default:
                break;
        }
    }
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_addBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [_addBtn setTitle:@"新增电话" forState:UIControlStateNormal];
    //    [_addBtn setTitleColor:CLBlackColor forState:UIControlStateNormal];
    [_addBtn setImage:IMAGE_WITH_NAME(@"content_add") forState:UIControlStateNormal];
    [_scrollView addSubview:_addBtn];
    
    NSArray *titleArr = @[@"姓名：",@"性别：",@"联系号码：",@"证件类型：",@"证件号：",@"出生年月：",@"邮政编码：",@"客户来源：",@"认知途径：",@"来源类型：",@"通讯地址："];
    
    for (int i = 0; i < 11; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _nameL = label;
                [_scrollView addSubview:_nameL];
                break;
            }
                
            case 1:
            {
                _genderL = label;
                [_scrollView addSubview:_genderL];
                break;
            }
                
            case 2:
            {
                _phoneL = label;
                [_scrollView addSubview:_phoneL];
                break;
            }
                
            case 3:
            {
                _certTypeL = label;
                [_scrollView addSubview:_certTypeL];
                break;
            }
                
            case 4:
            {
                _certNumL = label;
                [_scrollView addSubview:_certNumL];
                break;
            }
                
            case 5:
            {
                _birthL = label;
                [_scrollView addSubview:_birthL];
                break;
            }
                
            case 6:
            {
                _mailCodeL = label;
                [_scrollView addSubview:_mailCodeL];
                break;
            }
                
            case 7:
            {
                _customSourceL = label;
                [_scrollView addSubview:_customSourceL];
                break;
            }
            case 8:
            {
                _approachL = label;
                [_scrollView addSubview:_approachL];
                break;
            }
            case 9:
            {
                _sourceTypeL = label;
                [_scrollView addSubview:_sourceTypeL];
                break;
            }
            case 10:
            {
                _addressL = label;
                [_scrollView addSubview:_addressL];
                break;
            }
            
            default:
                break;
        }
    }
    
    for (int i = 0; i < 6; i++) {
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.placeL.text = @"请选择证件类型";
        switch (i) {
            case 0:
            {
                
                _certTypeBtn = btn;
                [_scrollView addSubview:_certTypeBtn];
                break;
            }
            case 1:
            {
                
                _birthBtn = btn;
                [_scrollView addSubview:_birthBtn];
                break;
            }
            case 2:
            {
                
                _customSourceBtn = btn;
                [_scrollView addSubview:_customSourceBtn];
                break;
            }
            case 3:
            {
                
                _approachBtn = btn;
                [_scrollView addSubview:_approachBtn];
                break;
            }
            case 4:
            {
                
                _sourceTypeBtn = btn;
                [_scrollView addSubview:_sourceTypeBtn];
                break;
            }
            case 5:
            {
                
                _addressBtn = btn;
                [_scrollView addSubview:_addressBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _addressTV = [[UITextView alloc] init];
    _addressTV.layer.cornerRadius = 5 *SIZE;
    _addressTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _addressTV.layer.borderWidth = SIZE;
    _addressTV.clipsToBounds = YES;
    [_scrollView addSubview:_addressTV];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步 意向调查" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    //    _nextBtn.layer.cornerRadius = 5 *SIZE;
    //    _nextBtn.clipsToBounds = YES;
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
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_scrollView).offset(50 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_scrollView).offset(46 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(100 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_femaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(170 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(217 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(313 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(27 *SIZE);
        make.width.mas_equalTo(25 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_certTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_certTypeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_certTypeBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_birthL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_certNumTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_birthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_certNumTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_mailCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_birthBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_mailCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_birthBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_customSourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_mailCodeTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_customSourceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_mailCodeTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_approachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_customSourceBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_approachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_customSourceBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_sourceTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_approachBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_sourceTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_approachBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_sourceTypeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_sourceTypeBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
        make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
    }];
 //    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self->_scrollView).offset(0 *SIZE);
    //        make.bottom.equalTo(self.view.mas_bottom).offset(-(43 *SIZE + TAB_BAR_MORE));
    //        make.width.mas_equalTo(360 *SIZE);
    //        make.height.mas_equalTo(43 *SIZE + TAB_BAR_MORE);
    //    }];
}

@end
