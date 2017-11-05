//
//  DataSourceManager.h
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSourceManager : NSObject

+ (DataSourceManager *)sharedManager;

-(NSArray *) getShoppingList;
-(NSArray *) getFilterList;

@end
