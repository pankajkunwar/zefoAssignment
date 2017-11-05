//
//  filter.m
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "filter.h"

@implementation filter

-(id) init {
    self = [super init];
    if(self) {
        // Initialize Variable Here
        
        return self;
    }
    return nil;
}

+(NSMutableArray *) parseFilerData:(NSArray *) filters {

    NSMutableArray *filterList = [NSMutableArray new];
    
    for (NSDictionary *filterDetails in filters) {
        
        filter *item = [[filter alloc] init];
        
        item.category = (NSString *)[[filterDetails allKeys] firstObject];
        item.options = [(NSArray *)[filterDetails allValues] firstObject];
        
        [filterList addObject:item];
    }
    
    return filterList;
}

@end
