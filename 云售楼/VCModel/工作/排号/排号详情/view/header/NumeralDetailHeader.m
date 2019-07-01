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
    
    NSMutableArray *_collArr;
    NSMutableArray *_selectArr;
}
@end

@implementation NumeralDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _statusL.text = @"排号";
    _auditL.text = @"审核";
    _payL.text = @"未收款";
    _titleL.text = [NSString stringWithFormat:@"排号类别：%@",@"一批次"];
    _moneyL.text = [NSString stringWithFormat:@"诚意金：%@",@"一批次"];
    
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
//    if (self.callTelegramCustomDetailHeaderCollBlock) {
//
//        self.callTelegramCustomDetailHeaderCollBlock(indexPath.item);
//    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:13 *SIZE];
    _flowLayout.itemSize = CGSizeMake(67 *SIZE, 30 *SIZE);
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
    _headImg.layer.cornerRadius = 33.5 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _titleL = label;
                [self.contentView addSubview:_titleL];
                break;
            }
            case 1:
            {
                _payL = label;
                _payL.textAlignment = NSTextAlignmentCenter;
                [self.contentView addSubview:_payL];
                break;
            }
            case 2:
            {
                _auditL = label;
                _auditL.textAlignment = NSTextAlignmentCenter;
                [self.contentView addSubview:_auditL];
                break;
            }
            case 3:
            {
                _moneyL = label;
                [self.contentView addSubview:_moneyL];
                break;
            }
            case 4:
            {
                _statusL = label;
                _statusL.textAlignment = NSTextAlignmentCenter;
                [self.contentView addSubview:_statusL];
                break;
            }
            default:
                break;
        }
    }
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:IMAGE_WITH_NAME(@"editor_3") forState:UIControlStateNormal];
    [self.contentView addSubview:_editBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(47 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-13 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.height.mas_equalTo(25 *SIZE);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.height.mas_equalTo(67 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-18 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(11 *SIZE);
        make.width.height.mas_equalTo(26 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(94 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(self.contentView.mas_right).offset(-70 *SIZE);
    }];
    
    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(94 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView.mas_right).offset(-70 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
//        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_auditL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(125 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
//        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
    }];
}


@end
