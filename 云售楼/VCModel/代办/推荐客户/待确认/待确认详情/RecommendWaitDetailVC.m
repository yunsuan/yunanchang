//
//  RecommendWaitDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/10.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RecommendWaitDetailVC.h"

#import "CountDownCell.h"

@interface RecommendWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_data;
}
@end

@implementation RecommendWaitDetailVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
//    [self post];
}


-(void)initDataSouce{
    _titleArr = @[@"推荐信息",@"判重信息"];
    _data = @[];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(post) name:@"reloadCustom" object:nil];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
}

#pragma mark    -----  delegate   ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
//    if (_checkArr.count) {
//
//        if (_sign) {
//
//            return _data.count + 2;
//        }
        return _data.count + 1;
//    }else{
//
//        if (_sign) {
//
//            return _data.count + 1;
//        }
//        return _data.count;
//    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    if (section == 0) {
    
        NSArray *arr = _data[section];
        return arr.count? arr.count + 1:0;
//    }else{
//
//        if (section == 1) {
//
//            if (_checkArr.count) {
//
//                return _checkArr.count;
//            }else{
//
//                return _arrArr.count;
//            }
//        }else{
//
//            return _arrArr.count;
//        }
//    }
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
//    backview.backgroundColor = [UIColor whiteColor];
//    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
//    header.backgroundColor = CLBlueBtnColor;
//    [backview addSubview:header];
//    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
//    title.font = [UIFont systemFontOfSize:15.3*SIZE];
//    title.textColor = YJTitleLabColor;
//    //    title.text = _titleArr[section];
//
//    if (section == 0) {
//
//        title.text = _titleArr[section];
//    }else{
//
//        if (section == 1) {
//
//            if (_checkArr.count) {
//
//                title.text = @"判重信息";
//            }else{
//
//                title.text = @"到访信息";
//            }
//        }else{
//
//            title.text = @"到访信息";
//        }
//    }
//    [backview addSubview:title];
//    return backview;
//}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CountDownCell";
    CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
    cell.countDownCellBlock = ^{
        
//        [self refresh];
    };
    //            [cell setcountdownbyendtime:_endtime];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"确认中详情";
    
    
    
}



@end
