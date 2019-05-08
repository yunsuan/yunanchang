//
//  AddCallTelegramVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddCallTelegramVC.h"

#import "FollowRecordVC.h"
#import "IntentSurveyVC.h"
#import "AddCallTelegramGroupMemberVC.h"

#import "BoxSelectCollCell.h"
#import "BaseHeader.h"

#import "BorderTextField.h"
#import "DropBtn.h"

@interface AddCallTelegramVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    
    NSString *_group;
    NSInteger _numAdd;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *groupL;

@property (nonatomic, strong) UIButton *addGroupBtn;

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

@property (nonatomic, strong) UILabel *propertyIntentL;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *propertyIntentColl;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddCallTelegramVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    _maleBtn.selected = NO;
    _femaleBtn.selected = NO;
    if (btn.tag == 0) {
        
        _maleBtn.selected = YES;
    }else{
        
        _femaleBtn.selected = YES;
    }
}

- (void)ActionAddGroupBtn:(UIButton *)btn{
    
    AddCallTelegramGroupMemberVC *nextVC = [[AddCallTelegramGroupMemberVC alloc] init];
    nextVC.addCallTelegramGroupMemberVCBlock = ^(NSString * group) {
        
        self->_group = group;
        self->_groupL.text = [NSString stringWithFormat:@"%@,%@",self->_groupL.text,self->_group];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (_numAdd == 0) {
        
        _numAdd += 1;
        _phoneTF2.hidden = NO;
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_scrollView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
    }else{
        
        _phoneTF3.hidden = NO;
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_scrollView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    IntentSurveyVC *nextVC = [[IntentSurveyVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([self isEmpty:textField.text]) {
        
        if (_group.length) {
            
            _groupL.text = [NSString stringWithFormat:@"组别成员：%@",_group];
        }else{
            
            _groupL.text = [NSString stringWithFormat:@"组别成员："];
        }
    }else{
        
        if (_group.length) {
            
            _groupL.text = [NSString stringWithFormat:@"组别成员：%@,%@",textField.text,_group];
        }else{
            
            _groupL.text = [NSString stringWithFormat:@"组别成员：%@",textField.text];
        }
    }
}


#pragma mark -- CollectionView

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
        [btn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"default") forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"selected") forState:UIControlStateSelected];
    
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
                _nameTF.textField.placeholder = @"姓名";
                [_scrollView addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _phoneTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 217 *SIZE, 33 *SIZE)];
                _phoneTF.textField.placeholder = @"请输入手机号码";
                [_scrollView addSubview:_phoneTF];
                break;
            }
            case 2:
            {
                _phoneTF2 = tf;
                _phoneTF2.hidden = YES;
                _phoneTF2.textField.placeholder = @"请输入手机号码";
                [_scrollView addSubview:_phoneTF2];
                break;
            }
            case 3:
            {
                _phoneTF3 = tf;
                _phoneTF3.hidden = YES;
                _phoneTF3.textField.placeholder = @"请输入手机号码";
                [_scrollView addSubview:_phoneTF3];
                break;
            }
            case 4:
            {
                _certNumTF = tf;
                _certNumTF.textField.placeholder = @"请输入证件号";
                [_scrollView addSubview:_certNumTF];
                break;
            }
            case 5:
            {
                _mailCodeTF = tf;
                _mailCodeTF.textField.placeholder = @"请输入邮政编码";
                [_scrollView addSubview:_mailCodeTF];
                break;
            }
            default:
                break;
        }
    }
    
    _addGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addGroupBtn addTarget:self action:@selector(ActionAddGroupBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addGroupBtn setImage:IMAGE_WITH_NAME(@"add_5") forState:UIControlStateNormal];
    [_scrollView addSubview:_addGroupBtn];

    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:IMAGE_WITH_NAME(@"add_1") forState:UIControlStateNormal];
    [_scrollView addSubview:_addBtn];
    
    NSArray *titleArr = @[@"组别成员：",@"姓名：",@"性别：",@"联系号码：",@"证件类型：",@"证件号：",@"出生年月：",@"邮政编码：",@"客户来源：",@"认知途径：",@"来源类型：",@"通讯地址：",@"物业意向："];
    
    for (int i = 0; i < 13; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _groupL = label;
                [_scrollView addSubview:_groupL];
                break;
            }
                
            case 1:
            {
                _nameL = label;
                [_scrollView addSubview:_nameL];
                break;
            }
              
            case 2:
            {
                _genderL = label;
                [_scrollView addSubview:_genderL];
                break;
            }
                
            case 3:
            {
                _phoneL = label;
                [_scrollView addSubview:_phoneL];
                break;
            }
                
            case 4:
            {
                _certTypeL = label;
                [_scrollView addSubview:_certTypeL];
                break;
            }
                
            case 5:
            {
                _certNumL = label;
                [_scrollView addSubview:_certNumL];
                break;
            }
                
            case 6:
            {
                _birthL = label;
                [_scrollView addSubview:_birthL];
                break;
            }
                
            case 7:
            {
                _mailCodeL = label;
                [_scrollView addSubview:_mailCodeL];
                break;
            }
            
            case 8:
            {
                _customSourceL = label;
                [_scrollView addSubview:_customSourceL];
                break;
            }
            case 9:
            {
                _approachL = label;
                [_scrollView addSubview:_approachL];
                break;
            }
            case 10:
            {
                _sourceTypeL = label;
                [_scrollView addSubview:_sourceTypeL];
                break;
            }
            case 11:
            {
                _addressL = label;
                [_scrollView addSubview:_addressL];
                break;
            }
            case 12:
            {
                _propertyIntentL = label;
                [_scrollView addSubview:_propertyIntentL];
                break;
            }
            
            default:
                break;
        }
    }
    
    for (int i = 0; i < 6; i++) {
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        switch (i) {
            case 0:
            {
                
                _certTypeBtn = btn;
                _certTypeBtn.placeL.text = @"请选择证件类型";
                [_scrollView addSubview:_certTypeBtn];
                break;
            }
            case 1:
            {
                
                _birthBtn = btn;
                _birthBtn.placeL.text = @"请选择出生年月";
                [_scrollView addSubview:_birthBtn];
                break;
            }
            case 2:
            {
                
                _customSourceBtn = btn;
                _customSourceBtn.placeL.text = @"请选择客户来源";
                [_scrollView addSubview:_customSourceBtn];
                break;
            }
            case 3:
            {
                
                _approachBtn = btn;
                _approachBtn.placeL.text = @"请选择认知途径";
                [_scrollView addSubview:_approachBtn];
                break;
            }
            case 4:
            {
                
                _sourceTypeBtn = btn;
                _sourceTypeBtn.placeL.text = @"请选择来源类型";
                [_scrollView addSubview:_sourceTypeBtn];
                break;
            }
            case 5:
            {
                
                _addressBtn = btn;
                _addressBtn.placeL.text = @"请选择地址";
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
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(100 *SIZE, 20 *SIZE);
    
    _propertyIntentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 255 *SIZE, 100 *SIZE) collectionViewLayout:_flowLayout];
    _propertyIntentColl.backgroundColor = CLWhiteColor;
    _propertyIntentColl.delegate = self;
    _propertyIntentColl.dataSource = self;
    [_propertyIntentColl registerClass:[BoxSelectCollCell class] forCellWithReuseIdentifier:@"BoxSelectCollCell"];
    [_scrollView addSubview:_propertyIntentColl];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步 意向调查" forState:UIControlStateNormal];
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
    
    [_groupL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_scrollView).offset(50 *SIZE);
        make.width.mas_lessThanOrEqualTo(280 *SIZE);
    }];
    
    [_addGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_groupL.mas_right).offset(5 *SIZE);
        make.top.equalTo(self->_scrollView).offset(46 *SIZE);
        make.width.mas_equalTo(20 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];

    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_groupL.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_groupL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_femaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(150 *SIZE);
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
    
    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
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
    }];

    [_propertyIntentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_addressTV.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_propertyIntentColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(30 *SIZE);
        make.top.equalTo(self->_propertyIntentL.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(self->_propertyIntentColl.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
    }];

}

@end
