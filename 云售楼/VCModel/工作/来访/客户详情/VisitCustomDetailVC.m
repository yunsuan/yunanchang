//
//  VisitCustomDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "VisitCustomDetailVC.h"

#import "CallTelegramModifyCustomVC.h"
#import "CallTelegramSimpleCustomVC.h"
#import "AddCallTelegramGroupMemberVC.h"
#import "IntentSurveyVC.h"
#import "FollowRecordVC.h"
#import "IntentSurveyVC.h"
#import "AddNumeralVC.h"
#import "AddOrderVC.h"
#import "AddSignVC.h"

#import "SinglePickView.h"

#import "CallTelegramCustomDetailHeader.h"
#import "CallTelegramCustomDetailIntentHeader.h"
#import "CallTelegramCustomDetailInfoCell.h"
#import "ContentBaseCell.h"
#import "BaseAddCell.h"
#import "CallTelegramCustomDetailFollowCell.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
//#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface VisitCustomDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _index;
    NSInteger _num;
    
    NSString *_groupId;
    
    NSMutableDictionary *_groupInfoDic;
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_infoDataArr;
    NSMutableArray *_intentArr;
    NSMutableArray *_followArr;
    NSMutableArray *_peopleArr;
    
    AVAudioPlayer *_player;
    
}
@property (nonatomic, strong) UITableView *table;


@end

@implementation VisitCustomDetailVC

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
    
    _propertyArr = [@[] mutableCopy];
    _infoDataArr = [@[] mutableCopy];
    _peopleArr = [@[] mutableCopy];
    _intentArr = [@[] mutableCopy];
    _followArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:WorkClientAutoDetail_URL parameters:@{@"group_id":_groupId} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_groupInfoDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"][@"group_info"]];
            self->_name = self->_groupInfoDic[@"advicer_name"];
            self->_intentArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"need"]];
            self->_followArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"follow"]];
            self->_peopleArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"client_info"]];
            [self->_infoDataArr removeAllObjects];
            for (NSDictionary *dic in resposeObject[@"data"][@"client_info"]) {
                
                NSArray *arr = @[[NSString stringWithFormat:@"姓名：%@",dic[@"name"]],[NSString stringWithFormat:@"联系电话：%@",dic[@"tel"]],[NSString stringWithFormat:@"证件类型：%@",dic[@"card_type"]],[NSString stringWithFormat:@"证件号：%@",dic[@"card_num"]],[NSString stringWithFormat:@"邮政编码：%@",dic[@"mail_code"]],[NSString stringWithFormat:@"通讯地址：%@",dic[@"address"]],[NSString stringWithFormat:@"出生日期：%@",dic[@"birth"]],[NSString stringWithFormat:@"备注：%@",dic[@"comment"]]];
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

-(void)action_play:(UIButton *)sender
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSError *playError;
    
    NSURL* url = [NSURL URLWithString: [NSString stringWithFormat: @"%@%@",TestBase_Net,_followArr[sender.tag][@"comment"]]];
    NSString *adress =_followArr[sender.tag][@"comment"];
    adress =[adress stringByReplacingOccurrencesOfString:@"upload/sale/upload/" withString:@""];
    NSData * audioData = [NSData dataWithContentsOfURL:url];
    
    //将数据保存到本地指定位置
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", docDirPath , adress];
    [audioData writeToFile:filePath atomically:YES];
    
    //播放本地音乐
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    if (_player == nil) {
        NSLog(@"Error crenting player: %@", [playError description]);
    }else {
        _player.delegate = self;
        NSLog(@"开始播放");
        [_player stop];
        //开始播放
        if ([_player prepareToPlay] == YES) {
            
            [_player play];
            
        }
    }
    
    
}


- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *numeral = [UIAlertAction actionWithTitle:@"转排号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
        AddNumeralVC *nextVC = [[AddNumeralVC alloc] initWithProject_id:self->_project_id personArr:self->_peopleArr info_id:self->_info_id group_id:self->_groupId];
        nextVC.projectName = self.projectName;
        nextVC.addNumeralVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *order = [UIAlertAction actionWithTitle:@"转订单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddOrderVC *nextVC = [[AddOrderVC alloc] initWithRow_id:@"" personArr:self->_peopleArr project_id:self.project_id info_id:self.info_id];
        nextVC.status = @"1";
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *sign = [UIAlertAction actionWithTitle:@"转签约" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddSignVC *nextVC = [[AddSignVC alloc] initWithRow_id:@"" personArr:self->_peopleArr];
//        nextVC.status = @"1";
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *quit = [UIAlertAction actionWithTitle:@"放弃跟进" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [BaseRequest POST:WorkClientAutoGroupUpdate_URL parameters:@{@"group_id":self->_groupInfoDic[@"group_id"],@"disabled_state":@"1"} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCall" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:numeral];
    [alert addAction:order];
    [alert addAction:sign];
    
    if ([self.powerDic[@"giveUp"] boolValue]) {
        
        [alert addAction:quit];
    }
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark -- delegate --

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
            
            if (_index == 1) {
                
                if ([self.powerDic[@"update"] boolValue]) {
                    
                    return 1;
                }
                return 0;
            }else{
                
                if ([self.powerDic[@"follow"] boolValue]) {
                    
                    return 1;
                }
                return 0;
            }
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
        
        if ([self.powerDic[@"update"] boolValue]) {
            
            header.editBtn.hidden = NO;
            header.addBtn.hidden = NO;
        }else{
            
            header.editBtn.hidden = YES;
            header.addBtn.hidden = YES;
        }
        
        header.dataDic = _groupInfoDic;
        header.belongL.text = [NSString stringWithFormat:@"归属人：%@",self.name];
        if (_peopleArr.count) {
            
            if ([_peopleArr[_num][@"sex"] integerValue] == 1) {
                
                header.headImg.image = IMAGE_WITH_NAME(@"nan");
            }else{
                
                header.headImg.image = IMAGE_WITH_NAME(@"nv");
            }
        }
        
        header.propertyL.text = [NSString stringWithFormat:@"意向物业："];
        for (int i = 0; i < _intentArr.count; i++) {
            
            if (i == 0) {
                
                header.propertyL.text = [NSString stringWithFormat:@"意向物业：%@",_intentArr[0][@"property_name"]];
            }else{
                
                header.propertyL.text = [NSString stringWithFormat:@"%@,%@",header.propertyL.text,_intentArr[i][@"property_name"]];
            }
        }
        
        header.dataArr = _peopleArr;
        
        if (_peopleArr.count) {
            
            if (_num < _peopleArr.count) {
                
                header.num = _num;
            }else{
             
                _num = _peopleArr.count - 1;
                header.num = _num;
            }
        }
        
        
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
        
        header.callTelegramCustomDetailHeaderEditBlock = ^(NSInteger index) {
            
            CallTelegramModifyCustomVC *vc = [[CallTelegramModifyCustomVC alloc] initWithDataDic:self->_groupInfoDic projectId:self->_project_id info_id:self->_info_id];
            if ([self->_groupInfoDic[@"source"] isEqualToString:@"分配分销"]) {
                
                vc.status = @"分配";
            }
            vc.callTelegramModifyCustomVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        header.callTelegramCustomDetailHeaderCollBlock = ^(NSInteger index) {
            
            self->_num = index;
            self->_index = 0;
            if ([self->_peopleArr[index][@"sex"] integerValue] == 1) {
                
                header.headImg.image = IMAGE_WITH_NAME(@"nan");
            }else{
                
                header.headImg.image = IMAGE_WITH_NAME(@"nv");
            }
            [tableView reloadData];
        };
        
        header.callTelegramCustomDetailHeaderAddBlock = ^(NSInteger index) {
            
            AddCallTelegramGroupMemberVC *nextVC = [[AddCallTelegramGroupMemberVC alloc] initWithProjectId:self->_project_id info_id:self->_info_id];
            nextVC.group_id = [NSString stringWithFormat:@"%@",self->_groupInfoDic[@"group_id"]];
            nextVC.addCallTelegramGroupMemberDirectVCBlock = ^{
                
                self->_num += 1;
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        
        header.callTelegramCustomDetailHeaderTagBlock = ^(NSInteger index) {
            
            self->_index = index;
            if (index == 0) {
                
                
            }else if (index == 1){
                
            }else{
                
                
            }
            [tableView reloadData];
        };
        
        return header;
    }else{
        
        if (_index == 1) {
            
            CallTelegramCustomDetailIntentHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CallTelegramCustomDetailIntentHeader"];
            if (!header) {
                
                header = [[CallTelegramCustomDetailIntentHeader alloc] initWithReuseIdentifier:@"CallTelegramCustomDetailIntentHeader"];
            }
            
             header.tag = section;
            
            if ([self.powerDic[@"update"] boolValue]) {
                
                header.editBtn.hidden = NO;
                
            }else{
                
                header.editBtn.hidden = YES;
            }
            if ([self.powerDic[@"delete"] boolValue]) {
                
                header.deleteBtn.hidden = NO;
                
            }else{
                
                header.deleteBtn.hidden = YES;
            }
            
            header.callTelegramCustomDetailIntentHeaderEditBlock = ^(NSInteger index) {
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self->_intentArr[index - 1]];
                [dic setObject:[NSString stringWithFormat:@"%@",dic[@"property_id"]] forKey:@"id"];
                IntentSurveyVC *nextVC = [[IntentSurveyVC alloc] initWithData:@[dic]];
                nextVC.status = @"modify";
                nextVC.property_id = dic[@"id"];
                nextVC.intentSurveyVCBlock = ^{
                    
                    [self RequestMethod];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            header.callTelegramCustomDetailIntentHeaderDeleteBlock = ^(NSInteger index) {
                
                NSString *needId;
                for (int i = 0; i < [self->_intentArr[section - 1][@"list"] count]; i++) {
                    
                    if (i == 0) {
                        
                        needId = [NSString stringWithFormat:@"%@",self->_intentArr[section - 1][@"list"][i][@"need_id"]];
                    }else{
                        
                        needId = [NSString stringWithFormat:@"%@,%@",needId,self->_intentArr[section - 1][@"list"][i][@"need_id"]];
                    }
                }
                [BaseRequest POST:WorkClientAutoNeedUpdate_URL parameters:@{@"need_id":needId,@"state":@"0"} success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [self->_intentArr removeObjectAtIndex:section - 1];
                        [self->_propertyArr removeAllObjects];
                        [tableView reloadData];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [self showContent:@"网络错误"];
                }];
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
            
            if ([self.powerDic[@"update"] boolValue]) {
                
                cell.editBtn.hidden = NO;
                //                cell.deleteBtn.hidden = NO;
            }else{
                
                cell.editBtn.hidden = YES;
                //                cell.deleteBtn.hidden = YES;
            }
            if ([self.powerDic[@"delete"] boolValue]) {
                
                cell.deleteBtn.hidden = NO;
                
            }else{
                
                cell.deleteBtn.hidden = YES;
            }
        }else{
            
            cell.editBtn.hidden = YES;
            cell.deleteBtn.hidden = YES;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.text = _infoDataArr[_num][indexPath.row];
        
        cell.callTelegramCustomDetailInfoCellEditBlock = ^{
            
            CallTelegramSimpleCustomVC *nextVC = [[CallTelegramSimpleCustomVC alloc] initWithDataDic:self->_peopleArr[self->_num] projectId:self->_project_id info_id:self.info_id];
            nextVC.callTelegramSimpleCustomVCEditBlock = ^(NSDictionary * _Nonnull dic) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->_peopleArr[self->_num]];
                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if (dic[key]) {
                        
                        [tempDic setObject:dic[key] forKey:key];
                    }
                }];
                [self->_peopleArr replaceObjectAtIndex:self->_num withObject:tempDic];
                
                NSArray *arr = @[[NSString stringWithFormat:@"姓名：%@",tempDic[@"name"]],[NSString stringWithFormat:@"联系电话：%@",tempDic[@"tel"]],[NSString stringWithFormat:@"证件类型：%@",tempDic[@"card_type"]],[NSString stringWithFormat:@"证件号：%@",tempDic[@"card_num"]],[NSString stringWithFormat:@"邮政编码：%@",tempDic[@"mail_code"]],[NSString stringWithFormat:@"通讯地址：%@",tempDic[@"address"]],[NSString stringWithFormat:@"出生日期：%@",tempDic[@"birth"]],[NSString stringWithFormat:@"备注：%@",tempDic[@"comment"]]];
                [self->_infoDataArr replaceObjectAtIndex:self->_num withObject:arr];
                
                [tableView reloadData];
//                [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                if (self.visitCustomDetailModifyBlock) {
                    
                    self.visitCustomDetailModifyBlock();
                }
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        
        cell.callTelegramCustomDetailInfoCellDeleteBlock = ^{
            
            if (self->_peopleArr.count > 1) {
                
                [BaseRequest POST:WorkClientAutoClientUpdate_URL parameters:@{@"state":@"0",@"client_id":self->_peopleArr[self->_num][@"client_id"]} success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        self->_num -= 1;
                        [self RequestMethod];
                        if (self.visitCustomDetailModifyBlock) {
                            
                            self.visitCustomDetailModifyBlock();
                        }
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }else{
                
                [self showContent:@"唯一客户不能删除"];
            }
        };
        
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
        
        cell.contentL.text = [NSString stringWithFormat:@"%@：%@",_intentArr[indexPath.section - 1][@"list"][indexPath.row][@"config_name"],_intentArr[indexPath.section - 1][@"list"][indexPath.row][@"value"]];

        [cell.contentL mas_updateConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(cell.contentView).offset(28 *SIZE);
        }];
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
        
        if (!cell.speechImg.hidden) {
            cell.speechImg.tag = indexPath.row;
            [cell.speechImg addTarget:self action:@selector(action_play:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 0) {
        
        
    }else if (_index == 1){
        
        if (indexPath.section == 0) {
            
            if (self->_propertyArr.count) {
                
                for (int i = 0; i < self->_intentArr.count; i++) {
                    
                    for (int j = 0; j < self->_propertyArr.count; j++) {
                        
                        if ([self->_intentArr[i][@"property_id"] integerValue] == [self->_propertyArr[j][@"id"] integerValue]) {
                            
                            [self->_propertyArr removeObjectAtIndex:j];
                        }
                    }
                }

                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_propertyArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    IntentSurveyVC *nextVC = [[IntentSurveyVC alloc] initWithData:@[@{@"id":[NSString stringWithFormat:@"%@",ID],@"param":MC}]];
                    nextVC.property_id = [NSString stringWithFormat:@"%@",ID];
                    nextVC.status = @"add";
                    nextVC.group_id = self->_groupId;
                    nextVC.intentSurveyVCBlock = ^{
                      
                        [self RequestMethod];
                    };
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
                [self.view addSubview:view];
            }else{
                
                [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"info_id":self->_info_id} success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        for (NSDictionary *dic in resposeObject[@"data"][3]) {
                            
                            NSDictionary *tempDic = @{@"id":dic[@"config_id"],
                                                      @"param":dic[@"config_name"]
                                                      };
                            [self->_propertyArr addObject:tempDic];
                        }
                        for (int i = 0; i < self->_intentArr.count; i++) {
                            
                            for (int j = 0; j < self->_propertyArr.count; j++) {
                                
                                if ([self->_intentArr[i][@"property_id"] integerValue] == [self->_propertyArr[j][@"id"] integerValue]) {
                                    
                                    [self->_propertyArr removeObjectAtIndex:j];
                                }
                            }
                        }
                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_propertyArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {
                            
                            IntentSurveyVC *nextVC = [[IntentSurveyVC alloc] initWithData:@[@{@"id":[NSString stringWithFormat:@"%@",ID],@"param":MC}]];
                            nextVC.property_id = [NSString stringWithFormat:@"%@",ID];
                            nextVC.status = @"add";
                            nextVC.group_id = self->_groupId;
                            nextVC.intentSurveyVCBlock = ^{
                                
                                [self RequestMethod];
                            };
                            [self.navigationController pushViewController:nextVC animated:YES];
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }
        }
    }else{
        
        if (indexPath.section == 0) {
            
            FollowRecordVC *vc = [[FollowRecordVC alloc] initWithGroupId:_groupId];
            if (_followArr.count) {
                
                vc.followDic = [[NSMutableDictionary alloc] initWithDictionary:_followArr[0]];
            }else{
                
                vc.followDic = [@{} mutableCopy];
            }
            vc.status = @"direct";
            vc.info_id = self.info_id;
            vc.allDic = [NSMutableDictionary dictionaryWithDictionary:@{@"project_id":self.project_id}];
            vc.followRecordVCBlock = ^{
                
                [self RequestMethod];
                if (self.visitCustomDetailModifyBlock) {
                    
                    self.visitCustomDetailModifyBlock();
                }
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.backgroundColor = CLBlueBtnColor;
    self.titleLabel.text = @"客户详情";
    self.titleLabel.textColor = CLWhiteColor;
    [self.leftButton setImage:[UIImage imageNamed:@"leftarrow_white"] forState:UIControlStateNormal];
    if ([self.powerDic[@"giveUp"] boolValue]) {
        
        self.rightBtn.hidden = NO;
    }else{
        
        self.rightBtn.hidden = YES;
    }
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
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
