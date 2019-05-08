//
//  SelectCompanyVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SelectCompanyVC.h"

#import "SelectCompanyTableCell.h"
#import "SelectCompanyCollCell.h"

#import "CompanyModel.h"

@interface SelectCompanyVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    
    NSMutableArray *_dataArr;
    NSMutableArray *_proArr;
    NSMutableArray *_cityArr;
    NSMutableArray *_disArr;
    NSString *_province;
    NSString *_proName;
    NSString *_city;
    NSString *_cityName;
    NSString *_district;
    NSString *_disName;
    NSInteger _page;
    BOOL _isSearch;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *selectColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation SelectCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    _isSearch = NO;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (_province) {
        
        [dic setObject:_province forKey:@"province"];
    }
    
    if (_city) {
        
        [dic setObject:_city forKey:@"city"];
    }
    
    if (_district) {
        
        [dic setObject:_district forKey:@"district"];
    }
    
    _page = 1;
    _table.mj_footer.state = MJRefreshStateIdle;
    [_dataArr removeAllObjects];
//    [BaseRequest GET:GetCompanyList_URL parameters:dic success:^(id resposeObject) {
//
//        [_selecTable.mj_header endRefreshing];
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
//
//                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
//
//                    if ([resposeObject[@"data"][@"data"] count]) {
//
//                        //                        [_selecTable.mj_header endRefreshing];
//                        [self SetData:resposeObject[@"data"][@"data"]];
//                    }else{
//
//                        _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//                    }
//                }else{
//
//                    _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//                }
//            }else{
//
//                _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//            }
//        }else{
//            [self showContent:resposeObject[@"msg"]];
//
//            _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//        }
//    } failure:^(NSError *error) {
//
//        [_selecTable.mj_header endRefreshing];
//        //        NSLog(@"%@",error);
//        [self showContent:@"网络错误"];
//    }];
}

- (void)RequestMethodAdd{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (_province) {
        
        [dic setObject:_province forKey:@"province"];
    }
    
    if (_city) {
        
        [dic setObject:_city forKey:@"city"];
    }
    
    if (_district) {
        
        [dic setObject:_district forKey:@"district"];
    }
    
    
    [dic setObject:@(_page) forKey:@"page"];
    
//    [BaseRequest GET:GetCompanyList_URL parameters:dic success:^(id resposeObject) {
//
//        //        NSLog(@"%@",resposeObject);
//
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
//
//                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
//
//                    if ([resposeObject[@"data"][@"data"] count]) {
//
//                        [_selecTable.mj_footer endRefreshing];
//                        [self SetData:resposeObject[@"data"][@"data"]];
//                    }else{
//
//                        _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//                    }
//                }else{
//
//                    _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//                }
//            }else{
//
//                _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//            }
//        }else{
//
//            [self showContent:resposeObject[@"msg"]];
//
//            _page -= 1;
//            _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//        }
//    } failure:^(NSError *error) {
//
//        _page -= 1;
//        [_selecTable.mj_footer endRefreshing];
//        //        NSLog(@"%@",error);
//        [self showContent:@"网络错误"];
//    }];
}

- (void)SearchRequest{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //    _page += 1;
    [dic setObject:@(_page) forKey:@"page"];
    
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"company_name"];
    }
    
//    [BaseRequest GET:GetCompanyList_URL parameters:dic success:^(id resposeObject) {
//
//
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            if (_page == 1) {
//
//                [_dataArr removeAllObjects];
//                [_selecTable reloadData];
//            }
//            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
//
//                if ([resposeObject[@"data"][@"data"] isKindOfClass:[NSArray class]]) {
//
//                    if ([resposeObject[@"data"][@"data"] count]) {
//
//                        [_selecTable.mj_header endRefreshing];
//                        [_selecTable.mj_footer endRefreshing];
//                        [self SetData:resposeObject[@"data"][@"data"]];
//                    }else{
//
//                        [_selecTable.mj_header endRefreshing];
//                        _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//                    }
//                }else{
//
//                    [_selecTable.mj_header endRefreshing];
//                    _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//                }
//            }else{
//
//                [_selecTable.mj_header endRefreshing];
//                _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//            }
//        }else{
//
//            [self showContent:resposeObject[@"msg"]];
//            _page -= 1;
//            _selecTable.mj_footer.state = MJRefreshStateNoMoreData;
//            [_selecTable.mj_header endRefreshing];
//        }
//    } failure:^(NSError *error) {
//
//        _page -= 1;
//        [_selecTable.mj_header endRefreshing];
//        [_selecTable.mj_footer endRefreshing];
//        //        NSLog(@"%@",error);
//        [self showContent:@"网络错误"];
//    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        CompanyModel *model = [[CompanyModel alloc] initWithDictionary:tempDic];
        [_dataArr addObject:model];
    }
    [_table reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    _page = 1;
    if (![self isEmpty:textField.text]) {
        
        _isSearch = YES;
        [self SearchRequest];
        
    }else{
        
        [self RequestMethod];
    }
    return YES;
}


#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectCompanyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectCompanyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SelectCompanyCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 40 *SIZE)];
    }
    
    switch (indexPath.item) {
        case 0:
        {
            if (_proName.length) {
                
                cell.typeL.text = _proName;
            }else{
                
                cell.typeL.text = @"省份";
            }
            break;
        }
        case 1:
        {
            if (_cityName.length) {
                
                cell.typeL.text = _cityName;
            }else{
                
                cell.typeL.text = @"城市";
            }
            break;
        }
        case 2:
        {
            if (_disName.length) {
                
                cell.typeL.text = _disName;
            }else{
                
                cell.typeL.text = @"区域";
            }
            break;
        }
        default:
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
        
//        WS(weakSelf);
//        _provinceView = [[BoxAddressView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 140 *SIZE, SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 140 *SIZE)];
//        NSArray *array = [self getProvince];
//        NSMutableArray * tempArr = [NSMutableArray arrayWithArray:array];
//        _provinceView.dataArr = [NSMutableArray arrayWithArray:tempArr];
//        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//            if (idx == 0) {
//
//                [tempArr replaceObjectAtIndex:idx withObject:@(1)];
//            }else{
//
//                [tempArr replaceObjectAtIndex:idx withObject:@(0)];
//            }
//        }];
//        _provinceView.selectArr = [NSMutableArray arrayWithArray:tempArr];
//        _provinceView.boxAddressCancelBlock = ^{
//
//            [weakSelf.selectColl reloadData];
//        };
//
//        _provinceView.boxAddressComfirmBlock = ^(NSString *ID, NSString *str, NSInteger index) {
//
//            _isSearch = NO;
//            _province = [NSString stringWithFormat:@"%@",ID];
//            _proName = [NSString stringWithFormat:@"%@",str];
//            _cityName = @"";
//            _disName = @"";
//            _city = @"";
//            _district = @"";
//            weakSelf.cityView = [[BoxAddressView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 140 *SIZE, SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 140 *SIZE)];
//            weakSelf.cityView.dataArr = [NSMutableArray arrayWithArray:[weakSelf getCityArrayByprovince:index]];
//            NSMutableArray * tempArr = [NSMutableArray arrayWithArray:[weakSelf getCityArrayByprovince:index]];
//            [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                if (idx == 0) {
//
//                    [tempArr replaceObjectAtIndex:idx withObject:@(1)];
//                }else{
//
//                    [tempArr replaceObjectAtIndex:idx withObject:@(0)];
//                }
//            }];
//            weakSelf.cityView.selectArr = [NSMutableArray arrayWithArray:tempArr];
//            [weakSelf.selectColl reloadData];
//            [weakSelf RequestMethod];
//        };
//        [[UIApplication sharedApplication].keyWindow addSubview:_provinceView];
    }else if (indexPath.item == 1){
        
//        if (_proName) {
//
//            WS(weakSelf);
//            _cityView.boxAddressCancelBlock = ^{
//
//                [weakSelf.selectColl reloadData];
//            };
//            _cityView.boxAddressComfirmBlock = ^(NSString *ID, NSString *str, NSInteger index) {
//
//                _isSearch = NO;
//                _city = [NSString stringWithFormat:@"%@",ID];
//                _cityName = [NSString stringWithFormat:@"%@",str];
//                _disName = @"";
//                _district = @"";
//                weakSelf.districtView = [[BoxAddressView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 140 *SIZE, SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 140 *SIZE)];
//                weakSelf.districtView.dataArr = [NSMutableArray arrayWithArray:[weakSelf getAreaArrayBycity:index]];
//                NSMutableArray * tempArr = [NSMutableArray arrayWithArray:[weakSelf getAreaArrayBycity:index]];
//                [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                    if (idx == 0) {
//
//                        [tempArr replaceObjectAtIndex:idx withObject:@(1)];
//                    }else{
//
//                        [tempArr replaceObjectAtIndex:idx withObject:@(0)];
//                    }
//                }];
//                weakSelf.districtView.selectArr = [NSMutableArray arrayWithArray:tempArr];
//                [weakSelf.selectColl reloadData];
//                [weakSelf RequestMethod];
//            };
//            [[UIApplication sharedApplication].keyWindow addSubview:_cityView];
//        }else{
//
//            [self showContent:@"请先选择省份"];
//        }
    }else{
//        if (_cityName) {
//
//            WS(weakSelf);
//            _districtView.boxAddressCancelBlock = ^{
//
//                [weakSelf.selectColl reloadData];
//            };
//            _districtView.boxAddressComfirmBlock = ^(NSString *ID, NSString *str, NSInteger index) {
//
//                _isSearch = NO;
//                _district = [NSString stringWithFormat:@"%@",ID];
//                _disName = [NSString stringWithFormat:@"%@",str];
//                [weakSelf.selectColl reloadData];
//                [weakSelf RequestMethod];
//            };
//            [[UIApplication sharedApplication].keyWindow addSubview:_districtView];
//        }else{
//
//            [self showContent:@"请先选择城市"];
//        }
    }
    
}

#pragma mark --table代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 100 *SIZE;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Identifier = @"SelectCompanyTableCell";
    SelectCompanyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[SelectCompanyTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyModel *model = _dataArr[indexPath.row];
//    CompanyDetailVC *nextVC = [[CompanyDetailVC alloc] initWithModel:model];
//    nextVC.companyDetailVCBlock = ^(NSString *companyId, NSString *name) {
//
//        if (self.selectCompanyVCBlock) {
//
//            self.selectCompanyVCBlock(companyId, name);
//        }
//    };
//    nextVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 160 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    [whiteView addSubview:self.leftButton];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.center = CGPointMake(SCREEN_Width / 2, STATUS_BAR_HEIGHT+20 );
    titleL.bounds = CGRectMake(0, 0, 180 * SIZE, 30 * SIZE);
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = [UIColor blackColor];
    titleL.font = [UIFont systemFontOfSize:17 * SIZE];
    titleL.text = @"选择公司";
    [whiteView addSubview:titleL];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 84 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = CLBackColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"请输入公司名称/营业执照号查询";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 40 *SIZE);
    
    _selectColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120 *SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _selectColl.backgroundColor = [UIColor whiteColor];
    _selectColl.delegate = self;
    _selectColl.dataSource = self;
    _selectColl.bounces = NO;
    [_selectColl registerClass:[SelectCompanyCollCell class] forCellWithReuseIdentifier:@"SelectCompanyCollCell"];
    [whiteView addSubview:_selectColl];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_selectColl.frame) + SIZE, SCREEN_Width, SCREEN_Height - CGRectGetMaxY(_selectColl.frame) - SIZE) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
//    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
//
//        _page = 1;
//        if (_isSearch) {
//
//            [self SearchRequest];
//        }else{
//
//
//            [self RequestMethod];
//        }
//    }];
//
//    _selecTable.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
//
//        _page += 1;
//        if (_isSearch) {
//
//            [self SearchRequest];
//        }else{
//
//
//            [self RequestMethodAdd];
//        }
//    }];
}

- (NSArray *)getProvince{
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
    
    NSError *err;
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:JSONData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];
    _proArr = [NSMutableArray arrayWithArray:arr];
    return arr;
}

-(NSArray *)getCityArrayByprovince:(NSInteger)num
{
    _cityArr = [NSMutableArray arrayWithArray:_proArr[num][@"city"]];
    return [NSMutableArray arrayWithArray:[self getProvince][num][@"city"]];
}


-(NSArray *)getAreaArrayBycity:(NSInteger )num
{
    if (![_cityArr[num][@"district"] isKindOfClass:[NSNull class]]) {
        
        _disArr = [NSMutableArray arrayWithArray:_cityArr[num][@"district"]];
    }else{
        
        _disArr = [[NSMutableArray alloc] init];
    }
    return _disArr;
}

@end
