//
//  shoppingItem.m
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "shoppingItem.h"

@implementation shoppingItem

-(id) init {
    self = [super init];
    if(self) {
        // Initialize Variable Here
        
        return self;
    }
    return nil;
}

+(NSMutableArray *) parseShoppingItemData:(NSArray *) items{
    
    NSMutableArray *shoppingList = [NSMutableArray new];
    
    for (NSDictionary *itemDetails in items) {
        
        shoppingItem *item = [[shoppingItem alloc] init];
        
        item.itemName = [itemDetails valueForKey:@"name"];
        item.type = [itemDetails valueForKey:@"type"];
        item.condition = [itemDetails valueForKey:@"condition"];
        item.logo = [itemDetails valueForKey:@"logo"];
        item.offerPrice = [itemDetails valueForKey:@"offerPrice"];
        item.orginalPrice = [itemDetails valueForKey:@"orginal Price"];
        
        [shoppingList addObject:item];
    }
    
    return shoppingList;
}


@end
