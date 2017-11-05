//
//  shoppingItem.h
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shoppingItem : NSObject

@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSString *logo;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *condition;
@property (strong, nonatomic) NSString *offerPrice;
@property (strong, nonatomic) NSString *orginalPrice;

+(NSMutableArray *) parseShoppingItemData:(NSArray *) items;


@end
