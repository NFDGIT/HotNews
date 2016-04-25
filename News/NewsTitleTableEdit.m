//
//  NewsTitleTableEdit.m
//  News
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsTitleTableEdit.h"
#import "Channels.h"
@interface NewsTitleTableEdit ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *titleTable;
@property (strong, nonatomic) IBOutlet UITableView *contentTable;
@property (nonatomic,strong) Channels *channels;


@property (nonatomic,strong) NSMutableArray *currentArray;
@end

@implementation NewsTitleTableEdit
static NSString *identifierT=@"titleCell";
static NSString *identifierC=@"contentCell";

- (void)viewDidLoad {
     [super viewDidLoad];
    _channels=[Channels shareSetting];
    self.contentTable.dataSource=self;
    self.titleTable.dataSource=self;
    
    self.contentTable.delegate=self;
    self.titleTable.delegate=self;
    
   
    
   [self.contentTable registerClass:[UITableViewCell class] forCellReuseIdentifier:identifierC];
    
    
    [self.titleTable registerClass:[UITableViewCell class] forCellReuseIdentifier:identifierT];
}

#pragma  mark---dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==100) {
        return 2;
    }
        else
    if (tableView.tag==101){
    
        
        return self.channels.channels.count;
    }
    return 0;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   ///标题
    if (tableView.tag==100) {
     UITableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:identifierT forIndexPath:indexPath];
     //   cell.backgroundColor=[UIColor redColor];
        if (indexPath.row==0) {
            cell.textLabel.text=@"全部";
        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"已订阅";
        }
        return cell;
        
        
    }
    //显示内容
    else
    if (tableView.tag==101){
        UITableViewCell*cell1=[tableView dequeueReusableCellWithIdentifier:identifierC forIndexPath:indexPath];
      ///  cell1.backgroundColor=[UIColor blueColor];
        
        NSString *title=self.currentArray[indexPath.row][@"title"];
        cell1.textLabel.text=title;
        return cell1;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==100) {
        switch (indexPath.row) {
            case 0:
                self.currentArray=self.channels.channels;
                [_contentTable reloadData];
                break;
            case 1:
                
                self.currentArray=[self.channels getSubcribeSetting];
                [_contentTable reloadData];
                break;
            default:
                break;
        }

    }

}
-(NSArray <UITableViewRowAction*> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==101) {
        //往内容中添加事件
        UITableViewRowAction *action=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
        }];
        return @[action];
    }
    return nil;
}

@end
