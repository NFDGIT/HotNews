//
//  CityTV.m
//  News
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "CityTV.h"
#import "Channels.h"
@interface CityTV ()
@property (nonatomic,strong) Channels *channels;
@end

@implementation CityTV
+(instancetype)shareCityTV{
    static CityTV *cityTV;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        cityTV =[[CityTV alloc]init];
    });
    
    return cityTV;
}
static NSString *cityCell=@"cityCell";
-(Channels *)channels{
    if (!_channels) {
        _channels=[Channels shareSetting];
    }
    return _channels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cityCell];
    

}

-(void)done:(UIBarButtonItem *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return  [self.channels getProvince].count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCell];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityCell];
    }
    if (indexPath.row==0) {
        cell.textLabel.text=@"定位";
        return cell;
    }
    if ([self.proORcity isEqualToString:@"local"]) {
        NSDictionary *info=[self.channels getProvince][indexPath.row-1];
        
        cell.textLabel.text=(NSString *)(info.allKeys.firstObject);
        return cell;
    }
    if ([self.proORcity isEqualToString:@"house"]) {
        NSDictionary *info=[self.channels getProvince][indexPath.row-1];
        
        cell.textLabel.text=(NSString *)(info.allValues.firstObject);
        return cell;
    }
    
    // Configure the cell...
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
   
    if ([self.proORcity isEqualToString:@"local"]) {
        
  
    
    
         if (indexPath.row!=0) {
           NSDictionary *info=[self.channels getProvince][indexPath.row-1];
          NSString *string=(NSString *)(info.allKeys.firstObject);
           if (self.changeProvince) {
            self.changeProvince(string);
          }
           [self dismissViewControllerAnimated:YES completion:nil];
          }else{
        //做定位
        
        
         }
        
        
        
    }else if([self.proORcity isEqualToString:@"house"]){
        
        if (indexPath.row!=0) {
            NSDictionary *inf=[self.channels getProvince][indexPath.row-1];
            NSString *strin=(NSString *)(inf.allValues.firstObject);
            if (self.changeProvince) {
                self.changeProvince(strin);
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            //做定位
            
            
        }
        
        
        
        
    }
    
}


@end
