//
//  ViewController.m
//  News
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"//Users/qingyun/Desktop/彭辉/项目/0414/News/News
#import "NewsContentTVC.h"
#import "Channels.h"
#import "NewsTitleEdit.h"
#import "CityTV.h"
#import "NewsTitleTableEdit.h"


#define  tY  5
#define  tW  50
#define  tS  20


@interface ViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
//用来保存 当前 城市和省份 便于初始化时加载已选好的数据
@property (nonatomic,strong)NSString *currentCity;
@property (nonatomic,strong)NSString *currentProvince;



@property (nonatomic,assign)NSInteger currentIndex;

//views
@property (nonatomic,strong)UIScrollView *titleSV;


//@property (nonatomic,strong)NSMutableArray *channels;//频道
@property (nonatomic,strong)Channels *pChannels;
@property (nonatomic,strong)NSMutableArray *subcChannels;

@end

@implementation ViewController

{
    UIPageViewController *_pageViewController;
    int _currentPage;
  

}
//-(NSMutableArray *)subcChannels{
//    if (_subcChannels==nil) {
//        _subcChannels=[[Channels shareSetting]getSubcribeSetting];
//    }
//    return _subcChannels;
//}

-(void)popHint{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"默认订阅太少？点击右上角订阅你喜欢的栏目吧!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //跳转到  新闻页
       // self.tabBarController.selectedIndex=1;
        
        
        
    }];
    
    [alert addAction:action];
  
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pChannels=[[Channels alloc]init];
    self.subcChannels=[self.pChannels getSubcribeSetting];
    [self refreshTitleView];
    

    
    self.currentProvince=@"henan";
    self.currentCity=@"zhengzhou";
    
    
    self.navigationController.navigationBar.translucent=NO;
 
    
       [self relizeBlock];
    
    
    //设置ui
    
    
    [self createUI];
    
    _titleSV=[self setTitleViewWithFrame:self.navigationItem.titleView.frame];
    
    [self.navigationItem.titleView addSubview:_titleSV];
    
    
    //初始化 程序 刚运行时   titleView  默认哪个为选中状态
    for (UIButton *btn in self.titleSV.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag==100) {
                btn.selected=YES;
            }
        }
    }

    
    if (self.subcChannels.count<2) {
        [self popHint];
    }
  ///  NSLog(@"%d",_currentPage);
}

-(void)refreshTitleView{
    [self.navigationItem.titleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titleSV=[self setTitleViewWithFrame:self.navigationItem.titleView.frame];
    [self.navigationItem.titleView addSubview:_titleSV];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.subcChannels=[[Channels shareSetting]getSubcribeSetting];

    [self refreshTitleView];
    
}
-(void)relizeBlock{
    
    CityTV *city=[CityTV shareCityTV];
    city.changeProvince=^(NSString  *province){
        
        NewsContentTVC *contentTVC=[NewsContentTVC instantTableVCWith:self.currentIndex];
        
        
        
        
        contentTVC.currentProvince=[self.pChannels  getSpellingFromCC:province];
        contentTVC.currentCity=[self.pChannels getSpellingFromCC:province];
        
        [_pageViewController setViewControllers:@[contentTVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
        
        UIButton *button=[_titleSV viewWithTag:self.currentIndex+100];
        [button setTitle:province forState:UIControlStateNormal];
        
        
        
        
    };
    

    
    
}
-(UIScrollView *)setTitleViewWithFrame:(CGRect )frame{
    ///标题的尺寸

    CGFloat tH=frame.size.height-2*tY;
    
    
    UIScrollView *titleSV=[[UIScrollView alloc]init];
    titleSV.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    //titleSV.backgroundColor=[UIColor redColor];
    
        for (int i=0; i<self.subcChannels.count; i++) {
            
            titleSV.contentSize=CGSizeMake((tS+tW)*(i+1)+tS,frame.size.height);
            CGFloat tX=tS*(i+1)+tW*i;
            
            UIButton *titleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            titleBtn.frame=CGRectMake(tX, tY, tW, tH);
            
            if (![[_pChannels channelTypeWithIndex:i] isEqualToString:@"local"]) {
                [titleBtn setTitle:self.subcChannels[i][@"title"] forState:UIControlStateNormal];
                [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                
            }
            
//            [titleBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
            [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            titleBtn.tag=100+i;
            titleBtn.backgroundColor=[UIColor colorWithRed:0.9 green:0.5 blue:0.9 alpha:1];
            titleBtn.layer.cornerRadius=5;
            [titleSV addSubview:titleBtn];
            
           
        }
    return titleSV;
}
//添加titleView的点击事件
-(void)titleBtnClick:(UIButton *)sender{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        NewsContentTVC *newContentTVC=[NewsContentTVC instantTableVCWith:sender.tag-100];
        newContentTVC.currentCity=self.currentCity;
        newContentTVC.currentProvince=self.currentProvince;
        
        
        [_pageViewController setViewControllers:@[newContentTVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        self.currentIndex=sender.tag-100;
    }];
    
    for (UIButton *btn in sender.superview.subviews) {
        
        if ([btn isKindOfClass:[UIButton class]]) {
           btn.selected=NO;
        }
    }
    
    sender.selected=YES;
}

- (IBAction)setAction:(UIBarButtonItem *)sender {
    if (self.tabBarController.view.frame.origin.x==0) {
        
        [UIView  animateWithDuration:0.2 animations: ^{
            self.tabBarController.view.transform=CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width*2/5, 0);
        } ];
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
        self.tabBarController.view.transform=CGAffineTransformMakeTranslation(0, 0);
            
        }];
        
    }
    
    
    
}



-(void)createUI{
    _pageViewController=[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    [_pageViewController setViewControllers:@[[NewsContentTVC instantTableVCWith:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    _pageViewController.delegate=self;
    _pageViewController.dataSource=self;

    
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];

}
- (IBAction)editTB:(UIBarButtonItem *)sender {
    
    NewsTitleTableEdit *titleEdit=[[NewsTitleTableEdit alloc]init];
    titleEdit.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:titleEdit animated:YES];

}
                              
                              
# pragma  mark ---datasource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    NewsContentTVC *cont= (NewsContentTVC*)viewController;
    NSInteger index = cont.countIndex;

    index--;
    if (index < 0) {
        return nil;
    }
    
    self.currentIndex=index;
    return [NewsContentTVC instantTableVCWith:index];

}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    
    NewsContentTVC *cont = (NewsContentTVC *)viewController;
    NSInteger index = cont.countIndex;

    index++;
    if (index > self.subcChannels.count-1) {
        return nil;
    }
    self.currentIndex=index;
    
    return [NewsContentTVC instantTableVCWith:index];

}


-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSInteger index = 0;
    index=((NewsContentTVC *)(pageViewController.viewControllers.firstObject)).countIndex;
    if (completed) {
        
        [self setTitleSVWithIndex:index];
        
        NSLog(@"%ld",index);
        
       // _titleSV.contentOffset=CGPointMake((tW+tS)*index, 0);
    }
    
    
}
-(void)setTitleSVWithIndex:(NSInteger )index{
    self.titleSV.contentOffset=CGPointMake((tW+tS)*index+tS-120, 0);
    [self.titleSV.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton *)obj;
            [btn setSelected:NO];
            if (btn.tag==index+100){
                [btn setSelected:YES];
            }
        }
        
        
    }];
    
    
}

@end
