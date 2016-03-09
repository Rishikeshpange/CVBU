//
//  OpportunitySearchResultController.h
//  CRM_APP
//
//  Created by admin on 24/11/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"

@interface OpportunitySearchResultController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    
}
@property(strong,nonatomic)NSMutableArray *optySearchDetails;
@property(strong,nonatomic)NSMutableArray *optySearchDetails_Comes;
@property(strong,nonatomic)NSString *txtFromDate;
@property(strong,nonatomic)NSString *txtToDate;
@property(strong,nonatomic)NSString *txtSalesStages;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, assign) int flag;

// Search Parameters in ......
@property(strong,nonatomic)NSString *txtTGMTKM;
@property(strong,nonatomic)NSString *txtCustomerName;
@property(strong,nonatomic)NSString *txtCustomerMobile;
@property(strong,nonatomic)NSString *txtPassFromDate;
@property(strong,nonatomic)NSString *txtPassToDate;
@property(strong,nonatomic)NSString *txtPassSalesStages;
@property(strong,nonatomic)NSString *txtPPL;
@property(strong,nonatomic)NSString *txtTaluka;
@property(strong,nonatomic)NSString *txtAssign;
@property(strong,nonatomic)NSString *txtpassid;
@property(strong,nonatomic)NSString *txtpassfinancier;

@end
