//
//  ModelArchiver.h
//  LGW_Persistence
//
//  Created by Lilong on 16/4/18.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelArchiver : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int age;
@end
