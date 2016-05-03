//
//  NewsCellWVC.m
//  News
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsCellWVC.h"
#import "ModelNews.h"
#import "Channels.h"

#import "AFNetworking.h"

@interface NewsCellWVC () //<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *favoriteBtn;
@property (nonatomic,strong)UIWebView *webView;



@end

@implementation NewsCellWVC
+(instancetype)instantCellWVCWithUrl:(NSURL *)urlString{
    NewsCellWVC *newsCellWVC=[[NewsCellWVC alloc]init];
    newsCellWVC.urlString=urlString;
    

    return newsCellWVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self judgeSubcIsNil];
    [self setNavigation];
    
    
 //   [self judgeIsFavorited];
    
    [self setWebView];
   // [self setToolbar];

    // Do any additional setup after loading the view.
}


//确保  订阅信息  补位空   或者  个数为零
-(void)judgeSubcIsNil{
    
    NSMutableArray *subcs=[[Channels shareSetting]getSubcribeSetting];
    if (subcs==nil) {
        subcs=[NSMutableArray array];
        [subcs addObject:[Channels shareSetting].channels.firstObject];
        [[Channels shareSetting] saveSubcribeSettingWithArray:subcs];
    }else if(subcs.count==0){
        [subcs addObject:[Channels shareSetting].channels.firstObject];
        [[Channels shareSetting] saveSubcribeSettingWithArray:subcs];
    }
    
}


-(void)setNavigation{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pic_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
}
-(void)backAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self judgeIsFavorited];

}

-(void)judgeIsFavorited{
    Channels *channels=[Channels shareSetting];
    
    NSMutableArray *mArray=[channels getFavorite];
    
    if (mArray==nil){
        mArray =[NSMutableArray array];
        
        self.isFavorited=NO;
        self.favoriteBtn.tintColor=[UIColor blueColor];
        
        return;
    }
    
    
    for (NSMutableDictionary *dict in mArray) {
        
        if ([dict[@"id"] isEqualToString:self.currentModel.idstr]) {
            self.isFavorited=YES;
            self.favoriteBtn.tintColor=[UIColor redColor];
            return;
     
          }
       }
    self.isFavorited=NO;
    self.favoriteBtn.tintColor=[UIColor blueColor];
    
    
}


-(void)setToolbar{
    //self.navigationController.toolbarHidden=NO;
 
    
  //  self.navigationController.toolbarItems=[]
    
}

-(void)setWebView{
    self.webView=[[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.urlString]];
    
    
//    //获取html源码
//            NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
//    
//            NSString *HTMLSource = [self.webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
//           // NSLog(@"data  ========   %@",HTMLSource);
//    
//    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    
    
}

//-(void)webViewDidStartLoad:(UIWebView *)webView {
//    [webView stringByEvaluatingJavaScriptFromString:@"javascript:document.getElementById('head','body').style.display='none';"];
//}


//- (void)loadData {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
//    
//    [manager GET:self.urlString.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)favoriteBtn:(UIBarButtonItem *)sender {
    
  
    Channels *channels=[Channels shareSetting];
    
    //获取收藏信息
    NSMutableArray *favorite=[channels getFavorite];
    
    
    if (!self.isFavorited){
        if (favorite==nil) {
            favorite=[NSMutableArray array];
        }
        //把当前的模型存入进去
        [favorite addObject:[self.currentModel transDict]];
    
    }else{
        
            for (NSDictionary *dict in favorite) {
                
                if ([((NSString *)dict[@"id"]) isEqualToString:self.currentModel.idstr]) {
                    
                    [favorite removeObject:dict];
                }

            
            
        }
        
        
        
        self.isFavorited=NO;
        self.favoriteBtn.tintColor=[UIColor blueColor];
    }
    
    //把保存好的数组放到本地文件
   BOOL result= [channels saveFavoriteWithArray:favorite];
    
    //判断收藏状态  刷新 数据和UI
    [self judgeIsFavorited];

    
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
