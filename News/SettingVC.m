//
//  SettingVC.m
//  News
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SettingVC.h"
#import "SDImageCache.h"
@interface SettingVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *settingTV;

@end

@implementation SettingVC
static NSString *identifier=@"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //_settingTV=[UITableView alloc]init];
    self.settingTV.delegate=self;
    self.settingTV.dataSource=self;
    
}

#pragma  mark --dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    if (indexPath.row==2) {
        cell.textLabel.text=@"清除缓存";
        SDImageCache *imageCache=[[SDImageCache alloc]init];
         NSUInteger size=[imageCache getSize];
        cell.detailTextLabel.text=@(size/1024/1024).stringValue;
    }
    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        SDImageCache *imageCache=[[SDImageCache alloc]init];
        [imageCache clearDisk];
        [_settingTV reloadData];
    }
    
}
@end
