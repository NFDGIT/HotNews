//
//  NewsModel.h
//  News
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger, NShowStyle) {
    common,
    big_image_show,
    };



//@class  ModelVideo;
@interface ModelNews : NSObject

//加判断的属性
@property (nonatomic,assign)BOOL isFavorite;

@property (nonatomic,strong)NSString * feedShowStyle;
@property (nonatomic,strong)NSArray *pics;
//@property (nonatomic,strong)ModelVideo *video;

@property (nonatomic,strong)NSString *idstr;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *intro;
@property (nonatomic,strong)NSString *source;
@property (nonatomic,strong)NSURL *pic;
@property (nonatomic,strong)NSURL *kpic;
@property (nonatomic,strong)NSURL *link;


-(instancetype)initWithData:(NSDictionary *)data;
+(NSArray *)ModelsWith:(NSArray *)datas;

-(NSMutableDictionary *)transDict;
@end
