//
//  ViewController.m
//  LGW_Persistence
//
//  Created by Lilong on 16/4/13.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
应用沙盒目录的常见获取方式

沙盒根目录：NSString *home = NSHomeDirectory();

Documents：(2种方式)

利用沙盒根目录拼接”Documents”字符串

NSString *home = NSHomeDirectory();
NSString *documents = [home stringByAppendingPathComponent:@"Documents"];
// 不建议采用，因为新版本的操作系统可能会修改目录名
利用NSSearchPathForDirectoriesInDomains函数

// NSUserDomainMask 代表从用户文件夹下找
// YES 代表展开路径中的波浪字符“~”
NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
// 在iOS中，只有一个目录跟传入的参数匹配，所以这个集合里面只有一个元素
NSString *documents = [array objectAtIndex:0];
tmp：NSString *tmp = NSTemporaryDirectory();

Library/Caches：(跟Documents类似的2种方法)

利用沙盒根目录拼接”Caches”字符串
利用NSSearchPathForDirectoriesInDomains函数(将函数的第2个参数改为：NSCachesDirectory即可)
Library/Preference：通过NSUserDefaults类存取该目录下的设置信息
*/


@end
