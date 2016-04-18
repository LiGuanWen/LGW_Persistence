//
//  PlistViewController.m
//  LGW_Persistence
//
//  Created by Lilong on 16/4/18.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import "PlistViewController.h"

@interface PlistViewController ()
@property (weak, nonatomic) IBOutlet UITextView *writeTextView;
@property (weak, nonatomic) IBOutlet UIButton *writeBtn;
@property (weak, nonatomic) IBOutlet UITextView *readTextView;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;

@end

@implementation PlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //读取手动创建的plist文件 (字典)
    NSString *plistDictPath = [[NSBundle mainBundle] pathForResource:@"PlistData" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistDictPath];
    NSLog(@"本地PlistData = %@",dict);
    
    NSString *plistArrayPath = [[NSBundle mainBundle] pathForResource:@"PlistArray" ofType:@"plist"];
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] initWithContentsOfFile:plistArrayPath];
    NSLog(@"本地plistArray = %@",dict2);
    NSArray *arr = [[NSArray alloc] init];
    arr = [dict2 objectForKey:@"myList"];
    for (int i = 0; i < arr.count; i++) {
        NSLog(@"==== %@",arr[i]);
    }
    
    // Do any additional setup after loading the view.
}
- (NSString *)filePath{
    //获取路径对象
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    // 获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"lilong.plist"];
//    //上面3句可以写成这一句
//    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"lilong.plist"];
    
    NSLog(@"------filepath---%@",filePath);
    return filePath;
}

- (IBAction)writeAction:(id)sender {
    NSString *path = [self filePath];
    // 将数据封装成字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.writeTextView.text forKey:@"data"];

    // 将字典持久化到Documents/lilong.plist文件中
    [dict writeToFile:path atomically:YES];
}

- (IBAction)readAction:(id)sender {
     NSString *path = [self filePath];
    // 读取Documents/stu.plist的内容，实例化NSDictionary
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *data = [dict objectForKey:@"data"];
    NSLog(@"data:%@", [dict objectForKey:@"data"]);
    self.readTextView.text = data;
}
- (IBAction)deleteAction:(id)sender {
    NSFileManager *filManager = [NSFileManager defaultManager];
    NSString *path = [self filePath];
    //如果文件路径存在的话
    BOOL bRet = [filManager fileExistsAtPath:path];
    if (bRet) {
        NSError *error;
        [filManager removeItemAtPath:path error:&error];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
