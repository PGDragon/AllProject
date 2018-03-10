//
//  DataModel.m
//  lianxiExtend
//
//  Created by ios on 18/2/27.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

-(instancetype)init{
    self = [super init];
    if(self){
        _dataArray = [[NSMutableArray alloc]init];
        _cellDic = [[NSMutableDictionary alloc]init];
        _cellHeightDic = [[NSMutableDictionary alloc]init];
        _pageIndex = 1;
    }
    return self;
}

@end
