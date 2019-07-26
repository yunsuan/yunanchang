//
//  SpePerferDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SpePerferDetailVC.h"

#import "GZQFlowLayout.h"
#import "SelectPerferCollCell.h"

@interface SpePerferDetailVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_dataArr;;
}

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

@implementation SpePerferDetailVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = [[NSMutableArray alloc] initWithArray:dataArr];;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initUI];
//    [self RequestMethod];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectPerferCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectPerferCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SelectPerferCollCell alloc] initWithFrame:CGRectMake(0, 0, 340 *SIZE, 100 *SIZE)];
    }
    
    cell.layer.cornerRadius = 5 *SIZE;
    cell.layer.borderWidth = SIZE;
    cell.layer.borderColor = CLLineColor.CGColor;
    cell.clipsToBounds = YES;
    
//    cell.dataDic = _dataArr[indexPath.item];
    
    cell.nameL.text = [NSString stringWithFormat:@"折扣名称：%@",_dataArr[indexPath.item][@"name"]];
    cell.wayL.text = [NSString stringWithFormat:@"折扣方式：%@",_dataArr[indexPath.item][@"type"]];
    cell.describeL.text = [NSString stringWithFormat:@"优惠：%@",_dataArr[indexPath.item][@"num"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (self.selectSpePerferVCBlock) {
//
//        self.selectSpePerferVCBlock(_dataArr[indexPath.item]);
//    }
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"优惠详情";
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithCenter betweenOfCell:5 *SIZE];
    _layout.itemSize = CGSizeMake(340 *SIZE, 100 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) collectionViewLayout:_layout];
    _coll.backgroundColor = CLBackColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[SelectPerferCollCell class] forCellWithReuseIdentifier:@"SelectPerferCollCell"];
    [self.view addSubview:_coll];
}
@end
