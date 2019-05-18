//
//  RotationVC.m
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RotationVC.h"
#import "RotationHeadView.h"
#import "RotationCell.h"
@interface RotationVC()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
     NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UICollectionView *rotationCV;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation RotationVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
//
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    

}



-(void)PostWithType:(NSInteger)type Houseid:(NSString *)houseid
{
//    NSDictionary *prameters;
//    if(type == 1)
//    {
//        prameters = @{
//                      @"build_id":houseid
//                      };
//    }
//    else
//    {
//        prameters = @{
//                      @"unit_id":houseid
//                      };
//    }
//
//    [BaseRequest GET:ProjectHouseGetDetail_URL parameters:prameters success:^(id  _Nonnull resposeObject) {
//        if ([resposeObject[@"code"] integerValue]== 200) {
//            NSLog(@"%@",resposeObject);
//            RoomDetailVC *vc = [[RoomDetailVC alloc] init];
//            vc.LDinfo = resposeObject[@"data"];
//            vc.LDtitle = self->_ldtitle;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
}


- (void)ActionRightBtn:(UIButton *)btn{
   
}

- (void)RequestMethod{
    
    //    if (_info_id.length) {
    
//    [BaseRequest GET:ProjectHouseGetBuildList_URL parameters:@{@"info_id":[UserModel defaultModel].projectinfo[@"info_id"]} success:^(id  _Nonnull resposeObject) {
//
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            [self->_dataArr removeAllObjects];
//            self->_dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
//            [self->_coll reloadData];
//        }else{
//
//            [self showContent:resposeObject[@"msg"]];
//        }
//    } failure:^(NSError * _Nonnull error) {
//
//        [self showContent:@"网络错误"];
//    }];
//    //    }
//
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 12;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 40 *SIZE);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
        RotationHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RotationHeadView" forIndexPath:indexPath];
        if (!header) {
            
            header = [[RotationHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
        }
        
        header.lineView.hidden = YES;
        
        header.titleL.text = _dataArr[indexPath.section][@"batch_name"];
        
        return header;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RotationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RotationCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RotationCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 5, 90 *SIZE)];
    }
  
    //[NSString stringWithFormat:@"%ld号楼",indexPath.item + 1];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    
}

- (void)initUI{
    
    self.titleLabel.text = @"轮岗";
    
    self.leftButton.hidden = NO;
    self.rightBtn.hidden = NO;
    self.rightBtn.center = CGPointMake(SCREEN_Width - 45 * SIZE, STATUS_BAR_HEIGHT + 20);
    self.rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle: [UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 5 ,80 *SIZE);
    _flowLayout.minimumInteritemSpacing = 0 *SIZE;
    _flowLayout.minimumLineSpacing = 0;
    
    
    _rotationCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+129*SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE-129*SIZE) collectionViewLayout:_flowLayout];
    _rotationCV.backgroundColor = CLWhiteColor;
    _rotationCV.delegate = self;
    _rotationCV.dataSource = self;
    [_rotationCV registerClass:[RotationCell class] forCellWithReuseIdentifier:@"RotationCell"];
    [_rotationCV registerClass:[RotationHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RotationHeadView"];
    [self.view addSubview:_rotationCV];
}



@end
