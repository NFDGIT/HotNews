//
//  VedioVC.m
//  News
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ImageVC.h"
#import "VedioTVC.h"


@interface ImageVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic,strong)UIPageViewController *pageViewController;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedC;



@end

@implementation VedioVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPageViewController];
    
    
    
}
-(void)setPageViewController{
    self.pageViewController=[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    self.pageViewController.dataSource=self;
    self.pageViewController.delegate=self;
    
    [self.pageViewController setViewControllers:@[[VedioTVC instantWithIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    

    
}

//segm
- (IBAction)segmentBtn:(UISegmentedControl *)sender {
    [self.pageViewController setViewControllers:@[[VedioTVC instantWithIndex:sender.selectedSegmentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
#pragma  mark---pageDatasource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index=((VedioTVC *)pageViewController.viewControllers.firstObject).index;
    index++;
    if (index>3) {
        return nil;
    }
    return [VedioTVC instantWithIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index=((VedioTVC *)pageViewController.viewControllers.firstObject).index;
    index--;
    
    if (index<0) {
        return nil;
    }

    return [VedioTVC instantWithIndex:index];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSInteger index=((VedioTVC *)pageViewController.viewControllers.firstObject).index;
    
    
    
    if (finished) {
        
    }
    self.segmentedC.selectedSegmentIndex=index;
    
}


@end
