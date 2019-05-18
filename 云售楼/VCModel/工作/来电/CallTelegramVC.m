//
//  CallTelegramVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramVC.h"

#import "CallTelegramCustomDetailVC.h"
#import "AddCallTelegramVC.h"

#import "CallTelegramCell.h"

@interface CallTelegramVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    NSMutableArray *_dataArr;
    NSString *_projectId;
    NSString *_info_id;
    NSInteger _page;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UITextField *searchBar;

@end

@implementation CallTelegramVC

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
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
    
    self->_table.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:WorkClientAutoList_URL parameters:@{@"type":@"1",@"project_id":_projectId} success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self->_dataArr removeAllObjects];
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    [BaseRequest GET:WorkClientAutoList_URL parameters:@{@"type":@"1",@"project_id":_projectId,@"page":@(_page)} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self->_table.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
            
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
    
    for (NSDictionary *dic in data) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_table reloadData];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    AddCallTelegramVC *nextVC = [[AddCallTelegramVC alloc] initWithProjectId:_projectId info_id:_info_id];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;//_dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCell"];
    if (!cell) {
        
        cell = [[CallTelegramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.section];;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCustomDetailVC *nextVC = [[CallTelegramCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.section][@"group_id"]]];
    nextVC.project_id = _projectId;
    nextVC.info_id = _info_id;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"来电";
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:IMAGE_WITH_NAME(@"add_3") forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.line.hidden = YES;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = CLLineColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.delegate = self;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入电话/姓名";
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
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStyleGrouped];
    _table.backgroundColor = CL240Color;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
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
