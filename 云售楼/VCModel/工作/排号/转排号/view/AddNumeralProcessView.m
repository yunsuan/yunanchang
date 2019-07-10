//
//  AddNumeralProcessView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddNumeralProcessView.h"

#import "BoxSelectCollCell.h"

@interface AddNumeralProcessView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    
}
@end

@implementation AddNumeralProcessView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _typeBtn.content.text = dataDic[@"progress_name"];
    if ([dataDic[@"check_type"] integerValue] == 1) {

        [_typeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
//            make.bottom.equalTo(self).offset(-10 *SIZE);
        }];
        
        _auditL.hidden = NO;
        _auditBtn.hidden = NO;
        
        [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(9 *SIZE);
            make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_auditBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            make.bottom.equalTo(self).offset(-10 *SIZE);
        }];
    }else if ([dataDic[@"check_type"] integerValue] == 2){
        
        [_typeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            make.bottom.equalTo(self).offset(-10 *SIZE);
        }];
        _auditL.hidden = YES;
        _auditBtn.hidden = YES;
    }else if ([dataDic[@"check_type"] integerValue] == 3){
        
        _auditL.hidden = NO;
        _auditBtn.hidden = NO;
        
        [_typeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            //            make.bottom.equalTo(self).offset(-10 *SIZE);
        }];
        
        [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(9 *SIZE);
            make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_auditBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            make.bottom.equalTo(self).offset(-10 *SIZE);
        }];
    }else{
        
        
    }
}

- (void)ActionTypeBtn:(UIButton *)btn{
    
    if (self.addNumeralProcessViewTypeBlock) {
        
        self.addNumeralProcessViewTypeBlock();
    }
}

- (void)ActionAuditBtn:(UIButton *)btn{
    
    if (self.addNumeralProcessViewAuditBlock) {
        
        self.addNumeralProcessViewAuditBlock();
    }
}

- (void)ActionRoleBtn:(UIButton *)btn{
    
    if (self.addNumeralProcessViewRoleBlock) {
        
        self.addNumeralProcessViewRoleBlock();
    }
}

- (void)ActionFinalBtn:(UIButton *)btn{
    
    if (self.addNumeralProcessViewFinalBlock) {
        
        self.addNumeralProcessViewFinalBlock();
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxSelectCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxSelectCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BoxSelectCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 20 *SIZE)];
    }
    
    cell.tag = 1;
    
//    if (collectionView == _followWayColl) {
//
//        [cell setIsSelect:[_followSelectArr[indexPath.item] integerValue]];
//
//        cell.titleL.text = _followArr[indexPath.item][@"param"];
//    }else{
//
//        [cell setIsSelect:[_levelSelectArr[indexPath.item] integerValue]];
//
//        cell.titleL.text = _levelArr[indexPath.item][@"config_name"];
//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    
    NSArray *titleArr = @[@"审批流程：",@"流程类型：",@"项目角色：",@"审核人员：",@"是否终审："];
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        //        [self addSubview:label];
        
        if (i == 1) {
            
            _auditL = label;
            _auditL.hidden = YES;
            [self addSubview:_auditL];
            
            _auditBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_auditBtn addTarget:self action:@selector(ActionAuditBtn:) forControlEvents:UIControlEventTouchUpInside];
            _auditBtn.hidden = YES;
            [self addSubview:_auditBtn];
        }else if(i == 0){
            
            _typeL = label;
            [self addSubview:_typeL];
            
            _typeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_typeBtn addTarget:self action:@selector(ActionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_typeBtn];
        }else if(i == 2){
            
            _roleL = label;
            _roleL.hidden = YES;
            [self addSubview:_roleL];
            
            _roleBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_roleBtn addTarget:self action:@selector(ActionRoleBtn:) forControlEvents:UIControlEventTouchUpInside];
            _roleBtn.hidden = YES;
            [self addSubview:_roleBtn];
        }else if(i == 3){
            
            _personL = label;
            _personL.hidden = YES;
            [self addSubview:_personL];
            
            _layout = [[GZQFlowLayout alloc] initWithType:1 betweenOfCell:5 *SIZE];
            _layout.itemSize = CGSizeMake(100 *SIZE, 20 *SIZE);
            
            _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
            _coll.backgroundColor = CLWhiteColor;
            _coll.delegate = self;
            _coll.dataSource = self;
            [_coll registerClass:[BoxSelectCollCell class] forCellWithReuseIdentifier:@"BoxSelectCollCell"];
            [self addSubview:_coll];
        }else{
            
            _finalL = label;
            _finalL.hidden = YES;
            [self addSubview:_finalL];
            
            _finalBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_finalBtn addTarget:self action:@selector(ActionFinalBtn:) forControlEvents:UIControlEventTouchUpInside];
            _finalBtn.hidden = YES;
            [self addSubview:_finalBtn];
        }
    }
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self).offset(-10 *SIZE);
    }];
    
    [_auditL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];

    [_auditBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_roleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_auditBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_roleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_auditBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_personL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_roleBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_roleBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_finalL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_finalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    
}

@end
