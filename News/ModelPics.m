//
//  Pics.m
//  News
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ModelPics.h"
#import "Common.h"
@implementation ModelPics
-(instancetype)initWithData:(NSDictionary *)data{
    if (self=[super init]) {
        self.alt=data[pAlt];
       // self.intro=data[p];

        self.kpic=[NSURL URLWithString:data[pKpic]];
        self.pic=[NSURL URLWithString:data[pPic]];
    }
    return self;
}
+(NSArray *)getPicsWithPics:(NSArray *)picInfos{
    
    NSMutableArray *mArray=[NSMutableArray array];
    
    for (NSDictionary *info in picInfos) {
        ModelPics *model=[[ModelPics alloc]initWithData:info];
        [mArray addObject:model];
    }
    
    
    return mArray;
}
@end
