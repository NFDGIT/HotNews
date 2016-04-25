//
//  VedioTVC.h
//  News
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTVC : UITableViewController
@property (nonatomic,assign)NSInteger index;
+(instancetype)instantWithIndex:(NSInteger)index;
@end
