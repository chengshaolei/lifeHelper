//
//  CSLDataBase.m
//  LiveAssistant
//
//  Created by csl on 15/12/12.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDataBase.h"
#import "FMDB.h"
@implementation CSLDBManager
{
    FMDatabase * _db;//数据库
}

+(instancetype) defaultDBManager{
    static CSLDBManager * manager = nil;
    static dispatch_once_t once_token = 0;
    dispatch_once(&once_token, ^{
        manager = [[super alloc] init];
    });
    return manager;
}

-(instancetype) init{
    if (self = [super init]) {
        NSString *dbName = DBNAME;
        if (!dbName||dbName.length<=0) {
            dbName = @"myDB";//默认数据库名
        }
    
        //设置数据库路径
        NSString * path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",dbName];
        
        //创建数据库，如果没有该数据库，则创建
        _db = [FMDatabase databaseWithPath:path];
        if ([_db open]==NO) {//打开数据库
            return nil;//失败返回nil
        }
    }
    return self;
}

-(BOOL) createTable:(NSString*)sqlString{
    return [_db executeUpdate:sqlString];
}

//功能：查询一个表，将返回的记录放到一个字典，将字典放到数组
//参数：tbName:表名字
//     sqlString: sql语句
//    where：查询条件
//返回值：返回一个数组，数组每一个值是一个字典（代表一条记录）
-(NSArray*) select:(NSString*)sqlString where:(NSArray*)condition{
    if(!sqlString || sqlString.length<=0){//如果查询呢语句为空，返回nil
        return nil;
    }
    FMResultSet * rs = [_db executeQuery:sqlString withArgumentsInArray:condition];
    
    //创建一条数组保存将记录
    NSMutableArray * records = [NSMutableArray array];
    while ([rs next]) {
        for(int i = 0;i<[rs columnCount];i++)
        {
            //获得一条记录
            NSDictionary * result = [rs resultDictionary];
            [records addObject:result];
        }
    }
    [rs close];//关闭记录集
    return records;
}


//功能：查询一个表，将返回的记录转换成对象，放到一个数组里
//参数：tbName:表名字
//    where：查询条件
//    cname，类名
//返回值：返回一个对象数组
-(NSArray*) select:(NSString*)sqlString  where:(NSArray*)condition className:(NSString*)cname{
    if(!sqlString || sqlString.length<=0){//如果查询呢语句为空，返回nil
        return nil;
    }
    if (!cname || cname.length<=0) {//类名为空
        return nil;
    }
    
    FMResultSet * rs = [_db executeQuery:sqlString withArgumentsInArray:condition];
    
    //创建一条数组保存将记录
    NSMutableArray * records = [NSMutableArray array];
    
    //创建类对象
    Class myClass = NSClassFromString(cname);
    
    while ([rs next]) {
        for(int i = 0;i<[rs columnCount];i++)
        {
            id object = [[myClass alloc] init];//由类对象创建对象
            [rs kvcMagic:object];//使用kvc模式给对象赋值
            [records addObject:object];//把对象加到数组
        }
    }
    [rs close];//关闭记录集
    return records;
}


//功能：在表里插入一条记录
//参数：tableName:表名字
//    dict：一条记录的属性/值的集合
//返回值：成功返回YES 否则返回NO
-(BOOL) insertTable:(NSString*)tableName record:(NSDictionary*)dict{
    if (!tableName || tableName.length<=0) {//字符串为空
        return NO;
    }
    if (!dict||dict.count<=0) {//如果字典为空
        return NO;
    }
    
    //创建查询语句
    NSMutableString *sqlString = [NSMutableString stringWithFormat:@"insert into %@",tableName];
    NSArray * keys = [dict allKeys];//取得字典的键
    [sqlString appendFormat:@"("];
    
    //拼插入SQL语句串
    for (NSString * key in keys) {
        [sqlString appendFormat:@":%@",key];
    }
    [sqlString appendFormat:@")"];
    
    //执行插入语句
    return [_db executeUpdate:sqlString withParameterDictionary:dict];
}

//功能：在表里删除一条记录
//参数：tableName:表名字
//    condition：删除条件
//返回值：成功返回YES 否则返回NO
-(BOOL) deleteTable:(NSString*)tableName where:(NSString*)condition{
    //拼sqL串
    NSString * sqlString = [NSString stringWithFormat:@"delete from %@ where %@",tableName,condition];
    
    return [_db executeUpdate:sqlString];
}

//功能：更新一个表里的记录
//参数：sqlString:sql语句
//     NSArray：更新参数
//返回值：成功返回YES 否则返回NO
-(BOOL) update:(NSString*)sqlString paras:(NSArray*)condition{
    if (!sqlString || sqlString.length<=0) {
        return NO;
    }
    return [_db executeUpdate:sqlString withArgumentsInArray:condition];
}
@end
