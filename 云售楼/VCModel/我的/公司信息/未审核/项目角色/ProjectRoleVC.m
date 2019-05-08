//
//  ProjectRoleVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ProjectRoleVC.h"

#import "IntentSurveyHeader.h"
#import "BoxSelectCollCell.h"
#import "GZQFlowLayout.h"

@interface ProjectRoleVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
    
}
@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *intentColl;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation ProjectRoleVC

- (void)ActionNextBtn:(UIButton *)btn{
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 30 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    IntentSurveyHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IntentSurveyHeader" forIndexPath:indexPath];
    if (!header) {
        
        header = [[IntentSurveyHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 30 *SIZE)];
    }
    
    header.titleL.text = @"意向总价：";
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxSelectCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxSelectCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BoxSelectCollCell alloc] initWithFrame:CGRectMake(0, 0, 90 *SIZE, 50 *SIZE)];
    }
    [cell.titleL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(cell.contentView).offset(18 *SIZE);
        make.bottom.equalTo(cell.contentView).offset(-18 *SIZE);
    }];
    
    cell.titleL.text = @"写字楼";
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"选择此项目角色";

    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _flowLayout.itemSize = CGSizeMake(90 *SIZE, 50 *SIZE);
    _flowLayout.minimumLineSpacing = 10 *SIZE;
    
    _intentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _intentColl.backgroundColor = self.view.backgroundColor;
    _intentColl.delegate = self;
    _intentColl.dataSource = self;
    [_intentColl registerClass:[BoxSelectCollCell class] forCellWithReuseIdentifier:@"BoxSelectCollCell"];
    [_intentColl registerClass:[IntentSurveyHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IntentSurveyHeader"];
    [self.view addSubview:_intentColl];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    _nextBtn.layer.cornerRadius = 5 *SIZE;
    _nextBtn.clipsToBounds = YES;
    [self.view addSubview:_nextBtn];
}

@end
