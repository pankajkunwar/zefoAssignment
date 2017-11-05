//
//  FilterViewController.m
//  Zefo
//
//  Created by Pankaj Kunwar on 05/11/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "FilterViewController.h"
#import "DataSourceManager.h"
#import "filter.h"

@interface FilterViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSMutableDictionary *selectedFilter;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // create a right navigation bar button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                              style:UIBarButtonItemStyleDone target:self
                                                                             action:@selector(applyFilter)];
    self.selectedFilter = [NSMutableDictionary new];
    [self getfilterList];
}

-(void) getfilterList{
    self.dataSource = [[DataSourceManager sharedManager] getFilterList];
    
    [self.tableView reloadData];
}

- (void) applyFilter {
    if ([self.delegate respondsToSelector:@selector(isFilterSelected:)]) {
        [self.delegate isFilterSelected:self.selectedFilter];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((filter *)[self.dataSource objectAtIndex:section]).options.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.text = ((filter *)[self.dataSource objectAtIndex:section]).category;
    
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSArray *optionsArray = ((filter *)[self.dataSource objectAtIndex:indexPath.section]).options;
    
    cell.textLabel.text = [optionsArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    filter *filterDetail = (filter *) [self.dataSource objectAtIndex:indexPath.section];
    NSMutableArray *optionsSelected = [NSMutableArray new];
    if ([self.selectedFilter valueForKey:filterDetail.category]) {
        [optionsSelected addObjectsFromArray:[self.selectedFilter valueForKey:filterDetail.category]];
    }
    [optionsSelected addObject:(NSString *)[filterDetail.options objectAtIndex:indexPath.row]];
    [self.selectedFilter setValue:optionsSelected forKey:filterDetail.category];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    filter *filterDetail = (filter *) [self.dataSource objectAtIndex:indexPath.section];
    NSMutableArray *selectedOptions = [[self.selectedFilter valueForKey:filterDetail.category] mutableCopy];
    [selectedOptions removeObject:(NSString *)[filterDetail.options objectAtIndex:indexPath.row]];
    if (selectedOptions.count > 0) {
        [self.selectedFilter setValue:selectedOptions forKey:filterDetail.category];
    } else {
        [self.selectedFilter removeObjectForKey:filterDetail.category];
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
