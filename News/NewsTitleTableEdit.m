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
@property (nonatomic,assign)BOOL isFavorited;

@property (nonatomic,strong) NSMutableArray *currentArray;
@end

@implementation NewsTitleTableEdit
static NSString *identifierT=@"titleCell";
static NSString *identifierC=@"contentCell";


-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)awakeFromNib{
        self.hidesBottomBarWhenPushed=YES;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
}

- (void)viewDidLoad {
     [super viewDidLoad];
    _channels=[Channels shareSetting];
    

    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pic_back"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    self.contentTable.layer.shadowOffset=CGSizeMake(-2, 2);
    self.contentTable.layer.shadowOpacity=0.5;
    self.contentTable.clipsToBounds=NO;
    UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentTable.frame.size.width, 35)];
    tishi.textAlignment=NSTextAlignmentCenter;
    tishi.text=@"向左拖动,增删订阅项!";
    self.contentTable.tableHeaderView=tishi;
    
    
    self.contentTable.dataSource=self;
    self.titleTable.dataSource=self;
    
    self.contentTable.delegate=self;
    self.titleTable.delegate=self;
    
    self.currentArray=_channels.channels;
    
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
    
        
        return self.currentArray.count;
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
        
        
         [self judgeIsSubcWithDict:self.currentArray[indexPath.row]];
        
        
        
         //往内容中添加事件
        if (self.isFavorited) {
            UITableViewRowAction *action=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                if ([[Channels shareSetting] getSubcribeSetting].count>1) {
                 [self deleteSubcActionWithIndex:indexPath.row];
                }else{
                    [self popDialogBox];
                }
                [tableView reloadData];
            }];
            return @[action];
        }else{
            UITableViewRowAction *action=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"订阅" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                
                [self subcActionWithIndex:indexPath.row];
                [tableView reloadData];
            }];
            return @[action];
        }
       

    }

    return nil;
}
-(void)subcActionWithIndex:(NSInteger)index{
    NSMutableArray *subC =[[Channels shareSetting] getSubcribeSetting];
    NSDictionary *selectedChannel=[Channels shareSetting].channels[index];
    
    if (subC==nil) {
        subC =[NSMutableArray array];
        
    }
     [subC addObject:selectedChannel];
    [[Channels shareSetting] saveSubcribeSettingWithArray:subC];
}
-(void)deleteSubcActionWithIndex:(NSInteger)index{
    NSMutableArray *hadSubc=[[Channels shareSetting] getSubcribeSetting];
    
    NSDictionary *dict=[self.currentArray objectAtIndex:index];
    
    
    for (NSDictionary *currentDict in hadSubc) {
        if ([currentDict[@"channel"] isEqualToString:dict[@"channel"]]) {
            
            [hadSubc removeObject:currentDict];
            [[Channels shareSetting] saveSubcribeSettingWithArray:hadSubc];
            return;
            //self.isFavorited=NO;
            //return;
        }
    }
    //self.isFavorited=YES;
    
    
  
}
-(void)judgeIsSubcWithDict:(NSDictionary *)dict{
   NSMutableArray *hadSubc=[[Channels shareSetting] getSubcribeSetting];
    for (NSDictionary *subCdict in hadSubc) {
        if ([subCdict[@"channel"] isEqualToString:dict[@"channel"]]) {
            self.isFavorited=YES;
            return;
        }
    }
    self.isFavorited=NO;
    
}

-(void)popDialogBox{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"至少订阅一条" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
