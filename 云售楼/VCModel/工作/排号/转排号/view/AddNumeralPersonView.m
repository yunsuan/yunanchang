//
//  AddNumeralPersonView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddNumeralPersonView.h"

@interface AddNumeralPersonView ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextFieldDelegate>
{
    
    NSInteger _index;
    
    NSMutableArray *_collArr;
    NSMutableArray *_selectArr;
}
@end

@implementation AddNumeralPersonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _selectArr = [@[] mutableCopy];
        _collArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr{
    
    _collArr = [NSMutableArray arrayWithArray:dataArr];
    [self setPersonData:dataArr[0]];
    [_coll reloadData];
}

- (void)setProportion:(NSString *)proportion{
    
    _proportionTF.textField.text = proportion;
}

- (void)setNum:(NSInteger)num{
    
    _index = num;
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < _collArr.count; i++) {
        
        if (i == num) {
            
            [_selectArr addObject:@1];
        }else{
            
            [_selectArr addObject:@0];
        }
    }
    [_coll reloadData];
}

- (void)ActionPersonAddBtn:(UIButton *)btn{
    
    if (self.addNumeralPersonViewAddBlock) {
        
        self.addNumeralPersonViewAddBlock(_index);
    }
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.addNumeralPersonViewEditBlock) {
        
        self.addNumeralPersonViewEditBlock(_index);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.addNumeralPersonViewStrBlock) {
        
        self.addNumeralPersonViewStrBlock(textField.text, _index);
    }
}

- (void)setPersonData:(NSDictionary *)data{
    
    NSLog(@"%@",data);
    _nameTF.textField.text = [NSString stringWithFormat:@"%@",data[@"name"]];
    _maleBtn.selected = NO;
    _femaleBtn.selected = NO;
    if ([data[@"sex"] integerValue] == 1) {
        
        _maleBtn.selected = YES;
    }else if ([data[@"sex"] integerValue] == 2){
        
        _femaleBtn.selected = YES;
    }else{
        
        _maleBtn.selected = NO;
        _femaleBtn.selected = NO;
    }
    
    NSArray *arr = [data[@"tel"] componentsSeparatedByString:@","];
    if (arr.count == 1) {
        
        _phoneTF.textField.text = arr[0];
        _phoneTF2.textField.text = @"";
        _phoneTF3.textField.text = @"";
        
        _phoneTF2.hidden = YES;
        _phoneTF3.hidden = YES;

        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];

    }else if (arr.count == 2){
        
        _phoneTF.textField.text = arr[0];
        _phoneTF2.textField.text = arr[1];
        _phoneTF3.textField.text = @"";
        _phoneTF2.hidden = NO;
        _phoneTF3.hidden = YES;
        
        [_phoneTF2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        

    }else{
    
        _phoneTF.textField.text = arr[0];
        _phoneTF2.textField.text = arr[1];
        _phoneTF3.textField.text = arr[2];
        
        _phoneTF2.hidden = NO;
        _phoneTF3.hidden = NO;
        
        [_phoneTF2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_phoneTF3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
    }
    
    if ([data[@"card_type"] length]) {
        
        _certTypeBtn.content.text = data[@"card_type"];
        _certTypeBtn.placeL.text = @"";
        _certNumTF.textField.text = data[@"card_num"];
//        for (int i = 0; i < _certArr.count; i++) {
//
//            if ([data[@"card_type"] isEqualToString:_certArr[i][@"param"]]) {
//
//                _certTypeBtn->str = _certArr[i][@"id"];
//                break;
//            }
//        }
    }else{
        
        _certNumTF.textField.text = @"";
    }
    
    if ([data[@"birth"] length]) {
        
        _birthBtn.content.text = data[@"birth"];
        _birthBtn.placeL.text = @"";
    }
    _mailCodeTF.textField.text = data[@"mail_code"];
    _addressBtn.textField.text = data[@"address"];
    _markTV.text = data[@"comment"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _collArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCustomDetailHeaderCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CallTelegramCustomDetailHeaderCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CallTelegramCustomDetailHeaderCollCell alloc] initWithFrame:CGRectMake(0, 0, 87 *SIZE, 70 *SIZE)];
    }
    cell.tag = indexPath.item;
    
    cell.titleL.text = _collArr[indexPath.item][@"name"];
    
    cell.isSelect = [_selectArr[indexPath.item] integerValue];
    
    if (indexPath.item == 0) {
        
        cell.deleteBtn.hidden = YES;
    }else{
        
        cell.deleteBtn.hidden = NO;
    }
    
    cell.callTelegramCustomDetailHeaderCollCellDeleteBlock = ^(NSInteger index) {
        
        [self->_collArr removeObjectAtIndex:index];
        [collectionView reloadData];
        if (self.addNumeralPersonViewDeleteBlock) {
            
            self.addNumeralPersonViewDeleteBlock(index);
        }
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i = 0; i < _selectArr.count; i++) {
        
        [_selectArr replaceObjectAtIndex:i withObject:@0];
    }
    [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    [collectionView reloadData];
    [self setPersonData:_collArr[indexPath.item]];
    if (self.addNumeralPersonViewCollBlock) {
        
        self.addNumeralPersonViewCollBlock(indexPath.item);
    }
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    
    NSArray *btnArr = @[@"男",@"女"];
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        btn.tag = i;
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"default") forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"selected") forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;
        switch (i) {
            case 0:
            {
                _maleBtn = btn;
                [self addSubview:_maleBtn];
                
                break;
            }
            case 1:
            {
                _femaleBtn = btn;
                [self addSubview:_femaleBtn];
                
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 8; i++) {
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        tf.userInteractionEnabled = NO;
        tf.backgroundColor = CLBackColor;
        tf.textField.tag = i;
        switch (i) {
            case 0:
            {
                _nameTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 217 *SIZE, 33 *SIZE)];
                _nameTF.userInteractionEnabled = NO;
                _nameTF.backgroundColor = CLBackColor;
                _nameTF.textField.delegate = self;
                [self addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _phoneTF = tf;
                _phoneTF.textField.delegate = self;
                _phoneTF.textField.keyboardType = UIKeyboardTypePhonePad;
                [self addSubview:_phoneTF];
                break;
            }
            case 2:
            {
                _phoneTF2 = tf;
                _phoneTF2.hidden = YES;
                _phoneTF2.textField.delegate = self;
                _phoneTF2.textField.keyboardType = UIKeyboardTypePhonePad;
                [self addSubview:_phoneTF2];
                break;
            }
            case 3:
            {
                _phoneTF3 = tf;
                _phoneTF3.hidden = YES;
                _phoneTF3.textField.delegate = self;
                _phoneTF3.textField.keyboardType = UIKeyboardTypePhonePad;
                [self addSubview:_phoneTF3];
                break;
            }
            case 4:
            {
                _certNumTF = tf;
                _certNumTF.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                _certNumTF.textField.delegate = self;
                [self addSubview:_certNumTF];
                break;
            }
            case 5:
            {
                _mailCodeTF = tf;
                _mailCodeTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                _mailCodeTF.textField.delegate = self;
                [self addSubview:_mailCodeTF];
                break;
            }
            case 6:
            {
                _addressBtn = tf;
                [self addSubview:_addressBtn];
                break;
            }
            case 7:
            {
                _proportionTF = tf;
                _proportionTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                _proportionTF.textField.delegate = self;
                _proportionTF.userInteractionEnabled = YES;
                _proportionTF.backgroundColor = CLWhiteColor;
                [self addSubview:_proportionTF];
                break;
            }
                
            default:
                break;
        }
    }
    
    _personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_personBtn addTarget:self action:@selector(ActionPersonAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_personBtn setImage:IMAGE_WITH_NAME(@"add_1") forState:UIControlStateNormal];
    [self addSubview:_personBtn];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:IMAGE_WITH_NAME(@"editor_2") forState:UIControlStateNormal];
    [self addSubview:_editBtn];
    
    NSArray *titleArr = @[@"组别成员：",@"客户姓名：",@"性别：",@"手机号码：",@"证件类型：",@"证件号：",@"出生年月：",@"邮政编码：",@"客户来源：",@"认知途径：",@"来源类型：",@"通讯地址：",@"备注：",@"产权比例："];
    
    for (int i = 0; i < 14; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        switch (i) {
            case 0:
            {
                
                break;
            }
                
            case 1:
            {
                _nameL = label;
                [self addSubview:_nameL];
                break;
            }
                
            case 2:
            {
                _genderL = label;
                [self addSubview:_genderL];
                break;
            }
                
            case 3:
            {
                _phoneL = label;
                [self addSubview:_phoneL];
                break;
            }
                
            case 4:
            {
                _certTypeL = label;
                [self addSubview:_certTypeL];
                break;
            }
                
            case 5:
            {
                _certNumL = label;
                [self addSubview:_certNumL];
                break;
            }
                
            case 6:
            {
                _birthL = label;
                [self addSubview:_birthL];
                break;
            }
                
            case 7:
            {
                _mailCodeL = label;
                [self addSubview:_mailCodeL];
                break;
            }
                
            case 8:
            {
                break;
            }
            case 9:
            {
                break;
            }
            case 10:
            {
                break;
            }
            case 11:
            {
                _addressL = label;
                [self addSubview:_addressL];
                break;
            }
            case 12:
            {

                break;
            }
            case 13:
            {
                _proportionL = label;
                [self addSubview:_proportionL];
                break;
            }
                
            default:
                break;
        }
    }
    
    for (int i = 0; i < 6; i++) {
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        btn.userInteractionEnabled = NO;
        btn.backgroundColor = CLBackColor;
        switch (i) {
            case 0:
            {
                
                _certTypeBtn = btn;
                _certTypeBtn.placeL.text = @"请选择证件类型";
                [self addSubview:_certTypeBtn];
                break;
            }
            case 1:
            {
                
                _birthBtn = btn;
                _birthBtn.placeL.text = @"请选择出生年月";
                [self addSubview:_birthBtn];
                break;
            }
            case 2:
            {
                
                break;
            }
            case 3:
            {
                
                break;
            }
            case 4:
            {
                
                break;
            }
            case 5:{
                
                break;
            }
            default:
                break;
        }
    }
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:13 *SIZE];
    _flowLayout.itemSize = CGSizeMake(87 *SIZE, 70 *SIZE);
    _flowLayout.minimumLineSpacing = 8 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 10 *SIZE, 0, 0);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[CallTelegramCustomDetailHeaderCollCell class] forCellWithReuseIdentifier:@"CallTelegramCustomDetailHeaderCollCell"];
    [self addSubview:_coll];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self).offset(0 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
    }];
    
    [_personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-13 *SIZE);
        make.top.equalTo(self).offset(11 *SIZE);
        make.width.height.mas_equalTo(25 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self).offset(52 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self).offset(47 *SIZE);
        make.width.mas_equalTo(217 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(313 *SIZE);
        make.top.equalTo(self).offset(50 *SIZE);
        make.width.mas_equalTo(25 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_femaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(150 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_certTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_certTypeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_certTypeBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_birthL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_certNumTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_birthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_certNumTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_mailCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_birthBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_mailCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_birthBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_mailCodeTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_mailCodeTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_proportionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_proportionTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self).offset(-20 *SIZE);
    }];
}

@end
