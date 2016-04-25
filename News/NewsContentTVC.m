//
//  NewsContentTVC.m
//  News
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsContentTVC.h"
#import "NewsTVCell.h"
#import "Channels.h"
#import "Common.h"
#import "AFNetworking.h"
#import "NewsCellWVC.h"
#import "CityTV.h"
#import "ModelNews.h"



@interface NewsContentTVC ()
//数据
@property(nonatomic,strong)NSArray *models;
@property (nonatomic,strong)NSString *currentChanlStyle;

@property (nonatomic,assign)NSInteger provinCount;
@property (nonatomic,strong)NSArray *contents;
@property (nonatomic,strong)NSString *currentChannel;



@property (nonatomic ,strong)UILabel *label;
@property (nonatomic,strong)Channels *pChannels;
@property (nonatomic,strong)NSMutableArray *subcChannels;


//刷新的参数
@property (nonatomic,assign)NSInteger numbOfRefresh;
@property (nonatomic,assign)NSInteger numbOfDropdown;
@property (nonatomic,assign)BOOL isUpOrDown;


//网络是否正在请求
@property (nonatomic,assign)BOOL isNetRequesting;


@end

@implementation NewsContentTVC
static NSString *cellIdentifier=@"cell";

-(NSMutableArray *)subcChannels{
    if (_subcChannels==nil) {
        _subcChannels=[[Channels shareSetting]getSubcribeSetting];
    }
    return _subcChannels;
}


-(Channels *)pChannels{
    if (!_pChannels) {
        _pChannels=[[Channels alloc]init];
    }
    return _pChannels;
}

+(instancetype)instantTableVCWith:(NSInteger)index{
 
    NewsContentTVC  * newTVC=[[NewsContentTVC alloc]init];
    newTVC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100) / 100.f green:arc4random_uniform(100) / 100.f blue:arc4random_uniform(100) / 100.f alpha:1.0f];
    newTVC.countIndex=index;
    newTVC.currentProvince=@"henan";
    newTVC.currentCity=@"zhengzhou";
    //newTVC.view.backgroundColor=[UIColor clearColor];
    return newTVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //给下拉刷新  和  加载更多的  次数进行  初始化
    
    self.isUpOrDown=YES;
    self.numbOfDropdown=0;
    self.numbOfRefresh=0;
    
    
    
    
    
    self.navigationController.navigationBar.translucent=NO;
    
    //添加refresher
    
    self.refreshControl=[[UIRefreshControl alloc]init];
    
    
    
   // _pChannels=[[Channels alloc]init];

    self.tableView.rowHeight = 100;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewsTVCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self loadDataWithChannel:_countIndex];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NewsTVCell*cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [cell bandingDataWithData:self.models[indexPath.row]];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewsCellWVC *cellWvc=[storyBoard instantiateViewControllerWithIdentifier:@"newsCellWeb"];
    //获取当前model
    ModelNews *currentModel=self.models[indexPath.row];
    
    
    
    if ([[_pChannels channelTypeWithIndex:self.countIndex] isEqual:@"news"]||[[_pChannels channelTypeWithIndex:self.countIndex] isEqual:@"local"]) {
        

        cellWvc.urlString=currentModel.link;
        
        [self.navigationController pushViewController:cellWvc animated:YES];
    }
    
   
    //收藏   将当前数组传入webView;
    cellWvc.currentModel=currentModel;
    
    
    
}
//加载更多

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
 NSArray *currentDatas= [self.pChannels getCacheWithKey:self.currentChannel];
    
    if (currentDatas.count-indexPath.row<5){
        if (self.isUpOrDown!=NO) {
            self.isUpOrDown=NO;
            
            [self setContentWithChannel:self.currentChannel];
        }
    }
}



//判断channel的类型来加载什么样的数据


-(void)loadDataWithChannel:(NSInteger )index{
    

    NSString *channelType=[self.pChannels channelTypeWithIndex:self.countIndex];
    self.currentChanlStyle=channelType;
    
    //设置  频道参数   channel
    
    NSString *channelParam;
    
    
    
    //主要频道
    if ([channelType isEqualToString:@"news"]) {
        channelParam=self.subcChannels[index][@"channel"];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self setContentWithChannel:_pChannels.channels[index][@"channel"]];
//        });
//
    }
    

    
     //省份频道
    if ([channelType isEqualToString:@"local"]) {
        
        [self setHeaderView];
        
        NSDictionary *currentChannel=self.subcChannels[self.countIndex];
        NSString *s1=currentChannel[@"channel"];
        NSString *s2=self.currentProvince;
        
        NSString *param=[s1 stringByAppendingString:s2];
        
    
        channelParam=param;

        
        }
    //专栏频道
    if ([channelType isEqualToString:@"zhuanlan"]) {
        
    }
    //房产频道
    if ([channelType isEqualToString:@"house"]) {
       // [self.pChannels getProvince];
        [self setHeaderView];
        
        NSDictionary *currentChannel=self.subcChannels[self.countIndex];
        NSString *s1=currentChannel[@"channel"];
        NSString *s2=self.currentCity;
        
        
        
        NSString *param=[s1 stringByAppendingString:s2];
        
        
        channelParam=param;
       
        
    }
    
    //判断  本地请求还是  网络请求

    self.currentChannel=channelParam;
    NSArray *array=[self.pChannels getCacheWithKey:channelParam];
    if (array==nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self setContentWithChannel:channelParam];
        });
    }
    self.models=[ModelNews ModelsWith:array];
    [self.tableView reloadData];
}

//为本地频道添加头视图

-(void)setHeaderView{
    
    
    
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    btn.backgroundColor=[UIColor grayColor];
    
    [btn setTitle:@"切换地区" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(localHeaderBtn) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView=btn;
    
    
}
-(void)localHeaderBtn{
    
    CityTV *cityTV=[CityTV shareCityTV];
    cityTV.proORcity=self.currentChanlStyle;

    
    
    UINavigationController *cityNAC=[[UINavigationController alloc]initWithRootViewController:cityTV];
    
    [self presentViewController:cityNAC animated:YES completion:nil];
    
    
}


-(void)setContentWithChannel:(NSString *)channel{
    
    if (!self.isNetRequesting) {
        if (self.isUpOrDown) {
    [self.refreshControl beginRefreshing];
        }
 
    }

    
    

    
    //下拉刷新的参数
    NSString *times=self.isUpOrDown?@(self.numbOfRefresh).stringValue:@(self.numbOfDropdown).stringValue;
    
    NSString *upOrDown=self.isUpOrDown?@"down":@"up";
    
     
    NSDictionary * parameters=@{@"pull_direction":upOrDown,
     @"pull_times":times,
     @"channel":channel};
   

    
    AFHTTPSessionManager *session=[[AFHTTPSessionManager alloc]init];
    
    AFHTTPRequestSerializer *request=[AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer *response=[AFHTTPResponseSerializer serializer];
    
    
    
    session.requestSerializer=request;
    session.responseSerializer=response;
    
    [session GET:apiUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@", downloadProgress);
        
        if (downloadProgress.fractionCompleted==1) {
            self.isNetRequesting=NO;
        }else{
            self.isNetRequesting=YES;
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSJSONSerialization *json=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dict=(NSDictionary *)json;
        
        
        
        NSArray * contents=dict[@"data"][@"list"];
      // NSLog(@"%@",contents.firstObject);
        
        if (self.isUpOrDown) {
            [self.pChannels deleteCacheWithKey:channel];
        }
        [self.pChannels insertCacheWithData:contents andKey:channel];
        
        
        self.models=[ModelNews ModelsWith:[self.pChannels getCacheWithKey:channel]] ;
     //  self.models=[ModelNews ModelsWith:contents];
        
      // self.contents=contents;
        [self.tableView reloadData];
        
        self.numbOfDropdown++;
        self.numbOfRefresh++;
        NSLog(@"%ld",self.numbOfRefresh);
        [self.refreshControl endRefreshing];
        self.isUpOrDown=YES;
        
        
            NSLog(@"加载完成");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
#pragma  mark  ---scroll view
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"%lf",scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y<-50) {
        //self.isUpOrDown=YES;
        [self setContentWithChannel:self.currentChannel];
     //  [self loadDataWithChannel:self.countIndex];
    }

    
}


@end
