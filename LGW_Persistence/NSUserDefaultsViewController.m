//
//  NSUserDefaultsViewController.m
//  LGW_Persistence
//
//  Created by Lilong on 16/4/18.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import "NSUserDefaultsViewController.h"

@interface NSUserDefaultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *writeTextView;
@property (weak, nonatomic) IBOutlet UITextView *readTextView;

@end

@implementation NSUserDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)writeAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.writeTextView.text forKey:@"lilong"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)deleteAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lilong"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)readAction:(id)sender {
    self.readTextView.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"lilong"];
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
