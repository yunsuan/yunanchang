//
//  NumeralDetailHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralDetailHeader.h"

#import "CallTelegramCustomDetailHeaderCollCell.h"

@interface NumeralDetailHeader ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSInteger _selectNum;
    
    NSMutableArray *_collArr;
    NSMutableArray *_selectArr;
}
@end

@implementation NumeralDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        _selectArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{

    
    _collArr = [[NSMutableArray alloc] initWithArray:dataDic[@"beneficiary"]];
    [_coll reloadData];
    
//    for (int i = 0; i < _collArr.count; i++) {
//
//        [_selectArr addObject:@0];
//    }
//    _statusL.text = @"排号";
    switch ([dataDic[@"disabled_state"] integerValue]) {
        case 0:
        {
            _statusL.text = @"有效";
            break;
        }
        case 1:
        {
            _statusL.text = @"变更";
            break;
        }
        case 2:
        {
            _statusL.text = @"作废";
            break;
        }
        case 3:
        {
            _statusL.text = @"转定单";
            break;
        }
        case 4:
        {
            _statusL.text = @"转签约";
            break;
        }
        case 5:
        {
            _statusL.text = @"退号";
            break;
        }
        default:
            _statusL.text = @"有效";
            break;
    }
    switch ([dataDic[@"check_state"] integerValue]) {
        case 0:
        {
            _auditL.text = @"不通过";
            break;
        }
        case 1:
        {
            _auditL.text = @"已审核";
            break;
        }
        case 2:
        {
            _auditL.text = @"未审核";
            break;
        }
        case 3:
        {
            _auditL.text = @"审核中";
            break;
        }
        default:
            _auditL.text = @"未审核";
            break;
    }
    
    if ([dataDic[@"disabled_state"] integerValue] == 0 && [dataDic[@"check_state"] integerValue] == 2) {
        
        _editBtn.hidden = NO;
    }else{
        
        _editBtn.hidden = YES;
    }
    
    _payL.text = [dataDic[@"receive_state"] integerValue] == 1? @"已收款":@"未收款";
    _numL.text = [NSString stringWithFormat:@"排号号码：%@",dataDic[@"row_code"]];
    _customL.text = [NSString stringWithFormat:@"归属人：%@",dataDic[@"advicer"][0][@"name"]];
    _titleL.text = [NSString stringWithFormat:@"%@/%@",dataDic[@"batch_name"],dataDic[@"row_name"]];
//    _moneyL.text = [NSString stringWithFormat:@"诚意金：%@",dataDic[@"down_pay"]];
}

- (void)setOrderDic:(NSDictionary *)orderDic{
    
    _collArr = [[NSMutableArray alloc] initWithArray:orderDic[@"beneficiary"]];
    [_coll reloadData];
    
    switch ([orderDic[@"disabled_state"] integerValue]) {
        case 0:
        {
            _statusL.text = @"有效";
            break;
        }
        case 1:
        {
            _statusL.text = @"变更";
            break;
        }
        case 2:
        {
            _statusL.text = @"作废";
            break;
        }
        case 3:
        {
            _statusL.text = @"转定单";
            break;
        }
        case 4:
        {
            _statusL.text = @"转签约";
            break;
        }
        case 5:
        {
            _statusL.text = @"退号";
            break;
        }
        default:
            _statusL.text = @"定单";
            break;
    }
    switch ([orderDic[@"check_state"] integerValue]) {
        case 0:
        {
            _auditL.text = @"不通过";
            break;
        }
        case 1:
        {
            _auditL.text = @"已审核";
            break;
        }
        case 2:
        {
            _auditL.text = @"未审核";
            break;
        }
        case 3:
        {
            _auditL.text = @"审核中";
            break;
        }
        default:
            _auditL.text = @"未审核";
            break;
    }
    
    if ([orderDic[@"disabled_state"] integerValue] == 0 && [orderDic[@"check_state"] integerValue] == 2) {
        
        _editBtn.hidden = NO;
    }else{
        
        _editBtn.hidden = YES;
    }
    
    _payL.text = [orderDic[@"receive_state"] integerValue] == 1? @"已收款":@"未收款";
    _numL.text = [NSString stringWithFormat:@"付款方式：%@",orderDic[@"pay_way_name"]];
    _customL.text = [NSString stringWithFormat:@"成交总价：%@元",orderDic[@"sub_total_price"]];
    _titleL.text = [NSString stringWithFormat:@"%@/%@/%@",orderDic[@"batch_name"],orderDic[@"build_name"],orderDic[@"property_type"]];
}

- (void)setSignDic:(NSDictionary *)signDic{
    
    _collArr = [[NSMutableArray alloc] initWithArray:signDic[@"beneficiary"]];
    [_coll reloadData];
    
    switch ([signDic[@"disabled_state"] integerValue]) {
        case 0:
        {
            _statusL.text = @"有效";
            break;
        }
        case 1:
        {
            _statusL.text = @"变更";
            break;
        }
        case 2:
        {
            _statusL.text = @"作废";
            break;
        }
        case 3:
        {
            _statusL.text = @"转定单";
            break;
        }
        case 4:
        {
            _statusL.text = @"转签约";
            break;
        }
        case 5:
        {
            _statusL.text = @"退号";
            break;
        }
        default:
            _statusL.text = @"签约";
            break;
    }
    switch ([signDic[@"check_state"] integerValue]) {
        case 0:
        {
            _auditL.text = @"不通过";
            break;
        }
        case 1:
        {
            _auditL.text = @"已审核";
            break;
        }
        case 2:
        {
            _auditL.text = @"未审核";
            break;
        }
        case 3:
        {
            _auditL.text = @"审核中";
            break;
        }
        default:
            _auditL.text = @"未审核";
            break;
    }
    
    if ([signDic[@"disabled_state"] integerValue] == 0 && [signDic[@"check_state"] integerValue] == 2) {
        
        _editBtn.hidden = NO;
    }else{
        
        _editBtn.hidden = YES;
    }
    
    _payL.text = [signDic[@"receive_state"] integerValue] == 1? @"已收款":@"未收款";
    _numL.text = [NSString stringWithFormat:@"付款方式：%@",signDic[@"pay_way_name"]];
    _customL.text = [NSString stringWithFormat:@"成交总价：%@元",signDic[@"contract_total_price"]];
    _titleL.text = [NSString stringWithFormat:@"%@/%@",signDic[@"build_name"],signDic[@"house_name"]];
}

- (void)setNum:(NSInteger)num{
    
    [_selectArr removeAllObjects];
    for (int i = 0; i < _collArr.count; i++) {
        
        [_selectArr addObject:@0];
    }
    _selectNum = num;
    [_selectArr replaceObjectAtIndex:num withObject:@1];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.numeralDetailHeaderAddBlock) {
        
        self.numeralDetailHeaderAddBlock();
    }
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.numeralDetailHeaderEditBlock) {
        
        self.numeralDetailHeaderEditBlock();
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _collArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCustomDetailHeaderCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CallTelegramCustomDetailHeaderCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CallTelegramCustomDetailHeaderCollCell alloc] initWithFrame:CGRectMake(0, 0, 87 *SIZE, 70 *SIZE)];
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
    if (self.numeralDetailHeaderCollBlock) {

        self.numeralDetailHeaderCollBlock(indexPath.item);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:_blueView];
    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:13 *SIZE];
    _flowLayout.itemSize = CGSizeMake(87 *SIZE, 70 *SIZE);
    _flowLayout.minimumLineSpacing = 8 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 10 *SIZE, 0, 0);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:IMAGE_WITH_NAME(@"add_4") forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[CallTelegramCustomDetailHeaderCollCell class] forCellWithReuseIdentifier:@"CallTelegramCustomDetailHeaderCollCell"];
    [self.contentView addSubview:_coll];
    
    _headImg = [[UIImageView alloc] init];
//    _headImg.layer.cornerRadius = 33.5 *SIZE;
//    _headImg.clipsToBounds = YES;
    _headImg.image = IMAGE_WITH_NAME(@"paihao");
    [_blueView addSubview:_headImg];
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLWhiteColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _titleL = label;
                [_blueView addSubview:_titleL];
                break;
            }
            case 1:
            {
                _payL = label;
                _payL.textAlignment = NSTextAlignmentCenter;
                _payL.backgroundColor = CLBlueTagColor;
                [_blueView addSubview:_payL];
                break;
            }
            case 2:
            {
                _auditL = label;
                _auditL.backgroundColor = CLBlueTagColor;
                _auditL.textAlignment = NSTextAlignmentCenter;
                [_blueView addSubview:_auditL];
                break;
            }
            case 3:
            {
                _moneyL = label;
                [_blueView addSubview:_moneyL];
                break;
            }
            case 4:
            {
                _statusL = label;
                _statusL.backgroundColor = CLBlueTagColor;
                _statusL.textAlignment = NSTextAlignmentCenter;
                [_blueView addSubview:_statusL];
                break;
            }
            case 5:
            {
                _customL = label;
                [_blueView addSubview:_customL];
                break;
            }
            case 6:
            {
                _numL = label;
                [_blueView addSubview:_numL];
                break;
            }
            default:
                break;
        }
    }
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:IMAGE_WITH_NAME(@"editor_3") forState:UIControlStateNormal];
    [_blueView addSubview:_editBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(10 *SIZE);
        make.top.equalTo(self->_blueView).offset(10 *SIZE);
        make.width.height.mas_equalTo(67 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-18 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.height.mas_equalTo(26 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_blueView).offset(9 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
    }];
    
    [_customL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_customL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
    }];
    
    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_numL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(0 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(119 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self->_blueView).offset(-0 *SIZE);
    }];
    
    [_auditL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(120 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(119 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_blueView).offset(240 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self->_blueView).offset(-0 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-13 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(11 *SIZE);
        make.width.height.mas_equalTo(25 *SIZE);
    }];
}


@end
