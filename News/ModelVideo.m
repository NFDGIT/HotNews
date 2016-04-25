//
//  ModelVideo.m
//  News
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ModelVideo.h"
#import "Common.h"
@implementation ModelVideo
-(instancetype)initWithData:(NSDictionary *)data{
    if (self=[super init]) {
        self.kpic=[NSURL URLWithString:data[vKpic]];
        self.pic=[NSURL URLWithString:data[vPic]];
        self.runtime= ((NSString *)data[vRuntime]).integerValue;
        self.url=[NSURL URLWithString:data[vUrl]];
        self.type=data[vType];

    }
    return self;
}
+(instancetype)modelWithData:(NSDictionary *)data{
    
    return  [[ModelVideo alloc]initWithData:data];
}
@end
