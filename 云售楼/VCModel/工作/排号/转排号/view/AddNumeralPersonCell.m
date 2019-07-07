//
//  AddNumeralPersonCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/2.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddNumeralPersonCell.h"

#import "CallTelegramCustomDetailHeaderCollCell.h"

@interface AddNumeralPersonCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextFieldDelegate>
{
    
    NSInteger _num;
    NSInteger _numAdd;
    
    NSString *_gender;
    
    NSMutableArray *_selectArr;
    NSMutableArray *_collArr;
    NSMutableArray *_certArr;
}

@end

@implementation AddNumeralPersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _collArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    
}

- (void)setCerArr:(NSArray *)cerArr{
    
    _certArr = [[NSMutableArray alloc] initWithArray:cerArr];
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    _collArr = [NSMutableArray arrayWithArray:dataArr];
    _selectArr = [@[] mutableCopy];
    for (int i = 0; i < dataArr.count; i++) {

        [_selectArr addObject:@0];
    }
    [_coll reloadData];
    if (dataArr.count) {
        
        [_coll selectItemAtIndexPath:[NSIndexPath indexPathForItem:_num inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
    [_coll reloadData];
}

- (void)setNum:(NSInteger)num{
    
    _numAdd = 0;
    if (_selectArr.count) {
        
        for (int i = 0; i < _collArr.count; i++) {
            
            [_selectArr addObject:@0];
        }
        [_selectArr replaceObjectAtIndex:num withObject:@1];
    }
    _nameTF.textField.text = _collArr[num][@"name"];
    
    _maleBtn.selected = NO;
    _femaleBtn.selected = NO;
    if ([_collArr[num][@"sex"] integerValue] == 1) {
        
        _maleBtn.selected = YES;
        _gender = @"1";
    }else if ([_collArr[num][@"sex"] integerValue] == 2){
        
        _femaleBtn.selected = YES;
        _gender = @"2";
    }else{
        
        _maleBtn.selected = NO;
        _femaleBtn.selected = NO;
        _gender = @"";
    }
    
    NSArray *arr = [_collArr[num][@"tel"] componentsSeparatedByString:@","];
    if (arr.count == 1) {
        
        _phoneTF.textField.text = arr[0];
        _phoneTF2.textField.text = @"";
        _phoneTF3.textField.text = @"";
    }else if (arr.count == 2){
        
        _numAdd = 1;
        _phoneTF.textField.text = arr[0];
        _phoneTF2.textField.text = arr[1];
//        [self ActionAddBtn:_addBtn];
    }else{
        
        _numAdd = 2;
        _phoneTF.textField.text = arr[0];
        _phoneTF2.textField.text = arr[1];
        _phoneTF3.textField.text = arr[2];

    }
    
//    if (_numAdd == 0) {
//
//        _phoneTF2.hidden = YES;
//        _phoneTF3.hidden = YES;
//
//        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(9 *SIZE);
//            make.top.equalTo(self->_phoneTF.mas_bottom).offset(31 *SIZE);
//            make.width.mas_equalTo(70 *SIZE);
//        }];
//
//        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(80 *SIZE);
//            make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
//            make.width.mas_equalTo(258 *SIZE);
//            make.height.mas_equalTo(33 *SIZE);
//        }];
//
//    }else if (_numAdd == 1){
//
//        _phoneTF3.textField.text = @"";
//        _phoneTF2.hidden = NO;
//        _phoneTF3.hidden = YES;
//
//        [_phoneTF2 mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(80 *SIZE);
//            make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
//            make.width.mas_equalTo(258 *SIZE);
//            make.height.mas_equalTo(33 *SIZE);
//        }];
//
//        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(9 *SIZE);
//            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(31 *SIZE);
//            make.width.mas_equalTo(70 *SIZE);
//        }];
//
//        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(80 *SIZE);
//            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
//            make.width.mas_equalTo(258 *SIZE);
//            make.height.mas_equalTo(33 *SIZE);
//        }];
//
//    }else{
//
//        _phoneTF2.hidden = NO;
//        _phoneTF3.hidden = NO;
//
//        _numAdd = 2;
//
//        [_phoneTF2 mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(80 *SIZE);
//            make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
//            make.width.mas_equalTo(258 *SIZE);
//            make.height.mas_equalTo(33 *SIZE);
//        }];
//
//        [_phoneTF3 mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(80 *SIZE);
//            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
//            make.width.mas_equalTo(258 *SIZE);
//            make.height.mas_equalTo(33 *SIZE);
//        }];
//
//        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(9 *SIZE);
//            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(31 *SIZE);
//            make.width.mas_equalTo(70 *SIZE);
//        }];
//        //
//        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self.contentView).offset(80 *SIZE);
//            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(21 *SIZE);
//            make.width.mas_equalTo(258 *SIZE);
//            make.height.mas_equalTo(33 *SIZE);
//        }];
//    }
    
    if ([_collArr[num][@"card_type"] length]) {
        
        _certTypeBtn.content.text = _collArr[num][@"card_type"];
        _certTypeBtn.placeL.text = @"";
        _certNumTF.textField.text = _collArr[num][@"card_num"];
        for (int i = 0; i < _certArr.count; i++) {
            
            if ([_collArr[num][@"card_type"] isEqualToString:_certArr[i][@"param"]]) {
                
                _certTypeBtn->str = _certArr[i][@"id"];
                break;
            }
        }
    }else{
        
        _certNumTF.textField.text = @"";
    }
    
    if ([_collArr[num][@"birth"] length]) {
        
        _birthBtn.content.text = _collArr[num][@"birth"];
        _birthBtn.placeL.text = @"";
    }
    _mailCodeTF.textField.text = _collArr[num][@"mail_code"];
    _addressBtn.textField.text = _collArr[num][@"address"];
    _markTV.text = _collArr[num][@"comment"];
}

- (void)setPhoneNum:(NSInteger)phoneNum{
    
    _numAdd = phoneNum;
    if (_numAdd == 0) {
        
        _phoneTF2.hidden = YES;
        _phoneTF3.hidden = YES;
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
    }else if (_numAdd == 1){
        
        _phoneTF3.textField.text = @"";
        _phoneTF2.hidden = NO;
        _phoneTF3.hidden = YES;
        
        [_phoneTF2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
    }else{
        
        _phoneTF2.hidden = NO;
        _phoneTF3.hidden = NO;
        
        _numAdd = 2;
        
        [_phoneTF2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_phoneTF3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        //
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in self.contentView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    _maleBtn.selected = NO;
    _femaleBtn.selected = NO;
    if (btn.tag == 0) {
        
        _maleBtn.selected = YES;
        _gender = @"1";
    }else{
        
        _femaleBtn.selected = YES;
        _gender = @"2";
    }
}

- (void)textFieldDidChange:(UITextField *)textfield{
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _nameTF.textField) {
        
        
    }else if (textField == _phoneTF.textField){
        
        
    }else if (textField == _phoneTF2.textField){
        
        
    }else if (textField == _phoneTF3.textField){
        
        
    }else if (textField == _certNumTF.textField){
        
        
    }else if (textField == _mailCodeTF.textField){
        
        
    }else if (textField == _addressBtn.textField){
        
        
    }else{
        
        
    }
    if (self.addNumeralPersonCellStrBlock) {
        
        self.addNumeralPersonCellStrBlock(textField.text, textField.tag);
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in self.contentView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    if (_numAdd == 0) {
        
        _numAdd += 1;
        _phoneTF2.hidden = NO;
        
        [_phoneTF2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        if (self.addNumeralPersonCellAddPhoneBlock) {

            self.addNumeralPersonCellAddPhoneBlock(_numAdd);
        }
    }else{
        
        _phoneTF3.hidden = NO;
        
        [_phoneTF3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        if (self.addNumeralPersonCellAddPhoneBlock) {

            self.addNumeralPersonCellAddPhoneBlock(_numAdd);
        }
    }
}

- (void)ActionPersonAddBtn:(UIButton *)btn{
    
    
}

//- (void)textFieldDidChange:(UITextField *)textfield{
//
//    
//}

- (void)ActionDropBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in self.contentView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    if (self.addNumeralPersonCellDropBtnBlock) {
        
        self.addNumeralPersonCellDropBtnBlock(btn.tag);
    }
    
    switch (btn.tag) {
        case 0:
        {
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:_certArr];
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                self->_certTypeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
//                self->_certTypeBtn->str = [NSString stringWithFormat:@"%@",ID];
//                self->_certTypeBtn.placeL.text = @"";
//                if ([self->_certTypeBtn.content.text containsString:@"身份证"]) {
//
//                    if (self->_certNumTF.textField.text.length) {
//
//                        if ([self validateIDCardNumber:self->_certNumTF.textField.text]) {
//
//                            self->_birthBtn.placeL.text = @"";
//                            self->_birthBtn.content.text = [self subsIDStrToDate:self->_certNumTF.textField.text];
//                        }else{
//
//                            [self showContent:@"请输入正确的身份证号"];
//                        }
//                    }else{
//
//                        [self showContent:@"请输入正确的身份证号"];
//                    }
//                }
//            };
//            [self.view addSubview:view];
            break;
        }
        case 1:{
            
//            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
//            view.dateblock = ^(NSDate *date) {
//
//                self->_birthBtn.content.text = [self->_formatter stringFromDate:date];
//                self->_birthBtn.placeL.text = @"";
//            };
//            [self.view addSubview:view];
            break;
        }
        case 2:{
            
//            AdressChooseView *addressChooseView = [[AdressChooseView alloc] initWithFrame:self.view.bounds withdata:@[]];
//            WS(weakself);
//            addressChooseView.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
//
//                NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
//
//                NSError *err;
//                NSArray *proArr = [NSJSONSerialization JSONObjectWithData:JSONData
//                                                                  options:NSJSONReadingMutableContainers
//                                                                    error:&err];
//                NSString *pro = [cityid substringToIndex:2];
//                pro = [NSString stringWithFormat:@"%@0000",pro];
//                NSString *proName;
//                if ([pro isEqualToString:@"900000"]) {
//                    proName = @"海外";
//                }
//                else{
//                    for (NSDictionary *dic in proArr) {
//
//                        if([dic[@"code"] isEqualToString:pro]){
//
//                            proName = dic[@"name"];
//                            break;
//                        }
//                    }
//                }
//                self->_proId = pro;
//                self->_cityId = cityid;
//                self->_areaId = areaid;
//            };
//            [self.view addSubview:addressChooseView];
            break;
        }
        case 3:{
            
            
            break;
        }
        case 5:{
            
            
            break;
        }
        default:
            break;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _collArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCustomDetailHeaderCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CallTelegramCustomDetailHeaderCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CallTelegramCustomDetailHeaderCollCell alloc] initWithFrame:CGRectMake(0, 0, 67 *SIZE, 30 *SIZE)];
    }
    
    cell.titleL.text = _collArr[indexPath.item][@"name"];
    
    cell.isSelect = [_selectArr[indexPath.item] integerValue];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i = 0; i < _selectArr.count; i++) {
        
        [_selectArr replaceObjectAtIndex:i withObject:@0];
    }
    
    [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    [collectionView reloadData];
    if (self.addNumeralPersonCellCollBlock) {

        self.addNumeralPersonCellCollBlock(indexPath.item);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
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
                [self.contentView addSubview:_maleBtn];
                
                break;
            }
            case 1:
            {
                _femaleBtn = btn;
                [self.contentView addSubview:_femaleBtn];
                
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 8; i++) {
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        tf.textField.tag = i;
        switch (i) {
            case 0:
            {
                _nameTF = tf;
                _nameTF.textField.delegate = self;
                _nameTF.textField.placeholder = @"姓名";
                [self.contentView addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _phoneTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 217 *SIZE, 33 *SIZE)];
                _phoneTF.textField.placeholder = @"请输入手机号码";
                _phoneTF.textField.delegate = self;
                _phoneTF.textField.keyboardType = UIKeyboardTypePhonePad;
                [_phoneTF.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [self.contentView addSubview:_phoneTF];
                break;
            }
            case 2:
            {
                _phoneTF2 = tf;
                _phoneTF2.hidden = YES;
                _phoneTF2.textField.placeholder = @"请输入手机号码";
                _phoneTF2.textField.delegate = self;
                _phoneTF2.textField.keyboardType = UIKeyboardTypePhonePad;
                [_phoneTF2.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [self.contentView addSubview:_phoneTF2];
                break;
            }
            case 3:
            {
                _phoneTF3 = tf;
                _phoneTF3.hidden = YES;
                _phoneTF3.textField.placeholder = @"请输入手机号码";
                _phoneTF3.textField.delegate = self;
                _phoneTF3.textField.keyboardType = UIKeyboardTypePhonePad;
                [_phoneTF3.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [self.contentView addSubview:_phoneTF3];
                break;
            }
            case 4:
            {
                _certNumTF = tf;
                _certNumTF.textField.placeholder = @"请输入证件号";
                _certNumTF.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                _certNumTF.textField.delegate = self;
                [self.contentView addSubview:_certNumTF];
                break;
            }
            case 5:
            {
                _mailCodeTF = tf;
                _mailCodeTF.textField.placeholder = @"请输入邮政编码";
                _mailCodeTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                _mailCodeTF.textField.delegate = self;
                [self.contentView addSubview:_mailCodeTF];
                break;
            }
            case 6:
            {
                _addressBtn = tf;
                _addressBtn.textField.placeholder = @"请输入通讯地址";
                [self.contentView addSubview:_addressBtn];
                break;
            }
            case 7:
            {
                _proportionTF = tf;
                //                _proportionTF.textField.placeholder = @"请输入邮政编码";
                _proportionTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                _proportionTF.textField.delegate = self;
                [self.contentView addSubview:_proportionTF];
                break;
            }
                
            default:
                break;
        }
    }
    
    _personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_personBtn addTarget:self action:@selector(ActionPersonAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_personBtn setImage:IMAGE_WITH_NAME(@"add_1") forState:UIControlStateNormal];
    [self.contentView addSubview:_personBtn];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:IMAGE_WITH_NAME(@"add_1") forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
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
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_nameL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _nameL.attributedText = attr;
                [self.contentView addSubview:_nameL];
                break;
            }
                
            case 2:
            {
                _genderL = label;
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_genderL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _genderL.attributedText = attr;
                [self.contentView addSubview:_genderL];
                break;
            }
                
            case 3:
            {
                _phoneL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_phoneL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _phoneL.attributedText = attr;
                [self.contentView addSubview:_phoneL];
                break;
            }
                
            case 4:
            {
                _certTypeL = label;
                [self.contentView addSubview:_certTypeL];
                break;
            }
                
            case 5:
            {
                _certNumL = label;
                [self.contentView addSubview:_certNumL];
                break;
            }
                
            case 6:
            {
                _birthL = label;
                [self.contentView addSubview:_birthL];
                break;
            }
                
            case 7:
            {
                _mailCodeL = label;
                [self.contentView addSubview:_mailCodeL];
                break;
            }
                
            case 8:
            {
                //                _customSourceL = label;
                //                [self.contentView addSubview:_customSourceL];
                break;
            }
            case 9:
            {
                //                _approachL = label;
                //                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_approachL.text]];
                //                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                //                _approachL.attributedText = attr;
                //                [self.contentView addSubview:_approachL];
                break;
            }
            case 10:
            {
                //                _sourceTypeL = label;
                //                [self.contentView addSubview:_sourceTypeL];
                break;
            }
            case 11:
            {
                _addressL = label;
                [self.contentView addSubview:_addressL];
                break;
            }
            case 12:
            {
                //                _markL = label;
                //                [self.contentView addSubview:_markL];
                break;
            }
            case 13:
            {
                _proportionL = label;
                [self.contentView addSubview:_proportionL];
                break;
            }
                
            default:
                break;
        }
    }
    
    for (int i = 0; i < 6; i++) {
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                
                _certTypeBtn = btn;
                _certTypeBtn.placeL.text = @"请选择证件类型";
                [self.contentView addSubview:_certTypeBtn];
                break;
            }
            case 1:
            {
                
                _birthBtn = btn;
                _birthBtn.placeL.text = @"请选择出生年月";
                [self.contentView addSubview:_birthBtn];
                break;
            }
            case 2:
            {
                
                //                _customSourceBtn = btn;
                //                _customSourceBtn.placeL.text = @"请选择客户来源";
                //                [self.contentView addSubview:_customSourceBtn];
                break;
            }
            case 3:
            {
                
                //                _approachBtn = btn;
                //                _approachBtn.placeL.text = @"请选择认知途径";
                //                [self.contentView addSubview:_approachBtn];
                break;
            }
            case 4:
            {
                
                //                _sourceTypeBtn = btn;
                //                _sourceTypeBtn.content.text = @"自行添加";
                //                _sourceTypeBtn.dropimg.hidden = YES;
                //                _sourceTypeBtn.backgroundColor = CLLineColor;
                //                [self.contentView addSubview:_sourceTypeBtn];
                break;
            }
            case 5:{
                
                //                _approachBtn2 = btn;
                //                _approachBtn2.hidden = YES;
                //                _approachBtn2.placeL.text = @"请选择认知途径";
                //                [self.contentView addSubview:_approachBtn2];
                break;
            }
            default:
                break;
        }
    }
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:13 *SIZE];
    _flowLayout.itemSize = CGSizeMake(67 *SIZE, 30 *SIZE);
    _flowLayout.minimumLineSpacing = 8 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 10 *SIZE, 0, 0);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[CallTelegramCustomDetailHeaderCollCell class] forCellWithReuseIdentifier:@"CallTelegramCustomDetailHeaderCollCell"];
    [self.contentView addSubview:_coll];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
    }];
    
    [_personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-13 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.height.mas_equalTo(25 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(52 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(47 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_femaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(150 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(217 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(313 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(27 *SIZE);
        make.width.mas_equalTo(25 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_certTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_certTypeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_certTypeBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_birthL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_certNumTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_birthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_certNumTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_mailCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_birthBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_mailCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_birthBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_mailCodeTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_mailCodeTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_proportionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_proportionTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
