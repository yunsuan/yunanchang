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
    
    NSString *_project_id;
    
    NSMutableDictionary *_dataDic;
    
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

- (instancetype)initWithProjectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        
        _project_id = projectId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataDic = [@{} mutableCopy];
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
    
    RotationSettingVC *next_vc = [[RotationSettingVC alloc]initWithData:_dataDic];
    next_vc.project_id = _project_id;
    next_vc.rotationSettingVCBlock = ^{
        
        [self RequestMethod];
    };
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
    
    [BaseRequest GET:DutyDetail_URL parameters:@{@"project_id":_project_id} success:^(id  _Nonnull resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

//            [self->_dataArr removeAllObjects];
//            self->_dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
//            [self->_coll reloadData];
            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [self->_rotationCV reloadData];
        }else{

            if ([resposeObject[@"code"] integerValue] == 400) {
                
                [self alertControllerWithNsstring:@"轮岗详情" And:resposeObject[@"msg"] WithCancelBlack:^{
                    
                } WithDefaultBlack:^{
                    
                    RotationSettingVC *next_vc = [[RotationSettingVC alloc]init];
                    [self.navigationController pushViewController:next_vc animated:YES];
                }];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        }
    } failure:^(NSError * _Nonnull error) {

        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return [_dataDic[@"person"] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataDic[@"person"][section][@"list"] count];
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
        header.dataDic = _dataDic[@"duty"];
        header.companyL.text = [NSString stringWithFormat:@"%@",_dataDic[@"person"][indexPath.section][@"company_name"]];
        return header;
    }
    else
    {
        TitelHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TitelHeaderView" forIndexPath:indexPath];
        if (!header) {
            
            header = [[TitelHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 37 *SIZE)];

        }
        header.companyL.text = [NSString stringWithFormat:@"%@",_dataDic[@"person"][indexPath.section][@"company_name"]];
     
        return header;
    }
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RotationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RotationCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RotationCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 5, 90 *SIZE)];
    }

    if ([_dataDic[@"person"][indexPath.section][@"list"][indexPath.row][@"current_state"] integerValue] == 0) {
        
        if ([_dataDic[@"person"][indexPath.section][@"list"][indexPath.row][@"state"] integerValue] == 0) {
            
            [cell ConfigCellByType:REST_TYPE Title:_dataDic[@"person"][indexPath.section][@"list"][indexPath.row][@"name"]];
        }else{
            
            [cell ConfigCellByType:WAIT_TYPE Title:_dataDic[@"person"][indexPath.section][@"list"][indexPath.row][@"name"]];
        }
    }else if ([_dataDic[@"person"][indexPath.section][@"list"][indexPath.row][@"current_state"] integerValue] == 1){
        
        [cell ConfigCellByType:A_TYPE Title:_dataDic[@"person"][indexPath.section][@"list"][indexPath.row][@"name"]];
    }else{
        
        [cell ConfigCellByType:B_TYPE Title:_dataDic[@"person"][indexPath.section][@"list"][indexPath.row][@"name"]];
    }
    
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
