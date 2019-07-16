//
//  AddOrderView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddOrderView.h"

#import "preferentialCollCell.h"
#import "installmentCollCell.h"

@interface AddOrderView ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextFieldDelegate>
{
    
    NSMutableArray *_preferentialArr;
    NSMutableArray *_installmentArr;
}
@end

@implementation AddOrderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _preferentialArr = [@[] mutableCopy];
        _installmentArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.addOrderViewAddBlock) {
        
        self.addOrderViewAddBlock();
    }
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    if (self.addOrderViewDropBlock) {
        
        self.addOrderViewDropBlock(0);
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _totalTF.textField.text = dataDic[@"total_price"];
    _payWayBtn.content.text = dataDic[@"payWay_Name"];
    _priceTF.textField.text = dataDic[@"price"];
    _preferPriceTF.textField.text = dataDic[@"preferPrice"];
    _spePreferentialTF.textField.text = dataDic[@"spePreferential"];
    if ([_payWayBtn.content.text isEqualToString:@"一次性付款"]) {
        
        [_installmentArr removeAllObjects];
        [_installmentColl reloadData];
        
        _paymentL.hidden = YES;
        _paymentTF.hidden = YES;
        _businessLoanPriceL.hidden = YES;
        _businessLoanPriceTF.hidden = YES;
        _businessLoanBankL.hidden = YES;
        _businessLoanBankBtn.hidden = YES;
        _businessLoanYearL.hidden = YES;
        _businessLoanYearTF.hidden = YES;
        _fundLoanL.hidden = YES;
        _fundLoanTF.hidden = YES;
        _fundLoanBankL.hidden = YES;
        _fundLoanBankBtn.hidden = YES;
        _fundLoanYearL.hidden = YES;
        _fundLoanYearTF.hidden = YES;
        _loanPriceL.hidden = YES;
        _loanPriceTF.hidden = YES;
        _loanBankL.hidden = YES;
        _loanBankBtn.hidden = YES;
        _loanYearL.hidden = YES;
        _loanYearTF.hidden = YES;
        _installmentColl.hidden = YES;
        
        [_priceTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_totalTF.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            make.bottom.equalTo(self).offset(-20 *SIZE);
        }];
        
        [_loanYearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_loanBankBtn.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_fundLoanYearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_loanBankBtn.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
    }else if ([_payWayBtn.content.text isEqualToString:@"公积金贷款"]){
        
        [_installmentArr removeAllObjects];
        [_installmentColl reloadData];
        
        _paymentL.hidden = NO;
        _paymentTF.hidden = NO;
        _loanPriceL.hidden = NO;
        _loanPriceTF.hidden = NO;
        _loanBankL.hidden = NO;
        _loanBankBtn.hidden = NO;
        _loanYearL.hidden = NO;
        _loanYearTF.hidden = NO;
        _businessLoanPriceL.hidden = YES;
        _businessLoanPriceTF.hidden = YES;
        _businessLoanBankL.hidden = YES;
        _businessLoanBankBtn.hidden = YES;
        _businessLoanYearL.hidden = YES;
        _businessLoanYearTF.hidden = YES;
        _fundLoanL.hidden = YES;
        _fundLoanTF.hidden = YES;
        _fundLoanBankL.hidden = YES;
        _fundLoanBankBtn.hidden = YES;
        _fundLoanYearL.hidden = YES;
        _fundLoanYearTF.hidden = YES;
        _installmentColl.hidden = YES;
        
        [_priceTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_totalTF.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            
        }];
        
        [_loanYearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_loanBankBtn.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            make.bottom.equalTo(self).offset(-20 *SIZE);
        }];
        
        [_fundLoanYearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_fundLoanBankBtn.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_installmentColl mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_paymentTF.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(self->_installmentColl.collectionViewLayout.collectionViewContentSize.height);
//            make.bottom.equalTo(self).offset(-20 *SIZE);
        }];
    }else if ([_payWayBtn.content.text isEqualToString:@"综合贷款"]){
        
        [_installmentArr removeAllObjects];
        [_installmentColl reloadData];
        
        _paymentL.hidden = NO;
        _paymentTF.hidden = NO;
        _loanPriceL.hidden = YES;
        _loanPriceTF.hidden = YES;
        _loanBankL.hidden = YES;
        _loanBankBtn.hidden = YES;
        _loanYearL.hidden = YES;
        _loanYearTF.hidden = YES;
        _businessLoanPriceL.hidden = NO;
        _businessLoanPriceTF.hidden = NO;
        _businessLoanBankL.hidden = NO;
        _businessLoanBankBtn.hidden = NO;
        _businessLoanYearL.hidden = NO;
        _businessLoanYearTF.hidden = NO;
        _fundLoanL.hidden = NO;
        _fundLoanTF.hidden = NO;
        _fundLoanBankL.hidden = NO;
        _fundLoanBankBtn.hidden = NO;
        _fundLoanYearL.hidden = NO;
        _fundLoanYearTF.hidden = NO;
        _installmentColl.hidden = YES;
        
        [_priceTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_totalTF.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            
        }];
        
        [_loanYearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_loanBankBtn.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            
        }];
        
        [_fundLoanYearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_fundLoanBankBtn.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            make.bottom.equalTo(self).offset(-20 *SIZE);
        }];
        
        [_installmentColl mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_paymentTF.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(self->_installmentColl.collectionViewLayout.collectionViewContentSize.height);
//            make.bottom.equalTo(self).offset(-20 *SIZE);
        }];
    }else if ([_payWayBtn.content.text isEqualToString:@"银行按揭贷款"]){
        
        [_installmentArr removeAllObjects];
        [_installmentColl reloadData];
        
        _paymentL.hidden = NO;
        _paymentTF.hidden = NO;
        _loanPriceL.hidden = NO;
        _loanPriceTF.hidden = NO;
        _loanBankL.hidden = NO;
        _loanBankBtn.hidden = NO;
        _loanYearL.hidden = NO;
        _loanYearTF.hidden = NO;
        _businessLoanPriceL.hidden = YES;
        _businessLoanPriceTF.hidden = YES;
        _businessLoanBankL.hidden = YES;
        _businessLoanBankBtn.hidden = YES;
        _businessLoanYearL.hidden = YES;
        _businessLoanYearTF.hidden = YES;
        _fundLoanL.hidden = YES;
        _fundLoanTF.hidden = YES;
        _fundLoanBankL.hidden = YES;
        _fundLoanBankBtn.hidden = YES;
        _fundLoanYearL.hidden = YES;
        _fundLoanYearTF.hidden = YES;
        _installmentColl.hidden = YES;
        
        [_priceTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_totalTF.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            
        }];
        
        [_loanYearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_loanBankBtn.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            make.bottom.equalTo(self).offset(-20 *SIZE);
        }];
        
        [_fundLoanYearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_fundLoanBankBtn.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_installmentColl mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_paymentTF.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(self->_installmentColl.collectionViewLayout.collectionViewContentSize.height);
//            make.bottom.equalTo(self).offset(-20 *SIZE);
        }];
    }else if ([_payWayBtn.content.text isEqualToString:@"分期付款"]){
        
//        [_installmentArr removeAllObjects];
        _paymentL.hidden = YES;
        _paymentTF.hidden = YES;
        _businessLoanPriceL.hidden = YES;
        _businessLoanPriceTF.hidden = YES;
        _businessLoanBankL.hidden = YES;
        _businessLoanBankBtn.hidden = YES;
        _businessLoanYearL.hidden = YES;
        _businessLoanYearTF.hidden = YES;
        _fundLoanL.hidden = YES;
        _fundLoanTF.hidden = YES;
        _fundLoanBankL.hidden = YES;
        _fundLoanBankBtn.hidden = YES;
        _fundLoanYearL.hidden = YES;
        _fundLoanYearTF.hidden = YES;
        _loanPriceL.hidden = YES;
        _loanPriceTF.hidden = YES;
        _loanBankL.hidden = YES;
        _loanBankBtn.hidden = YES;
        _loanYearL.hidden = YES;
        _loanYearTF.hidden = YES;
        _installmentColl.hidden = NO;
        [_installmentColl reloadData];
        
        [_priceTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_totalTF.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
//            make.bottom.equalTo(self).offset(-20 *SIZE);
        }];
        
        [_installmentColl mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_paymentTF.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(self->_installmentColl.collectionViewLayout.collectionViewContentSize.height);
            make.bottom.equalTo(self).offset(-20 *SIZE);
        }];
        
        [_loanYearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_loanBankBtn.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_fundLoanYearTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_loanBankBtn.mas_bottom).offset(14 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
    }
    
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    _preferentialArr = [NSMutableArray arrayWithArray:dataArr];
    [_coll reloadData];
    [_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_addBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.addOrderViewStrBlock(textField.text, textField.tag);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (collectionView == _coll) {
        
        return 1;
    }else{
        
        return _installmentArr.count ? _installmentArr.count : 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _coll) {
        
        return _preferentialArr.count;
    }else{
        
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _coll) {
        
        preferentialCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"preferentialCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[preferentialCollCell alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 80 *SIZE)];
        }
        cell.tag = indexPath.item;
        
        cell.dataDic = _preferentialArr[indexPath.item];
        
        cell.preferentialCollCellDeleteBlock = ^(NSInteger index) {
            
            [self->_preferentialArr removeObjectAtIndex:index];
            [collectionView reloadData];
            [self->_coll mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(self).offset(80 *SIZE);
                make.top.equalTo(self->_addBtn.mas_bottom).offset(14 *SIZE);
                make.width.mas_equalTo(258 *SIZE);
                make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
            }];
            self.addOrderViewDeleteBlock(index);
        };
        
        return cell;
    }else{
        
        installmentCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"installmentCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[installmentCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 90 *SIZE)];
        }
        
        return cell;
    }
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    
    NSArray *titleArr = @[@"定单编号：",@"定金金额：",@"优惠方案：",@"总价优惠：",@"优惠价格：",@"公示总价：",@"成交价格：",@"付款方式：",@"首付金额：",@"商业贷款金额：",@"商业按揭银行：",@"商业按揭年限：",@"公积金贷款金额：",@"公积金按揭银行：",@"公积金按揭年限：",@"贷款金额：",@"按揭银行：",@"按揭年限："];
    NSArray *placeArr = @[@"请输入定单编号",@"请输入定金金额",@"",@"请输入总价优惠金额",@"选择优惠方案自动计算",@"",@"自动计算",@"请选择付款方式",@"请输入首付金额",@"商业贷款金额",@"请选择商业按揭银行",@"请输入商业按揭年限",@"公积金贷款金额",@"请选择公积金按揭银行",@"请输入公积金按揭年限",@"贷款金额",@"请选择按揭银行",@"请输入按揭年限"];
    for (int i = 0; i < 18; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = titleArr[i];
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        tf.textField.placeholder = placeArr[i];
        tf.textField.tag = i;
        tf.textField.delegate = self;
        switch (i) {
            case 0:
            {
                _codeL = label;
                [self addSubview:_codeL];
                
                _codeTF = tf;
                [self addSubview:_codeTF];
                break;
            }
            case 1:
            {
                _depositL = label;
                [self addSubview:_depositL];
                
                _depositTF = tf;
                _depositTF.unitL.text = @"元";
                [self addSubview:_depositTF];
                break;
            }
            case 2:
            {
                _preferentialL = label;
                [self addSubview:_preferentialL];
                
                
                break;
            }
            case 3:
            {
                _spePreferentialL = label;
                [self addSubview:_spePreferentialL];
                
                _spePreferentialTF = tf;
                _spePreferentialTF.unitL.text = @"元";
                [self addSubview:_spePreferentialTF];
                break;
            }
            case 4:
            {
                _preferPriceL = label;
                [self addSubview:_preferPriceL];
                
                _preferPriceTF = tf;
                _preferPriceTF.backgroundColor = CLBackColor;
                _preferPriceTF.userInteractionEnabled = NO;
                _preferPriceTF.unitL.text = @"元";
                [self addSubview:_preferPriceTF];
                break;
            }
            case 5:
            {
                _totalL = label;
                [self addSubview:_totalL];
                
                _totalTF = tf;
                _totalTF.backgroundColor = CLBackColor;
                _totalTF.userInteractionEnabled = NO;
                _totalTF.unitL.text = @"元";
                [self addSubview:_totalTF];
                break;
            }
            case 6:
            {
                _priceL = label;
                [self addSubview:_priceL];
                
                _priceTF = tf;
                _priceTF.backgroundColor = CLBackColor;
                _priceTF.userInteractionEnabled = NO;
                _priceTF.unitL.text = @"元";
                [self addSubview:_priceTF];
                break;
            }
            case 7:
            {
                _payWayL = label;
                [self addSubview:_payWayL];
                
                _payWayBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_payWayBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_payWayBtn];
                break;
            }
            case 8:
            {
                _paymentL = label;
                _paymentL.hidden = YES;
                [self addSubview:_paymentL];
                
                _paymentTF = tf;
                _paymentTF.hidden = YES;
                _paymentTF.unitL.text = @"元";
                [self addSubview:_paymentTF];
                break;
            }
            case 9:
            {
                _businessLoanPriceL = label;
                _businessLoanPriceL.hidden = YES;
                [self addSubview:_businessLoanPriceL];
                
                _businessLoanPriceTF = tf;
                _businessLoanPriceTF.hidden = YES;
                _businessLoanPriceTF.unitL.text = @"元";
                [self addSubview:_businessLoanPriceTF];
                break;
            }
            case 10:
            {
                _businessLoanBankL = label;
                _businessLoanBankL.hidden = YES;
                [self addSubview:_businessLoanBankL];
                
                _businessLoanBankBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                _businessLoanBankBtn.hidden = YES;
//                _businessLoanBankBtn.placeL.text = 
                [self addSubview:_businessLoanBankBtn];
                break;
            }
            case 11:
            {
                _businessLoanYearL = label;
                _businessLoanYearL.hidden = YES;
                [self addSubview:_businessLoanYearL];
                
                _businessLoanYearTF = tf;
                _businessLoanYearTF.hidden = YES;
                _businessLoanYearTF.unitL.text = @"年";
                [self addSubview:_businessLoanYearTF];
                break;
            }
            case 12:
            {
                _fundLoanL = label;
                _fundLoanL.hidden = YES;
                [self addSubview:_fundLoanL];
                
                _fundLoanTF = tf;
                _fundLoanTF.hidden = YES;
                _fundLoanTF.unitL.text = @"元";
                [self addSubview:_fundLoanTF];
                break;
            }
            case 13:
            {
                _fundLoanBankL = label;
                _fundLoanBankL.hidden = YES;
                [self addSubview:_fundLoanBankL];
                
                _fundLoanBankBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                _fundLoanBankBtn.hidden = YES;
                [self addSubview:_fundLoanBankBtn];
                break;
            }
            case 14:
            {
                _fundLoanYearL = label;
                _fundLoanYearL.hidden = YES;
                [self addSubview:_fundLoanYearL];
                
                _fundLoanYearTF = tf;
                _fundLoanYearTF.hidden = YES;
                _fundLoanYearTF.unitL.text = @"年";
                [self addSubview:_fundLoanYearTF];
                break;
            }
            case 15:
            {
                _loanPriceL = label;
                _loanPriceL.hidden = YES;
                [self addSubview:_loanPriceL];
                
                _loanPriceTF = tf;
                _loanPriceTF.hidden = YES;
                _loanPriceTF.backgroundColor = CLBackColor;
                _loanPriceTF.userInteractionEnabled = NO;
                _loanPriceTF.unitL.text = @"元";
                [self addSubview:_loanPriceTF];
                break;
            }
            case 16:
            {
                _loanBankL = label;
                _loanBankL.hidden = YES;
                [self addSubview:_loanBankL];
                
                _loanBankBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                _loanBankBtn.hidden = YES;
                [self addSubview:_loanBankBtn];
                break;
            }
            case 17:
            {
                _loanYearL = label;
                _loanYearL.hidden = YES;
                [self addSubview:_loanYearL];
                
                _loanYearTF = tf;
                _loanYearTF.hidden = YES;
                _loanYearTF.unitL.text = @"年";
                [self addSubview:_loanYearTF];
                break;
            }
            default:
                break;
        }
    }
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:IMAGE_WITH_NAME(@"add_1") forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithCenter betweenOfCell:5 *SIZE];
    _layout.itemSize = CGSizeMake(258 *SIZE, 80 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[preferentialCollCell class] forCellWithReuseIdentifier:@"preferentialCollCell"];
    [self addSubview:_coll];
    
    _installmentLayout = [[GZQFlowLayout alloc] initWithType:AlignWithCenter betweenOfCell:5 *SIZE];
    _installmentLayout.itemSize = CGSizeMake(SCREEN_Width, 90 *SIZE);

    
    _installmentColl = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_installmentLayout];
    _installmentColl.backgroundColor = CLWhiteColor;
    _installmentColl.hidden = YES;
    [_installmentColl registerClass:[installmentCollCell class] forCellWithReuseIdentifier:@"installmentCollCell"];
    [self addSubview:_installmentColl];
    
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self).offset(22 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self).offset(17 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_depositL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_depositTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_depositTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_depositTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_preferentialL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_payWayBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_payWayBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(33 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_addBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
//        make.height.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_spePreferentialL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_spePreferentialTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_preferPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_spePreferentialTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_preferPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_spePreferentialTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_preferPriceTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_totalTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_preferPriceTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_totalTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_totalTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self).offset(-20 *SIZE);
    }];
    
    [_paymentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_paymentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self).offset(-20 *SIZE);
    }];
    
    [_installmentColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_paymentTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(self->_installmentColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_loanPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_paymentTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_loanPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_paymentTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_businessLoanPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_paymentTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_businessLoanPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_paymentTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_loanBankL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_loanPriceTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_loanBankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_loanPriceTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_businessLoanBankL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_businessLoanPriceTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_businessLoanBankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_businessLoanPriceTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_loanYearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_loanBankBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_loanYearTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_loanBankBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_businessLoanYearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_businessLoanBankBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_businessLoanYearTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_businessLoanBankBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_fundLoanL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_businessLoanYearTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_fundLoanTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_businessLoanYearTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_fundLoanBankL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_fundLoanTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_fundLoanBankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_fundLoanTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_fundLoanYearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_fundLoanBankBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_fundLoanYearTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_fundLoanBankBtn.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
}

@end
