//
//  NewsCellWVC.h
//  News
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelNews;

@interface NewsCellWVC : UIViewController
@property (nonatomic,strong)NSURL *urlString;


@property (nonatomic,strong)ModelNews *currentModel;


@property (nonatomic,assign)BOOL isFavorited;

+(instancetype)instantCellWVCWithUrl:(NSURL *)urlString;
@end
