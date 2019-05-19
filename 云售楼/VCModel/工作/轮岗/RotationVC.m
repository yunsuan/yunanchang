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
#import "TitelHeaderView.h"
#import "RotationSettingVC.h"
#import "AbdicateVC.h"

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
    RotationSettingVC *next_vc = [[RotationSettingVC alloc]init];
    [self.navigationController pushViewController:next_vc animated:YES];
    
}

-(void)action_comple
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下位" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"接待客户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            
        }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"让位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AbdicateVC *next_vc = [[AbdicateVC alloc]init];
        [self.navigationController pushViewController:next_vc animated:YES];
        
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
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
    
    if (section ==0) {
        return CGSizeMake(SCREEN_Width, 167*SIZE);
    }
    else
    {
    return CGSizeMake(SCREEN_Width, 37 *SIZE);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        RotationHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RotationHeadView" forIndexPath:indexPath];
        if (!header) {
            
            header = [[RotationHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 167 *SIZE)];
        }
        [header.compleBtn addTarget:self action:@selector(action_comple) forControlEvents:UIControlEventTouchUpInside];
        

        
        return header;
    }
    else
    {
        TitelHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitelHeaderView" forIndexPath:indexPath];
        if (!header) {
            
            header = [[TitelHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 37 *SIZE)];

        }
     
        return header;
    }
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RotationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RotationCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RotationCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 5, 90 *SIZE)];
    }
    if(indexPath.section == 0 &&indexPath.row==0)
    {
        [cell ConfigCellByType:A_TYPE Title:@"张三"];
    }else if (indexPath.section == 1 &&indexPath.row==0)
    {
        [cell ConfigCellByType:B_TYPE Title:@"李四"];
    }else if (indexPath.row==11)
    {
         [cell ConfigCellByType:REST_TYPE Title:@"李四SS"];
    }else{
         [cell ConfigCellByType:WAIT_TYPE Title:@"李四11"];
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
    self.rightBtn.center = CGPointMake(SCREEN_Width - 20 * SIZE, STATUS_BAR_HEIGHT + 20);
    self.rightBtn.bounds = CGRectMake(0, 0, 40 * SIZE, 33 * SIZE);
//    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
//    [self.rightBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.rightBtn setTitle: [UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
    [self.rightBtn setImage:[UIImage imageNamed:@"Setupthe"] forState:UIControlStateNormal];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 5 ,90 *SIZE);
    _flowLayout.minimumInteritemSpacing = 0 *SIZE;
    _flowLayout.minimumLineSpacing = 0;
    
    
    _rotationCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _rotationCV.backgroundColor = CLWhiteColor;
    _rotationCV.delegate = self;
    _rotationCV.dataSource = self;
    [_rotationCV registerClass:[RotationCell class] forCellWithReuseIdentifier:@"RotationCell"];
    [_rotationCV registerClass:[RotationHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RotationHeadView"];
    [_rotationCV registerClass:[TitelHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitelHeaderView"];
    [self.view addSubview:_rotationCV];
}



@end
