//
//  AddressBookVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddressBookVC.h"

#import "SinglePickView.h"

#import "AddressBookCell.h"
#import "AddressBookCollCell.h"

@interface AddressBookVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    
    NSInteger _page;
    
    NSString *_search;
    NSString *_depart;
    NSString *_departId;
    NSString *_postion;
    NSString *_postionId;
    
    NSMutableArray *_departArr;
    NSMutableArray *_positionArr;
    NSMutableArray *_collArr;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UICollectionView *selectColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) SinglePickView *departView;

@property (nonatomic, strong) SinglePickView *positionView;
@end

@implementation AddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
//    [self RequestDepart];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    _positionArr = [@[] mutableCopy];
    _collArr = [@[] mutableCopy];
    _departArr = [@[] mutableCopy];
}

- (void)RequestDepart{
    
    [self->_departArr addObject:@{@"id":@"0",@"param":@"选择部门"}];
    [BaseRequest GET:UserPersonalGetCompanyStructure_URL parameters:nil success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_collArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                
                NSDictionary *dic = @{@"id":resposeObject[@"data"][i][@"department_id"],
                                      @"param":resposeObject[@"data"][i][@"department_name"]
                                      };
                [self->_departArr addObject:dic];
                
            }
            self->_departView = [[SinglePickView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 80 *SIZE, SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 80 *SIZE) WithData:self->_departArr];
            self->_departView.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self->_depart = [NSString stringWithFormat:@"%@",MC];
                if ([ID integerValue] == 0) {
                    
                    self->_departId = [NSString stringWithFormat:@"%@",ID];
                }else{
                    
                    self->_departId = @"";
                }
                self->_postionId = @"";
                self->_postion = @"选择岗位";
                [self->_positionArr removeAllObjects];
                [self->_positionArr addObject:@{@"id":@"0",@"param":@"选择岗位"}];
                for (int i = 0; i < self->_collArr.count; i++) {
                    
                    if ([self->_postionId integerValue] == [self->_collArr[i][@"department_id"] integerValue]) {
                        
                        for (int j = 0; j < [self->_collArr[i][@"postList"] count]; j++) {
                            
                            NSDictionary *dic = @{@"id":self->_collArr[i][@"postList"][j][@"post_id"],@"param":self->_collArr[i][@"postList"][j][@"post_name"]};
                            [self->_positionArr addObject:dic];
                        }
                    }
                }
                [self RequestMethod];
            };
            [self.view addSubview:self->_departView];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"获取部门信息失败"];
    }];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:_search]) {
        
        [dic setObject:_search forKey:@"search"];
    }
    if (_departId.length) {
        
        [dic setObject:_departId forKey:@"department_id"];
    }
    if (_postionId.length) {
        
        [dic setObject:_postionId forKey:@"post_id"];
    }
    
    _table.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:UserPersonalGetCompanyStaff_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            [self SetData:resposeObject[@"data"][@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
       
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:_search]) {
        
        [dic setObject:_search forKey:@"search"];
    }
    if (_departId.length) {
        
        [dic setObject:_departId forKey:@"department_id"];
    }
    if (_postionId.length) {
        
        [dic setObject:_postionId forKey:@"post_id"];
    }
    
    [BaseRequest GET:UserPersonalGetCompanyStaff_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"][@"data"]];
        }else{
            
            [self->_table.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self->_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    if (!data.count) {
        
        _table.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        
        [self->_table.mj_footer endRefreshing];
    }
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [dic setObject:@"" forKey:key];
            }else{
                
                [dic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }];
        
        [_dataArr addObject:dic];
    }
    [_table reloadData];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    _page = 1;
    if (![self isEmpty:textField.text]) {
        
        _search = textField.text;
        [self RequestMethod];
    }else{
        
        _search = @"";
        [self RequestMethod];
    }
    
    return YES;
}

#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressBookCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddressBookCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AddressBookCollCell alloc] initWithFrame:CGRectMake(0, 0, 180 *SIZE, 40 *SIZE)];
    }
    
    switch (indexPath.item) {
        case 0:
        {
            if (_depart.length) {
                
                cell.typeL.text = _depart;
            }else{
                
                cell.typeL.text = @"选择部门";
            }
            break;
        }
        case 1:
        {
            if (_postion.length) {
                
                cell.typeL.text = _postion;
            }else{
                
                cell.typeL.text = @"选择岗位";
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
        if (_departArr.count > 1) {
            
            SS(strongSelf);
            _departView = [[SinglePickView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 80 *SIZE, SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 80 *SIZE) WithData:_departArr];
            _departView.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self->_depart = [NSString stringWithFormat:@"%@",MC];
                if ([ID integerValue] != 0) {
                    
                    self->_departId = [NSString stringWithFormat:@"%@",ID];
                }else{
                    
                    self->_departId = @"";
                }
                self->_postionId = @"";
                self->_postion = @"选择岗位";
                [strongSelf->_positionArr removeAllObjects];
                [strongSelf->_positionArr addObject:@{@"id":@"0",@"param":@"选择岗位"}];
                for (int i = 0; i < self->_collArr.count; i++) {
                    
                    if ([self->_departId integerValue] == [self->_collArr[i][@"department_id"] integerValue]) {
                        
                        for (int j = 0; j < [self->_collArr[i][@"postList"] count]; j++) {
                            
                            NSDictionary *dic = @{@"id":strongSelf->_collArr[i][@"postList"][j][@"post_id"],@"param":strongSelf->_collArr[i][@"postList"][j][@"post_name"]};
                            [strongSelf->_positionArr addObject:dic];
                        }
                    }
                }
                [collectionView reloadData];
                [strongSelf RequestMethod];
            };
            [self.view addSubview:_departView];
        }else{
            
            [self RequestDepart];
        }
    }else if (indexPath.item == 1){
        
        if (_departId.length) {
            
            if (_positionArr.count) {
                
                SS(strongSelf);
                _positionView = [[SinglePickView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 80 *SIZE, SCREEN_Width, SCREEN_Height - STATUS_BAR_HEIGHT - 80 *SIZE) WithData:_positionArr];
                _positionView.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    self->_postion = [NSString stringWithFormat:@"%@",MC];
                    if ([ID integerValue] != 0) {
                        
                        self->_postionId = [NSString stringWithFormat:@"%@",ID];
                    }else{
                        
                        self->_postionId = @"";
                    }
                    [collectionView reloadData];
                    [strongSelf RequestMethod];
                };
                [self.view addSubview:_positionView];
            }else{
                
                [self showContent:@"暂无岗位数据"];
            }
        }else{
            
            [self showContent:@"请先选择部门"];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressBookCell"];
    if (!cell) {
        
        cell = [[AddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressBookCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"通讯录";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,  NAVIGATION_BAR_HEIGHT, SCREEN_Width, 80 *SIZE)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = CLBackColor;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入电话/姓名";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [view addSubview:_searchBar];
    
//    for (int i = 0; i < 2; i++) {
//
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(SCREEN_Width / 2 * i,40 *SIZE, SCREEN_Width / 2, 40 *SIZE);
//        btn.tag = i + 1;
//        [btn setBackgroundColor:[UIColor whiteColor]];
//        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
//
//        if (i == 0) {
//
//            [btn setTitle:@"选择部门" forState:UIControlStateNormal];
//            [btn setTitleColor:CL86Color forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
//            [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
//            [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
//            _departBtn = btn;
//            [view addSubview:_departBtn];
//        }else{
//
//            [btn setTitle:@"选择岗位" forState:UIControlStateNormal];
//            [btn setTitleColor:CL86Color forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
//            [btn setImage:[UIImage imageNamed:@"downarrow1"] forState:UIControlStateNormal];
//            [btn setImage:[UIImage imageNamed:@"uparrow2"] forState:UIControlStateSelected];
//            _positionBtn = btn;
//            [view addSubview:_positionBtn];
//        }
//    }
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(180 *SIZE, 40 *SIZE);
    
    _selectColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40 *SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _selectColl.backgroundColor = [UIColor whiteColor];
    _selectColl.delegate = self;
    _selectColl.dataSource = self;
    _selectColl.bounces = NO;
    [_selectColl registerClass:[AddressBookCollCell class] forCellWithReuseIdentifier:@"AddressBookCollCell"];
    [view addSubview:_selectColl];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 80 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 80 *SIZE) style:UITableViewStylePlain];
    
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        self->_page = 1;
        [self RequestMethod];
    }];
    
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self->_page += 1;
        [self RequestAddMethod];
    }];
}

@end
