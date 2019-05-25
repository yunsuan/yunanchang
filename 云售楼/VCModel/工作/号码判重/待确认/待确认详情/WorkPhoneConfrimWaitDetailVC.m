//
//  WorkPhoneConfrimWaitDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkPhoneConfrimWaitDetailVC.h"

#import "TitleRightBtnHeader.h"
#import "CountDownCell.h"
#import "ContentBaseCell.h"

@interface WorkPhoneConfrimWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSString *_clientId;
    NSDictionary *_dataDic;
    //    NSString *_phone;
}

@property (nonatomic, strong) UITableView *detailTable;

@property (nonatomic, strong) UIButton *invalidBtn;

@property (nonatomic , strong) UIButton *CopyBtn;

@end

@implementation WorkPhoneConfrimWaitDetailVC

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
    
    [self initUI];
    [self RequestMethod];
}

-(void)refresh{
    
//    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneAllConfirm" object:nil];
//        [self.navigationController popViewControllerAnimated:YES];
//    } failure:^(NSError *error) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ButterTelConfirmDetail_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            [self SetData:resposeObject[@"data"]];
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    _dataDic = data;
    _titleArr = @[[NSString stringWithFormat:@"失效倒计时：%@",data[@"timeLimit"]],[NSString stringWithFormat:@"推荐编号：%@",data[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",data[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",data[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",data[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",data[@"project_name"]],[NSString stringWithFormat:@"项目地址：%@",data[@"absolute_address"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"sex"] integerValue] == 1 ? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"tel"]],[NSString stringWithFormat:@"备注：%@",data[@"client_comment"]]];
    if (![data[@"is_deal"] integerValue]) {
        
        [self.view addSubview:_invalidBtn];
        [self.view addSubview:_CopyBtn];
    }else{
        
        _detailTable.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
    }
    [_detailTable reloadData];
}

-(void)ActionCopy:(UIButton *)btn
{
    [self showContent:@"复制成功!"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _dataDic[@"tel"];
}

- (void)ActionInValidBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认号码" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *unuse = [UIAlertAction actionWithTitle:@"可带看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [BaseRequest GET:ClientTelCheckValue_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 200) {

                if (self.workPhoneConfrimWaitDetailVCBlock) {

                    self.workPhoneConfrimWaitDetailVCBlock();
                    [self.navigationController popViewControllerAnimated:YES];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneConfirm" object:nil];
            }else{

                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {

            [self showContent:@"网络错误"];
        }];
    }];
    
    UIAlertAction *used = [UIAlertAction actionWithTitle:@"不可带看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [BaseRequest GET:ClientTelCheckDisabled_URL parameters:@{@"client_id":self->_clientId} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if (self.workPhoneConfrimWaitDetailVCBlock) {
                    
                    self.workPhoneConfrimWaitDetailVCBlock();
                    [self.navigationController popViewControllerAnimated:YES];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneConfirm" object:nil];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:unuse];
    [alert addAction:used];
    [alert addAction:cancel];
    
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleRightBtnHeader"];
    if (!header) {
        
        header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
    }
    
    header.titleL.text = @"推荐信息";
    header.line.hidden = YES;
    [header.moreBtn setBackgroundColor:_invalidBtn.backgroundColor];
    header.moreBtn.layer.cornerRadius = 3 *SIZE;
    header.moreBtn.clipsToBounds = YES;
    header.addBtn.hidden = YES;
    [header.moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [header.moreBtn setTitle:@"报备单" forState:UIControlStateNormal];
    if (!_dataDic[@"copy_content"]) {
    
        header.moreBtn.hidden = YES;
    }else{
        
        header.moreBtn.hidden = NO;
    }
    header.titleRightBtnHeaderMoreBlock = ^{
        
        [self showContent:@"复制成功!"];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self->_dataDic[@"copy_content"];
    };
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *CellIdentifier = @"CountDownCell";
        CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.titleL.text = @"房源真实性判断失效倒计时：";
        cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
        cell.countDownCellBlock = ^{
        
            //            [self refresh];
        };
        cell.titleL.textColor = CLTitleLabColor;
        if (_titleArr.count) {
            

            [cell setcountdownbyendtime:[_titleArr[0] substringWithRange:NSMakeRange(6, [_titleArr[0] length] - 6)]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        ContentBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentBaseCell"];
        if (!cell) {
            
            cell = [[ContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentBaseCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        
        if (indexPath.row == _titleArr.count - 1) {
            
            //            cell.textContent.text = @"备注：123123123123123123";
            cell.textContent.text = _titleArr[indexPath.row];//赋值文本
            NSMutableAttributedString * att =[[NSMutableAttributedString alloc] initWithString:cell.textContent.text];
            NSMutableParagraphStyle * para = [[NSMutableParagraphStyle alloc] init];
            para.lineSpacing = 5;
            [att addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, cell.textContent.text.length)];
            [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, cell.textContent.text.length)];
            cell.textContent.attributedText = att;
            CGFloat height = [att boundingRectWithSize:CGSizeMake(SCREEN_Width - 54 *SIZE, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
            [cell.textContent mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(27*SIZE);
                make.top.equalTo(cell.contentView).offset(9*SIZE);
                make.right.equalTo(cell.contentView).offset(-27*SIZE);
                make.height.mas_equalTo(height);
            }];
            [cell.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(cell.textContent.mas_bottom).offset(9 *SIZE);
            }];
            //            _contentLab.height = height;
            cell.textContent.hidden = NO;
        }else{
            
            cell.textContent.hidden = YES;
            cell.contentL.text = _titleArr[indexPath.row];
            [cell.contentL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(27*SIZE);
                make.top.equalTo(cell.contentView).offset(9*SIZE);
                make.right.equalTo(cell.contentView).offset(-27*SIZE);
            }];
            
            [cell.textContent mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(27*SIZE);
                make.top.equalTo(cell.contentView).offset(9*SIZE);
                make.right.equalTo(cell.contentView).offset(-27*SIZE);
            }];
            
            [cell.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(0);
                make.top.equalTo(cell.contentL.mas_bottom).offset(9 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(SIZE);
                make.bottom.equalTo(cell.contentView).offset(0);
            }];
        }
        
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"待确认详情";
    self.navBackgroundView.hidden = NO;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
    
    _invalidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _invalidBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    [_invalidBtn setBackgroundColor:CLBlueBtnColor];
    _invalidBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_invalidBtn addTarget:self action:@selector(ActionInValidBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_invalidBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.view addSubview:_invalidBtn];
    
    _CopyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _CopyBtn.frame = CGRectMake(0*SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 120 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    [_CopyBtn setBackgroundColor:COLOR(255, 188, 88, 1)];
    _CopyBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_CopyBtn addTarget:self action:@selector(ActionCopy:) forControlEvents:UIControlEventTouchUpInside];
    [_CopyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [self.view addSubview:_CopyBtn];
}

@end
