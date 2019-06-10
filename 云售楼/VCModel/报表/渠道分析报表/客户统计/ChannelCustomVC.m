//
//  ChannelCustomVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelCustomVC.h"

#import "ChannelRecommendVC.h"
#import "ChannelVisitVC.h"
#import "ChannelDealVC.h"

#import "TypeTagCollCell.h"

@interface ChannelCustomVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSString *_endTime;
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) ChannelRecommendVC *channelRecommendVC;

@property (nonatomic, strong) ChannelVisitVC *channelVisitVC;

@property (nonatomic, strong) ChannelDealVC *channelDealVC;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ChannelCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0] animated:NO scrollPosition:0];
    [_scrollView setContentOffset:CGPointMake(SCREEN_Width * self.index, 0) animated:NO];
}

- (void)initDataSource{
    
    _titleArr = @[@"推荐客户",@"到访客户",@"成交客户"];
}

- (void)action_add{
    
    //    QuickAddCustomVC *nextVC = [[QuickAddCustomVC alloc] initWithProjectId:[NSString stringWithFormat:@"%@",@""] clientId:@""];
    //    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionRecommendReload{
    
//    [_workRecommendWaitVC RequestMethod];
//    [_workRecommendValidVC RequestMethod];
//    [_workRecommendFailVC RequestMethod];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSInteger index = _scrollView.contentOffset.x / SCREEN_Width;
    switch (index) {
        case 0:
        {
            _channelRecommendVC.search = textField.text;
            [_channelRecommendVC RequestMethod];
            break;
        }
        case 1:
        {
            _channelVisitVC.search = textField.text;
            [_channelVisitVC RequestMethod];
            break;
        }
        case 2:
        {
            _channelDealVC.search = textField.text;
            [_channelDealVC RequestMethod];
            break;
        }
        default:
            break;
    }
    return YES;
}


#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TypeTagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeTagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TypeTagCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 3, 40 *SIZE)];
        cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 3, 11 *SIZE);
        cell.line.frame = CGRectMake(42 *SIZE, 38 *SIZE, 28 *SIZE, 2 *SIZE);
    }
    
    cell.titleL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [_scrollView setContentOffset:CGPointMake(SCREEN_Width * indexPath.item, 0) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_Width;
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
}
- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
//    self.titleLabel.text = @"推荐客户";
    self.line.hidden = YES;
    
    self.rightBtn.hidden = NO;
    if (self.date.length) {
        
        _endTime = self.date;
        [self.rightBtn setTitle:[NSString stringWithFormat:@"%@-%@",self.date,_endTime] forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = CLLineColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.delegate = self;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入电话/姓名";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 3, 40 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = [UIColor whiteColor];
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[TypeTagCollCell class] forCellWithReuseIdentifier:@"TypeTagCollCell"];
    [self.view addSubview:_segmentColl];
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 81 *SIZE, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 81 *SIZE)];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 80 *SIZE);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 80 *SIZE, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 80 *SIZE)];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT - 80 *SIZE);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    _channelRecommendVC = [[ChannelRecommendVC alloc] init];
    _channelRecommendVC.project_id = self->_project_id;
    if (self.date.length) {
        
        _channelRecommendVC.date = self.date;
        _channelRecommendVC.endTime = self.date;
    }
    _channelVisitVC = [[ChannelVisitVC alloc] init];
    _channelVisitVC.project_id = self->_project_id;
    if (self.date.length) {
        
        _channelRecommendVC.date = self.date;
        _channelRecommendVC.endTime = self.date;
    }
    _channelDealVC = [[ChannelDealVC alloc] init];
    if (self.date.length) {
        
        _channelRecommendVC.date = self.date;
        _channelRecommendVC.endTime = self.date;
    }
    _channelDealVC.project_id = self->_project_id;
    
    // 添加为self的子控制器
    [self addChildViewController:_channelRecommendVC];
    [self addChildViewController:_channelVisitVC];
    [self addChildViewController:_channelDealVC];
    
    _channelRecommendVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _channelVisitVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _channelDealVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    [self.scrollView addSubview:_channelRecommendVC.view];
    [self.scrollView addSubview:_channelVisitVC.view];
    [self.scrollView addSubview:_channelDealVC.view];
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

@end
