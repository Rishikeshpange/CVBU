//
//  AssignSearchViewController.h
//  CRM_APP
//
//  Created by admin on 19/10/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
#import "APLResultsTableController.h"
@interface AssignSearchViewController : UIViewController<UITableViewDelegate,UISearchBarDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
 
    
}

@property (nonatomic, strong) UISearchController *searchController;

// our secondary search results table view
@property (nonatomic, strong) APLResultsTableController *resultsTableController;

@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;


//@property(nonatomic, strong) IBOutlet NSArray *items;
@property(strong,nonatomic)NSMutableArray *ListofDSE_Arr;

@property (strong, nonatomic) IBOutlet UITableView *_searchtableView;
@property(strong,nonatomic)NSMutableArray *ListofDSE_Name_Arr;



@end
