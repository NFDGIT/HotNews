//
//  NewsContentTVC.h
//  News
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface NewsContentTVC : UITableViewController
@property (nonatomic,assign)NSInteger countIndex;
@property (nonatomic,strong)NSString *nIconUrl;
@property (nonatomic,strong)NSString *nTitle;
@property (nonatomic,strong)NSString *nIntro;


@property (nonatomic,strong)NSString *currentProvince;
@property (nonatomic,strong)NSString *currentCity;


+(instancetype)instantTableVCWith:(NSInteger )index;

@end
