//
//  VideoCell.m
//  News
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ImageCell.h"
#import "UIImageView+WebCache.h"
#import "ModelNews.h"
#import "ModelVideo.h"
@interface ImageCell ()





@end
@implementation ImageCell
-(void)bangdingData:(ModelNews *)model{
    
    ///self.imgView.layer=;
    
    
   // [self.imgView sd_setImageWithURL:model.kpic];
    [self.imgView sd_setImageWithURL:model.kpic placeholderImage:[UIImage imageNamed:@"pic_imgCache"]];
    
  //  self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.textBtn setTitle:model.title forState:UIControlStateNormal];
    
}



- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
