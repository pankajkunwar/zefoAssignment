//
//  FilterViewController.h
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterDelegate <NSObject>

-(void) isFilterSelected:(NSDictionary *) filterData;

@end

@interface FilterViewController : UIViewController

@property (weak, nonatomic) id<FilterDelegate> delegate;

@end
