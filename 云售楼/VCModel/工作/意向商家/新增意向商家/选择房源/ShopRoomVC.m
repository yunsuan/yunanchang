//
//  ShopRoomVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ShopRoomVC.h"

//#import "PowerMannerger.h"


//#import "RoomDetailVC.h"
#import "ShopRoomDetailVC.h"
//#import "CompanyAuthVC.h"

#import "RoomHeader.h"
#import "RoomCollCell.h"
#import "RoomFooter.h"

#import "SinglePickView.h"

@interface ShopRoomVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSArray *_projectArr;
//    NSString *_info_id;
//    NSString *_project_id;
    NSString *_ldtitle;

}

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ShopRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _projectArr = [UserModel defaultModel].project_list;
    _dataArr = [@[] mutableCopy];
}


-(void)postWithUnitId:(NSString *)unitId buildId:(NSString *)buildId;
{
    NSDictionary *prameters;
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
    prameters = @{@"build_id":buildId,@"unit_id":unitId};
    
    
    [BaseRequest GET:ShopGetShopList_URL parameters:prameters success:^(id  _Nonnull resposeObject) {
        if ([resposeObject[@"code"] integerValue]== 200) {
            NSLog(@"%@",resposeObject);
            ShopRoomDetailVC *vc = [[ShopRoomDetailVC alloc] init];
            vc.LDinfo = resposeObject[@"data"];
            vc.LDtitle = self->_ldtitle;
            vc.status = @"store";
            vc.roomArr = self.roomArr;
            vc.shopRoomDetailVCBlock = ^(NSDictionary * _Nonnull dic, NSString * _Nonnull chargeId) {

                self.shopRoomVCBlock(dic,chargeId);
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


- (void)RequestMethod{

    [BaseRequest GET:ShopGetTitleList_URL parameters:@{@"info_id":[UserModel defaultModel].projectinfo[@"info_id"]} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            self->_dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [self->_coll reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}


- (void)ActionGoBtn:(UIButton *)btn{
    
//    CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataArr[section][@"build"] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 40 *SIZE);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        RoomHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RoomHeader" forIndexPath:indexPath];
        if (!header) {
            
            header = [[RoomHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
        }
        
        header.lineView.hidden = YES;
        
        header.titleL.text = _dataArr[indexPath.section][@"batch_name"];
        
        return header;
    }else{
        
        RoomFooter *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"RoomFooter" forIndexPath:indexPath];
        if (!header) {
            
            header = [[RoomFooter alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 3 *SIZE)];
        }
        
        return header;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 4, 145 *SIZE)];
    }
    cell.titleL.text = _dataArr[indexPath.section][@"build"][indexPath.item][@"build_name"];
    //[NSString stringWithFormat:@"%ld号楼",indexPath.item + 1];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    NSMutableArray *unitList =_dataArr[indexPath.section][@"build"][indexPath.row][@"unitList"];
    if(unitList.count == 0)
    {
        _ldtitle = [NSString stringWithFormat:@"%@-%@",_dataArr[indexPath.section][@"batch_name"],_dataArr[indexPath.section][@"build"][indexPath.row][@"build_name"]];
        
        [self postWithUnitId:@"0" buildId:[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.section][@"build"][indexPath.row][@"build_id"]]];
//        [self PostWithType:1 Houseid:_dataArr[indexPath.section][@"buildList"][indexPath.row][@"build_id"]];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:_dataArr[indexPath.section][@"buildList"][indexPath.row][@"build_name"] message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        for (int i= 0; i<unitList.count; i++) {
            UIAlertAction *alertaction = [UIAlertAction actionWithTitle:unitList[i][@"unit_name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_ldtitle = [NSString stringWithFormat:@"%@-%@-%@",self->_dataArr[indexPath.section][@"batch_name"],self->_dataArr[indexPath.section][@"build"][indexPath.row][@"build_name"],unitList[i][@"unit_name"]];
                [self postWithUnitId:[NSString stringWithFormat:@"%@",unitList[i][@"unit_id"]] buildId:[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.section][@"build"][indexPath.row][@"build_id"]]];
//                [self PostWithType:2 Houseid:unitList[i][@"unit_id"]];
                
            }];
               [alert addAction:alertaction];
        }
        
        [alert addAction:cancel];
        [self.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    }
    


}

- (void)initUI{
    
    self.titleLabel.text = @"房源";
  
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 4, 145 *SIZE);
    _flowLayout.minimumInteritemSpacing = 0 *SIZE;
    _flowLayout.minimumLineSpacing = 0;
    
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[RoomCollCell class] forCellWithReuseIdentifier:@"RoomCollCell"];
    [_coll registerClass:[RoomHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RoomHeader"];
    [_coll registerClass:[RoomFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"RoomFooter"];
    [self.view addSubview:_coll];
    
    if ([UserModel defaultModel].projectinfo) {
        
        _coll.hidden = NO;
    }else{
        
        _coll.hidden = YES;
    }
}

@end
