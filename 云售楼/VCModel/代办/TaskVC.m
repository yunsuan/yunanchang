//
//  TaskVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TaskVC.h"

#import "FollowRecordVC.h"
#import "CallTelegramCustomDetailVC.h"
#import "WorkPhoneConfrimWaitDetailVC.h"
#import "WorkRecommendWaitDetailVC.h"

#import "TaskCallBackCell.h"
#import "TaskCallFollowCell.h"
#import "TaskTakeLookConfirmCell.h"
#import "TaskSignAuditCell.h"
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
//    _dataArr = [[NSMutableArray alloc] initWithArray:@[@"来电客户",@"来访客户",@"推荐客户",@"审核待办",@"财务待办"]];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HandleGetMessageList_URL parameters:nil success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        [self->_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            if ([resposeObject[@"data"][@"list"] count]) {
                
                [self SetData:resposeObject[@"data"][@"list"]];
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

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"signAgent"]) {
                    
                    [dic setObject:@[] forKey:key];
                }else{
                 
                    [dic setObject:@"" forKey:key];
                }
            }else{
                
                if ([key isEqualToString:@"signAgent"]) {
                    
//                    key setObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>
                }else{
                    
                    [dic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
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
    
    if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 1) {

        TaskCallBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCallBackCell"];
        if (!cell) {

            cell = [[TaskCallBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCallBackCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];

        cell.taskCallBackCellBlock = ^{

            FollowRecordVC *nextVC = [[FollowRecordVC alloc] initWithGroupId:self->_dataArr[indexPath.row][@"group_id"]];
            nextVC.info_id = self->_dataArr[indexPath.row][@"info_id"];
            nextVC.status = @"direct";
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;

    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 2){

        TaskCallFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCallFollowCell"];
        if (!cell) {

            cell = [[TaskCallFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCallFollowCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];


        return cell;

    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 3){

        TaskTakeLookConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTakeLookConfirmCell"];
        if (!cell) {

            cell = [[TaskTakeLookConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskTakeLookConfirmCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        return cell;

    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 4){

        TaskSignAuditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskSignAuditCell"];
        if (!cell) {

            cell = [[TaskSignAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskSignAuditCell"];
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
//    if (indexPath.row == 0) {
//
//        TaskCallBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCallBackCell"];
//        if (!cell) {
//
//            cell = [[TaskCallBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCallBackCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
////        cell.dataDic = _dataArr[indexPath.row];
//        return cell;
//    }else if (indexPath.row == 1){
//
//        TaskCallFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCallFollowCell"];
//        if (!cell) {
//
//            cell = [[TaskCallFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCallFollowCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
////        cell.dataDic = _dataArr[indexPath.row];
//        return cell;
//    }else if (indexPath.row == 2){
//
//        TaskTakeLookConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTakeLookConfirmCell"];
//        if (!cell) {
//
//            cell = [[TaskTakeLookConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskTakeLookConfirmCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
////        cell.dataDic = _dataArr[indexPath.row];
//        return cell;
//    }else if (indexPath.row == 3){
//
//        TaskSignAuditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskSignAuditCell"];
//        if (!cell) {
//
//            cell = [[TaskSignAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskSignAuditCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
////        cell.dataDic = _dataArr[indexPath.row];
//        return cell;
//    }else{
//
//        TaskVisitConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskVisitConfirmCell"];
//        if (!cell) {
//
//            cell = [[TaskVisitConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskVisitConfirmCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
////        cell.dataDic = _dataArr[indexPath.row];
//        return cell;
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 1) {
        
        CallTelegramCustomDetailVC *nextVC = [[CallTelegramCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.section][@"group_id"]]];
        nextVC.project_id = _dataArr[indexPath.section][@"project_id"];
        nextVC.info_id = _dataArr[indexPath.section][@"info_id"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 2) {
        
        CallTelegramCustomDetailVC *nextVC = [[CallTelegramCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.section][@"group_id"]]];
        nextVC.project_id = _dataArr[indexPath.section][@"project_id"];
        nextVC.info_id = _dataArr[indexPath.section][@"info_id"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 3) {
        
        WorkPhoneConfrimWaitDetailVC *nextVC = [[WorkPhoneConfrimWaitDetailVC alloc] initWithClientId:_dataArr[indexPath.row][@"client_id"]];
        nextVC.workPhoneConfrimWaitDetailVCBlock = ^{
            
            [self->_dataArr removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 4) {
        
    }else{
        
        WorkRecommendWaitDetailVC *nextVC = [[WorkRecommendWaitDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];
        //    if (_dataArr[indexPath.row][@"need_confirm"]) {
        //
        //        nextVC.needConfirm = _dataArr[indexPath.row][@"need_confirm"];
        //    }else{
        //
        //        nextVC.needConfirm = @"1";
        //    }
        //
        [self.navigationController pushViewController:nextVC animated:YES];
    }
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
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
       
        [self RequestMethod];
    }];
    [self.view addSubview:_table];
}

@end
