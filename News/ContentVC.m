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
#import "CollCell.h"
#import "PHImageBrowner.h"

@interface ContentVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UICollectionView *collectionView;


@property (nonatomic,strong)NSArray *models;
@end

@implementation ContentVC
    static NSString *identifier=@"cell";
    static NSString *identifierColl=@"collCell";


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
-(void)popHint{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有收藏任何东西,快去浏览吧!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       //跳转到  新闻页
        self.tabBarController.selectedIndex=self.index;

    }];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.models==nil){
        [self popHint];
    }else if(self.models.count==0){
        [self popHint];
    }
    
    
    switch (self.index) {
        case 0:
            [self setTableView];
            break;
        case 1:
            [self setCollectionView];
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
    self.models=[ModelNews ModelsWith:[[Channels shareSetting]getFavoritePhoto]];
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];

    
//    
    flowLayout.minimumLineSpacing=8;
    flowLayout.minimumInteritemSpacing=8;
    
    flowLayout.itemSize=CGSizeMake(150, 130);
//    flowLayout.estimatedItemSize=CGSizeMake(80, 90);
    flowLayout.sectionInset=UIEdgeInsetsMake(8, 40, 8, 40);
    

    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollCell class]) bundle:nil] forCellWithReuseIdentifier:identifierColl];
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
    return self.models.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     CollCell *collCell=[collectionView dequeueReusableCellWithReuseIdentifier:identifierColl forIndexPath:indexPath];
    [collCell bandingData:self.models[indexPath.row]];

    
    return collCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PHImageBrowner *imgBrower=[PHImageBrowner createImageBrowerWithImgDict:[[Channels shareSetting] getFavoritePhoto][indexPath.row]];
    [self.navigationController pushViewController:imgBrower animated:YES];
    
    
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
