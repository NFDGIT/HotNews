//
//  ContentVC.m
//  News
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ContentVC.h"
#import "Channels.h"
#import "ModelNews.h"
#import "NewsTVCell.h"
#import "NewsCellWVC.h"



@interface ContentVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UICollectionView *collectionView;


@property (nonatomic,strong)NSArray *models;
@end

@implementation ContentVC
    static NSString *identifier=@"cell";
    static NSString *identifierColl=@"Collcell";


-(instancetype)initWithIndex:(NSInteger)index{
    if (self=[super init]) {
        self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100) / 100.f green:arc4random_uniform(100) / 100.f blue:arc4random_uniform(100) / 100.f alpha:1.0f];
        self.index=index;
    }
    return self;
}
+(instancetype)instantWithIndex:(NSInteger)index{
    return [[ContentVC alloc]initWithIndex:index];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    switch (self.index) {
        case 0:
            [self setTableView];
            break;
        case 1:
          //  [self setCollectionView];
            break;
        default:
            break;
    }
    
}

-(void)setTableView{
    
  //取出本地文件   并转化为模型    且放到变量中
    
    NSMutableArray *localArray=[[Channels shareSetting] getFavorite];
    
    
    self.models=[ModelNews ModelsWith:localArray];
    
    
    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.rowHeight=100;
    
    
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    ///注册 nib文件
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewsTVCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
}
-(void)setCollectionView{
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    
    
//    
    flowLayout.minimumLineSpacing=8;
    flowLayout.minimumInteritemSpacing=8;
    flowLayout.itemSize=CGSizeMake(80, 90);
    flowLayout.estimatedItemSize=CGSizeMake(80, 90);
    flowLayout.sectionInset=UIEdgeInsetsMake(8, 8, 8, 8);
    

    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark----talble delegate
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.models==nil) {
        return 0;
    }
    return self.models.count;
}
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTVCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    [cell bandingDataWithData:self.models[indexPath.row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewsCellWVC *cellWvc=[storyBoard instantiateViewControllerWithIdentifier:@"newsCellWeb"];
    //获取当前model
    ModelNews *model=self.models[indexPath.row];
    cellWvc.currentModel=model;
    
    
    cellWvc.urlString=model.link;
    [self.navigationController pushViewController:cellWvc animated:YES];
    //收藏   将当前数组传入webView;
 
    
    
    
}



#pragma  mark ----collect delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
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
