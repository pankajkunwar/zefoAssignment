//
//  ShoppingItemTableViewCell.h
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemType;
@property (weak, nonatomic) IBOutlet UILabel *itemCondition;
@property (weak, nonatomic) IBOutlet UILabel *offerPrice;
@property (weak, nonatomic) IBOutlet UILabel *orginalPrice;

@property (weak, nonatomic) IBOutlet UIButton *itemTypeButton;

@end
