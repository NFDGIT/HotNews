//
//  ContentVC.h
//  News
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentVC : UIViewController


@property (nonatomic,assign) NSInteger index;
-(instancetype)initWithIndex:(NSInteger)index;
+(instancetype)instantWithIndex:(NSInteger)index;
@end
