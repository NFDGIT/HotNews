//
//  titleEdit.m
//  News
//
//  Created by qingyun on 16/4/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsTitleEdit.h"

@interface NewsTitleEdit ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation NewsTitleEdit
static NSString *collCell=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    
    
}
-(void)setCollView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumLineSpacing=2;
    flowLayout.minimumInteritemSpacing=10;
    flowLayout.itemSize=CGSizeMake(30, 20);
    flowLayout.estimatedItemSize=CGSizeMake(30, 20);
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
 
_titleCView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3) collectionViewLayout:flowLayout];
    _titleCView.delegate=self;
    _titleCView.dataSource=self;
    
    [_titleCView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collCell];
   }
#pragma  mark ---datasource
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 100;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)  collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell *cell=
    [collectionView dequeueReusableCellWithReuseIdentifier:collCell forIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
    return cell;
    
}

@end
