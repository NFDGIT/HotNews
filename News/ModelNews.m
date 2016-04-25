//
//  NewsModel.m
//  News
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ModelNews.h"
#import "ModelPics.h"
#import "Common.h"
//#import "ModelVideo.h"
@implementation ModelNews


+(NSArray *)ModelsWith:(NSArray *)datas{
    NSMutableArray *mArray=[NSMutableArray array];
    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict=(NSDictionary *)obj;
        ModelNews *model=[[ModelNews alloc]initWithData:dict];
        
    
       [mArray addObject:model];
    }];
    return mArray;
}

-(instancetype)initWithData:(NSDictionary *)data{
    if (self=[super init]) {
       
        self.idstr=data[nId];
        
        self.kpic=[NSURL URLWithString:data[nKpic]];
        self.pic=[NSURL URLWithString:data[nPic]];
        self.link=[NSURL URLWithString:data[nLink]];
        self.title=data[nTitle];
        self.source=data[nSource];
        self.intro=data[nIntro];
        
        
        self.feedShowStyle=data[nFeedShowStyle];
        if (data[nPics]) {
        self.pics=[ModelPics getPicsWithPics:data[nPics][@"list"]];
        }
//        if (data[nVideo_info]) {
//            self.video=[ModelVideo modelWithData:data[nVideo_info]];
//        }
//        
        
        
        
    }
    return self;
}


//@property (nonatomic,assign)BOOL isFavorite;
//
//@property (nonatomic,strong)NSString * feedShowStyle;
//@property (nonatomic,strong)NSArray *pics;
//
//
//@property (nonatomic,strong)NSString *idstr;
//@property (nonatomic,strong)NSString *title;
//@property (nonatomic,strong)NSString *intro;
//@property (nonatomic,strong)NSString *source;
//@property (nonatomic,strong)NSURL *pic;
//@property (nonatomic,strong)NSURL *kpic;
//@property (nonatomic,strong)NSURL *link;
-(NSDictionary *)transDict{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjects:@[self.idstr,self.title,self.intro,self.source,self.kpic.absoluteString,self.link.absoluteString] forKeys:@[@"id",@"title",@"intro",@"source",@"kpic",@"link"]];
    return dict;
}


@end
