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
#import "ImageCell.h"
#import "ModelPics.h"
#import "Channels.h"


#import "PHImageBrowner.h"

//#import "UIViewController+PHRefresher.h"
//#import <AVKit/AVKit.h>
//#import <AVFoundation/AVFoundation.h>


#import "ModelNews.h"
#import "ModelVideo.h"

@interface ImageTVC ()
@property (nonatomic,strong)NSArray *contents;
@property (nonatomic,strong)NSArray *models;

@property (nonatomic,strong)NSArray *params;

//@property (nonatomic,strong)AVPlayer *player;
@property (nonatomic,assign)NSInteger numbOfRefresh;
@property (nonatomic,assign)NSInteger numbOfDropdown;

//判断是刷新还是加载更多
@property (nonatomic,assign)BOOL isUpOrDown;

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

-(void)judgeLocaOrNet{
    Channels *dataManager=[Channels shareSetting];
  NSArray *localArray=[dataManager getCacheWithKey:self.params[self.index][@"channel"] ];
    if (localArray) {
        //如果本地有文件   把文件  传给属性   以便   跳转到图片浏览器时  把文件传给   浏览器
        self.contents=localArray;
        
        self.models=[ModelNews ModelsWith:localArray];
        
        [self.tableView reloadData];
    }else{
    [self downLoadFromNetWithParam:self.params[self.index]];
        
    }
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.numbOfDropdown=0;
    self.numbOfRefresh=0;
    
    self.tableView.rowHeight=250;


    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ImageCell class]) bundle:nil] forCellReuseIdentifier:identifier];

    [self judgeLocaOrNet];
    ///创建下拉刷新
    
    self.refreshControl=[[UIRefreshControl alloc]init];

    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.sectionHeaderHeight=20;
    tableView.sectionFooterHeight=40;
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // Configure the cell...
    cell.backgroundColor=[UIColor clearColor];
    
    
    
    //获取当前模型
    ModelNews *model=self.models[indexPath.section];
    

    [cell.imgView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    
    
   // [cell.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    [cell bangdingData:model];
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出当前模型
    ModelNews *modelNews=self.models[indexPath.section];
    
    NSMutableArray *picInfos=[NSMutableArray array];
    
    for (ModelPics *modelPic in modelNews.pics) {
        
        

        NSDictionary  *dict=@{@"urlString":modelPic.kpic.absoluteString,@"alt":modelPic.alt};
        
        
        [picInfos addObject:dict];
    }
    
    PHImageBrowner *imgBrower=[PHImageBrowner createImageBrowerWithImgDict:self.contents[indexPath.section]];
    
    //给   浏览器 传值

 
    
    
    
    [self.navigationController pushViewController:imgBrower animated:YES];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.contents.count-indexPath.section<3) {
        
        
        if (self.isUpOrDown!=NO) {
            self.isUpOrDown=NO;
            self.numbOfDropdown++;
            [self downLoadFromNetWithParam:self.params[self.index]];
        }
        
    }
    
    
    
}


-(void)downLoadFromNetWithParam:(NSDictionary *)param{
    [self.refreshControl beginRefreshing];
    
    //判断下拉还是刷新并改变参数
    NSString *upOrDown=self.isUpOrDown?@"down":@"up";
    
    NSString *times=self.isUpOrDown?@(self.numbOfRefresh).stringValue:@(self.numbOfDropdown).stringValue;
    
    //下拉刷新的参数
    
     
    NSMutableDictionary  * parameters= [NSMutableDictionary dictionaryWithDictionary:@{@"pull_direction":upOrDown,@"pull_times":times}];
    [parameters addEntriesFromDictionary:param];
    
    
  
    
    AFHTTPSessionManager  *manager=[[AFHTTPSessionManager alloc]init];
    
    
      NSLog(@">>>%@",parameters);
    
    [manager GET:apiUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *result=((NSDictionary *)responseObject)[@"data"][@"list"];
        
        //把原始数据传送给  self.contents;
        self.contents=result;
        
        //self.contents=result;
        

        [self.refreshControl endRefreshing];
        self.numbOfRefresh++;
        
        
    //判断是  下拉刷新 还是加载更多
        if (self.isUpOrDown) {
            //下拉刷新  先清空本地的数据
            [[Channels shareSetting] deleteCacheWithKey:self.params[self.index][@"channel"] ];
        }
        
        
        
    ///把网络上请求的数据存储到本地
   [[Channels shareSetting] insertCacheWithData:result andKey:self.params[self.index][@"channel"]];
   
        
     //网络请求成功后  把存储到  本地的数据  传给  self.contents
        self.contents=[[Channels shareSetting] getCacheWithKey:@"channel"];
        
        
        
        
    //把本地的数据   读取到内存
        
    self.models=[ModelNews ModelsWith:[[Channels shareSetting] getCacheWithKey:self.params[self.index][@"channel"]]];
        
        
    //锁定  让下拉刷新可以 执行
    self.isUpOrDown=YES;
    [self.tableView reloadData];
        
       // NSLog(@"<<<<%ld",result.count);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma  mark ---图片浏览器

#pragma  mark----scroll view

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
    //NSLog(@">>>>>>>>%lf",scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y<-30) {
        self.isUpOrDown=YES;
        
       // [[Channels shareSetting] deleteCacheWithKey:self.params[self.index][@"channel"]];
        [self downLoadFromNetWithParam:self.params[self.index]];
    }
    
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
