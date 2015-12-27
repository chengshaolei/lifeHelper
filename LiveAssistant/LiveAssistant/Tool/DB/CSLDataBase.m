//
//  CSLDataBase.m
//  LiveAssistant
//
//  Created by csl on 15/12/12.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDataBase.h"
#import "FMDB.h"
@interface CSLDBManager()
-(void) createTable;
@end

@implementation CSLDBManager
{
  
}


+(instancetype) defaultDBManager{
    static CSLDBManager * manager = nil;
    static dispatch_once_t once_token = 0;
    dispatch_once(&once_token, ^{
        manager = [[super alloc] init];
        if (manager) {
            [manager createTable];//创建表
        }
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
        NSLog(@"%@",path);
        
        //创建数据库，如果没有该数据库，则创建
        _db = [FMDatabase databaseWithPath:path];
        if ([_db open]==NO) {//打开数据库
            return nil;//失败返回nil
        }
    }
    return self;
}

- (BOOL) isTableOK:(NSString *)tableName{
    //从系统表sqlite_master查询
    FMResultSet *rs = [_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        return count!=0?YES:NO;
    }
    return NO;
}

-(BOOL) createTable:(NSString*)sqlString{
    return [_db executeUpdate:sqlString];
}


// 字符串型
- (NSString *)getStringValue:(NSString *)tableName withFieldName:(NSString *)fieldName  where:(NSString*)condition
{
    NSString *result = nil;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@", fieldName, tableName,condition];
    FMResultSet *rs = [_db executeQuery:sql];
    if ([rs next])
        result = [rs stringForColumnIndex:0];
    [rs close];
    
    return result;
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
    NSMutableString *sqlString = [NSMutableString stringWithFormat:@"insert into %@(",tableName];
    NSMutableString * valueString = [NSMutableString stringWithString:@"  values ("];
    
    //值的数组
    NSMutableArray * values = [NSMutableArray array];
    
    NSArray * keys = [dict allKeys];//取得字典的键
    
    //拼插入SQL语句串
    for (NSString * key in keys) {
        [sqlString appendFormat:@"%@,",key];
        [valueString appendString:@"?,"];
        [values addObject:dict[key]];
    }
    
    [sqlString deleteCharactersInRange:NSMakeRange(sqlString.length-1, 1)];
    [valueString deleteCharactersInRange:NSMakeRange(valueString.length-1, 1)];
    [sqlString appendString:@")"];
    [valueString appendString:@")"];
    [sqlString appendString:valueString];
   
    
    //执行插入语句
    return [_db executeUpdate:sqlString withArgumentsInArray:values];
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

-(void) createTable{
    //创建用户表
    [_db executeUpdate:@"CREATE TABLE  if not exists user (uid  INTEGER PRIMARY KEY AUTOINCREMENT, username  TEXT NOT NULL,  password  TEXT NOT NULL,  thirdparty  BOOLEAN DEFAULT false)"];
    
    //创建快递公司表
    [_db executeUpdate:@"create table if not exists expresscompany (esid INTEGER PRIMARY KEY AUTOINCREMENT,shortname text, name text)"];
    
    //创建密保
    [_db executeUpdate:@"CREATE TABLE if not exists  codesure (cdid  INTEGER PRIMARY KEY AUTOINCREMENT, uid INTEGER REFERENCES  user (uid), password  TEXT, itemname  TEXT NOT NULL)"];
    
    //创建闹钟表
    [_db executeUpdate:@"CREATE TABLE  alarm (alarmid TEXT PRIMARY KEY, uid INTEGER REFERENCES  user (uid))"];
    //创建视图
    [_db executeUpdate:@"create view useralarm as  select username,alarmid  from user,alarm"];
}
@end
