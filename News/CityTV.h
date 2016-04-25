//
//  CityTV.h
//  News
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTV : UITableViewController


+(instancetype)shareCityTV;


@property (nonatomic,strong)void(^changeProvince)(NSString * province);

@property (nonatomic,strong)NSString *proORcity;
@end
