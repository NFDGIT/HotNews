//
//  BackVC.m
//  News
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "BackVC.h"
#import "SettingVC.h"
#import "MainTabbarC.h"
@interface BackVC ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)SettingVC *settingVC;
@property (nonatomic,strong)MainTabbarC *mainVC;

@end

@implementation BackVC
-(instancetype)init{
    if (self=[super init]) {
        
      
        
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _settingVC=[storyBoard instantiateViewControllerWithIdentifier:@"setting"];
        _mainVC=[
        storyBoard instantiateViewControllerWithIdentifier:@"main"];
        
        
        [self addChildViewController:_settingVC];
        [self.view addSubview:_settingVC.view];
        
        [self addChildViewController:_mainVC];
        [self.view addSubview:_mainVC.view];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScreenEdgePanGestureRecognizer *edge=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edge:)];
    edge.edges=UIRectEdgeLeft;
    edge.delegate=self;
    
    [_mainVC.view addGestureRecognizer:edge];
    
//    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
//    [_mainVC.view addGestureRecognizer:pan];

}
-(void)pan:(UIPanGestureRecognizer *)sender{

    _mainVC.view.transform=CGAffineTransformTranslate(_mainVC.view.transform, [sender translationInView:_mainVC.view].x, 0);
    [sender setTranslation:CGPointZero inView:_mainVC.view];
   
    
}

//手势  完成主控制器的偏移
-(void)edge:(UIScreenEdgePanGestureRecognizer *)sender{
    _mainVC.view.transform=CGAffineTransformTranslate(_mainVC.view.transform, [sender translationInView:_mainVC.view].x, 0);
    [sender setTranslation:CGPointZero inView:_mainVC.view];
    
    NSLog(@"bianyuan");
    
    
    
    
    if (sender.state==UIGestureRecognizerStateEnded) {
        
        if (_mainVC.view.frame.origin.x>[UIScreen mainScreen].bounds.size.width*1/3) {
            
            [_settingVC.view reloadInputViews];
           [UIView  animateWithDuration:0.2 animations: ^{
            _mainVC.view.frame=CGRectMake([UIScreen mainScreen].bounds.size.width*2/3, 0,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
           } completion:^(BOOL finished) {
               sender.edges=UIRectEdgeRight;
           } ];
 
        }else{
            [UIView animateWithDuration:0.2 animations:^{
            _mainVC.view.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            } completion:^(BOOL finished) {
                sender.edges=UIRectEdgeLeft;
            }];

            
        }
        
    }

}


#pragma  mark  delegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
// UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:<#(nullable id)#> action:<#(nullable SEL)#>]
//    
    return YES;
}


@end
