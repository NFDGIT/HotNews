//
//  Channels.h
//  News
//
//  Created by qingyun on 16/4/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channels : NSObject
@property(nonatomic,strong)NSString *province;

@property (nonatomic,strong)NSMutableArray *channels;
@property (nonatomic,strong)NSArray *provinces;


+(instancetype)shareSetting;





-(NSString *)channelTypeWithIndex:(NSInteger )index;
//保存和取出订阅信息
-(BOOL)saveSubcribeSettingWithArray:(NSMutableArray *)array;
-(NSMutableArray *)getSubcribeSetting;
//取出省份信息
-(NSMutableArray *)getProvince;

//保存  与收藏
-(BOOL)saveFavoriteWithArray:(NSMutableArray *)favorite;
-(NSMutableArray *)getFavorite;

-(BOOL)saveFavoritePhotoWithArray:(NSMutableArray *)favorite;
-(NSMutableArray *)getFavoritePhoto;



-(NSString *)getSpellingFromCC:(NSString *)source;




//数据的管理
-(BOOL)insertCacheWithData:(NSArray *)array andKey:(NSString *)key;
-(BOOL)deleteCacheWithKey:(NSString *)key;
-(NSArray *)getCacheWithKey:(NSString *)key;



@end
