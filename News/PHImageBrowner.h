//
//  PHImageBrowner.h
//  News
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHImageBrowner : UIViewController
@property (nonatomic,strong)NSMutableArray *images;
@property (nonatomic,strong)NSDictionary * imageDict;

-(instancetype)initWithImgDict:(NSDictionary *)imgDict;
+(instancetype)createImageBrowerWithImgDict:(NSDictionary *)imgDict;

@end
