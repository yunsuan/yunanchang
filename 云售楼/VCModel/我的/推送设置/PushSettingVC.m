//
//  PushSettingVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "PushSettingVC.h"

#import "PushSettingCell.h"

@interface PushSettingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _num;
    NSArray *_titleArr;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *personTable;

@end

@implementation PushSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _titleArr = @[@"全部提醒",@"客户跟进提醒",@"移动审核提醒",@"渠道客户到访确认提醒",@"项目数据统计提醒"];
    _dataArr = [[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"0",@"0",@"0"]];
//    _contentArr = [[NSMutableArray alloc] initWithArray:@[@"云算号",@"",@"姓名",@"电话号码",@"性别",@"出生年月",@"住址",@"******",@""]];
    
}

- (void)RequestMethod{
    
    [BaseRequest GET:PersonalPushTopsGet_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"follow"] integerValue] == 1) {
                
                [self->_dataArr replaceObjectAtIndex:1 withObject:@"1"];
            }else{
                
                [self->_dataArr replaceObjectAtIndex:1 withObject:@"0"];
            }
            if ([resposeObject[@"data"][@"check_push"] integerValue] == 1) {
                
                [self->_dataArr replaceObjectAtIndex:2 withObject:@"1"];
            }else{
                
                [self->_dataArr replaceObjectAtIndex:2 withObject:@"0"];
            }
            if ([resposeObject[@"data"][@"confirm"] integerValue] == 1) {
                
                [self->_dataArr replaceObjectAtIndex:3 withObject:@"1"];
            }else{
                
                [self->_dataArr replaceObjectAtIndex:3 withObject:@"0"];
            }
            if ([resposeObject[@"data"][@"data"] integerValue] == 1) {
                
                [self->_dataArr replaceObjectAtIndex:4 withObject:@"1"];
            }else{
                
                [self->_dataArr replaceObjectAtIndex:4 withObject:@"0"];
            }
            [self->_dataArr replaceObjectAtIndex:0 withObject:@"1"];
            for (int i = 0; i < self->_dataArr.count; i++) {
                
                if ([self->_dataArr[i] integerValue] == 0) {
                    
                    [self->_dataArr replaceObjectAtIndex:0 withObject:@"0"];
                }
            }
            
            [self->_personTable reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}


- (void)RequestQueueMethod:(void(^)(void))finish data:(NSDictionary *)data {
    
    [BaseRequest POST:PersonPushTipsUpdate_URL parameters:data success:^(id  _Nonnull resposeObject) {
        
        self->_num += 1;
        finish();
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        self->_num += 1;
        finish();
        [self showContent:@"网络错误"];
    }];
}


#pragma mark -- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 51 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PushSettingCell"];
    if (!cell) {
        
        cell = [[PushSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PushSettingCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = _titleArr[(NSUInteger) indexPath.row];
    
    cell.contentL.hidden = YES;
    cell.headImg.hidden = YES;
    cell.OnOff.hidden = NO;
    cell.rightView.hidden = YES;
    if ([_dataArr[indexPath.row] integerValue] == 1) {
        
        [cell.OnOff setOn:YES];
    }else{
        
        [cell.OnOff setOn:NO];
    }
    
    __weak __typeof(&*cell)weakCell = cell;
    cell.pushSettingCellSwitchBlock = ^{
        
        if (weakCell.OnOff.on) {
            
            [self->_dataArr replaceObjectAtIndex:0 withObject:@"1"];
//            NSInteger newNum = 4;
            switch (indexPath.row) {
                case 0:
                {
                    NSMutableDictionary *tempDic = [@{} mutableCopy];
                    [self->_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                       
                        if ([obj integerValue] == 0) {
                            
                            if (idx == 1) {
                                
                                [tempDic setObject:@"1" forKey:@"follow"];
                            }else if (idx == 2){
                                
                                [tempDic setObject:@"1" forKey:@"check_push"];
                            }else if (idx == 3){
                                
                                [tempDic setObject:@"1" forKey:@"confirm"];
                            }else if (idx == 4){
                                
                                [tempDic setObject:@"1" forKey:@"data"];
                            }
                        }
                    }];
                    [BaseRequest GET:PersonPushTipsUpdate_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            for (int i = 0; i < self->_dataArr.count; i++) {
                                
                                [self->_dataArr replaceObjectAtIndex:i withObject:@"1"];
                            }
                            [self->_personTable reloadData];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                    break;
                }
                case 1:
                {
                    [BaseRequest GET:PersonPushTipsUpdate_URL parameters:@{@"follow":@"1"} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr replaceObjectAtIndex:1 withObject:@"1"];
                            for (int i = 0; i < self->_dataArr.count; i++) {
                                
                                if ([self->_dataArr[i] integerValue] == 0) {
                                    
                                    [self->_dataArr replaceObjectAtIndex:0 withObject:@"0"];
                                }
                            }
                            [self->_personTable reloadData];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                    break;
                }
                case 2:
                {
                    [BaseRequest GET:PersonPushTipsUpdate_URL parameters:@{@"check_push":@"1"} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr replaceObjectAtIndex:2 withObject:@"1"];
                            for (int i = 0; i < self->_dataArr.count; i++) {
                                
                                if ([self->_dataArr[i] integerValue] == 0) {
                                    
                                    [self->_dataArr replaceObjectAtIndex:0 withObject:@"0"];
                                }
                            }
                            [self->_personTable reloadData];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                    break;
                }
                case 3:
                {
                    [BaseRequest GET:PersonPushTipsUpdate_URL parameters:@{@"confirm":@"1"} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr replaceObjectAtIndex:3 withObject:@"1"];
                            for (int i = 0; i < self->_dataArr.count; i++) {
                                
                                if ([self->_dataArr[i] integerValue] == 0) {
                                    
                                    [self->_dataArr replaceObjectAtIndex:0 withObject:@"0"];
                                }
                            }
                            [self->_personTable reloadData];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                    break;
                }
                case 4:
                {
                    [BaseRequest GET:PersonPushTipsUpdate_URL parameters:@{@"data":@"1"} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr replaceObjectAtIndex:4 withObject:@"1"];
                            for (int i = 0; i < self->_dataArr.count; i++) {
                                
                                if ([self->_dataArr[i] integerValue] == 0) {
                                    
                                    [self->_dataArr replaceObjectAtIndex:0 withObject:@"0"];
                                }
                            }
                            [self->_personTable reloadData];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                    break;
                }
                default:
                    break;
            }
        }else{
            
            switch (indexPath.row) {
                case 0:
                {
                    NSMutableDictionary *tempDic = [@{} mutableCopy];
                    [self->_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ([obj integerValue] == 1) {
                            
                            if (idx == 1) {
                                
                                [tempDic setObject:@"0" forKey:@"follow"];
                            }else if (idx == 2){
                                
                                [tempDic setObject:@"0" forKey:@"check_push"];
                            }else if (idx == 3){
                                
                                [tempDic setObject:@"0" forKey:@"confirm"];
                            }else if (idx == 4){
                                
                                [tempDic setObject:@"0" forKey:@"data"];
                            }
                        }
                    }];
                    [BaseRequest GET:PersonPushTipsUpdate_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            for (int i = 0; i < self->_dataArr.count; i++) {
                                
                                [self->_dataArr replaceObjectAtIndex:i withObject:@"0"];
                            }
                            [self->_personTable reloadData];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                    break;
                }
                case 1:
                {
                    [BaseRequest GET:PersonPushTipsUpdate_URL parameters:@{@"follow":@"0"} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr replaceObjectAtIndex:1 withObject:@"0"];
                            for (int i = 0; i < self->_dataArr.count; i++) {
                                
                                if ([self->_dataArr[i] integerValue] == 0) {
                                    
                                    [self->_dataArr replaceObjectAtIndex:0 withObject:@"0"];
                                }
                            }
                            [self->_personTable reloadData];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                    break;
                }
                case 2:
                {
                    [BaseRequest GET:PersonPushTipsUpdate_URL parameters:@{@"check_push":@"0"} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr replaceObjectAtIndex:2 withObject:@"0"];
                            for (int i = 0; i < self->_dataArr.count; i++) {
                                
                                if ([self->_dataArr[i] integerValue] == 0) {
                                    
                                    [self->_dataArr replaceObjectAtIndex:0 withObject:@"0"];
                                }
                            }
                            [self->_personTable reloadData];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                    break;
                }
                case 3:
                {
                    [BaseRequest GET:PersonPushTipsUpdate_URL parameters:@{@"confirm":@"0"} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr replaceObjectAtIndex:3 withObject:@"0"];
                            for (int i = 0; i < self->_dataArr.count; i++) {
                                
                                if ([self->_dataArr[i] integerValue] == 0) {
                                    
                                    [self->_dataArr replaceObjectAtIndex:0 withObject:@"0"];
                                }
                            }
                            [self->_personTable reloadData];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                    break;
                }
                case 4:
                {
                    [BaseRequest GET:PersonPushTipsUpdate_URL parameters:@{@"data":@"0"} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr replaceObjectAtIndex:4 withObject:@"0"];
                            for (int i = 0; i < self->_dataArr.count; i++) {
                                
                                if ([self->_dataArr[i] integerValue] == 0) {
                                    
                                    [self->_dataArr replaceObjectAtIndex:0 withObject:@"0"];
                                }
                            }
                            [self->_personTable reloadData];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                    break;
                }
                default:
                    break;
            }
        }
    };

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"推送设置";
    
    
    _personTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _personTable.backgroundColor = self.view.backgroundColor;
    _personTable.delegate = self;
    _personTable.dataSource = self;
    _personTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_personTable];
    
}

@end
