//
//  Pics.h
//  News
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//



#import <Foundation/Foundation.h>



@interface ModelPics : NSObject
@property (nonatomic,strong)NSString * alt;
@property (nonatomic,strong)NSString * intro;

@property (nonatomic,strong)NSURL * kpic;
@property (nonatomic,strong)NSURL * pic;


-(instancetype)initWithData:(NSDictionary *)data;
+(NSArray *)getPicsWithPics:(NSArray *)picInfo;
@end
