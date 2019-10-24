//
//  WeekCountVC.m
//  云售楼
//
//  Created by xiaoq on 2019/10/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WeekCountVC.h"

#import "myDataGridView.h"
#import "ZQDataGridHeadItemModel.h"
#import "ZQDataGridLeftTableViewCellModel.h"

#import "DateChooseView.h"

#import "WeekCountCell.h"

@interface WeekCountVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    NSString *_project_id;
    NSString *_firstDay;
    NSString *_oneDay;
    NSString *_lastDay;
    NSString *_sevenDay;
    
    NSDate *_date;
    NSDateFormatter *_formatter;
    
    NSArray *_titleArr;
    
    NSMutableArray *_dataArr;
    
    NSMutableDictionary *_dataDic;
}
@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *timeBtn;

@property (nonatomic, strong) myDataGridView *dataGridView;

@end

@implementation WeekCountVC

- (instancetype)initWithProjectId:(NSString *)project_id
{
    self = [super init];
    if (self) {
        
        _project_id = project_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
//    [self RequestMethod];
}


- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY年MM月dd日"];
    
    _date = [NSDate date];
    [self getWeekBeginAndEndWith:_date];
    _dataDic = [@{} mutableCopy];
    _dataArr = [@[] mutableCopy];
    for (int i = 0; i < 8; i++) {
        
        NSMutableArray *tempArr = [@[] mutableCopy];
        for (int j = 0; j < 8; j++) {
            
            [tempArr addObject:@"0"];
        }
        [_dataArr addObject:tempArr];
    }
    _titleArr = @[@"来电",@"来访",@"排号",@"认购",@"合同",@"排号金额",@"定单金额",@"合同金额"];
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
    view.dateblock = ^(NSDate *date) {
        
        [self getWeekBeginAndEndWith:date];
    };
    [self.view addSubview:view];
}

- (void)getWeekBeginAndEndWith:(NSDate *)newDate{

//    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:newDate];

    // 获取今天是周几
    NSInteger weekDay = [comp weekday];

    /**获取当前几个月*/
    NSInteger monthDay = [comp month];
    NSLog(@"%ld",monthDay);

    // 获取几天是几号
    NSInteger day = [comp day];
    NSLog(@"%ld----%ld",weekDay,day);

    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    if (weekDay == 1){

        firstDiff = -6;
        lastDiff = 0;
    }else{

        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }

    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:newDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:newDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"YYYYMMdd"];

    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    _oneDay = [formatter1 stringFromDate:firstDayOfWeek];
    _sevenDay = [formatter1 stringFromDate:lastDayOfWeek];
    NSLog(@"%@=======%@",firstDay,lastDay);

    NSString *dateStr = [NSString stringWithFormat:@"%@-%@",firstDay,lastDay];
    self.timeL.text = [NSString stringWithFormat:@"%@-%@",[_formatter stringFromDate:firstDayOfWeek],[_formatter stringFromDate:lastDayOfWeek]];

    _firstDay = [NSString stringWithFormat:@"%@ 00:00:00",firstDay];
    _lastDay = [NSString stringWithFormat:@"%@ 23:59:59",lastDay];
    NSLog(@"%@",dateStr);
    [self RequestMethod];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id}];
    [dic setValue:_firstDay forKey:@"start_time"];
    [dic setValue:_lastDay forKey:@"end_time"];
    [BaseRequest GET:ReportSaleDateCount_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
                
            self->_dataArr = [@[] mutableCopy];
            for (int i = 0; i < 8; i++) {
                
                NSMutableArray *tempArr = [@[] mutableCopy];
                for (int j = 0; j < 8; j++) {
                    
                    [tempArr addObject:@"0"];
                }
                [self->_dataArr addObject:tempArr];
            }
            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            
            if ([self->_dataDic[@"clientTel"] count]) {
                
                NSInteger count = 0;
                for (NSDictionary *dic in self->_dataDic[@"clientTel"]) {
                    
                    count = count + [dic[@"count"] integerValue];
                    NSInteger day = [self->_oneDay integerValue];
                    for (int i = 0; i < 7; i++) {
                        
                        if (day == [dic[@"days"] integerValue]) {
                            
                            NSMutableArray *tempArr = self->_dataArr[0];
                            [tempArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@",dic[@"count"]]];
                            [self->_dataArr replaceObjectAtIndex:0 withObject:tempArr];
                        }
                        day ++;
                    }
                }
                NSMutableArray *tempArr = self->_dataArr[0];
                [tempArr replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%ld",count]];
                [self->_dataArr replaceObjectAtIndex:0 withObject:tempArr];
            }
            if ([self->_dataDic[@"clientVisit"] count]) {
                
                NSInteger count = 0;
                for (NSDictionary *dic in self->_dataDic[@"clientVisit"]) {
                    
                    count = count + [dic[@"count"] integerValue];
                    NSInteger day = [self->_oneDay integerValue];
                    for (int i = 0; i < 7; i++) {
                        
                        if (day == [dic[@"days"] integerValue]) {
                            
                            NSMutableArray *tempArr = self->_dataArr[1];
                            [tempArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@",dic[@"count"]]];
                            [self->_dataArr replaceObjectAtIndex:1 withObject:tempArr];
                        }
                        day ++;
                    }
                }
                NSMutableArray *tempArr = self->_dataArr[1];
                [tempArr replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%ld",count]];
                [self->_dataArr replaceObjectAtIndex:1 withObject:tempArr];
            }
            if ([self->_dataDic[@"row"] count]) {
                
                NSInteger count = 0;
                double money = 0.0;
                for (NSDictionary *dic in self->_dataDic[@"row"]) {
                    
                    count = count + [dic[@"count"] integerValue];
                    NSInteger day = [self->_oneDay integerValue];
                    money = money + [dic[@"down_pay"] doubleValue];
                    for (int i = 0; i < 7; i++) {
                        
                        if (day == [dic[@"days"] integerValue]) {
                            
                            NSMutableArray *tempArr = self->_dataArr[2];
                            [tempArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@",dic[@"count"]]];
                            NSMutableArray *tempArr1 = self->_dataArr[5];
                            [tempArr1 replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@",dic[@"down_pay"]]];
                            [self->_dataArr replaceObjectAtIndex:2 withObject:tempArr];
                            [self->_dataArr replaceObjectAtIndex:5 withObject:tempArr1];
                        }
                        day ++;
                    }
                }
                NSMutableArray *tempArr = self->_dataArr[2];
                [tempArr replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%ld",count]];
                NSMutableArray *tempArr1 = self->_dataArr[5];
                [tempArr1 replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%.2f",money]];
                [self->_dataArr replaceObjectAtIndex:2 withObject:tempArr];
                [self->_dataArr replaceObjectAtIndex:5 withObject:tempArr1];
            }
            if ([self->_dataDic[@"sub"] count]) {
                
                NSInteger count = 0;
                double money = 0.0;
                for (NSDictionary *dic in self->_dataDic[@"sub"]) {
                    
                    count = count + [dic[@"count"] integerValue];
                    NSInteger day = [self->_oneDay integerValue];
                    money = money + [dic[@"down_pay"] doubleValue];
                    for (int i = 0; i < 7; i++) {
                        
                        if (day == [dic[@"days"] integerValue]) {
                            
                            NSMutableArray *tempArr = self->_dataArr[3];
                            [tempArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@",dic[@"count"]]];
                            NSMutableArray *tempArr1 = self->_dataArr[6];
                            [tempArr1 replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@",dic[@"down_pay"]]];
                            [self->_dataArr replaceObjectAtIndex:3 withObject:tempArr];
                            [self->_dataArr replaceObjectAtIndex:6 withObject:tempArr1];
                        }
                        day ++;
                    }
                }
                NSMutableArray *tempArr = self->_dataArr[3];
                [tempArr replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%ld",count]];
                NSMutableArray *tempArr1 = self->_dataArr[6];
                [tempArr1 replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%.2f",money]];
                [self->_dataArr replaceObjectAtIndex:3 withObject:tempArr];
                [self->_dataArr replaceObjectAtIndex:6 withObject:tempArr1];
            }
            if ([self->_dataDic[@"contract"] count]) {
                
                NSInteger count = 0;
                double money = 0.0;
                for (NSDictionary *dic in self->_dataDic[@"contract"]) {
                    
                    count = count + [dic[@"count"] integerValue];
                    NSInteger day = [self->_oneDay integerValue];
                    money = money + [dic[@"down_pay"] doubleValue];
                    for (int i = 0; i < 7; i++) {
                        
                        if (day == [dic[@"days"] integerValue]) {
                            
                            NSMutableArray *tempArr = self->_dataArr[4];
                            [tempArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@",dic[@"count"]]];
                            NSMutableArray *tempArr1 = self->_dataArr[7];
                            [tempArr1 replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@",dic[@"down_pay"]]];
                            [self->_dataArr replaceObjectAtIndex:4 withObject:tempArr];
                            [self->_dataArr replaceObjectAtIndex:7 withObject:tempArr1];
                        }
                        day ++;
                    }
                }
                NSMutableArray *tempArr = self->_dataArr[4];
                [tempArr replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%ld",count]];
                NSMutableArray *tempArr1 = self->_dataArr[7];
                [tempArr1 replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%.2f",money]];
                [self->_dataArr replaceObjectAtIndex:4 withObject:tempArr];
                [self->_dataArr replaceObjectAtIndex:7 withObject:tempArr1];
            }
//            [self->_table reloadData];
            [self.dataGridView reloadData:[self getDataModel]];
        }else{
                
            _dataArr = [@[] mutableCopy];
            for (int i = 0; i < 8; i++) {
                
                NSMutableArray *tempArr = [@[] mutableCopy];
                for (int j = 0; j < 8; j++) {
                    
                    [tempArr addObject:@"0"];
                }
                [_dataArr addObject:tempArr];
            }
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
                    
        _dataArr = [@[] mutableCopy];
        for (int i = 0; i < 8; i++) {
            
            NSMutableArray *tempArr = [@[] mutableCopy];
            for (int j = 0; j < 8; j++) {
                
                [tempArr addObject:@"0"];
            }
            [_dataArr addObject:tempArr];
        }
        [self showContent:@"网络错误"];
    }];
}


#pragma -mark h获取右侧头部的数据 其类型与右侧的 大cell 类型一致亦可自定义item
- (ZQDataGridRightTableViewCellModel *)getrightHeadModel{
    
    ZQDataGridRightTableViewCellModel * headDataModel = [[ZQDataGridRightTableViewCellModel alloc]init];
    headDataModel.collectionViewCellClass = @"ZQDataGridHeadItemCell";
    headDataModel.setDataMethodName = @"setItemModel:";
    headDataModel.itemModelArray = [self getHeadModelItemArray];
    return headDataModel;
}

#pragma -mark 获取表头数据
- (NSArray *)getHeadModelItemArray{
    NSMutableArray * itemArray = [[NSMutableArray alloc]init];
    
    for ( int i = 0; i < 8; i++) {
        ZQDataGridHeadItemModel * itemModel = [[ZQDataGridHeadItemModel alloc]init];
        itemModel.numOfColumnNumIndex = i;
        itemModel.backgroundColor = CLBackColor;
        itemModel.titleString = _titleArr[i];
        [itemArray addObject:itemModel];
    }
    return itemArray;
}

#pragma -mark 获取每列的宽度
- (NSMutableArray *)getColumnWidthArray{
    
    NSMutableArray * array = [NSMutableArray new];
    for (int i = 0; i < 8; i++) {
        
        if (i > 4) {
            
            [array addObject:@(140 *SIZE)];
        }else{
            
            [array addObject:@(70 *SIZE)];
        }
    }
    return array;
}

#pragma -mark 获取每一行中collocationView item 的小数据源
- (NSArray *)getItemModelArrayWithRowNum:(NSInteger)rowNum{
    NSMutableArray * itemArray = [[NSMutableArray alloc]init];
    for ( int i = 0; i < 8; i++) {
        
        ZQDataGridLeftTableViewCellModel * itemModel = [[ZQDataGridLeftTableViewCellModel alloc]init];
        itemModel.numOfColumnNumIndex = i;
        itemModel.numOfRowIndex = rowNum;
        itemModel.titleString = _dataArr[i][rowNum];
        [itemArray addObject:itemModel];
    }
    return itemArray;
}

#pragma -mark 组装表格数据模型
- (ZQDataGridComponentModel *)getDataModel{
    
    ZQDataGridComponentModel * dataModel = [[ZQDataGridComponentModel alloc]init];
    dataModel.firstRowHeight = 40.0f;
    dataModel.firstColumnWidth = 80.0f;
    dataModel.rowHeight = 70.0f;
    // 获取表格右侧表头数据
    ZQDataGridRightTableViewCellModel * headModel = [self getrightHeadModel];
    
    // 列宽数组
    NSMutableArray * columnWidthArray = [self getColumnWidthArray];
    // 坐标数据模型数组
    NSMutableArray * leftTableDataArray = [[NSMutableArray alloc]init];
    // 右侧数据模型数组
    NSMutableArray * rowDataArray = [[NSMutableArray alloc]init];
    
    // 根据房间数构造需要的行数据
    for (int i = 0 ; i < 8; i++) {
        // 左侧列表数据
        ZQDataGridLeftTableViewCellModel * model = [[ZQDataGridLeftTableViewCellModel alloc]init];
        if (i == 7) {
            
            model.titleString = @"汇总";
        }else{
            
            model.titleString = [NSString stringWithFormat:@"%d",i + 1];
        }
        [leftTableDataArray addObject:model];
      
        
        // 右侧列表数据
        ZQDataGridRightTableViewCellModel * rowModel = [[ZQDataGridRightTableViewCellModel alloc]init];
        rowModel.numOfRowIndex = i;
        rowModel.numOfColumnNumIndex = 0;
        rowModel.collectionViewCellClass = @"NomalCollectionViewCell";
        rowModel.setDataMethodName = @"setItemModel:";
        rowModel.itemModelArray = [self getItemModelArrayWithRowNum:i];
        [rowDataArray addObject:rowModel];
    }
    
    dataModel.headDataModel = headModel;
    dataModel.leftTableDataArray = leftTableDataArray;
    dataModel.rowDataArray = rowDataArray;
    dataModel.columnWidthArray = columnWidthArray;
    
    
    return dataModel;
}

#pragma -mark 表格事件处理
- (void)eventDealwithActionType:(ZQDataGridComponentClickType)type row:(NSInteger)row column:(NSInteger)column tagetView:(UIView *)tagetView{
    NSString * moudle = @"";
    if (type == ZQDataGridComponentClickTypeHead) {
        moudle = @"头部视图";
    }else if (type == ZQDataGridComponentClickTypeLeftTab){
        moudle = @"头部左侧列表";
    }else if (type == ZQDataGridComponentClickTypeRightTab){
        moudle = @"头部右侧列表";
    }
    
    NSLog(@"点击了 %@ 行号：%ld 列号：%ld  tagViewClass:%@",moudle,row,column,[tagetView class]);
}

- (void)initUI{
    
    self.titleLabel.text = @"销售周汇总表";
    
    self.view.backgroundColor = CLWhiteColor;
    
    [self.view addSubview:self.timeL];
    
    _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _timeBtn.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE);
    [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeBtn];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scroll.delegate = self;
    _scroll.bounces = NO;
    [_scroll setContentSize:CGSizeMake(120 *SIZE * 3, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
//    [self.view addSubview:_scroll];
    [self.view addSubview:self.dataGridView];

}

- (UILabel *)timeL{
    
    if (!_timeL) {
        
        _timeL = [[UILabel alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 13 *SIZE, SCREEN_Width, 20 *SIZE)];
        _timeL.textAlignment = NSTextAlignmentCenter;
        _timeL.font = FONT(13 *SIZE);
        _timeL.textColor = CLBlueTitleColor;
    }
    return _timeL;
}

- (myDataGridView *)dataGridView{
    
    if (!_dataGridView) {
        _dataGridView = [[myDataGridView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 50 *SIZE, self.view.width, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - 50 *SIZE) dataSource:[self getDataModel]];
       
        Weak(self);
        _dataGridView.itemClick = ^(ZQDataGridComponentClickType type, NSInteger row, NSInteger column, UIView *tagetView) {
            [weakself eventDealwithActionType:type row:row column:column tagetView:tagetView];
        };
        
//        if (self.type == 5) {
//
//            _dataGridView.rightTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//                NSLog(@"下拉刷新");
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [weakself.dataGridView.rightTableView.mj_header endRefreshing];
//                });
//            }];
//
//            _dataGridView.rightTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
//                NSLog(@"上拉加载");
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [weakself.dataGridView.rightTableView.mj_footer endRefreshingWithNoMoreData];
//                });
//            }];
//
//            // 不让mj 自适应宽度
//            _dataGridView.rightTableView.mj_header.autoresizingMask = UIViewAutoresizingNone;
//             // 设置mj宽度
//            _dataGridView.rightTableView.mj_header.mj_w = SCREEN_WIDTH;
//            _dataGridView.rightTableView.mj_header.mj_x = -_dataGridView.dataModel.firstColumnWidth;
//
//            _dataGridView.rightTableView.mj_footer.autoresizingMask = UIViewAutoresizingNone;
//            _dataGridView.rightTableView.mj_footer.mj_w = SCREEN_WIDTH;
//            _dataGridView.rightTableView.mj_footer.mj_x = -_dataGridView.dataModel.firstColumnWidth;
//        }
        
        
    }
    return _dataGridView;
}

@end
