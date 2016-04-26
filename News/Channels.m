//
//  Channels.m
//  News
//
//  Created by qingyun on 16/4/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Channels.h"
#define  titleSettingName  @"subsSetting.plist"
#define  provinceName  @"province.plist"


#define  favoriteName  @"favorite.plist"
#define  favoritePhotoName @"photoFavorite.plist"

#define  dataCache   @"dataCache.plist"



@implementation Channels
+(instancetype)shareSetting{
    static Channels *channels;
    
     static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        
        channels =[[Channels alloc]init];
    });
    return channels;
}
-(NSArray *)provinces{
    

    
    if (!_provinces) {
    NSArray *array=@[@{@"province":@"河南",@"spelling":@"henan",@"capital":@"郑州"},
                     @{@"province":@"北京",@"spelling":@"beijing",@"capital":@"郑州"},
                     @{@"province":@"上海",@"spelling":@"shanghai",@"capital":@"郑州"},
                     @{@"province":@"天津",@"spelling":@"tianjin",@"capital":@"郑州"},
                     @{@"province":@"广东",@"spelling":@"guangdong",@"capital":@"郑州"},
                     @{@"province":@"安徽",@"spelling":@"anhui",@"capital":@"郑州"},
                     @{@"province":@"福建",@"spelling":@"fujian",@"capital":@"郑州"},
                     @{@"province":@"河北",@"spelling":@"hebei",@"capital":@"郑州"},
                     @{@"province":@"辽宁",@"spelling":@"liaoning",@"capital":@"郑州"},
                     @{@"province":@"黑龙江",@"spelling":@"heilongjiang",@"capital":@"郑州"},
                     
                      @{@"province":@"西藏",@"spelling":@"xizang",@"capital":@"郑州"},
                      @{@"province":@"山西",@"spelling":@"shanxi",@"capital":@"郑州"},
                      @{@"province":@"山东",@"spelling":@"shandong",@"capital":@"郑州"},
                      @{@"province":@"湖南",@"spelling":@"hunan",@"capital":@"郑州"},
                      @{@"province":@"湖北",@"spelling":@"hubei",@"capital":@"郑州"},
                      @{@"province":@"四川",@"spelling":@"sichuan",@"capital":@"郑州"},
                      @{@"province":@"江西",@"spelling":@"jiangxi",@"capital":@"郑州"}];
        _provinces=array;
    }
    
    return _provinces;
    
}

-(NSMutableArray *)channels{
      // [self transFromString];
    if (!_channels) {
  
        NSArray *channelsA=@[@{@"channel":@"news_toutiao",@"title":@"头条",@"isSubs":@(1)},
                    @{@"channel":@"news_tuijian",@"title":@"推荐",@"isSubs":@(1)},
                    @{@"channel":@"news_sports",@"title":@"体育",@"isSubs":@(1)},
                    @{@"channel":@"news_finance",@"title":@"金融",@"isSubs":@(1)},
                    @{@"channel":@"news_auto",@"title":@"汽车",@"isSubs":@(1)},
                    @{@"channel":@"news_collection",@"title":@"收藏",@"isSubs":@(1)},
                    @{@"channel":@"news_game",@"title":@"游戏",@"isSubs":@(1)},
                    @{@"channel":@"news_ast",@"title":@"星座",@"isSubs":@(1)},
                    @{@"channel":@"news_gossip",@"title":@"八卦",@"isSubs":@(1)},
                    @{@"channel":@"news_baby",@"title":@"育儿",@"isSubs":@(1)},
                    @{@"channel":@"news_health",@"title":@"健康",@"isSubs":@(1)},
                    @{@"channel":@"news_nba",@"title":@"NBA",@"isSubs":@(1)},
                    @{@"channel":@"news_edu",@"title":@"教育",@"isSubs":@(1)},
                    @{@"channel":@"news_digital",@"title":@"数码",@"isSubs":@(1)},
                    @{@"channel":@"news_fashion",@"title":@"时尚",@"isSubs":@(1)},
                    @{@"channel":@"news_blog",@"title":@"博客",@"isSubs":@(1)},
                    @{@"channel":@"news_eladies",@"title":@"女性",@"isSubs":@(1)},
                    @{@"channel":@"news_sh",@"title":@"社会",@"isSubs":@(1)},
                    @{@"channel":@"news_history",@"title":@"历史",@"isSubs":@(1)},
                    @{@"channel":@"news_home",@"title":@"家居",@"isSubs":@(1)},
                    @{@"channel":@"news_mil",@"title":@"军事",@"isSubs":@(1)},
                    @{@"channel":@"news_gread",@"title":@"精读",@"isSubs":@(1)},
                             

                    @{@"channel":@"house_",@"title":@"房产",@"isSubs":@(1)},
                    @{@"channel":@"zhuanlan_",@"title":@"专栏",@"isSubs":@(1)},
                    @{@"channel":@"local_",@"title":@"省份",@"isSubs":@(1)}
                    ];
        _channels=[NSMutableArray arrayWithArray:channelsA];
        //[self saveSubcribeSettingWithArray:_channels];
    }

    return _channels;
}
-(BOOL)saveFileWithName:(NSString *)name WithArray:(NSMutableArray *)array{
    NSString *documentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath=[documentPath stringByAppendingPathComponent:name];
    
    
    BOOL result=[array writeToFile:filePath atomically:YES];
    if (result) {
        
        
        return YES;
    }else{
        return NO;
    }
}
-(NSMutableArray *)getFileWithname:(NSString *)name{
    NSString *documentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath=[documentPath stringByAppendingPathComponent:name];
    
    NSMutableArray *mArray=[NSMutableArray arrayWithContentsOfFile:filePath];
    
    
    return mArray;
    
}


//保存订阅信息
-(BOOL)saveSubcribeSettingWithArray:(NSMutableArray *)array{

    return  [self saveFileWithName:titleSettingName WithArray:array];
}

//取出订阅信息
-(NSMutableArray *)getSubcribeSetting{
    NSMutableArray *subc=[self getFileWithname:titleSettingName];
    if (subc==nil) {
        subc=[NSMutableArray array];
        [subc addObject:self.channels.firstObject];
        return subc;
    }else if (subc.count==0){
        [subc addObject:self.channels.firstObject];
        return subc;
    }
    return  [self getFileWithname:titleSettingName];
}

//保存省份信息
-(BOOL)saveProvinceWithArray:(NSMutableArray *)array{

    
    
    return [self saveFileWithName:provinceName WithArray:array];
}


//取出省份信息
-(NSMutableArray *)getProvince{
    
    if ([self getFileWithname:provinceName]==nil) {
        return [self transFromString];
    }
    return  [self getFileWithname:provinceName];
}



//保存收藏信息
-(BOOL)saveFavoriteWithArray:(NSMutableArray *)favorite{

   return  [self saveFileWithName:favoriteName WithArray:favorite];
    
}
-(NSMutableArray *)getFavorite{

    return  [self getFileWithname:favoriteName];

}

-(BOOL)saveFavoritePhotoWithArray:(NSMutableArray *)favorite{
    return  [self saveFileWithName:favoritePhotoName WithArray:favorite];
}
-(NSMutableArray *)getFavoritePhoto{
return  [self getFileWithname:favoritePhotoName];
}




//判断频道类型
-(NSString *)channelTypeWithIndex:(NSInteger)index{
    
    
    NSString *channel=[self getSubcribeSetting][index][@"channel"];
    
    if([channel hasPrefix:@"house"]){
        return @"house";
    }else if([channel hasPrefix:@"local"]){
        return @"local";
    }else if([channel hasPrefix:@"zhuanlan"]){
        return @"zhuanlan";
    }else{
        return @"news";
    }
}




-(NSMutableArray *)transFromString{
    NSString *string=@"1、j山东：济南 2、j河北：石家庄 3、j吉林：长春 4、j黑龙江：哈尔滨 5、j辽宁：沈阳 6、j内蒙古：呼和浩特 7、j新疆：乌鲁木齐 8、j甘肃：兰州 9、j宁夏：银川 10、山西：太原 11、陕西：西安 12、河南：郑州 13、安徽：合肥 14、江苏：南京 15、浙江：杭州 16、福建：福州 17、广东：广州 18、江西：南昌 19、海南：海口 20、广西：南宁 21、贵州：贵阳 22、湖南：长沙 23、湖北：武汉 24、四川：成都 25、云南：昆明 26、西藏：拉萨 27、青海：西宁 28、天津：天津 29、上海：上海 30、重庆：重庆 31、北京：北京 32、台湾：台北 33、香港 34、澳门";
    NSArray *array=[string componentsSeparatedByString:@" "];
 
    
    NSMutableArray *mArray=[NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str=obj;
        NSString *str1= [str stringByReplacingCharactersInRange:NSMakeRange(0,3) withString:@""];
        NSArray *result=[str1 componentsSeparatedByString:@"："];
        NSMutableDictionary  *resultDict=[NSMutableDictionary dictionary];
        
        [resultDict setValue:result.lastObject forKey:result.firstObject];
        [resultDict setObject:result.lastObject forKey:result.firstObject];
        [mArray addObject:resultDict];
    
    }];
    
 //  NSString *strfff= ((NSString *)mArray);
    [self saveProvinceWithArray:mArray];
    return mArray;
}

//汉字转化为拼音
-(NSString *)getSpellingFromCC:(NSString *)cc{

    
    CFStringRef cfString = (__bridge CFStringRef)cc;
    
    
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, cfString);
    CFStringTransform(string, NULL, kCFStringTransformToLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *resultBefore=CFBridgingRelease(string);
    
    NSString *result=[resultBefore stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return result;

}

-(BOOL)saveFileWithName:(NSString *)name WithDict:(NSMutableDictionary *)dict{
    NSString *documentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath=[documentPath stringByAppendingPathComponent:name];
    
    
    BOOL result=[dict writeToFile:filePath atomically:YES];
    if (result) {
        
        
        return YES;
    }else{
        return NO;
    }
}
-(NSMutableDictionary *)getCacheFileWithName:(NSString *)name{
    NSString *documentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath=[documentPath stringByAppendingPathComponent:name];
    
    NSMutableDictionary *mDict=[NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    
    return mDict;
}

//缓存的处理

-(BOOL)insertCacheWithData:(NSArray *)array andKey:(NSString *)key{
    NSMutableDictionary *dataDict=[self getCacheFileWithName:dataCache];
    if (dataDict==nil) {
        dataDict=[NSMutableDictionary dictionary];
    }
    
    for (NSString *keyString in dataDict.allKeys) {
        
        if ([keyString isEqualToString:key]) {
           
            NSMutableArray *mArray=dataDict[key];
            [mArray addObjectsFromArray:array];
            
            [dataDict setObject:mArray forKey:key];
            
            
            return [self saveFileWithName:dataCache WithDict:dataDict];
        }
    }
    
    
    
    [dataDict addEntriesFromDictionary:@{key:array}];
    return [self saveFileWithName:dataCache WithDict:dataDict];
}
-(BOOL)deleteCacheWithKey:(NSString *)key{
   NSMutableDictionary *dataDict=[self getCacheFileWithName:dataCache];
    
    for (NSString *keyString in dataDict.allKeys) {
        if ([keyString isEqualToString:key]) {
            [dataDict removeObjectForKey:key];
            return [self saveFileWithName:dataCache WithDict:dataDict];
        }
    }
    
    return YES;
}


-(NSArray *)getCacheWithKey:(NSString *)key{
  NSMutableDictionary *dataDict=[self getCacheFileWithName:dataCache];
    if (dataDict==nil) {
      ///  dataDict=[NSMutableDictionary dictionary];
        return nil;
    }
    //遍历dict 的allkeys  查看是否存在要查询的key
    for (NSString *keyString in dataDict.allKeys) {
        if ([keyString isEqualToString:key]) {
            NSArray *array=dataDict[key];
            return array;
        }
    }
    
    return nil;

}

@end
