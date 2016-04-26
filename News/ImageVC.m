//
//  VedioVC.m
//  News
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ImageVC.h"
#import "ImageTVC.h"


@interface ImageVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic,strong)UIPageViewController *pageViewController;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedC;



@end

@implementation ImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPageViewController];
    self.navigationController.navigationBar.translucent=NO;
    
    
}
-(void)setPageViewController{
    self.pageViewController=[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    self.pageViewController.dataSource=self;
    self.pageViewController.delegate=self;
    
    [self.pageViewController setViewControllers:@[[ImageTVC instantWithIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    

    
}

//segm
- (IBAction)segmentBtn:(UISegmentedControl *)sender {
    [self.pageViewController setViewControllers:@[[ImageTVC instantWithIndex:sender.selectedSegmentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
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


#pragma  mark---pageDatasource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index=((ImageTVC *)pageViewController.viewControllers.firstObject).index;
    index++;
    if (index>3) {
        return nil;
    }
    return [ImageTVC instantWithIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index=((ImageTVC *)pageViewController.viewControllers.firstObject).index;
    index--;
    
    if (index<0) {
        return nil;
    }

    return [ImageTVC instantWithIndex:index];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSInteger index=((ImageTVC *)pageViewController.viewControllers.firstObject).index;
    
    
    
    if (finished) {
        
    }
    self.segmentedC.selectedSegmentIndex=index;
    
}


@end
