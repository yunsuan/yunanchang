//
//  SignNeedInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SignNeedInfoVC.h"

#import "BaseHeader.h"
#import "InfoDetailCell.h"

@interface SignNeedInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSString *_clientId;
    NSMutableDictionary *_dataDic;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation SignNeedInfoVC

- (instancetype)initWithClientId:(NSString *)clientId
{
    self = [super init];
    if (self) {
        
        _clientId = clientId;
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
    
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:AgentProjectClientNeedGet_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                NSData *JSONData = [resposeObject[@"data"][@"need_info"][@"content"] dataUsingEncoding:NSUTF8StringEncoding];
                if (JSONData) {
                    
                    NSError *err = nil;
                    NSDictionary *parameters = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:&err];
                    _dataDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
                    NSArray * arr = [self getDetailConfigArrByConfigState:BUY_TYPE];
                    for (int i = 0; i < arr.count; i++) {
                        
                        if ([resposeObject[@"data"][@"need_info"][@"buy_purpose"] integerValue] == [arr[i][@"id"] integerValue]) {
                            
                             [_dataArr addObject:[NSString stringWithFormat:@"置业目的：%@",arr[i][@"param"]]];
                        }
                    }
                    [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        
                        if (![key isEqualToString:@"visit_img_url"]) {
                            
                            [_dataArr addObject:[NSString stringWithFormat:@"%@：%@",key,obj]];
                        }
                    }];
                }
            }
            [_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    header.lineView.hidden = YES;
    header.titleL.text = @"需求信息";
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoDetailCell"];
    if (!cell) {
        
        cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoDetailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell SetCellContentbystring:_dataArr[indexPath.row]];
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"需求信息";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT , SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
