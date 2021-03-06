//
//  ChannelCustomListVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelCustomListVC.h"

#import "FollowRecordVC.h"

#import "CallTelegramCell.h"

@interface ChannelCustomListVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    NSInteger _page;
    
    NSString *_projectId;
    NSString *_info_id;
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UITextField *searchBar;

@end

@implementation ChannelCustomListVC

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
    
    

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_projectId}];
    self->_table.mj_footer.state = MJRefreshStateIdle;
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"search"];
    }
    [BaseRequest GET:WorkClientRecommendList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        [self->_dataArr removeAllObjects];
        [self->_table reloadData];
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
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_projectId,@"page":@(_page)}];
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"search"];
    }
    [BaseRequest GET:WorkClientRecommendList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self RequestMethod];
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
    
    FollowRecordVC *vc = [[FollowRecordVC alloc] initWithGroupId:_dataArr[indexPath.section][@"group_id"]];
    vc.followDic = [@{} mutableCopy];
    vc.status = @"direct";
    vc.info_id = self->_info_id;
    vc.visit_id = self.visit_id;
    vc.allDic = [NSMutableDictionary dictionaryWithDictionary:@{@"project_id":self->_projectId}];
    vc.followRecordVCBlock = ^{
        
        if (self.channelCustomListVCBlock) {
            
            self.channelCustomListVCBlock(@{});
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
//    if (self.channelCustomListVCBlock) {
//
//        self.channelCustomListVCBlock(_dataArr[indexPath.section]);
//    }
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"来访";
    self.rightBtn.hidden = NO;
    
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
