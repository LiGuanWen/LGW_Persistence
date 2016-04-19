//
//  ModelArchiver.m
//  LGW_Persistence
//
//  Created by Lilong on 16/4/18.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import "ModelArchiver.h"

@implementation ModelArchiver

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntForKey:@"age"];
    }
    return self;
}
@end
