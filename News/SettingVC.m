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
    
    self.settingTV.backgroundColor=[UIColor clearColor];
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
    

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"";
            break;
        case 1:
            
            break;
        case 2:{
            cell.textLabel.text=@"清除缓存";
            SDImageCache *imageCache=[[SDImageCache alloc]init];
            NSUInteger size=[imageCache getSize];
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@ M",@(size/1024/1024).stringValue];
        }
            break;
        case 3:
            cell.textLabel.text=@"关于";
            break;
        case 4:
            cell.textLabel.text=@"退出当前应用";
            cell.textLabel.textColor=[UIColor redColor];
            break;
     
            
        default:
            break;
    }
    
    cell.layer.shadowOffset=CGSizeMake(-2, 2);
    cell.layer.shadowOpacity=0.5;
    cell.clipsToBounds=NO;
    
    
  //  cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:{
            SDImageCache *imageCache=[[SDImageCache alloc]init];
            [imageCache clearDisk];
            [self.settingTV reloadData];
        }
            break;
        case 3:
             [self popDialogBox];
            break;
        case 4:
            [self popExit];
            break;
            
            
        default:
            break;
    }
    
}

-(void)popDialogBox{
    
    NSString *version=[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"当前版本" message:[NSString stringWithFormat:@"当前版本为:%@.0",version] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)popExit{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"警告" message:@"将要退出当前程序!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        exit(1);
    }];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
      [alert addAction:action1];
    [alert addAction:action];
  
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
