//
//  MainViewController.h
//  HuiWen
//
//  Created by Edward on 13-5-4.
//  Copyright (c) 2013年 Lihang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HuiWenDelegate
- (void)getHuiWenArray:(NSArray *)array;
@end
@interface MainViewController : UIViewController <UITextFieldDelegate> {
    NSObject <HuiWenDelegate> *_delegate;
}
@property (retain, nonatomic) IBOutlet UITextField *text;
@property (retain, nonatomic) NSMutableArray *array;
@property (nonatomic, assign) NSObject<HuiWenDelegate> *delegate;
- (IBAction)Go:(id)sender;
@end
