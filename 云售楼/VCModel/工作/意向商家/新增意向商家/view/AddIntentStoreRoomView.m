//
//  AddIntentStoreRoomView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddIntentStoreRoomView.h"

#import "AddIntentStoreRoomCollCell.h"

@interface AddIntentStoreRoomView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSMutableArray *_imgArr;
}

@end

@implementation AddIntentStoreRoomView

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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self->_coll reloadData];
        [self->_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
        
            make.left.equalTo(self).offset(0 *SIZE);
            make.top.equalTo(self).offset(0 *SIZE);
            make.width.mas_equalTo(SCREEN_Width);
            make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
        }];
    });
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.addIntentStoreRoomViewAddBlock) {
        
        self.addIntentStoreRoomViewAddBlock();
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
//    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddIntentStoreRoomCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddIntentStoreRoomCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AddIntentStoreRoomCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 70 *SIZE)];
    }
    
    cell.tag = indexPath.item;
    
    cell.roomL.text = [NSString stringWithFormat:@"房间：%@%@%@",_imgArr[indexPath.item][@"build_name"],_imgArr[indexPath.item][@"unit_name"],_imgArr[indexPath.item][@"name"]];
    cell.areaL.text = [NSString stringWithFormat:@"面积：%@㎡",_imgArr[indexPath.item][@"build_size"]];
    cell.priceL.text = [NSString stringWithFormat:@"租金：%@元/月/㎡",_imgArr[indexPath.item][@"total_rent"]];

    cell.addIntentStoreRoomCollCellDeleteBlock = ^(NSInteger idx) {

        if (self.addIntentStoreRoomViewDeleteBlock) {

            self.addIntentStoreRoomViewDeleteBlock(idx);
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
    [_addBtn setTitle:@"添加房源" forState:UIControlStateNormal];
    [_addBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.titleLabel.font = FONT(13 *SIZE);
    _addBtn.layer.cornerRadius = 15 *SIZE;
    _addBtn.clipsToBounds = YES;
    [self addSubview:_addBtn];
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:5 *SIZE];
    _layout.itemSize = CGSizeMake(SCREEN_Width, 70 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[AddIntentStoreRoomCollCell class] forCellWithReuseIdentifier:@"AddIntentStoreRoomCollCell"];
    [self addSubview:_coll];
            
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(210 *SIZE);
        make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
        make.bottom.equalTo(self.mas_bottom).offset(-10 *SIZE);
    }];
}

@end
