//
//  ManageOpportunityViewController.h
//  CRM_APP
//
//  Created by admin on 23/09/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
@interface ManageOpportunityViewController : UIViewController<UISplitViewControllerDelegate,UIPopoverControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
}

@property (strong, nonatomic) UIPopoverController* masterPopoverController;

@property(weak,nonatomic)UISplitViewController *splitController;


@property (strong, nonatomic) IBOutlet UITableView *tbl_opportunity;

@property(nonatomic,retain)NSString *ResultCount;


@end
