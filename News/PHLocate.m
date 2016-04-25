//
//  PHLocate.m
//  News
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PHLocate.h"

@interface PHLocate ()

@end

@implementation PHLocate


+(instancetype)shareLocate{
    static PHLocate *locate;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        locate =[[PHLocate alloc]init];
    });
    
    return locate;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
-(NSString *)getCurrentProvince{
    return nil;
}
-(NSString *)getCurrentCity{
    
    return nil;
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
