//
//  ShoppingItemDetailsViewController.m
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "ShoppingItemDetailsViewController.h"

#import "ShoppingItemTableViewCell.h"

#import "ApiManager.h"

@interface ShoppingItemDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShoppingItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50.0;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ShoppingItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logoCell"];
        if (!cell) {
            cell = [[ShoppingItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logoCell"];
        }
        
        [[ApiManager sharedManager] imageWithUrl:self.item.logo WithCompletionblock:^(UIImage *image, NSError *error) {
            if (image) {
                cell.itemImageView.image = image;
            }
        }];

        
        return cell;
    }else{
        ShoppingItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemDetailsCell"];
        if (!cell) {
            cell = [[ShoppingItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemDetailsCell"];
        }
        
        
        cell.itemName.text = self.item.itemName;
        
        cell.offerPrice.text = [NSString stringWithFormat:@"Rs. %@",self.item.offerPrice];
        
        // Strike orginal Price
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Rs. %@",self.item.orginalPrice]];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@1
                                range:NSMakeRange(0, [attributeString length])];
        [attributeString addAttribute:NSStrikethroughColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, [attributeString length])];
        
        cell.orginalPrice.attributedText = attributeString;
        
        cell.itemTypeButton.layer.cornerRadius = 3.0f;
        cell.itemTypeButton.layer.borderWidth = 1.0f;
        cell.itemTypeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [cell.itemTypeButton setTitle:self.item.condition forState:UIControlStateNormal];
        
        return cell;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
