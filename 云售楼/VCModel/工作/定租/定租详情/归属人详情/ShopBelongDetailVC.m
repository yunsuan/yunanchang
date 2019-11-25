//
//  ShopBelongDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ShopBelongDetailVC.h"

#import "preferentialCollCell.h"

#import "GZQFlowLayout.h"

@interface ShopBelongDetailVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSArray *_dataArr;
}
@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

@implementation ShopBelongDetailVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = dataArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    preferentialCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"preferentialCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[preferentialCollCell alloc] initWithFrame:CGRectMake(0, 0, 340 *SIZE, 80 *SIZE)];
    }
    cell.tag = indexPath.item;
    
//    cell.dataDic = _dataArr[indexPath.item];
    cell.nameL.text = [NSString stringWithFormat:@"归属人：%@",_dataArr[indexPath.item][@"agent_name"]];
    cell.wayL.text = [NSString stringWithFormat:@"比重：%@%@",_dataArr[indexPath.item][@"property"],@"%"];
    cell.perferL.text = [NSString stringWithFormat:@"备注：%@",_dataArr[indexPath.item][@"comment"]];
    
    cell.deleteBtn.hidden = YES;
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"归属人详情";
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithCenter betweenOfCell:5 *SIZE];
    _layout.itemSize = CGSizeMake(340 *SIZE, 80 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[preferentialCollCell class] forCellWithReuseIdentifier:@"preferentialCollCell"];
    [self.view addSubview:_coll];
}

@end
