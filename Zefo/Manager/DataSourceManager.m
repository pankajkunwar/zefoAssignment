//
//  DataSourceManager.m
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "DataSourceManager.h"

#import "shoppingItem.h"
#import "filter.h"

@implementation DataSourceManager

+ (DataSourceManager *)sharedManager {
    static DataSourceManager *_sharedRestAPIManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRestAPIManager = [[self alloc] init];
    });
    
    return _sharedRestAPIManager;
}

- (instancetype)init {
    self = [super init];
    if (self){
    }
    return self;
}

-(NSArray *) getShoppingList{
    NSData *shoppingListData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shoppingList" ofType:@"json"]];
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:shoppingListData options:0 error:&localError];
    if (localError != nil){
        NSLog(@"%@", [localError userInfo]);
    }
    return [shoppingItem parseShoppingItemData:(NSArray *)[parsedObject valueForKey:@"itemList"]];
}

- (NSArray *)getFilterList {
    NSData *shoppingListData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shoppingList" ofType:@"json"]];
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:shoppingListData options:0 error:&localError];
    if (localError != nil){
        NSLog(@"%@", [localError userInfo]);
    }
    return [filter parseFilerData:((NSArray *)[parsedObject valueForKey:@"filter"])];
}

@end
