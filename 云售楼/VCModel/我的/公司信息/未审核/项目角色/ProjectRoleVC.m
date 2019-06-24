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
    
    NSString *_companyId;
    NSMutableArray *_dataArr;
    NSMutableArray *_selectArr;
}
@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *intentColl;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation ProjectRoleVC

- (instancetype)initWithCompanyId:(NSString *)companyId
{
    self = [super init];
    if (self) {
        
        _companyId = companyId;
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    _selectArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectRoleList_URL parameters:@{@"company_id":_companyId} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"self"] count]) {
                
                [self SetData:resposeObject[@"data"][@"self"]];
            }else if([resposeObject[@"data"][@"agency"] count]){
                
                [self SetData:resposeObject[@"data"][@"agency"]];
            }else{
                
                [self->_dataArr removeAllObjects];
                [_intentColl reloadData];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    _dataArr = [NSMutableArray arrayWithArray:data];
    [_intentColl reloadData];
    NSArray *selectArr = [self.roleId componentsSeparatedByString:@","];
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (int j = 0; j < [_dataArr[i][@"list"] count]; j++) {
            
            [tempArr addObject:@0];
//            if (selectArr.count) {
//
//                for (int m = 0; m < selectArr.count; m++) {
//
//                    if ([_dataArr[i][@"list"][j][@"role_id"] integerValue] == [selectArr[m] integerValue]) {
//
//                        [tempArr addObject:@1];
//                    }else{
//
//                        [tempArr addObject:@0];
//                    }
//                }
//            }else{
//
//                [tempArr addObject:@0];
//            }
        }
        [_selectArr addObject:tempArr];
    }
    
    for (int m = 0; m < selectArr.count; m++) {
        
        for (int i = 0; i < _dataArr.count; i++) {
            
            NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:_selectArr[i]];
            for (int j = 0; j < [_dataArr[i][@"list"] count]; j++) {
                
                if ([_dataArr[i][@"list"][j][@"role_id"] integerValue] == [selectArr[m] integerValue]) {
                    
                    [tempArr replaceObjectAtIndex:j withObject:@1];
                }else{
                    
                    
                }
            }
            [_selectArr replaceObjectAtIndex:i withObject:tempArr];
        }
    }
    
    [_intentColl reloadData];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if ([self.status isEqualToString:@"modify"]) {
        
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (int i = 0; i < _selectArr.count; i++) {
            
            NSString *projectId;
//            NSMutableArray *
            for (int j = 0; j < [_selectArr[i] count]; j++) {
                
                NSMutableArray *roleArr = [@[] mutableCopy];
                if ([_selectArr[i][j] integerValue] == 1) {
                
                    projectId = [NSString stringWithFormat:@"%@",_dataArr[i][@"project_id"]];
                    [roleArr addObject:[NSString stringWithFormat:@"%@",_dataArr[i][@"list"][j][@"role_id"]]];
                }
                if ([roleArr count]) {
                    
                    [tempArr addObject:@{@"project_id":projectId,@"role_id":roleArr}];
                }
            }
        }
        
        
        
        if (tempArr.count) {
            
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempArr options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
            [BaseRequest POST:PersonalChangeProjectRole_URL parameters:@{@"project_role":jsonString} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if (self.projectRoleVCBlock) {
                        
                        self.projectRoleVCBlock(@"", @"");
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];
        }else{
            
            
        }
    }else{
        
        self.roleId = @"";
        NSString *name;
        for (int i = 0; i < _selectArr.count; i++) {
            
            for (int j = 0; j < [_selectArr[i] count]; j++) {
                
                if ([_selectArr[i][j] integerValue] == 1) {
                    
                    if (!self.roleId.length) {
                        
                        self.roleId = [NSString stringWithFormat:@"%@",_dataArr[i][@"list"][j][@"role_id"]];
                        name = [NSString stringWithFormat:@"%@-%@",_dataArr[i][@"project_name"],_dataArr[i][@"list"][j][@"role_name"]];
                    }else{
                        
                        self.roleId = [NSString stringWithFormat:@"%@,%@",self.roleId,_dataArr[i][@"list"][j][@"role_id"]];
                        name = [NSString stringWithFormat:@"%@,%@-%@",name,_dataArr[i][@"project_name"],_dataArr[i][@"list"][j][@"role_name"]];
                    }
                }
            }
        }
        
        if (self.roleId.length) {
            
            if (self.projectRoleVCBlock) {
                
                self.projectRoleVCBlock(self.roleId, name);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataArr[section][@"list"] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 30 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    IntentSurveyHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IntentSurveyHeader" forIndexPath:indexPath];
    if (!header) {
        
        header = [[IntentSurveyHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 30 *SIZE)];
    }
    
    header.titleL.text = _dataArr[indexPath.section][@"project_name"];
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxSelectCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxSelectCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BoxSelectCollCell alloc] initWithFrame:CGRectMake(0, 0, 90 *SIZE, 50 *SIZE)];
    }
    cell.tag = 1;
    [cell.selectImg mas_updateConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(cell.contentView).offset(18 *SIZE);
        make.bottom.equalTo(cell.contentView).offset(-18 *SIZE);
    }];
    
    cell.titleL.text = _dataArr[indexPath.section][@"list"][indexPath.item][@"role_name"];
    cell.isSelect = [_selectArr[indexPath.section][indexPath.item] integerValue];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    for (int i = 0; i < _selectArr.count; i++) {
//
//
//    }
    NSMutableArray *tempArr = _selectArr[indexPath.section];
    for (int i = 0; i < tempArr.count; i++) {
        
        [tempArr replaceObjectAtIndex:i withObject:@0];
    }
//    if ([_selectArr[indexPath.section][indexPath.item] integerValue] == 0) {
    
        
        [tempArr replaceObjectAtIndex:indexPath.row withObject:@1];
        
        [_selectArr replaceObjectAtIndex:indexPath.section withObject:tempArr];
//    }else{
//
////        NSMutableArray *tempArr = _selectArr[indexPath.section];
//        [tempArr replaceObjectAtIndex:indexPath.row withObject:@0];
//        [_selectArr replaceObjectAtIndex:indexPath.section withObject:tempArr];
//    }
    [collectionView reloadData];
//    [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section]]];
//    [collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
}

- (void)initUI{
    
    self.titleLabel.text = @"选择此项目角色";

    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _flowLayout.itemSize = CGSizeMake(90 *SIZE, 50 *SIZE);
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 21 *SIZE, 0, 21 *SIZE);
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
