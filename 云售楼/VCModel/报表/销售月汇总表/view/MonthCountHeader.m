//
//  MonthCountHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "MonthCountHeader.h"

#import "TypeTagCollCell.h"

@interface MonthCountHeader ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    
}
@end

@implementation MonthCountHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TypeTagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeTagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TypeTagCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 40 *SIZE)];
    }
    
    if (indexPath.item == 0) {
        
        cell.titleL.text = @"套数";
    }else if (indexPath.item == 1){
        
        cell.titleL.text = @"面积";
    }else{
        
        cell.titleL.text = @"金额";
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.monthCountHeaderBlock) {
        
        self.monthCountHeaderBlock(indexPath.item);
    }
}

- (void)initUI{

    self.contentView.backgroundColor = [UIColor whiteColor];

    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(60 *SIZE, 40 *SIZE);
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_Width - 210 *SIZE, 0 , 210 *SIZE, 40 *SIZE) collectionViewLayout:_layout];
    _coll.backgroundColor = [UIColor whiteColor];
    _coll.delegate = self;
    _coll.dataSource = self;
    _coll.showsHorizontalScrollIndicator = NO;
    _coll.bounces = NO;
    [_coll registerClass:[TypeTagCollCell class] forCellWithReuseIdentifier:@"TypeTagCollCell"];
    [self.contentView addSubview:_coll];
    
    [_coll selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(150 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.equalTo(@(200 *SIZE));
        make.height.equalTo(@(40 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(0 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(SIZE));
    }];
}



@end
