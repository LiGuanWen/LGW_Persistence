//
//  SKeyedArchiverViewController.m
//  LGW_Persistence
//
//  Created by Lilong on 16/4/18.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import "SKeyedArchiverViewController.h"
#import "ModelArchiver.h"
@interface SKeyedArchiverViewController ()
@property (weak, nonatomic) IBOutlet UITextView *writeTextView;
@property (weak, nonatomic) IBOutlet UITextView *readTextView;

@end

@implementation SKeyedArchiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test01];
    [self test02];
    [self test03];
    [self test04NSData];
    [self test05Copy];
    // Do any additional setup after loading the view.
}

- (void)test01{
    
    //归档一般对象
    //获取路径对象
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    // 获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"lilong01.archive"];
    NSString *str = @"my name is lilong";
    //存
    [NSKeyedArchiver archiveRootObject:str toFile:filePath];
    //取
    NSString *str2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"str = %@",str2);
}

- (void)test02{
    //归档一般对象
    //获取路径对象
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    // 获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"lilong02.archive"];
    NSArray *arr = @[@"lilong",@"liguanwen"];
    //存
    [NSKeyedArchiver archiveRootObject:arr toFile:filePath];
    //取
    NSString *str2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"arr = %@",str2);
}

- (void)test03{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = pathArray[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"lilong03.archive"];
    
    ModelArchiver *model = [[ModelArchiver alloc] init];
    model.name = @"lilong";
    model.age = 25;
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
    ModelArchiver *model2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"lilong03 name= %@, age = %d",model2.name, model2.age);
    
}
#warning you wen ti
- (void)test04NSData{
    ModelArchiver *model = [[ModelArchiver alloc] init];
    model.name = @"lilong";
    model.age = 25;

    ModelArchiver *model2 = [[ModelArchiver alloc] init];
    model.name = @"liguanwen";
    model.age = 24;
   
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"lilong04.archive"];
    
     //新建一块可变数据区
    NSMutableData *data = [NSMutableData data];
    // 将数据区连接到一个NSKeyedArchiver对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 开始存档对象，存档的数据都会存储到NSMutableData中
    [archiver encodeObject:model forKey:@"model"];
    [archiver encodeObject:model2 forKey:@"model2"];
    // 存档完毕(一定要调用这个方法，调用了这个方法，archiver才会将encode的数据存储到NSMutableData中)
    [archiver finishEncoding];
    // 将存档的数据写入文件
    [data writeToFile:filePath atomically:YES];
    
    
    // 从文件中读取数据
    NSData *data2 = [NSData dataWithContentsOfFile:filePath];
    // 根据数据，解析成一个NSKeyedUnarchiver对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data2];
    ModelArchiver *model11 = [unarchiver decodeObjectForKey:@"model"];
    ModelArchiver *model22 = [unarchiver decodeObjectForKey:@"model2"];
    // 恢复完毕(这个方法调用之后，unarchiver不能再decode对象，而且会通知unarchiver的代理调用unarchiverWillFinish:和unarchiverDidFinish:方法)
    [unarchiver finishDecoding];
    
    NSLog(@"mode name= %@ age = %d, model2 name= %@ age =%d",model11.name,model11.age,model22.name, model22.age);
    
}
//利用归档实现深复制
//比如对一个ModelArchiver对象进行深复制
- (void)test05Copy{
    ModelArchiver *model = [[ModelArchiver alloc] init];
    model.name = @"lilong";
    model.age = 25;
    
    // 临时存储person1的数据
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    // 解析data，生成一个新的Person对象
    ModelArchiver *model2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    // 分别打印内存地址
    NSLog(@"model:0x%@", model); // person1:0x7177a60
    NSLog(@"model2:0x%@", model2); // person2:0x7177cf0
}

- (IBAction)writeAction:(id)sender {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"lilong06.archive"];
    [NSKeyedArchiver archiveRootObject:self.writeTextView.text toFile:filePath];

}
- (IBAction)readAction:(id)sender {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"lilong06.archive"];
    self.readTextView.text = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

- (IBAction)deleteAction:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
如果对象是NSString、NSDictionary、NSArray、NSData、NSNumber等类型，可以直接用NSKeyedArchiver进行归档和恢复
不是所有的对象都可以直接用这种方法进行归档，只有遵守了NSCoding协议的对象才可以
NSCoding协议有2个方法：
encodeWithCoder:
每次归档对象时，都会调用这个方法。一般在这个方法里面指定如何归档对象中的每个实例变量，可以使用encodeObject:forKey:方法归档实例变量
initWithCoder:
每次从文件中恢复(解码)对象时，都会调用这个方法。一般在这个方法里面指定如何解码文件中的数据为对象的实例变量，可以使用decodeObject:forKey方法解码实例变量
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
