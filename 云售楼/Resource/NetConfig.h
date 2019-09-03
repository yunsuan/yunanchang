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
//static NSString *const TestBase_Net = @"http://120.27.21.136:2798/";

static NSString *const TestBase_Net = @"http://47.107.246.94/";

#pragma mark --- 登录注册 ---

//登录
static NSString *const Login_URL = @"saleApp/login";

//2验证码
static NSString *const Captcha_URL = @"saleApp/captcha";

//3注册
static NSString *const Register_URL = @"saleApp/user/register";

//4忘记密码
static NSString *const ForgetPassWord_URL = @"user/resetPassword";

#pragma mark ---  配置  ---

//权限
static NSString *const PersonProjectRoleProjectPower_URL = @"saleApp/person/project/role/projectPower";

//项目字段配置
static NSString *const WorkClientAutoColumnConfig_URL = @"saleApp/work/client/auto/column/config";

//获取基础信息配置
static NSString *const WorkClientAutoBasicConfig_URL = @"saleApp/work/client/auto/basic/config";

//获取配置信息下选择类型字段配置项
static NSString *const ProjectConfigPropertyConfigOptionList_URL = @"saleApp/project/config/property/config/option/list";

//获取物业类型下需求字段
static NSString *const ProjectConfigPropertyConfigList_URL = @"saleApp/project/config/property/config/list";

//到访确认获取项目置业顾问
static NSString *const ProjectGetAdvicer_URL = @"user/project/getAdvicer";

#pragma mark ---  待办  ---

//清空消息
static NSString *const HandleEmptyMessage_URL = @"saleApp/handle/emptyMessage";

//获取待办首页
static NSString *const HandleGetMessageList_URL = @"saleApp/handle/getMessageList";

#pragma mark ---  房源  ---

//获取批次楼栋
static NSString *const ProjectHouseGetBuildList_URL =  @"saleApp/project/house/getBuildList";

//获取房源详情
static NSString *const ProjectHouseGetDetail_URL =  @"/saleApp/project/house/getHouseDetail";

//获取房源具体信息
static NSString *const ProjectHouseGetDetailInfo_URL =  @"/saleApp/project/house/getHouseInfo";



#pragma mark ---  工作  ---

//统计
static NSString *const WorkCount_URL = @"saleApp/work/count";



#pragma mark -- 来电 --

//来电来访列表
static NSString *const WorkClientAutoList_URL = @"saleApp/work/client/auto/list";

//获取客户详情
static NSString *const WorkClientAutoDetail_URL = @"saleApp/work/client/auto/detail";

//新增客户
static NSString *const ProjectClientAutoAdd_URL = @"saleApp/work/client/auto/add";

//新增组员客户
static NSString *const WorkClientAutoClientAdd_URL = @"saleApp/work/client/auto/client/add";

//修改客户信息
static NSString *const WorkClientAutoClientUpdate_URL = @"saleApp/work/client/auto/client/update";

//新增需求信息
static NSString *const WorkClientAutoNeedAdd_URL = @"saleApp/work/client/auto/need/add";

//修改需求信息
static NSString *const WorkClientAutoNeedUpdate_URL = @"saleApp/work/client/auto/need/update";

//删除需求信息
static NSString *const WorkClientAutoNeedDel_URL = @"saleApp/work/client/auto/need/del";

//修改组信息
static NSString *const WorkClientAutoGroupUpdate_URL = @"saleApp/work/client/auto/group/update";


//添加跟进记录
static NSString *const WorkClientAutoFollowAdd_URL = @"saleApp/work/client/auto/follow/add";

//删除跟进记录
static NSString *const WorkClientAutoFollowDelete_URL = @"saleApp/work/client/auto/follow/delete";

//号码判重
static NSString *const TelRepeatCheck_URL = @"saleApp/tel/repeatCheck";
#pragma mark -- 签字流程 --

//签字有效
static NSString *const AgentSignValue_URL = @"saleApp/sign/value";

//签字下一阶段人员
static NSString *const AgentSignNextAgent_URL = @"saleApp/sign/nextAgent";

//x签字无效
static NSString *const AgentSignDisabled_URL = @"saleApp/sign/disabled";

//获取推荐客户需求信息
static NSString *const AgentProjectClientNeedGet_URL = @"saleApp/project/client/need/get";

//获取项目配置字段
static NSString *const ProjectConfigColunm_URL = @"user/project/config/column";

//修改推荐客户需求信息
static NSString *const ProjectClientNeedUpdate_URL = @"saleApp/project/client/need/update";
//static NSString *const RecommendList_URL = @"agent/work/getRecommendList";

//经纪人信息统计
static NSString *const AgentInfoCount_URL = @"saleApp/work/broker/count";


static NSString *const Butterinfocount_URL = @"saleApp/work/butter/count";

//确认所需字段
static NSString *const ClientNeedInfo_URL = @"saleApp/client/needInfo";

//更新数据
static NSString *const FlushDate_URL = @"saleApp/work/flushDate";

//经纪人信息统计
//static NSString *const BrokerCount_URL = @"agent/work/broker/count";

//对接人信息统计
//static NSString *const ButterCount_URL = @"agent/work/butter/count";

//经纪人待确认客户列表
static NSString *const BrokerWaitConfirm_URL = @"saleApp/work/broker/waitConfirm";

//经纪人有效到访客户列表
static NSString *const BrokerValue_URL = @"saleApp/work/broker/value";

//经纪人无效列表
static NSString *const BrokerDisabled_URL = @"saleApp/work/broker/disabled";

//申诉
static NSString *const ClientAppeal_URL = @"saleApp/client/appeal";

//经纪人申诉列表
static NSString *const BrokerAppeal_URL = @"saleApp/work/broker/appeal";

//经纪人申诉详情
static NSString *const BrokerAppealDetail_URL = @"saleApp/work/broker/appealDetail";

//对接经纪人判断为有效到访
static NSString *const ConfirmValue_URL = @"saleApp/client/confirmValue";

//对接经纪人判断为无效
static NSString *const ConfirmDisabled_URL = @"saleApp/client/confirmDisabled";

//经纪人待确认客户详细
static NSString *const WaitConfirmDetail_URL = @"saleApp/work/broker/waitConfirmDetail";

//经纪人无效客户详细
static NSString *const DisabledDetail_URL = @"saleApp/work/broker/disabledDetail";

//获取申诉信息
//static NSString *const AppealGetOne_URL = @"agent/appeal/getOne";

//取消申诉
static NSString *const AppealCancel_URL = @"saleApp/client/appealCancel";

//经纪人有效到访客户详细
static NSString *const ValueDetail_URL = @"saleApp/work/broker/valueDetail";

//项目待确认列表
static NSString *const ProjectWaitConfirm_URL = @"saleApp/work/project/waitConfirm";

//项目待确认详情
static NSString *const ProjectWaitConfirmDetail_URL = @"saleApp/work/project/waitConfirmDetail";

//项目有效列表
static NSString *const ProjectValue_URL = @"saleApp/work/project/value";

//项目有效详情
static NSString *const ProjectValueDetail_URL = @"saleApp/work/project/valueDetail";

//项目失效列表
static NSString *const ProjectDisabled_URL = @"saleApp/work/project/disabled";

//项目失效详情
static NSString *const ProjectDisabledDetail_URL = @"saleApp/work/project/disabledDetail";

//项目申诉列表
static NSString *const ProjectAppealList_URL = @"saleApp/work/project/appealList";

//经纪人待成交列表
static NSString *const ProjectWaitDeal_URL = @"saleApp/work/project/waitDeal";

//经纪人待成交详细
static NSString *const ProjectWaitDealDetail_URL = @"saleApp/work/project/waitDealDetail";

//经纪人成交列表
static NSString *const ProjectDealList_URL = @"saleApp/work/project/deal";

//经纪人成交详情
static NSString *const ProjectDealDetail_URL = @"saleApp/work/project/dealDetail";

//经纪人成交失效列表
static NSString *const ProjectDealDisableList_URL = @"saleApp/work/project/dealDisabled";

//经纪人成交失效详情
static NSString *const ProjectDeailDisableDetail_URL = @"saleApp/work/project/dealDisabledDetail";

//经纪人成交申诉列表
static NSString *const ProjectDealAppealList_URL = @"saleApp/work/project/dealAppealList";

//对接人待确认列表
static NSString *const ButterWaitConfirm_URL = @"saleApp/work/butter/waitConfirm";

//对接人有效列表
static NSString *const ButterValue_URL = @"saleApp/work/butter/value";

//对接人无效客户列表
static NSString *const ButterDisabled_URL = @"saleApp/work/butter/disabled";

#pragma mark -- 二次确认 --

//待确认列表
static NSString *const ButterTelConfirmList_URL = @"saleApp/work/butter/tel/confirm/list";

//待确认详情
static NSString *const ButterTelConfirmDetail_URL = @"saleApp/work/butter/tel/confirm/detail";

//号码有效
static NSString *const ClientTelCheckValue_URL = @"saleApp/client/telCheckValue";

//号码重复
static NSString *const ClientTelCheckDisabled_URL = @"saleApp/client/telCheckDisabled";

//有效列表
static NSString *const ButterTelValueList_URL = @"saleApp/work/butter/tel/value/list";

//有效详情
static NSString *const ButterTelValueDetail_URL = @"saleApp/work/butter/tel/value/detail";

//无效列表
static NSString *const ButterTelDisabledList_URL = @"saleApp/work/butter/tel/disabled/list";

#pragma mark -- 审核 --

//获取流程列表
static NSString *const ProjectGetProgressList_URL = @"saleApp/project/getProgressList";

//审核流程通过
static NSString *const ProjectProgressPass_URL = @"saleApp/project/progress/pass";

//审核流程拒绝
static NSString *const ProjectProgressRefuse_URL = @"saleApp/project/progress/refuse";

#pragma mark -- 排号 --

//变更 --- 所有 ---
static NSString *const ProjectChange_URL = @"saleApp/project/change";

//作废
static NSString *const ProjectRowDisabled_URL = @"saleApp/project/disabled";

//转排号
static NSString *const ProjectRowAddRow_URL = @"saleApp/project/row/addRow";

//排号列表
static NSString *const ProjectRowGetProjectRowList_URL = @"saleApp/project/row/getProjectRowList";

//排号详情
static NSString *const ProjectRowGetRowDetail_URL = @"saleApp/project/row/getRowDetail";

//排号修改
static NSString *const ProjectRowUpdateRow_URL = @"saleApp/project/row/updateRow";

//获取排号类别
static NSString *const ProjectRowGetRowList_URL = @"saleApp/project/row/getRowList";

////获取排号流程
//static NSString *const ProjectGetProgressList_URL = @"saleApp/project/getProgressList";

//流程获取
static NSString *const ProjectProgressGet_URL = @"saleApp/project/progress/get";

//获取项目角色人员列表
static NSString *const ProjectRolePersonList_URL = @"saleApp/project/role/person/list";

//获取项目下角色列表
static NSString *const ProjectRoleListAll_URL = @"saleApp/project/role/listAll";

#pragma mark -- 认购 --

//修改定单
static NSString *const ProjectHouseUpdateProjectSub_URL = @"saleApp/project/house/updateProjectSub";

//转认购
static NSString *const ProjectHouseAddProjectSub_URL = @"saleApp/project/house/addProjectSub";

//认购列表
static NSString *const ProjectHouseGetProjectSublist_URL = @"saleApp/project/house/getProjectSubList";

//认购详情
static NSString *const ProjectHouseGetProjectSubDetail_URL = @"saleApp/project/house/getProjectSubDetail";

//折扣列表
static NSString *const ProjectHouseGetDiscountList_URL =  @"saleApp/project/house/getDiscountList";

#pragma mark -- 签约 --

//修改签约
static NSString *const ProjectHouseUpdateProjectContract_URL = @"saleApp/project/house/updateProjectContract";

//转签约
static NSString *const ProjectHouseAddProjectContract_URL = @"saleApp/project/house/addProjectContract";

//签约列表
static NSString *const ProjectHouseGetProjectContractList_URL = @"saleApp/project/house/getProjectContractList";

//签约详情
static NSString *const ProjectHouseGetProjectContractDetail_URL = @"saleApp/project/house/getProjectContractDetail";

#pragma mark --- 我的 ---

#pragma mark -- 通讯录 --

//获取当前公司下的部门以及岗位
static NSString *const UserPersonalGetCompanyStructure_URL = @"saleApp/user/personal/getCompanyStructure";

//通讯录
static NSString *const UserPersonalGetCompanyStaff_URL = @"saleApp/user/personal/getCompanyStaff";

#pragma mark -- 个人信息 --

//上传文件
static NSString *const UploadFile_URL = @"saleApp/file/upload";

//获取个人信息
static NSString *const UserPersonalGetAgentInfo_URL = @"saleApp/user/personal/getAgentInfo";

//修改个人信息
static NSString *const UserPersonalChangeAgentInfo_URL = @"saleApp/user/personal/changeAgentInfo";

//修改密码
static NSString *const UserPersonalChangePassword_URL = @"saleApp/user/personal/changePassword";

//意见反馈
static NSString *const UserPersonalSendAdvice_URL = @"saleApp/user/personal/sendAdvice";

//获取推送设置
static NSString *const PersonalPushTopsGet_URL = @"saleApp/user/personal/pushTips/get";

//修改推送
static NSString *const PersonPushTipsUpdate_URL = @"saleApp/user/personal/pushTips/update";

//退出登录
static NSString *const UserPersonalLogOut_URL = @"saleApp/user/personal/logOut";

#pragma mark -- 公司 --

//获取认证信息
static NSString *const CompanyAuthInfo_URL = @"saleApp/company/auth/info";

//获取公司列表
static NSString *const PersonalGetCompanyList_URL = @"saleApp/personal/getCompanyList";

//获取部门列表
static NSString *const CompanyPersonOrganizeList_URL = @"saleApp/company/person/organize/list";

//获取岗位列表
static NSString *const CompanyPersonOrganizePostList_URL = @"saleApp/company/person/organize/post/list";

//获取公司下项目及角色
static NSString *const ProjectRoleList_URL = @"saleApp/project/role/list";

//认证
static NSString *const CompanyAuth_URL = @"saleApp/company/auth";

//重新认证
static NSString *const CompanyAuthReAuth_URL = @"saleApp/company/auth/reAuth";

//离职
static NSString *const CompanyAuthQuit_URL = @"saleApp/company/auth/quit";

//取消认证
static NSString *const CompanyAuthCancel_URL = @"saleApp/company/auth/cancel";

//修改项目角色
static NSString *const PersonalChangeProjectRole_URL = @"saleApp/user/personal/changeProjectRole";

#pragma mark === 轮岗 =====

//获取待处理轮岗信息列表
static NSString *const ProjectDutyVisitLog_URL = @"saleApp/project/duty/visit/log";

//获取渠道分配客户
static NSString *const WorkClientRecommendList_URL = @"saleApp/work/client/recommend/list";

//开始轮岗
static NSString *const DutyStartURL = @"saleApp/project/duty/start";

//轮岗详情
static NSString *const DutyDetail_URL = @"saleApp/project/duty/detail";

//更换A位
static NSString *const DutyNext_URL = @"saleApp/project/duty/next";

//新增详情
static NSString *const Dutyadd_URL = @"saleApp/project/duty/add";

//修改轮岗基础设置
static NSString *const DutyUpdate_URL = @"saleApp/project/duty/update";

//修改轮岗公司
static NSString *const DutyCompanyUpdate_URL = @"saleApp/project/duty/company/update";

//修改轮岗人员
static NSString *const DutyAgentUpdate_URL = @"saleApp/project/duty/agent/update";

//新增团队或团队人员
static NSString *const DutyCompanyAdd_URL = @"saleApp/project/duty/company/add";

//获取公司
static NSString *const GetCompany_URL = @"saleApp/project/duty/company/list";


//获取人员
static NSString *const GetPeople_URL = @"saleApp/project/duty/company/person/list";

#pragma mark === 报表 =====

//客户来源
static NSString *const ProjectReportClientType_URL = @"saleApp/report/client/type";

//自然来访认知途径
static NSString *const ReportClientAutoListenWay_URL = @"saleApp/report/client/auto/listenWay";

//单物业客户需求统计
static NSString *const ReportClientAutoPropertyNeed_URL = @"saleApp/report/client/auto/property/need";

//到访客户列表
static NSString *const ProjectClientValue_URL = @"saleApp/project/client/value";

//推荐客户列表
static NSString *const ProjectClientWaitConfirmed_URL = @"saleApp/project/client/waitConfirmed";

//成交客户列表
static NSString *const ProjectClientDeal_URL = @"saleApp/project/client/deal";

//项目客户统计
static NSString *const ProjectClientCount_URL = @"saleApp/project/client/count";

//渠道规则佣金统计
static NSString *const BrokerRuleCompanyList_URL = @"saleApp/broker/rule/company/list";

//佣金详情列表
static NSString *const BrokerCompanyList_URL = @"saleApp/broker/company/list";

#endif /* NetConfig_h */
