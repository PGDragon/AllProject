//
//  DataModel.h
//  lianxiExtend
//
//  Created by ios on 18/2/27.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

//刷新的几种状态
typedef NS_ENUM(NSUInteger,refreshStatus) {
    refreshStatusRefresh = 0,//下拉刷新状态
    refreshStatusNormoal,
    refreshStatusLoadMore,   //上拉加载状态
    refreshStatusLoadNoMore   //上拉加载状态
};

@interface DataModel : NSObject

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *cellHeightDic;
@property (nonatomic,strong) NSMutableDictionary *cellDic;
/**
 *  当前页码
 */
@property(nonatomic,assign) int pageIndex;
@property (nonatomic,assign) refreshStatus status;


@end
