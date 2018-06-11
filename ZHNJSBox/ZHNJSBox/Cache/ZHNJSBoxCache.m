//
//  ZHNJSBoxCache.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/23.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxCache.h"

// todo test 名字是某个script的名字这里需要做修改
@implementation ZHNJSBoxCache
+ (id)responseWithFuncName:(NSString *)funcName arg:(JSValue *)arg {
    if ([funcName isEqualToString:@"set"]) {
        NSString *key = [arg[0] toString];
        id data = arg[1];
        [self set:data inScript:@"test" forKey:key];
    }
    if ([funcName isEqualToString:@"get"]) {
        return [self objForKey:[arg toString] inScript:@"test"];
    }
    return nil;
}


+ (void)set:(id)obj  inScript:(NSString *)scriptName forKey:(NSString *)key; {
    NSString *cacheFile = [self _filePathWithScriptName:scriptName key:key];
    if ([obj isKindOfClass:[JSValue class]]) {
        obj = [obj toObject];
    }
    [NSKeyedArchiver archiveRootObject:obj toFile:cacheFile];
}

+ (id)objForKey:(NSString *)key inScript:(NSString *)script {
    NSString *cacheFile = [self _filePathWithScriptName:script key:key];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:cacheFile];
}

+ (NSString *)_filePathWithScriptName:(NSString *)scriptName key:(NSString *)key {
    return [[self _pathForScript:scriptName] stringByAppendingPathComponent:key];
}

+ (NSString *)_pathForScript:(NSString *)scriptName {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:scriptName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL isExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (!isDir &&!isExist) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}
@end
