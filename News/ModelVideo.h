//
//  ModelVideo.h
//  News
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelVideo : NSObject
@property (nonatomic,strong) NSURL * kpic;
@property (nonatomic,strong) NSURL *pic;
@property (nonatomic,assign) NSTimeInterval runtime;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSURL * url;
@property (nonatomic,strong) NSString * video_id;
-(instancetype)initWithData:(NSDictionary *)data;
+(instancetype)modelWithData:(NSDictionary *)data;
@end
