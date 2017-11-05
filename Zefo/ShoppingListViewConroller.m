//
//  ShoppingListViewConroller.m
//  Zefo
//
//  Created by Pankaj on 05/11/17.
//  Copyright © 2017 VoyageUp. All rights reserved.
//

#import "ShoppingListViewConroller.h"
#import "ShoppingItemDetailsViewController.h"
#import "FilterViewController.h"

#import "ShoppingItemTableViewCell.h"

#import "ApiManager.h"
#import "DataSourceManager.h"

#import "shoppingItem.h"

@interface ShoppingListViewConroller ()<UITableViewDelegate, UITableViewDataSource, FilterDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSMutableArray *masterDataSource;

@end

@implementation ShoppingListViewConroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50.0;
    
    [self getShoppingList];
}

-(void) getShoppingList{
    self.dataSource = [[DataSourceManager sharedManager] getShoppingList];
    self.masterDataSource = [self.dataSource mutableCopy];
    
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"filterCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"filterCell"];
        }
        
        return cell;
    }else{
        ShoppingItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingItemCell"];
        if (!cell) {
            cell = [[ShoppingItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shoppingItemCell"];
        }
        
        shoppingItem *item = [self.dataSource objectAtIndex:indexPath.row];
        
        cell.itemName.text = item.itemName;
        cell.itemType.text = item.type;
        cell.itemCondition.text = item.condition;
        
        cell.offerPrice.text = [NSString stringWithFormat:@"Rs. %@",item.offerPrice];
        
        // Strike orginal Price
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Rs. %@",item.orginalPrice]];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@1
                                range:NSMakeRange(0, [attributeString length])];
        [attributeString addAttribute:NSStrikethroughColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, [attributeString length])];
        
        cell.orginalPrice.attributedText = attributeString;

        [[ApiManager sharedManager] imageWithUrl:item.logo WithCompletionblock:^(UIImage *image, NSError *error) {
            if (image) {
                cell.itemImageView.image = image;
            }
        }];
        
        return cell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <FilterDelegate>
- (void)isFilterSelected:(NSDictionary *)filterData{
    if ([filterData allKeys].count >0 && self.masterDataSource.count > 0) {
        NSMutableArray *predicateArray = [NSMutableArray new];
        for (NSString *key in [filterData allKeys]) {
            for (NSString *value in [filterData valueForKey:key]) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like %@",key,value]; 
                [predicateArray addObject:predicate];
            }
        }
        NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicateArray];
        self.dataSource = [[self.masterDataSource filteredArrayUsingPredicate:compoundPredicate] mutableCopy];
    }else{
        self.dataSource = [self.masterDataSource mutableCopy];
    }
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"itemDetails"]) {
        ShoppingItemDetailsViewController *shoppingDetailsVC = [segue destinationViewController];
        
        shoppingItem *item = [self.dataSource objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        shoppingDetailsVC.item = item;
    }else if ([segue.identifier isEqualToString:@"filter"]){
        FilterViewController *filterVC = [segue destinationViewController];
        filterVC.delegate = self;
    }
}



@end
