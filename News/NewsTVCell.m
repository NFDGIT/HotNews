//
//  NewsTVCell.m
//  News
//
//  Created by qingyun on 16/4/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsTVCell.h"
#import "UIImageView+WebCache.h"
#import "ModelNews.h"
#import "ModelPics.h"
@interface NewsTVCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *introLabel;

@end
@implementation NewsTVCell

- (void)awakeFromNib {
    // Initialization code
}



-(void)bandingDataWithData:(ModelNews *)model{
  //  [self.imgView sd_setImageWithURL:model.kpic ];
    [self.imgView sd_setImageWithURL:model.kpic placeholderImage:[UIImage imageNamed:@"pic_imgCache"]];
    self.titleLabel.text=model.title;
    self.introLabel.text=model.intro;
    
}


//-(void)bandingDataWithData:(NSDictionary *)status{
//    
//    
//    
//    
//    self.textLabel.text=status[@"title"];
//    self.detailTextLabel.text=status[@"intro"];
//    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:status[@"kpic"]]];
//    
//    
//
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
