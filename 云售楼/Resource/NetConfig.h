//
//  NetConfig.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#ifndef NetConfig_h
#define NetConfig_h

//新服务器
static NSString *const TestBase_Net = @"http://120.27.21.136:2798/";

#pragma mark --- 登录注册 ---

//登录
static NSString *const Login_URL = @"saleApp/login";

#pragma mark ---  工作  ---

#pragma mark -- 签字流程 --

//签字有效
static NSString *const AgentSignValue_URL = @"agent/sign/value";

//签字下一阶段人员
static NSString *const AgentSignNextAgent_URL = @"agent/sign/nextAgent";

//x签字无效
static NSString *const AgentSignDisabled_URL = @"agent/sign/disabled";

//获取推荐客户需求信息
static NSString *const AgentProjectClientNeedGet_URL = @"agent/project/client/need/get";

//获取项目配置字段
static NSString *const ProjectConfigColunm_URL = @"user/project/config/column";

//修改推荐客户需求信息
static NSString *const ProjectClientNeedUpdate_URL = @"agent/project/client/need/update";
//static NSString *const RecommendList_URL = @"agent/work/getRecommendList";

//经纪人信息统计
static NSString *const AgentInfoCount_URL = @"agent/work/broker/count";


static NSString *const Butterinfocount_URL = @"agent/work/butter/count";

//确认所需字段
static NSString *const ClientNeedInfo_URL = @"agent/client/needInfo";

//更新数据
static NSString *const FlushDate_URL = @"agent/work/flushDate";

//经纪人信息统计
//static NSString *const BrokerCount_URL = @"agent/work/broker/count";

//对接人信息统计
//static NSString *const ButterCount_URL = @"agent/work/butter/count";

//经纪人待确认客户列表
static NSString *const BrokerWaitConfirm_URL = @"agent/work/broker/waitConfirm";

//经纪人有效到访客户列表
static NSString *const BrokerValue_URL = @"agent/work/broker/value";

//经纪人无效列表
static NSString *const BrokerDisabled_URL = @"agent/work/broker/disabled";

//申诉
static NSString *const ClientAppeal_URL = @"agent/client/appeal";

//经纪人申诉列表
static NSString *const BrokerAppeal_URL = @"agent/work/broker/appeal";

//经纪人申诉详情
static NSString *const BrokerAppealDetail_URL = @"agent/work/broker/appealDetail";

//对接经纪人判断为有效到访
static NSString *const ConfirmValue_URL = @"agent/client/confirmValue";

//对接经纪人判断为无效
static NSString *const ConfirmDisabled_URL = @"agent/client/confirmDisabled";

//经纪人待确认客户详细
static NSString *const WaitConfirmDetail_URL = @"agent/work/broker/waitConfirmDetail";

//经纪人无效客户详细
static NSString *const DisabledDetail_URL = @"agent/work/broker/disabledDetail";

//获取申诉信息
//static NSString *const AppealGetOne_URL = @"agent/appeal/getOne";

//取消申诉
static NSString *const AppealCancel_URL = @"agent/client/appealCancel";

//经纪人有效到访客户详细
static NSString *const ValueDetail_URL = @"agent/work/broker/valueDetail";

//项目待确认列表
static NSString *const ProjectWaitConfirm_URL = @"agent/work/project/waitConfirm";

//项目待确认详情
static NSString *const ProjectWaitConfirmDetail_URL = @"agent/work/project/waitConfirmDetail";

//项目有效列表
static NSString *const ProjectValue_URL = @"agent/work/project/value";

//项目有效详情
static NSString *const ProjectValueDetail_URL = @"agent/work/project/valueDetail";

//项目失效列表
static NSString *const ProjectDisabled_URL = @"agent/work/project/disabled";

//项目失效详情
static NSString *const ProjectDisabledDetail_URL = @"agent/work/project/disabledDetail";

//项目申诉列表
static NSString *const ProjectAppealList_URL = @"agent/work/project/appealList";

//经纪人待成交列表
static NSString *const ProjectWaitDeal_URL = @"agent/work/project/waitDeal";

//经纪人待成交详细
static NSString *const ProjectWaitDealDetail_URL = @"agent/work/project/waitDealDetail";

//经纪人成交列表
static NSString *const ProjectDealList_URL = @"agent/work/project/deal";

//经纪人成交详情
static NSString *const ProjectDealDetail_URL = @"agent/work/project/dealDetail";

//经纪人成交失效列表
static NSString *const ProjectDealDisableList_URL = @"agent/work/project/dealDisabled";

//经纪人成交失效详情
static NSString *const ProjectDeailDisableDetail_URL = @"agent/work/project/dealDisabledDetail";

//经纪人成交申诉列表
static NSString *const ProjectDealAppealList_URL = @"agent/work/project/dealAppealList";

//对接人待确认列表
static NSString *const ButterWaitConfirm_URL = @"agent/work/butter/waitConfirm/v3.5";

//对接人有效列表
static NSString *const ButterValue_URL = @"agent/work/butter/value";

//对接人无效客户列表
static NSString *const ButterDisabled_URL = @"agent/work/butter/disabled";

#pragma mark -- 二次确认 --

//待确认列表
static NSString *const ButterTelConfirmList_URL = @"agent/work/butter/tel/confirm/list";

//待确认详情
static NSString *const ButterTelConfirmDetail_URL = @"agent/work/butter/tel/confirm/detail";

//号码有效
static NSString *const ClientTelCheckValue_URL = @"agent/client/telCheckValue";

//号码重复
static NSString *const ClientTelCheckDisabled_URL = @"agent/client/telCheckDisabled";

//有效列表
static NSString *const ButterTelValueList_URL = @"agent/work/butter/tel/value/list";

//有效详情
static NSString *const ButterTelValueDetail_URL = @"agent/work/butter/tel/value/detail";

//无效列表
static NSString *const ButterTelDisabledList_URL = @"agent/work/butter/tel/disabled/list";

#pragma mark --- 我的 ---

#pragma mark -- 公司 --

//获取公司下项目及角色
static NSString *const CompanyPersonOrganizePostList_URL = @"saleApp/company/person/organize/post/list";

//获取公司列表
static NSString *const PersonalGetCompanyList_URL = @"saleApp/personal/getCompanyList";

//获取部门列表
static NSString *const CompanyPersonOrganizeList_URL = @"saleApp/company/person/organize/list";


#endif /* NetConfig_h */
