//
//  DetailViewController.h
//  HuiWen
//
//  Created by Edward on 13-5-4.
//  Copyright (c) 2013年 Lihang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface DetailViewController : UIViewController <HuiWenDelegate,UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, retain) NSArray *array;
@end
