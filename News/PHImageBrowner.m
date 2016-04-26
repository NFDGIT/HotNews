//
//  PHImageBrowner.m
//  News
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PHImageBrowner.h"
#import "ImageBrowerSingerVC.h"
#import "Channels.h"

@interface PHImageBrowner ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic,strong)UIPageViewController *imgPageBrower;
@property (nonatomic,strong)UIView *imgTitleView;

@property (nonatomic,strong)UILabel *imgTitleLable;
@property (nonatomic,strong)UILabel *imgTitleAlt;


@property (nonatomic,assign)BOOL isFavorited;

@end

@implementation PHImageBrowner
-(instancetype)initWithImgDict:(NSDictionary *)imgDict{
    if (self=[super init]){
        self.hidesBottomBarWhenPushed=YES;
        self.automaticallyAdjustsScrollViewInsets=NO;
        [self setNavigation];
        
        
        self.imageDict=imgDict;
        self.images=imgDict[@"pics"][@"list"];
        //self.images=images;
    }
    return self;
}
+(instancetype)createImageBrowerWithImgDict:(NSDictionary *)imgDict{
    
    return [[PHImageBrowner alloc ]initWithImgDict:imgDict];
    
    
    
}

-(void)setNavigation{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(favoriteBtnAction:)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pic_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
}
-(void)backAction:(UIBarButtonItem *)sender{
   // [self.navigationController popoverPresentationController];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//处理收藏事件
-(void)favoriteBtnAction:(UIBarButtonItem *)sender{
//获取收藏文件
NSMutableArray *favorite=[[Channels shareSetting] getFavoritePhoto];
    if (favorite==nil) {
        favorite=[NSMutableArray array];
        self.isFavorited=NO;
    }
    
    
    
    if (self.isFavorited) {
        for (NSDictionary *info in favorite) {
            if ([info[@"id"] isEqualToString:self.imageDict[@"id"]]) {
                [favorite removeObject:info];
                
      
                 break;
            }
        }
    
        
    }else{
        [favorite addObject:self.imageDict];
    }
//保存收藏文件
    [[Channels shareSetting] saveFavoritePhotoWithArray:favorite];
    
    [self judgeIsFavorited];
}
-(void)judgeIsFavorited{
//判断是否收藏
    NSMutableArray *favorite=[[Channels shareSetting] getFavoritePhoto];
    
    if (favorite==nil) {
        self.navigationItem.rightBarButtonItem.tintColor=[UIColor blueColor];
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blueColor]];
        self.isFavorited=NO;
        return;

    }else{
        for (NSDictionary *favoDict in favorite) {
            if ([self.imageDict[@"id"] isEqualToString:favoDict[@"id"]]){
                self.navigationItem.rightBarButtonItem.tintColor=[UIColor redColor];
                [self.navigationItem.rightBarButtonItem setTintColor:[UIColor redColor]];
                self.isFavorited=YES;
                return;
            }
        }
        self.navigationItem.rightBarButtonItem.tintColor=[UIColor blueColor];
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blueColor]];
        self.isFavorited=NO;
        return;

    }
}


//设置ImageTitleView

-(void)setImageTitleView{
    self.imgTitleView =[[UIView alloc]initWithFrame:CGRectMake(8, self.view.frame.size.height-200, self.view.frame.size.width-16, 100)];
    self.imgTitleAlt=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.imgTitleView.frame.size.width, self.imgTitleView.frame.size.height)];
    
    
    
    self.imgTitleView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.imgTitleView];
    [self.imgTitleView addSubview:self.imgTitleAlt];
    self.imgTitleAlt.backgroundColor=[UIColor blackColor];
    [self.imgTitleAlt setTextColor:[UIColor whiteColor]];
    [self.imgTitleAlt setText:self.images[0][@"alt"]];
    self.imgTitleAlt.numberOfLines=4;
    self.imgTitleView.alpha=0.6;
    
    [self.view bringSubviewToFront:self.imgTitleView];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 //   self.imgPageBrower.delegate=self;
    self.view.frame=[UIScreen mainScreen].bounds;
    self.view.backgroundColor=[UIColor blackColor];
    
    //设置标题
   
    self.imgPageBrower=[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    
    self.imgPageBrower.dataSource=self;
    self.imgPageBrower.delegate=self;
    
    
    [self addChildViewController:self.imgPageBrower];
    [self.view addSubview:self.imgPageBrower.view];
    //在图片浏览器中添加title
    
  //  self.imgTitleView=[UIView alloc]initWithFrame:CGRectMake( , <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    
    
    
    [self.imgPageBrower setViewControllers:@[[ImageBrowerSingerVC instantImagePageWithIndex:0  totalNum:self.images.count andSingerImgInfo:self.images[0]]]  direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    
    
     [self setImageTitleView];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self judgeIsFavorited];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark---datasource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    //获取当前index
    
    NSInteger currentIndex=((ImageBrowerSingerVC *)pageViewController.viewControllers.firstObject).index;
    currentIndex++;
    if (currentIndex>self.images.count-1) {
        return nil;
    }

    
    return [ImageBrowerSingerVC instantImagePageWithIndex:currentIndex totalNum:self.images.count andSingerImgInfo:self.images[currentIndex]];
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger currentIndex=((ImageBrowerSingerVC *)pageViewController.viewControllers.firstObject).index;

    currentIndex--;
    if (currentIndex<0) {
        return nil;
    }


    return [ImageBrowerSingerVC instantImagePageWithIndex:currentIndex totalNum:self.images.count andSingerImgInfo:self.images[currentIndex]];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
      NSInteger currentIndex=((ImageBrowerSingerVC *)pageViewController.viewControllers.firstObject).index;
   // self.imgTitleLable.text=self.images[currentIndex][@"intro"];
    [self.imgTitleAlt setText:self.images[currentIndex][@"alt"]];
}


@end
