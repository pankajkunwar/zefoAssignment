//
//  filter.h
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface filter : NSObject

@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSArray *options;

+(NSMutableArray *) parseFilerData:(NSArray *) filters;

@end
