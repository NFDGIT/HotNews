//
//  ImageBrowerSingerVC.h
//  News
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageBrowerSingerVC : UIViewController
@property (nonatomic,assign)NSInteger index;

@property (nonatomic,strong)NSDictionary * singerImgInfo;

@property (nonatomic,strong)NSString * picUrlString;
@property (nonatomic,strong)NSString * picTitle;
@property (nonatomic,assign)NSInteger  picnubTotal;


-(instancetype)initWithIndex:(NSInteger)index totalNum:(NSInteger)totalNum andSingerImgInfo:(NSDictionary *)singerImgInfo;
+(instancetype)instantImagePageWithIndex:(NSInteger)index totalNum:(NSInteger)totalNum  andSingerImgInfo:(NSDictionary *)singerImgInfo;



@end
