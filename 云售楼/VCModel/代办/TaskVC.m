//
//  TaskVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TaskVC.h"

#import "TaskCallBackCell.h"
#import "TaskCallFollowCell.h"
#import "TaskTakeLookConfirmCell.h"
#import "TaskVisitConfirmCell.h"

@interface TaskVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation TaskVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    _dataArr = [[NSMutableArray alloc] initWithArray:@[@"来电客户",@"来访客户",@"推荐客户",@"审核待办",@"财务待办"]];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HandleGetMessageList_URL parameters:nil success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
       
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        TaskCallBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCallBackCell"];
        if (!cell) {
            
            cell = [[TaskCallBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCallBackCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        return cell;
    }else if (indexPath.row == 1){
        
        TaskCallFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCallFollowCell"];
        if (!cell) {
            
            cell = [[TaskCallFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCallFollowCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        return cell;
    }else if (indexPath.row == 2){
        
        TaskTakeLookConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTakeLookConfirmCell"];
        if (!cell) {
            
            cell = [[TaskTakeLookConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskTakeLookConfirmCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        return cell;
    }else if (indexPath.row == 3){
        
        TaskTakeLookConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTakeLookConfirmCell"];
        if (!cell) {
            
            cell = [[TaskTakeLookConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskTakeLookConfirmCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        return cell;
    }else{
        
        TaskVisitConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskVisitConfirmCell"];
        if (!cell) {
            
            cell = [[TaskVisitConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskVisitConfirmCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"待办";
    self.leftButton.hidden = YES;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"清空数据" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn setTitleColor:CL86Color forState:UIControlStateNormal];
    self.rightBtn.center = CGPointMake(SCREEN_Width - 40 * SIZE, STATUS_BAR_HEIGHT + 20);
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
