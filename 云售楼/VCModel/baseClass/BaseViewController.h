//
//  BaseViewController.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, ConfigState){
    BANK_TYPE=1, //银行类型
    CARD_TYPE=2, //证件类型
    COMMISSION_TYPE=3, //提成方式
    COMPLAINT_TYPE=4, //投诉方式
    COMPLAINT_RESOLVE_TYPE=5, //投诉解决方式
    CONTRACT_END_REASON=6, //合同终止原因
    ENABLED_TYPE=7, //禁用类型
    HOUSE_OLD=8,//房龄
    HOUSE_TYPE=9,//住房类型
    MONEY_TYPE=10,//货币类型
    OPEN_TYPE=11,//开盘方式
    BUY_TYPE=12,//置业目的
    PAY_WAY=13,//支付方式
    PROJECT_IMG_TYPE=14,//项目图片类型
    PROJECT_TAGS_DEFAULT=15,//项目标签默认
    PROPERTY_TYPE=16,//物业类型
    BUILD_TYPE=17,//建筑类型
    USER_DISABLED_TYPE=18,//用户失效类型
    FACE=19,//朝向
    LADDER_RATIO=20,//梯户比
    DECORATE=21, //装修标准、
    AVERAGE=22, //均价
    FOLLOW_TYPE=23,//跟进方式
    APPEAL_TYPE=24,   //申述类型
    TOTAL_PRICE = 25,    //总价
    AREA = 26,  //面积
    PAYMENT_FAIL=27,//佣金结算失败原因
    SERVICE_TEL=28,//客服电话
    VALUE_CONFIRM_DISABLED_TYPE=29,//有效来访判断失效类型
    RECODE_REPORT_TYPE=30,//房源报备联系人类型
    CHECK_WAY=31,//看房方式
    RECORD_DISABLED_TYPE=32,//报备确认无效类型
    HOUSE_DISABLED_RESON=33,//房源下架原因
    HOUSE_TAGS_HOUSE=34, //二手房住宅标签
    COMPANY_CHECK_FAIL_TYPE=35,//公司审核拒绝类型
    SYSTEM_FUNC=36,//系统功能(客户类型)
    RULE_TYPE=37,//规则类型
    BREACH_TYPE=38,//挞定类型
    FLOOR_TYPE=39,//楼层类型
    SHOP_TYPE=40,//商铺类型
    FORMAT_TAG=41,//业态标签
    OFFICE_GRADE=42,//写字楼等级
    BUY_USE=43,//购买用途
    HOUSE_TAGS_SHOP=44,//二手房商铺
    HOUSE_TAGS_OFFICE=45,//二手房写字楼标签
    RENT_DISABLED_TYPE=46,//租房失效类型
    RENT_TYPE=47,//租房类型
    RENT_HOUSE_RECEIVE_TYPE=48,//租房住宅收款类型
    RENT_SHOP_OFFICE_RECEIVE_TYPE=49,//租房商铺写字收款类型
    HOUSE_LEVEL=50,//住宅等级
    RENT_BREACH_TYPE=51, //租房挞定类型
    RENT_DISABLED_RESON=52, //租房下架原因
    TAKE_DISABLED_TYPE=53,//带看无效类型
    CLIENT_LEVEL=54,//客户等级
    TAKE_APPEAL=55,//带看申述类型
    TAKE_REPORT_TYPE=56,//带看联系人类型
    SELL_HOUSE_RESON=57,//卖房原因
    BUY_HOUSE_RESON=58,//买房原因
    TAKE_DEAL_AGENT_IDENTITY=59,//带看合同签约人类型
    TAKE_OVER_TYPE=60,//终止带看类型
    TAKE_DEAL_CANCEL_TYPE=61,//合同作废类型
    TAKE_DEAL_BUY_BREACH_TYPE=62,//买方毁约类型
    TAKE_DEAL_SALE_BREACH_TYPE=63//卖方毁约类型
};

@interface BaseViewController : UIViewController

//Nav背景
@property (nonatomic, strong)UIView *navBackgroundView;

@property (nonatomic, strong) UIImageView *navImg;

//Nav标题
@property (nonatomic, strong)UILabel *titleLabel;
//返回按钮
@property (nonatomic, strong)UIButton *leftButton;

@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, strong) UIView *line;

- (NSArray *)getDetailConfigArrByConfigState:(ConfigState)configState;

//返回按钮；
- (void)ActionMaskBtn:(UIButton *)btn;

//弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithCancelBlack:(void(^)(void))CancelBlack WithDefaultBlack:(void(^)(void))defaultBlack;

- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithDefaultBlack:(void(^)(void))defaultBlack;

//没有点击效果的弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1;

/**
 *  检查输入的手机号正确与否
 */
- (BOOL)checkTel:(NSString *)str;

/**
 *  检查输入的是否是数字
 */
- (BOOL)validateNumber:(NSString*)number;

/**
 *  检查输入的身份证号正确与否
 */
- (BOOL)validateIDCardNumber:(NSString *)value;

/**
 *  截取身份证的出生日期并转换为日期格式
 */
- (NSString *)subsIDStrToDate:(NSString *)str;

/**
 *  身份证号辨别男女
 */
- (NSInteger)genderOfIDNumber:(NSString *)IDNumber;

- (void)showContent:(NSString *)str;

- (NSString *)md5:(NSString *)str;

- (BOOL)isEmpty:(NSString *)str;

//图片压缩至希望的大小
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

//拍照后对图片进行处理
- (UIImage *)fixOrientation:(UIImage *)aImage;

- (NSString *)base64EncodeString:(NSString *)string;

- (NSString *)base64DecodeString:(NSString *)string;

- (double)DecimalNumber:(double)num1 num2:(double)num2;

- (double)AddNumber:(double)num1 num2:(double)num2;

- (double)MultiplyingNumber:(double)num1 num2:(double)num2;

//某个时间的几个月后
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month;

//两个时间的月差
- (NSInteger)getMonthFromDate:(NSDate *)date1 withDate2:(NSDate *)date2;
@end

NS_ASSUME_NONNULL_END
