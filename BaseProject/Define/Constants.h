//
//  Constants.h
//  BaseProject
//
//  Created by xf.wang on 15/10/21.
//  Copyright © 2015年 centralsoft. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

/*******************************************服务器配置信息********************************************/
////服务端配置信息 --- Weblogic
//#define SERVER_ID     @"10.1.10.99"//服务端地址
//#define SERVER_PORT   @"7001"      //服务端端口号
//#define SERVER_SUFFIX @"zhscjg"    //服务后缀

//服务端配置信息 --- Tomcat
#define SERVER_ID     @"10.1.10.99"//服务端地址
#define SERVER_PORT   @"8081"      //服务端端口号
#define SERVER_SUFFIX @"zhscjg"    //服务后缀

#define SERVER_PATH [NSString stringWithFormat:@"http://%@:%@/%@", SERVER_ID,SERVER_PORT,SERVER_SUFFIX]

#define GET_REQUEST(SUFFIX_CONTENT) [NSString stringWithFormat:@"http://%@:%@/%@/%@",SERVER_ID, SERVER_PORT, SERVER_SUFFIX, SUFFIX_CONTENT]

/***************************************************************************************************/










/*********************************************工具宏方法***********************************************/

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//通过RGB设置颜色
#define kRGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度

#define kAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

#define kStoryboard(StoryboardName)     [UIStoryboard storyboardWithName:StoryboardName bundle:nil]

//通过Storyboard ID 在对应Storyboard中获取场景对象
#define kVCFromSb(storyboardId, storyboardName)     [[UIStoryboard storyboardWithName:storyboardName bundle:nil] \
instantiateViewControllerWithIdentifier:storyboardId]

//移除iOS7之后，cell默认左侧的分割线边距
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}

//Docment文件夹目录
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

//移除子视图
#define REMOVE_SUBVIEWS(VIEW) [VIEW.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)]

/***************************************************************************************************/










/*****************************************系统常量的定义**********************************************/
#define TOAST_SHOW_INTERVAL 1 //提示框显示间隔
#define VERAREA @"zhejiang"//用户区域
#define COMMAND_SEPERATOR @"/%CommandSeperator%/"

//提示消息
#define INFO_NETWORKING_ERROR @"网络错误"

//系统颜色
#define COLOR_DIMGGREY [UIColor colorFromHexCode:@"#696969"] //暗灰色

/***************************************************************************************************/










/********************************************字段名称定义**********************************************/
// 丽水移动10.120.135.130 lsydgs.zj
// 金华移动10.22.253.81 jhgs.zj
// 金华电信（义乌用） APN：#777 用户名：jhgs@jhgs.133vpdn.zj 密码：gs12315
// 嘉兴移动211.140.95.86
// 绍兴联通10.19.1.16 sxgsj.zjapn
// 湖州联通10.21.3.153 uzgsj.ydoa.zjapn
// 舟山移动10.26.1.8 zsgsj.zj

#define APN_HAVE      @"0"                   // 是否有接入点 0无;1有
#define APN_NAME      @"金华工商"                // 接入点名称
#define APN_REAL_NAME @"#777"                // apn
#define APN_USER      @"jhgs@jhgs.133vpdn.zj"// 接入点用户名
#define APN_PASSWORD  @"gs12315"             // 接入点密码
#define BLUETOOTH     @"bluetooth"           // 蓝牙
#define DICTIONARY    @"/mnt/sdcarddata/"    // 文件夹名字

/**
 * 默认WEB服务器地址10.22.253.81:80
 * 绍兴10.19.1.16：7001
 * 湖州10.21.3.153:80
 * 嘉兴211.140.95.86:7001/10.20.90.23:7001
 */
#define DEFALUTSERVERIP             @"183.129.215.106"

/**
*                                   默认WEB服务器端口
 */
#define DEFALUTSERVERPORT           @"9006"

/**
*                                   默认WEB后缀名
 */
#define DEFALUTSERVERSUFFIX         @"zhscjg"
/**
*                                   WEB服务器地址
* 金华：                               10.22.253.81:80
 *
 *
 */
#define SERVERIP                    @"system_serverip"

/**
*                                   WEB服务器端口
 */
#define SERVERPORT                  @"system_serverport"

/**
* 记住用户名密码 0:不保存                     1:保存
 */
#define REMUSER                     @"0"

/**
*                                   用户ID
 */
#define USERID                      @"userid"

/**
*                                   用户名
 */
#define USERNAME                    @"username"

/**
*                                   用户密码
 */
#define PASSWORD                    @"password"

/**
*                                   用户真实姓名
 */
#define NAME                        @"name"

/**
*                                   用户登记机关
 */
#define DJJG                        @"djjg"

/**
*                                   用户管辖单位
 */
#define GXDW                        @"gxdw"

/**
*                                   用户登记机关名称
 */
#define DJJGNAME                    @"djjgname"

/**
*                                   用户管辖单位名称
 */
#define GXDWNAME                    @"gxdwname"

/**
*                                   内部序号
 */
#define NBXH                        @"nbxh"

/**
*                                   用户12315系统用户ID
 */
#define SSJBUSERID                  @"ssjbuserid"

/**
*                                   用户OA系统用户ID
 */
#define OAUSERID                    @"oauserid"
/**
*                                   企业名称查询
 */
#define QYMCQUERY                   @"qymcQuery"
/**
*                                   用户OA系统用户名字
 */
#define OAUSERNAME                  @"oausername"

/**
*                                   用户OA系统用户密码
 */
#define OAPASSWORD                  @"oapassword"

/**
*                                   用户OA系统用户登录地址
 */
#define OAURL                       @"oaurl"

/**
*                                   用户电子邮箱帐户
 */
#define EMAILNAME                   @"emailname"
/**
*                                   已安装用户功能JSON字符串

 */
#define HASFUNCTION                 @"hasfunction"

/**
*                                   用户功能JSON字符串
 */
#define FUNCTION                    @"function"

/**
 * 用户功能ID
 */
#define FUNCTIONID    @"functionid"
#define FUNCTIONID_CX @"functionid_cx"
#define FUNCTIONID_ZF @"functionid_zf"
#define FUNCTIONID_FZ @"functionid_fz"

/**
 * 用户功能名称
 */
#define FUNCTIONNAME    @"functionname"
#define FUNCTIONNAME_CX @"functionname_cx"
#define FUNCTIONNAME_ZF @"functionname_zf"
#define FUNCTIONNAME_FZ @"functionname_fz"


/**
 * 巡查队code
 */
#define XCDCODE @"xcdcode"
/**
 * 用户功能action
 */
#define FUNCTIONACTION    @"functionaction"
#define FUNCTIONACTION_CX @"functionaction_cx"
#define FUNCTIONACTION_ZF @"functionaction_zf"
#define FUNCTIONACTION_FZ @"functionaction_fz"

/**
 * 用户功能类别
 */
#define FUNCTIONLB    @"functionlb"
#define FUNCTIONLB_CX @"functionlb_cx"
#define FUNCTIONLB_ZF @"functionlb_fz"
#define FUNCTIONLB_FZ @"functionlb_zf"

/**
*                  客户端代码
 */
#define CLIENTCODE @"clientcode"

/**
*                  客户端版本
 */
#define CLIENTVER  @"clientver"

/**
*                  服务端BS访问路径
 */
#define SERVERPATH @"serverpath"

/**
*                  FTP服务器地址
 */
#define FTPIP      @"ftpip"

/**
*                  FTP服务器端口
 */
#define FTPPORT    @"ftpport"

/**
*                        FTP服务器用户名
 */
#define FTPUSER          @"ftpuser"

/**
*                        FTP服务器密码
 */
#define FTPPASS          @"ftppass"

/**
*                        FTP服务器图片路径
 */
#define FTPPATH          @"ftppath"

/**
*                        登录是否成功标志
 */
#define LOGIN_FLAG       @"loginflag"

/**
*                     登录返回消息
 */
#define LOGIN_MESSAGE @"loginmessage"

/**
*                     操作是否成功标志
 */
#define HANDLE_FLAG   @"handleflag"

/**
 *操作成功
 */
#define HANDLE_FLAG_SUCC @"1"

/**
 *操作失败
 */
#define HANDLE_FLAG_FAIL @"0"

/**
 *操作返回信息
 */
#define HANDLE_MSG       @"handlemsg"

/**
 *附件ID
 */
#define FJ_ID   @"fjid"

/**
 *附件类型
 */
#define FJ_TYPE @"fjtype"

/**
 *附件用途
 */
#define FJ_USE  @"fjuse"

/**
 *附件名称
 */
#define FJ_NAME @"fjname"

/**
 *附件路径
 */
#define FJ_PATH @"filepath"

/**
 *附件关联序号
 */
#define FJ_GLXH @"fjglxh"


/**
 *用戶类型
 *0：12315执法用户设置 1：公文系统用户设置 2：邮箱设置
 */
#define XT_TYPE "xttype"

/**
 * 地球半径（单位km）
 */
#define EARTH_RADIUS 6378.137
/**
 * 记忆输入
 */
#define MEMORY_INPUT @""

/**
 * 商圈序号
 */
#define SQXH @"sqxh"

/**
 * 实际地址
 */
#define SJDZ @"sjdz"

/**
 * 经度
 */
#define JD84 @"jd84"

/**
*                    纬度
 */
#define WD84         @"wd84"

/**
*                    地图经度
 */
#define JDDT         @"jddt"

/**
*                    地图纬度
 */
#define WDDT         @"wddt"

/**
*                    附件表中关联表名称

*                    */
#define FJ_TABLENAME      @"tablename"

/**
*                         地图版本
*                         */
#define MAP_SOURCE        @"mapSource"
/**
*                         地图版本
*                         */
#define MAP_SOURCE_BD_MAP @"baidu"

/**
 * 地图版本
 * */
#define MAP_SOURCE_ARCGIS = @"ArcGis"

/**
 * 企业名称查询
 */
#define QYMC @"qymc"

#define AREA_NAME_VALUE @"慈溪市"

/**
 * 百度地图key
 * */
#define MAP_KEY @"1DB1408B1D36AD7C80DE8639250EDEB8CDF3D741"

/**
*                        主配置文件

*                        */
#define CONFIG_FILE_NAME @"config"

/**
*                        推动服务开启状态

* 1：打开                   0：关闭

 */
#define OPS              @"OPS"

/**
*                        地区
*                        */
#define AREA             @"area"


#define AREA_NAME        @"area_name"

/**
*                        西安地区
*                        */
#define AREA_XA          @"xa"
/**
*                        慈溪地区
*                        */
#define AREA_CX          @"cx"


/**
 * 慈溪综合监管服务地址
 */
#define CXZHJGURL @"cxzhjgurl"
/***************************************************************************************************/

#endif /* Constants_h */
