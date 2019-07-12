//
//  SelectSpePerferVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SelectSpePerferVC.h"

#import "GZQFlowLayout.h"
#import "SelectPerferCollCell.h"

@interface SelectSpePerferVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_dataArr;;
}

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

@implementation SelectSpePerferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    NSDictionary *dic = @{@"batch_id":[NSString stringWithFormat:@"%@",self.dic[@"batch_id"]],
                          @"build_id":[NSString stringWithFormat:@"%@",self.dic[@"build_id"]],
                          @"unit_id":[NSString stringWithFormat:@"%@",self.dic[@"unit_id"]],
                          };
 
    [BaseRequest GET:ProjectHouseGetDiscountList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [self->_coll reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
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
    
    cell.dataDic = _dataArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectSpePerferVCBlock) {
        
        self.selectSpePerferVCBlock(_dataArr[indexPath.item]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"折扣";
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:5 *SIZE];
    _layout.itemSize = CGSizeMake(340 *SIZE, 100 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) collectionViewLayout:_layout];
    _coll.backgroundColor = CLBackColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[SelectPerferCollCell class] forCellWithReuseIdentifier:@"SelectPerferCollCell"];
    [self.view addSubview:_coll];
}

@end
