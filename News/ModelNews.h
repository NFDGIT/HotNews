//
//  NewsModel.h
//  News
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelNews : NSObject



@property (nonatomic,strong)NSString *nId;
@property (nonatomic,strong)NSString *nTitle;
@property (nonatomic,strong)NSString *nIntro;
@property (nonatomic,strong)NSString *nSource;
@property (nonatomic,strong)NSString *nPic;
@property (nonatomic,strong)NSString *nKpic;
@property (nonatomic,strong)NSArray *nPics;
@property (nonatomic,strong)NSString *nLink;

@end
