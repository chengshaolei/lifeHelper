//
//  QFConstant.h
//  LiveAssistant
//  工程常量定义文件
//  Created by csl on 15/12/10.
//  Copyright © 2015年 CSL. All rights reserved.
//

#ifndef QFConstant_h
#define QFConstant_h

//快递请求地址,post方式,参数：
//apikey ：授权密钥：
//keyword ：需要查询的快递单号
//kuaidicompany ：快递公司
#define URL_EXPRESS @"http://www.monqin.com/wxapp/index.php/Home/api/express"
#define URL_EXPRESS_APIKEY  @"6eb360953ca88ffef4ea260a23c54fda"


//聚合数据
#define JHAPPID  @"JHf553cdb37a3165b4a2da622205c1863e"

//成语词典
//参数说明
//名称	类型	   必填	说明
//word	string	是	填写需要查询的汉字，UTF8 urlencode编码
//key	string	是	应用APPKEY(应用详细页查询)
//dtype	string	否	返回数据的格式,xml或json，默认json
#define JH_Idiom_URL @"http://v.juhe.cn/chengyu/query"

//新华字典
// 数据ID：156
//参数说明
//名称	类型	   必填	说明
//word	string	是	填写需要查询的汉字，UTF8 urlencode编码
//key	string	是	应用APPKEY(应用详细页查询)
//dtype	string	否	返回数据的格式,xml或json，默认json
#define JH_Dictionary_URL @"http://v.juhe.cn/xhzd/query"

//药店大全

//药店位置
//数据ID：144
//名称	类型	  必填	说明
//key	string	是	应用APPKEY(应用详细页查询)
//dtype	string	否	返回数据的格式,xml或json，默认json
#define JH_ShopPostion_URL @"http://op.juhe.cn/yi18/store/region"

//药店列表
#define JH_ShopList_URL  @"http://op.juhe.cn/yi18/store/list"

//药店详情
#define JH_ShopInfo_URL  @"http://op.juhe.cn/yi18/store/show"


//医院信息
//数据ID：78
//名称	    类型	   必填	 说明
//hospital	string	是	要查询的医院名称，如：苏州市立医院
//key	string	是	应用APPKEY(应用详细页查询)
//dtype	string	否	返回数据的格式,xml或json，默认json
#define JH_Hospital_URL  @"http://op.juhe.cn/onebox/hospital/query"

//药品大全
//数据ID：148
//APPKey:4dc428e62a3a75334fbcd02e4d4f485a
//名称	类型	  必填	说明
//key	string	是	您申请的APPKEY
//name	string	否	分类关键字(如：胃)
//skip	int	    否 	跳过的数量，默认为0

//药品分类
#define JH_MedicineType_URL   @"http://api2.juheapi.com/medicine/drugclass"

//药品详细
#define JH_MedicineList_URL @"http://api2.juheapi.com/medicine/list"


//周公解梦
//数据ID：64
//key	string	是	应用APPKEY(应用详细页查询)
//fid	string	否	所属分类，默认全部，0:一级分类
#define JH_Dream_URL  @"http://v.juhe.cn/dream/category"

//星座运势
//数据ID：58
//名称	    类型	   必填	说明
//key	    string	是	应用APPKEY(应用详细页查询)
//consName	string	是	星座名称，如:白羊座
//type	    string	是	运势类型：today,tomorrow,week,nextweek,month,year
#define JH_Constellation_URL  @"http://web.juhe.cn:8080/constellation/getAll"

//


#endif /* QFConstant_h */
