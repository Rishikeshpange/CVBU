//
//  DemoViewController.m
//  CRM_APP
//
//  Created by admin on 15/09/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@end
@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.splitViewController.delegate = self;
    self.masterPopoverController.delegate=self;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
    
   
        NSLog(@"QQQ");
        UIBarButtonItem *barButtonItem = self.splitViewController.displayModeButtonItem;
        barButtonItem.title = @"Show master";
        self.navigationItem.leftBarButtonItem = barButtonItem;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    
    self.splitViewController.delegate = self;
    
  
        NSLog(@"QQQ");
        UIBarButtonItem *barButtonItem = self.splitViewController.displayModeButtonItem;
        barButtonItem.title = @"Show master";
        self.navigationItem.leftBarButtonItem = barButtonItem;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
