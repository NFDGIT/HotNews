//
//  NewsTVCell.h
//  News
//
//  Created by qingyun on 16/4/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ModelNews;
@interface NewsTVCell : UITableViewCell
-(void)bandingDataWithData:(ModelNews *)model;
@end
