//
//  CollCell.h
//  News
//
//  Created by qingyun on 16/4/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ModelNews;
@interface CollCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLable;

-(void)bandingData:(ModelNews *)model;

@end
