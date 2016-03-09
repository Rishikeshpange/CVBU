//
//  ContactSearchTableViewController.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 11/18/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"


@interface ContactSearchTableViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property(strong,nonatomic) IBOutlet  AppDelegate *appdelegate;

@property(strong,nonatomic)NSMutableArray *selectedcontact_Arr;
@property(nonatomic, strong) IBOutlet NSMutableArray *ContactList;

-(void)showAlert;
-(void)hideAlert;
@end
