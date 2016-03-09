//
//  AssignsearchTableViewController.h
//  NEEV
//
//  Created by Sachin Sharma on 03/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
@interface AssignsearchTableViewController : UITableViewController<UITableViewDelegate,UISearchBarDelegate,UITableViewDataSource,UISearchDisplayDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    
}
//@property(nonatomic, strong) IBOutlet NSArray *items;
@property(strong,nonatomic)NSMutableArray *ListofDSE_Arr;
@property (strong, nonatomic) IBOutlet UITableView *_searchtableView;
@property(strong,nonatomic)NSMutableArray *ListofDSE_Name_Arr;

@end
