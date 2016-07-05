//
//  RequestDataSource.h
//  登录
//
//  Created by 扶摇先生 on 15-12-16.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void(^Complicate)(BOOL success,id data);

@interface RequestDataSource : NSObject
//类方法 快速创建 当前对象
+(instancetype)request;

//请求
- (void)requestWithUrl:(NSString*)url parameters:(NSDictionary *)parameters complicate:(Complicate)complicate;


//下载图片
- (void)downLoadImageWithUrl:(NSString *)url complicate:(Complicate)complicate;


@end
