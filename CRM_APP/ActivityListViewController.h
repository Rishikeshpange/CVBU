//
//  ActivityListViewController.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/19/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"

@interface ActivityListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISplitViewControllerDelegate>
{
  
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;

}

@property (strong, nonatomic) UIPopoverController* masterPopoverController;

@property(weak,nonatomic)UISplitViewController *splitController;


@property (weak, nonatomic) IBOutlet UITableView *TableView;






@end
