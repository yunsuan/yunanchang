//
//  StoreVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "StoreVC.h"

#import "StoreDetailVC.h"

#import "AddStoreVC.h"

#import "StoreCell.h"

@interface StoreVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSInteger _page;
    
    NSString *_project_id;
    NSString *_info_id;
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UITableView *table;

@end

@implementation StoreVC

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(nonnull NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _project_id = projectId;
        _info_id = info_id;
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
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id,@"page":@(_page)}];
    
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"search"];
    }
    
    _table.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectBusinessGetList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            [self->_table reloadData];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id,@"page":@(_page)}];
    
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"search"];
    }
    //    _table.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectBusinessGetList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
//        [self->_table.mj_footer endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self->_table.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self->_table.mj_footer endRefreshing];
            self->_page -= 1;
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        self->_page -= 1;
        [self->_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
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

- (void)ActionRightBtn:(UIButton *)btn{
    
    AddStoreVC *nextVC = [[AddStoreVC alloc] initWithProjectId:_project_id info_id:_info_id];
//    nextVC.addVisitCustomVCBlock = ^{
//        
//        [self RequestMethod];
//        if (self.visitCustomVCBlock) {
//            
//            self.visitCustomVCBlock();
//        }
//    };
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self RequestMethod];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCell"];
    if (!cell) {
        
        cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreDetailVC *nextVC = [[StoreDetailVC alloc] initWithBusinessId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"business_id"]]];
    nextVC.project_id = _project_id;
    nextVC.info_id = _info_id;
    nextVC.powerDic = self.powerDic;
//    nextVC.need_check = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"need_check"]];
//    nextVC.projectName = self.projectName;
//    nextVC.orderDetailVCBlock = ^{
//
//        [self RequestMethod];
//    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"商家";
    
    if ([self.powerDic[@"add"] boolValue]) {

        self.rightBtn.hidden = NO;
    }else{

        self.rightBtn.hidden = YES;
    }
    [self.rightBtn setImage:IMAGE_WITH_NAME(@"add_3") forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = CLLineColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.delegate = self;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入公司名称";
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
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        self->_page = 1;
        [self RequestMethod];
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        
        self->_page += 1;
        [self RequestAddMethod];
    }];
}

@end
