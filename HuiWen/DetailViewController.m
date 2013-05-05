//
//  DetailViewController.m
//  HuiWen
//
//  Created by Edward on 13-5-4.
//  Copyright (c) 2013年 Lihang. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
-(void)getHuiWenArray:(NSArray *)array {
    NSArray *tmpArray = [array retain];
    self.array = tmpArray;
    [tmpArray release];
    [self.myTable reloadData];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[self.myTable reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate and UITableViewDataSouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_myTable]) {
        if ([self.array count] > 0) {
            return self.array.count;
        }
        return 0;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"LiHang";
    if ([tableView isEqual:_myTable]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        cell.textLabel.text = [_array objectAtIndex:[indexPath row]];
        return cell;
    }
    return nil;
    
}
- (void)dealloc {
    [_myTable release];
    [super dealloc];
}
@end
