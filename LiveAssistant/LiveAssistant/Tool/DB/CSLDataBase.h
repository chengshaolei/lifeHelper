//
//  CSLDataBase.h
//  LiveAssistant
//  数据库操作接口
//  Created by csl on 15/12/12.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DBNAME  @"myDB" //请根据自己的需要修改数据库名字
@interface CSLDBManager : NSObject

+(instancetype) defaultDBManager;//单例

//功能：创建表
//参数：sqlString：sql语句
//返回值：成功返回YES，否则返回NO
-(BOOL) createTable:(NSString*)sqlString;


//功能：查询一个表，将返回的记录放到一个字典，将字典放到数组
//参数：sqlString:sql语句
//     condition：查询条件,是一个数组
//返回值：返回一个数组，数组每一个值是一个字典（代表一条记录）
//使用示例：[[CSLDBManager defaultDBManager] select:@"select * from test where col1 = ? and col2 = ?" where @[@"1",@3]
-(NSArray*) select:(NSString*)sqlString where:(NSArray*)condition;


//功能：查询一个表，将返回的记录转换成对象，放到一个数组里
//参数：sqlString:查询语句
//     where：查询条件，是一个数组
//     cname，类名
//返回值：返回一个对象数组
-(NSArray*) select:(NSString*)sqlString  where:(NSArray*)condition className:(NSString*)cname;

//功能：在表里插入一条记录
//参数：tableName:表名字
//    dict：一条记录的属性/值的集合
//返回值：成功返回YES 否则返回NO
-(BOOL) insertTable:(NSString*)tableName record:(NSDictionary*)dict;

//功能：在表里删除一条记录
//参数：tableName:表名字
//    condition：删除条件
//返回值：成功返回YES 否则返回NO
//示例 [[CSLDBManager defaultDBManager] insertToTable:@"test" where @"col1= 1"]
-(BOOL) deleteTable:(NSString*)tableName where:(NSString*)condition;

//功能：更新一个表里的记录
//参数：sqlString:sql语句
//     paras：参数数组
//返回值：成功返回YES 否则返回NO
//示例：[[CSLDBManager defaultDBManager] update:@"update test set a = ?,b = ? where a = ?" paras @["1",@"2",@"3"]]
-(BOOL) update:(NSString*)sqlString paras:(NSArray*)condition;
@end
