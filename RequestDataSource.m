//
//  RequestDataSource.m
//  登录
//
//  Created by 扶摇先生 on 15-12-16.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "RequestDataSource.h"

#define  baseUrl  @"http://10.0.8.8/sns"

@interface RequestDataSource()

@property(nonatomic,strong)AFHTTPRequestOperationManager * manager;

@end

@implementation RequestDataSource

+(instancetype)request{
    
    return [[self alloc] init];
}


-(AFHTTPRequestOperationManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];//二进制解析器
        
        //        [_manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        
    }
    return _manager;
}

-(void)requestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters complicate:(Complicate)complicate{
    
    [self.manager POST:[baseUrl stringByAppendingString:url] parameters:parameters success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
        //自己解析
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        complicate(YES,responseObject);
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        
        complicate(NO,error);
        
    }];
    
}

- (void)downLoadImageWithUrl:(NSString *)url complicate:(Complicate)complicate{
    
    NSString * fileName = [[url componentsSeparatedByString:@"/"] componentsJoinedByString:@"-"];//做文件名
    
    NSString * filepath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];//文件所在路径
    
    //判断本地文件是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        NSData * data = [NSData dataWithContentsOfFile:filepath];
        complicate(YES,data);
        
        return;
    }
    
    
    [self.manager GET:[baseUrl stringByAppendingString:url] parameters:nil success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
        complicate(YES,responseObject);
        
        //请求成功之后 将 数据写到本地路径filepath 下
        [responseObject writeToFile:filepath atomically:YES];
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        complicate(NO,error);
    }];
}


@end
