//
//  RoomVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RoomVC.h"

#import "RoomDetailVC.h"

#import "RoomHeader.h"
#import "RoomCollCell.h"
#import "RoomFooter.h"

#import "SinglePickView.h"

@interface RoomVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSMutableArray *_projectArr;
    NSString *_info_id;
    NSString *_project_id;
}

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation RoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotificationProject:) name:@"projectSelect" object:nil];
    _info_id = [NSString stringWithFormat:@"%@",[UserModel defaultModel].company_info[@"project_list"][0][@"info_id"]];
    _project_id = [NSString stringWithFormat:@"%@",[UserModel defaultModel].company_info[@"project_list"][0][@"project_id"]];
    _dataArr = [@[] mutableCopy];
    _projectArr = [@[] mutableCopy];
}

- (void)NSNotificationProject:(NSNotification *)project{
    
    self->_project_id = project.userInfo[@"project_id"];
    self->_info_id = project.userInfo[@"info_id"];
    [self.rightBtn setTitle:project.userInfo[@"project_name"] forState:UIControlStateNormal];
}


- (void)ActionRightBtn:(UIButton *)btn{
    
    if (!_projectArr.count) {
        
        [_projectArr removeAllObjects];
        for (int i = 0; i < [[UserModel defaultModel].company_info[@"project_list"] count]; i++) {
            
            NSDictionary *dic = @{@"id":[UserModel defaultModel].company_info[@"project_list"][i][@"info_id"],
                                  @"param":[UserModel defaultModel].company_info[@"project_list"][i][@"project_name"]
                                  };
            [_projectArr addObject:dic];
        }
    }
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_projectArr];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        self->_info_id = [NSString stringWithFormat:@"%@",ID];
        [self.rightBtn setTitle:MC forState:UIControlStateNormal];
        for (int i = 0; i < [[UserModel defaultModel].company_info[@"project_list"] count]; i++) {
            
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultModel].company_info[@"project_list"][i][@"info_id"]] isEqualToString:self->_info_id]) {
                
                self->_project_id = [UserModel defaultModel].company_info[@"project_list"][i][@"project_id"];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"projectSelect" object:nil userInfo:@{@"info_id":self->_info_id,@"project_name":MC,@"project_id":self->_project_id}];
        [self RequestMethod];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)RequestMethod{
    
    if (_info_id.length) {
        
        [BaseRequest GET:ProjectHouseGetBuildList_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
            
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
        
        cell = [[RoomCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 3, 145 *SIZE)];
    }
    cell.titleL.text = _dataArr[indexPath.section][@"buildList"][indexPath.item][@"build_name"];
    //[NSString stringWithFormat:@"%ld号楼",indexPath.item + 1];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_dataArr[indexPath.section][@""][indexPath.item][@""]) {
        
        return;
    }
    NSArray *unitArr = _dataArr[indexPath.section][@""][indexPath.item][@""];
    
    RoomDetailVC *vc = [[RoomDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"房源";
    
    self.leftButton.hidden = YES;
//    self.rightBtn.hidden = NO;
    self.rightBtn.center = CGPointMake(SCREEN_Width - 45 * SIZE, STATUS_BAR_HEIGHT + 20);
    self.rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    if ([UserModel defaultModel].company_info
        .count) {
        
        if ([[UserModel defaultModel].company_info[@"project_list"] count]) {
            
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:[UserModel defaultModel].company_info[@"project_list"][0][@"project_name"] forState:UIControlStateNormal];
        }else{
            
            self.rightBtn.hidden = YES;
        }
    }
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 3, 145 *SIZE);
    _flowLayout.minimumInteritemSpacing = 0 *SIZE;
    _flowLayout.minimumLineSpacing = 0;
    
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = CLLineColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[RoomCollCell class] forCellWithReuseIdentifier:@"RoomCollCell"];
    [_coll registerClass:[RoomHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RoomHeader"];
    [_coll registerClass:[RoomFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"RoomFooter"];
    [self.view addSubview:_coll];
}



@end
