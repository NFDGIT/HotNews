//
//  FavoriteVC.m
//  News
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FavoriteVC.h"
#import "ContentVC.h"
@interface FavoriteVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
@property (nonatomic,strong)UIPageViewController *pageViewController;
@end

@implementation FavoriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
    
    [self setPageViewController];
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)segment:(UISegmentedControl *)sender {
    [self.pageViewController setViewControllers:@[[ContentVC instantWithIndex:sender.selectedSegmentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
- (IBAction)setAction:(UIBarButtonItem *)sender {
    if (self.tabBarController.view.frame.origin.x==0) {
        
        [UIView  animateWithDuration:0.2 animations: ^{
            self.tabBarController.view.transform=CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width*2/3, 0);
        } ];
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.tabBarController.view.transform=CGAffineTransformMakeTranslation(0, 0);
            
        }];
        
    }
    
    
    
    
}



-(void)setPageViewController{
    self.pageViewController=[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self.pageViewController setViewControllers:@[[ContentVC instantWithIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    
    self.pageViewController.delegate=self;
    self.pageViewController.dataSource=self;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    
    
    
    
    
    
}
#pragma  mark ---dataSource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger currentIndex=((ContentVC *)pageViewController.viewControllers.firstObject).index;
    currentIndex++;
    if (currentIndex>1) {
        return nil;
    }
    
    
    
    return [ContentVC instantWithIndex:currentIndex];
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger currentIndex=((ContentVC *)pageViewController.viewControllers.firstObject).index;
    currentIndex--;
    if (currentIndex<0) {
        return nil;
    }

    return [ContentVC instantWithIndex:currentIndex];
}


-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSInteger currentIndex=((ContentVC *)pageViewController.viewControllers.firstObject).index;
    self.segment.selectedSegmentIndex=currentIndex;
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
