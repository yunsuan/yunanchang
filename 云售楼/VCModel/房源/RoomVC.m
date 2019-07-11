//
//  RoomVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RoomVC.h"
#import "PowerMannerger.h"


#import "RoomDetailVC.h"
#import "CompanyAuthVC.h"

#import "RoomHeader.h"
#import "RoomCollCell.h"
#import "RoomFooter.h"

#import "SinglePickView.h"

@interface RoomVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
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

@implementation RoomVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
//    if ([[UserModel defaultModel].projectinfo count]) {
//
//        _coll.hidden = NO;
//        self.rightBtn.hidden = NO;
//    }else{
//
//        _coll.hidden = YES;
//        self.rightBtn.hidden = YES;
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    if ([UserModel defaultModel].projectinfo) {
        
        [self RequestMethod];
    }
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionNSNotificationMethod) name:@"reloadCompanyInfo" object:nil];
    
    _projectArr = [UserModel defaultModel].project_list;
//    _info_id = [UserModel defaultModel].projectinfo[@"info_id"];
//    _project_id =[UserModel defaultModel].projectinfo[@"project_id"];
    _dataArr = [@[] mutableCopy];

}

- (void)ActionNSNotificationMethod{
    
    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
    if ([[UserModel defaultModel].projectinfo count]) {
        
        _coll.hidden = NO;
        self.rightBtn.hidden = NO;
    }else{
        
        _coll.hidden = YES;
        self.rightBtn.hidden = YES;
    }
}



-(void)PostWithType:(NSInteger)type Houseid:(NSString *)houseid
{
    NSDictionary *prameters;
    if(type == 1)
    {
        prameters = @{
                      @"build_id":houseid
                      };
    }
    else
    {
        prameters = @{
                      @"unit_id":houseid
                      };
    }
    
    [BaseRequest GET:ProjectHouseGetDetail_URL parameters:prameters success:^(id  _Nonnull resposeObject) {
        if ([resposeObject[@"code"] integerValue]== 200) {
            NSLog(@"%@",resposeObject);
            RoomDetailVC *vc = [[RoomDetailVC alloc] init];
            vc.LDinfo = resposeObject[@"data"];
            vc.LDtitle = self->_ldtitle;
            vc.status = self.status;
            vc.roomDetailVCBlock = ^(NSDictionary * _Nonnull dic) {
                
                self.roomVCBlock(dic);
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
   
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


- (void)ActionRightBtn:(UIButton *)btn{
    NSMutableArray *temparr = [@[] mutableCopy];
    for (int i = 0; i < [_projectArr count]; i++) {
        
        NSDictionary *dic = @{@"id":[NSString stringWithFormat:@"%d",i],
                              @"param":_projectArr[i][@"project_name"]
                              };
        [temparr addObject:dic];
        
    }
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:temparr];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        [self.rightBtn setTitle:MC forState:UIControlStateNormal];
        [UserModel defaultModel].projectinfo =  [UserModel defaultModel].project_list[[ID integerValue]];
        [UserModelArchiver archive];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCompanyInfo" object:nil];
        [PowerMannerger RequestPowerByprojectID:[UserModel defaultModel].projectinfo[@"project_id"] success:^(NSString * _Nonnull result) {
            if ([result isEqualToString:@"获取权限成功"]) {
    
            }
        } failure:^(NSString * _Nonnull error) {
            [self showContent:error];
        }];
        [self RequestMethod];
    };
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)RequestMethod{

    if ([[UserModel defaultModel].projectinfo count]) {
        
        [BaseRequest GET:ProjectHouseGetBuildList_URL parameters:@{@"info_id":[UserModel defaultModel].projectinfo[@"info_id"]} success:^(id  _Nonnull resposeObject) {
            
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
}


- (void)ActionGoBtn:(UIButton *)btn{
    
    CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataArr[section][@"buildList"] count];
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
    cell.titleL.text = _dataArr[indexPath.section][@"buildList"][indexPath.item][@"build_name"];
    //[NSString stringWithFormat:@"%ld号楼",indexPath.item + 1];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    NSMutableArray *unitList =_dataArr[indexPath.section][@"buildList"][indexPath.row][@"unitList"];
    if(unitList.count == 0)
    {
        _ldtitle = [NSString stringWithFormat:@"%@-%@",_dataArr[indexPath.section][@"batch_name"],_dataArr[indexPath.section][@"buildList"][indexPath.row][@"build_name"]];
        [self PostWithType:1 Houseid:_dataArr[indexPath.section][@"buildList"][indexPath.row][@"build_id"]];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:_dataArr[indexPath.section][@"buildList"][indexPath.row][@"build_name"] message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        for (int i= 0; i<unitList.count; i++) {
            UIAlertAction *alertaction = [UIAlertAction actionWithTitle:unitList[i][@"unit_name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_ldtitle = [NSString stringWithFormat:@"%@-%@-%@",self->_dataArr[indexPath.section][@"batch_name"],self->_dataArr[indexPath.section][@"buildList"][indexPath.row][@"build_name"],unitList[i][@"unit_name"]];
                [self PostWithType:2 Houseid:unitList[i][@"unit_id"]];
                
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
    
    if (!self.status.length) {
        
        self.leftButton.hidden = YES;
        self.rightBtn.hidden = NO;
        self.rightBtn.center = CGPointMake(SCREEN_Width - 45 * SIZE, STATUS_BAR_HEIGHT + 20);
        self.rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
        self.rightBtn.titleLabel.font = FONT(13 *SIZE);
        [self.rightBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn setTitle: [UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
    }
    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(3 *SIZE, 7 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width - 6 *SIZE, 167 *SIZE)];
    whiteView.backgroundColor = CLWhiteColor;
    whiteView.layer.cornerRadius = 7 *SIZE;
    whiteView.clipsToBounds = YES;
    [self.view addSubview:whiteView];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(151 *SIZE, 36 *SIZE, 57 *SIZE, 57 *SIZE)];
    img.image = IMAGE_WITH_NAME(@"company");
    [whiteView addSubview:img];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 110 *SIZE, SCREEN_Width - 6 *SIZE, 13 *SIZE)];
    label.textColor = CL86Color;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"您目前没有进行公司认证，请先认证公司！";
    [whiteView addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(97 *SIZE, 31 *SIZE + CGRectGetMaxY(whiteView.frame), 167 *SIZE, 40 *SIZE);
    btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [btn addTarget:self action:@selector(ActionGoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"去认证" forState:UIControlStateNormal];
    [btn setBackgroundColor:CLBlueBtnColor];
    btn.layer.cornerRadius = 3 *SIZE;
    btn.clipsToBounds = YES;
    [self.view addSubview:btn];
  
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 4, 145 *SIZE);
    _flowLayout.minimumInteritemSpacing = 0 *SIZE;
    _flowLayout.minimumLineSpacing = 0;
    
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) collectionViewLayout:_flowLayout];
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
