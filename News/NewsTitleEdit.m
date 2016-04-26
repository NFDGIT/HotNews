//
//  titleEdit.m
//  News
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsTitleEdit.h"
#import "Channels.h"
#import "NewsTitleTableEdit.h"

@interface NewsTitleEdit ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)Channels *channels;
@end

@implementation NewsTitleEdit
static NSString *collCell=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor=[UIColor cyanColor];
    [self setCollView];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.channels=[Channels shareSetting];
    
    
}

-(void)setCollView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumLineSpacing=10;
    flowLayout.minimumInteritemSpacing=10;
   // flowLayout.itemSize=CGSizeMake(100, 30);
    flowLayout.estimatedItemSize=CGSizeMake(100, 30);
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
 
_titleCView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3) collectionViewLayout:flowLayout];
    
    
    _titleCView.delegate=self;
    _titleCView.dataSource=self;
    [self.view addSubview:_titleCView];
    
    
    
    [_titleCView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collCell];
   }
#pragma  mark ---datasource
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _channels.channels.count+1;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)  collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell *cell=
    [collectionView dequeueReusableCellWithReuseIdentifier:collCell forIndexPath:indexPath];
    
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (indexPath.row<=_channels.channels.count-1) {
        if (![[self.channels channelTypeWithIndex:indexPath.row] isEqualToString:@"local"]) {
            [btn setTitle:_channels.channels[indexPath.row][@"title"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(cesi:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [cell.contentView addSubview:btn];
            cell.backgroundColor=[UIColor redColor];
            return cell;
            
        }else{
            cell.backgroundColor=[UIColor redColor];
            [btn setTitle:@"本地" forState:UIControlStateNormal];
            [cell.contentView addSubview:btn];
            return cell;
        }
        
    }
        btn=[UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.frame=CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
     [cell.contentView addSubview:btn];
      cell.backgroundColor=[UIColor redColor];
    
    return cell;
    
}
-(void)cesi:(UIButton *)sender{
   
    NewsTitleTableEdit *titleTE=[[NewsTitleTableEdit alloc]init];
    [self.navigationController pushViewController:titleTE animated:YES];
    
}
@end
