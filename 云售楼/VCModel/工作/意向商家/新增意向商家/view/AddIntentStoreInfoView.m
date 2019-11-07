//
//  AddIntentStoreInfoView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddIntentStoreInfoView.h"

#import "AddIntentStoreInfoCollCell.h"

@interface AddIntentStoreInfoView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSMutableArray *_imgArr;
}

@end

@implementation AddIntentStoreInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _imgArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    _imgArr = [NSMutableArray arrayWithArray:dataArr];
    [_coll reloadData];
    [_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self->_addBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self.mas_bottom).offset(0 *SIZE);
    }];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.addIntentStoreInfoViewAddBlock) {
        
        self.addIntentStoreInfoViewAddBlock();
    }
}

- (void)ActionSelectBtn:(UIButton *)btn{
    
    if (self.addIntentStoreInfoViewSelectBlock) {
        
        self.addIntentStoreInfoViewSelectBlock();
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddIntentStoreInfoCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddIntentStoreInfoCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AddIntentStoreInfoCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 105 *SIZE)];
    }
    
    cell.tag = indexPath.item;
    
    cell.dataDic = _imgArr[indexPath.item];

    cell.addIntentStoreInfoCollCellDeleteBlock = ^(NSInteger idx) {

        if (self.addIntentStoreInfoViewDeleteBlock) {

            self.addIntentStoreInfoViewDeleteBlock(idx);
        }
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 

}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setBackgroundColor:CLOrangeColor];
    [_addBtn setTitle:@"添加商家" forState:UIControlStateNormal];
    [_addBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.titleLabel.font = FONT(13 *SIZE);
    _addBtn.layer.cornerRadius = 15 *SIZE;
    _addBtn.clipsToBounds = YES;
    [self addSubview:_addBtn];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setBackgroundColor:CLOrangeColor];
    [_selectBtn setTitle:@"选择商家" forState:UIControlStateNormal];
    [_selectBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(ActionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn.titleLabel.font = FONT(13 *SIZE);
    _selectBtn.layer.cornerRadius = 15 *SIZE;
    _selectBtn.clipsToBounds = YES;
    [self addSubview:_selectBtn];
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:5 *SIZE];
    _layout.itemSize = CGSizeMake(SCREEN_Width, 105 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[AddIntentStoreInfoCollCell class] forCellWithReuseIdentifier:@"AddIntentStoreInfoCollCell"];
    [self addSubview:_coll];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(40 *SIZE);
        make.top.equalTo(self).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
        
    }];
         
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(220 *SIZE);
        make.top.equalTo(self).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self->_addBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(210 *SIZE);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self.mas_bottom).offset(0 *SIZE);
    }];
}

@end
