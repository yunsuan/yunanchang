//
//  RotationSettingVC.m
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RotationSettingVC.h"

@interface RotationSettingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *SettingTable;

@property (nonatomic , strong) UIButton *SureBtn;

@end

@implementation RotationSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

- (void)initUI{
    
    self.titleLabel.text = @"轮岗设置";
    
    self.leftButton.hidden = NO;
   
}





@end
