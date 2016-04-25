//
//  ImageBrowerSingerVC.m
//  News
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ImageBrowerSingerVC.h"
#import "UIImageView+WebCache.h"


#define screenSize   [UIScreen mainScreen].bounds.size
@interface ImageBrowerSingerVC ()
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *imgLable;


@end

@implementation ImageBrowerSingerVC
-(instancetype)initWithIndex:(NSInteger)index  totalNum:(NSInteger)totalNum andSingerImgInfo:(NSDictionary *)singerImgInfo{
    if (self=[super init]) {
        
        self.picnubTotal=totalNum;
        self.index=index;
        
        
        
        self.picTitle=singerImgInfo[@"alt"];
        self.picUrlString=singerImgInfo[@"kpic"];
        self.view.backgroundColor = [UIColor blackColor];
        
        
        
    
    }
    return self;
}
+(instancetype)instantImagePageWithIndex:(NSInteger)index  totalNum:(NSInteger)totalNum andSingerImgInfo:(NSDictionary *)singerImgInfo{
    return [[ImageBrowerSingerVC alloc]initWithIndex:index  totalNum:(NSInteger)totalNum  andSingerImgInfo:(NSDictionary *)singerImgInfo];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame=[UIScreen mainScreen].bounds;
    //self.view.backgroundColor=[UIColor blueColor];
 
    

 
    
        [self setImgPageUI];
    
    // Do any additional setup after loading the view.
}
-(void)setImgPageUI{
    
    self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    
    self.imgLable=[[UILabel alloc]initWithFrame:CGRectMake((screenSize.width-50)/2, screenSize.height-90, 50, 20)];

    [self.view addSubview:self.imgView];
    [self.view addSubview:self.imgLable];
    
    self.imgView.contentMode=UIViewContentModeScaleAspectFit;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.picUrlString]];
    
    
    self.imgLable.text=[NSString stringWithFormat:@"%ld/%ld",self.picnubTotal,(long)self.index+1];
    self.imgLable.textColor=[UIColor whiteColor];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
