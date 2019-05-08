//
//  CallTelegramCustomDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramCustomDetailVC.h"

#import "CallTelegramModifyCustomVC.h"

#import "CallTelegramCustomDetailHeader.h"
#import "CallTelegramCustomDetailIntentHeader.h"
#import "CallTelegramCustomDetailInfoCell.h"
#import "ContentBaseCell.h"
#import "BaseAddCell.h"
#import "CallTelegramCustomDetailFollowCell.h"

@interface CallTelegramCustomDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_infoDataArr;
    NSInteger _index;
    NSMutableArray *_intentArr;
    NSMutableArray *_followArr;
//    NSMutableArray *_
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation CallTelegramCustomDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _infoDataArr = @[@"姓名：张大山",@"联系电话：18756451223",@"邮政编码：611100",@"通讯地址：四川省成都市p12312312312",@"客户来源：",@"出生日期：1929.12.22",@"备注：********"];
    _intentArr = [@[] mutableCopy];
    _intentArr = [[NSMutableArray alloc] initWithArray:@[@[@"购买目的：读书",@"意向户型：一房",@"意向楼层：10-20层",@"意向面积：90㎡",@"意见单价：6400元/㎡",@"意向总价：50-60万",@"关注重点：环境"]]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_index == 0) {
        
        return _infoDataArr.count ? 2:1;
    }else if (_index == 1){
        
        return _intentArr.count + 1;
    }else{
        
        return _followArr.count + 1;
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
            
            return _infoDataArr.count;
        }else if (_index == 1){
            
            return [_intentArr[section - 1] count];
        }else{
            
            return [_followArr[section - 1] count];
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
        
        header.dataDic = @{};
        
        
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
            
            header.titleL.text = @"物业意向——住宅";
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
        
        cell.contentL.text = _infoDataArr[indexPath.row];
        
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
        cell.contentL.text = _intentArr[0][indexPath.row];
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
        
        cell.dataDic = @{};
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
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
//    _table.backgroundColor = cl;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
