//
//  VedioTVC.m
//  News
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ImageTVC.h"
#import "AFNetworking.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "VideoCell.h"
#import "ModelPics.h"
//#import <AVKit/AVKit.h>
//#import <AVFoundation/AVFoundation.h>


#import "ModelNews.h"
#import "ModelVideo.h"

@interface ImageTVC ()
@property (nonatomic,strong)NSArray *contents;


@property (nonatomic,strong)NSArray *params;

//@property (nonatomic,strong)AVPlayer *player;

@end

@implementation ImageTVC
static NSString *identifier=@"reuseIdentifier";

-(NSArray*)params{
    if (!_params) {
        _params=@[@{@"channel":@"hdpic_pretty"},
                  @{@"channel":@"hdpic_toutiao"},
                  @{@"channel":@"hdpic_funny"},
                  @{@"channel":@"hdpic_story"}];
        
    }
    return _params;
}

-(instancetype)initWithIndex:(NSInteger)index{
    if (self=[super init]) {
        self.index=index;
       // self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100) / 100.f green:arc4random_uniform(100) / 100.f blue:arc4random_uniform(100) / 100.f alpha:1.0f];
        
    }
    return self;
}
+(instancetype)instantWithIndex:(NSInteger)index{
    ImageTVC *vedioTVC=[[ImageTVC alloc]initWithIndex:index];
    
    return vedioTVC;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight=250;
    
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VideoCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
    
    [self downLoadFromNetWithParam:self.params[self.index]];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.contents.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.sectionHeaderHeight=20;
    tableView.sectionFooterHeight=40;
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // Configure the cell...
    cell.backgroundColor=[UIColor clearColor];
    
    
    
    //获取当前模型
    ModelNews *model=self.contents[indexPath.section];
    

    [cell.imgView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    
    
   // [cell.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    [cell bangdingData:model];
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    //获取当前的model
    ModelNews *modelNews=self.contents[indexPath.section];
  //  ModelVideo *modelVideo=modelNews.video;
    
    //[self PlayerActionWithView:cell.imgView andUrl:modelVideo.url];
    
}



-(void)downLoadFromNetWithParam:(NSDictionary *)param{
    AFHTTPSessionManager  *manager=[[AFHTTPSessionManager alloc]init];
    
    
    
    
    [manager GET:apiUrl parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *result=((NSDictionary *)responseObject)[@"data"][@"list"];
        
        
        
        self.contents=[ModelNews ModelsWith:result];
        
        
        
        //self.contents=result;
        
        [self.tableView reloadData];
        NSLog(@"<<<<%ld",result.count);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma  mark  --视频播放器
/*

//视频播放器
- (void)PlayerActionWithView:(UIView *)view andUrl:(NSURL *)url{
    
    
    
  //1.创建媒体管理对象
    AVPlayerItem *item=[[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"124" ofType:@"m4v"]]];
    
    //2.创建播放器对象
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    //生成Layer图层,可以用来显示
    AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
    //设置layer区域 frame
    playerLayer.frame=CGRectMake(0, 0 ,view.frame.size.width, view.frame.size
                                 .height);
    //设置视频的填充区域
    playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;
    //添加显示
    
    //playerLayer.style=
    
     [view.layer addSublayer:playerLayer];
    
    [self addNOtifcation];
    [self.player play];
    
}
-(void)addNOtifcation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playfinsh:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
}
-(void)playfinsh:(NSNotification *)fication{
    NSLog(@"======%@",fication);
    //移除layer
}
*/




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
