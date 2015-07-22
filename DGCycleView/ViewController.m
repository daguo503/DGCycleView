//
//  ViewController.m
//  DGCycleView
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "DGCycleView.h"


@interface ViewController ()
{
    NSArray *_dataArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    _dataArray = [[NSMutableArray alloc]init];
//    UIImage *first = [UIImage imageNamed:@"first.jpg"];
//    UIImage *second = [UIImage imageNamed:@"second.jpg"];
//    UIImage *third = [UIImage imageNamed:@"third.jpg"];
//    [_dataArray addObject:first];
//    [_dataArray addObject:second];
//    [_dataArray addObject:third];
    _dataArray = @[[UIImage imageNamed:@"first.jpg"],[UIImage imageNamed:@"second.jpg"],[UIImage imageNamed:@"third.jpg"]];
    DGCycleView *scroll = [[DGCycleView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200) imageArray:_dataArray];
    [self.view addSubview:scroll];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
