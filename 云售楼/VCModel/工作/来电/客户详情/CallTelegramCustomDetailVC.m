//
//  CallTelegramCustomDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramCustomDetailVC.h"

#import "CallTelegramModifyCustomVC.h"
#import "FollowRecordVC.h"

#import "CallTelegramCustomDetailHeader.h"
#import "CallTelegramCustomDetailIntentHeader.h"
#import "CallTelegramCustomDetailInfoCell.h"
#import "ContentBaseCell.h"
#import "BaseAddCell.h"
#import "CallTelegramCustomDetailFollowCell.h"

@interface CallTelegramCustomDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _index;
    NSInteger _num;
    
    NSString *_groupId;
    
    NSMutableDictionary *_groupInfoDic;
    
    NSMutableArray *_infoDataArr;
    NSMutableArray *_intentArr;
    NSMutableArray *_followArr;
    NSMutableArray *_peopleArr;
    
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation CallTelegramCustomDetailVC

- (instancetype)initWithGroupId:(NSString *)groupId
{
    self = [super init];
    if (self) {
        
        _groupId = groupId;
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
    
    _groupInfoDic = [@{} mutableCopy];
    
    _infoDataArr = [@[] mutableCopy];
    _peopleArr = [@[] mutableCopy];
    _intentArr = [@[] mutableCopy];
    _followArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:WorkClientAutoDetail_URL parameters:@{@"group_id":_groupId} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_groupInfoDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"][@"group_info"]];
            
            self->_intentArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"need"]];
            self->_followArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"follow"]];
            self->_peopleArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"client_info"]];
            [self->_infoDataArr removeAllObjects];
            for (NSDictionary *dic in resposeObject[@"data"][@"client_info"]) {
                
                NSArray *arr = @[[NSString stringWithFormat:@"姓名：%@",dic[@"name"]],[NSString stringWithFormat:@"联系电话：%@",dic[@"tel"]],[NSString stringWithFormat:@"证件类型：%@",dic[@"card_type"]],[NSString stringWithFormat:@"证件号：%@",dic[@"card_num"]],[NSString stringWithFormat:@"邮政编码：%@",dic[@"mail_code"]],[NSString stringWithFormat:@"通讯地址：%@",dic[@"address"]],[NSString stringWithFormat:@"客户来源：%@",dic[@""]],[NSString stringWithFormat:@"出生日期：%@",dic[@"birth"]],[NSString stringWithFormat:@"备注：%@",dic[@"comment"]]];
                [self->_infoDataArr addObject:arr];
            }
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_index == 0) {
        
        return _infoDataArr.count ? 2:1;
    }else if (_index == 1){
        
        return _intentArr.count + 1;
    }else{
        
        return _followArr.count ? 2 : 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        if (_index == 0) {
            
            return 0;
        }else{
            
            return 1;
        }
    }else{
        
        if (_index == 0) {
            
            return [_infoDataArr[_num] count];
        }else if (_index == 1){
            
            return [_intentArr[section - 1][@"list"] count];
        }else{
            
            return _followArr.count;//[_followArr[section - 1] count];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return UITableViewAutomaticDimension;
    }else{
        
        if (_index == 0) {
            
            return 0;
        }else if (_index == 1){
            
            return UITableViewAutomaticDimension;
        }else{
            
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGFLOAT_MIN;
    }else{
        
        if (_index == 0) {
            
            return CGFLOAT_MIN;
        }else if (_index == 1){
            
            return 10 *SIZE;
        }else{
            
            return 10 *SIZE;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        CallTelegramCustomDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CallTelegramCustomDetailHeader"];
        if (!header) {
            
            header = [[CallTelegramCustomDetailHeader alloc] initWithReuseIdentifier:@"CallTelegramCustomDetailHeader"];
        }
        
        header.dataDic = _groupInfoDic;
        header.dataArr = _peopleArr;
        
        [header.infoBtn setBackgroundColor:CL248Color];
        [header.infoBtn setTitleColor:CL178Color forState:UIControlStateNormal];
        [header.intentBtn setBackgroundColor:CL248Color];
        [header.intentBtn setTitleColor:CL178Color forState:UIControlStateNormal];
        [header.followBtn setBackgroundColor:CL248Color];
        [header.followBtn setTitleColor:CL178Color forState:UIControlStateNormal];
        
        if (_index == 0) {
            
            [header.infoBtn setBackgroundColor:CLBlueBtnColor];
            [header.infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (_index == 1){
            
            [header.intentBtn setBackgroundColor:CLBlueBtnColor];
            [header.intentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            [header.followBtn setBackgroundColor:CLBlueBtnColor];
            [header.followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        header.callTelegramCustomDetailHeaderCollBlock = ^(NSInteger index) {
          
            self->_num = index;
            [tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
//            [tableView reloadData];
        };
        
        header.callTelegramCustomDetailHeaderTagBlock = ^(NSInteger index) {
            
            self->_index = index;
            if (index == 0) {
                
                
            }else if (index == 1){
                
                
            }else{
                
                
            }
            [tableView reloadData];
        };
        
        header.callTelegramCustomDetailHeaderEditBlock = ^(NSInteger index) {
          
            CallTelegramModifyCustomVC *vc = [[CallTelegramModifyCustomVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        return header;
    }else{
        
        if (_index == 1) {
            
            CallTelegramCustomDetailIntentHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CallTelegramCustomDetailIntentHeader"];
            if (!header) {
                
                header = [[CallTelegramCustomDetailIntentHeader alloc] initWithReuseIdentifier:@"CallTelegramCustomDetailIntentHeader"];
            }
            
            header.callTelegramCustomDetailIntentHeaderEditBlock = ^(NSInteger index) {
                
            };
            
            header.callTelegramCustomDetailIntentHeaderDeleteBlock = ^(NSInteger index) {
                
            };
            
            header.titleL.text = [NSString stringWithFormat:@"物业意向——%@",_intentArr[section - 1][@"property_name"]];//@"物业意向——住宅";
            return header;
        }else{
            
            return nil;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 0) {
        
        CallTelegramCustomDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCustomDetailInfoCell"];
        if (!cell) {
            
            cell = [[CallTelegramCustomDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCustomDetailInfoCell"];
        }
        
        if (indexPath.row == 0) {
            
            cell.editBtn.hidden = NO;
            cell.deleteBtn.hidden = NO;
        }else{
            
            cell.editBtn.hidden = YES;
            cell.deleteBtn.hidden = YES;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.text = _infoDataArr[_num][indexPath.row];
        
        return cell;
    }else if(_index == 1){
        
        if (indexPath.section == 0) {
            
            BaseAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseAddCell"];
            if (!cell) {
                
                cell = [[BaseAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseAddCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = @"添加意向";
            return cell;
        }
        ContentBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentBaseCell"];
        if (!cell) {
            
            cell = [[ContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentBaseCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.contentL mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(cell.contentView).offset(28 *SIZE);
        }];
        cell.contentL.text = [NSString stringWithFormat:@"%@：%@",_intentArr[indexPath.section - 1][@"list"][indexPath.row][@"config_name"],_intentArr[indexPath.section - 1][@"list"][indexPath.row][@"value"]];
        return cell;
    }else{
        
        if (indexPath.section == 0) {
            
            BaseAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseAddCell"];
            if (!cell) {
                
                cell = [[BaseAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseAddCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = @"添加跟进";
            return cell;
        }
        CallTelegramCustomDetailFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCustomDetailFollowCell"];
        if (!cell) {
            
            cell = [[CallTelegramCustomDetailFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCustomDetailFollowCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _followArr[indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 0) {
        
        
    }else if (_index == 1){
        
        
    }else{
        
        if (indexPath.section == 0) {
            
            FollowRecordVC *vc = [[FollowRecordVC alloc] initWithGroupId:_groupId];
            if (_followArr.count) {
                
                vc.followDic = [[NSMutableDictionary alloc] initWithDictionary:_followArr[0]];
            }else{
                
                vc.followDic = [@{} mutableCopy];
            }
            vc.status = @"direct";
            vc.allDic = [NSMutableDictionary dictionaryWithDictionary:@{@"project_id":self.project_id}];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.backgroundColor = CLBlueBtnColor;
    self.titleLabel.text = @"客户详情";
    self.titleLabel.textColor = CLWhiteColor;
    [self.leftButton setImage:[UIImage imageNamed:@"leftarrow_white"] forState:UIControlStateNormal];
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:IMAGE_WITH_NAME(@"add_2") forState:UIControlStateNormal];
    self.line.hidden = YES;
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _table.estimatedRowHeight = 367 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 320 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
