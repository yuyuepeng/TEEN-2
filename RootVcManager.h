//
//  RootVcManager.h
//  将进酒1
//
//  Created by 扶摇先生 on 16-1-8.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "ViewController.h"
@interface RootVcManager : NSObject
+(UIViewController *)mainVc;
+(UIViewController *)getWindowRootVC;
@end
