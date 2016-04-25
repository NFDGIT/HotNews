//
//  CollCell.m
//  News
//
//  Created by qingyun on 16/4/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "CollCell.h"
#import "UIImageView+WebCache.h"
#import "ModelNews.h"

@implementation CollCell
-(void)bandingData:(ModelNews *)model{
    [self.imgView sd_setImageWithURL:model.kpic];
    self.titleLable.text=model.title;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
