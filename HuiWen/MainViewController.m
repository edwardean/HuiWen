//
//  MainViewController.m
//  HuiWen
//
//  Created by Edward on 13-5-4.
//  Copyright (c) 2013年 Lihang. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import <string.h>
#define NUMBERS @"0123456789"
@interface MainViewController ()

@end

@implementation MainViewController

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
    [_text setDelegate:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
	
}
- (void)handleTap:(UITapGestureRecognizer *)sender {
    for (UITextField *field  in [self.view subviews]) {
        if ([field isFirstResponder]) {
            [field resignFirstResponder];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_text release];
    [_array release];
    [super dealloc];
}
- (void)getHuiWen:(NSString *)str{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    DetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    self.delegate = detail;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *array = [NSMutableArray array];
        const char *ch1 = [str cStringUsingEncoding:[NSString defaultCStringEncoding]];
        char ch[12];
        strcpy(ch, ch1);
        unsigned long count = strlen(ch),i,j;
        while(ch[0] != '0')
        {
            NSString *str = [NSString stringWithCString:ch encoding:NSUTF8StringEncoding];
            [array addObject:str];
            if(count == strlen(ch))
            {
                if(strlen(ch)%2 != 0)
                    i = j = strlen(ch)/2;
                else
                {
                    i = strlen(ch)/2-1;
                    j = strlen(ch)/2;
                }
                count --;
            }
            
            if(i == j)
            {
                ch[i]--;
                if(ch[i] == '0'-1)
                {
                    ch[i] = '9';
                    i--;
                    j++;
                }
            }
            else
            {
                ch[i]--;
                ch[j]--;
                
                if(ch[i] == '0'-1)
                {
                    ch[i] = ch[j] = '9';
                    i--;
                    j++;
                }
                else
                {
                    if(strlen(ch)%2 != 0)
                        i = j = strlen(ch)/2;
                    else
                    {
                        i = strlen(ch)/2-1;
                        j = strlen(ch)/2;
                    }
                }
                
                if(ch[0] == '0')
                {
                    int k;
                    for(k=0;k<count;k++)
                        ch[k] = '9';
                    ch[count] = '\0';
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [array removeObjectAtIndex:0];
            [self.delegate getHuiWenArray:array];
        });
    });
    [self.navigationController pushViewController:detail animated:YES];
}
- (IBAction)Go:(id)sender {
    if ([_text.text length]==0) {
        return;
    }
    
    long int val = [_text.text longLongValue];
    long int sum = 0,tmp = val;
    while (tmp) {
        sum = sum*10 + tmp%10;
        tmp /= 10;
    }
    if (sum == val) {
        [self getHuiWen:[NSString stringWithFormat:@"%ld",val]];
    } else {
        char data[10] = {0}, res[10] = {0}, len = 0, pos, bit = 0;
        const char* tmpch = [_text.text cStringUsingEncoding:[NSString defaultCStringEncoding]];
        strcpy(data, tmpch);
        len = strlen(data);
        if(len % 2 == 0){//偶
            pos = len/2 - 1;
        }
        else{
            pos = len/2;
        }
        
        while(pos - bit >= 0){
            if(len % 2 == 1){
                if(data[pos - bit] >= data[pos + bit]){
                    res[pos - bit] = data[pos - bit];
                    res[pos + bit] = data[pos - bit];
                }
                else{
                    data[pos - bit + 1]++;
                    memset(&data[pos - bit + 2], '0', len - (pos - bit+1));
                    bit = 0;
                    continue;
                }
                bit ++;
            }
            else{
                if(data[pos - bit] >= data[pos + 1 + bit]){
                    res[pos - bit] = data[pos - bit];
                    res[pos + 1 + bit] = data[pos - bit];
                }
                else{
                    data[pos - bit ]++;
                    memset(&data[pos - bit + 1], '0', len - (pos - bit+1) + 1);
                    bit = 0;
                    continue;
                }
                bit ++;
            }
            
        }
        [self getHuiWen:[NSString stringWithCString:res encoding:[NSString defaultCStringEncoding]]];
    }
    
    
    

    
        
}

#pragma mark -
#pragma UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSCharacterSet *cs = nil;
    if ([textField isEqual:_text]) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
        if ([toBeString length]>9) {
            textField.text = [toBeString substringToIndex:9];
            return NO;
        }
    } else
        return YES;
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    return basicTest;
    
}
@end
