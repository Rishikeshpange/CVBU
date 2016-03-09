//
//  ActivitySearchResultViewController.h
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 27/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
@interface ActivitySearchResultViewController : UIViewController
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
}
@property (nonatomic, retain) NSString* ActiveInActive
;@property (nonatomic, retain) NSString* Status
;@property (nonatomic, retain) NSString* ActivityType;
@property (nonatomic, retain) NSString* FromDate;
@property (nonatomic, retain) NSString* Todate;
@property (nonatomic, retain) NSString* ppl;
@property (nonatomic, retain) NSString* taluka;
@property (nonatomic, retain) NSString* assignTO;


@property (weak, nonatomic) IBOutlet UITableView *_tableView;

@property (strong, nonatomic) IBOutlet UILabel *lbl_customerName;

@property (strong, nonatomic) IBOutlet UILabel *lbl_SaleStage;

@property (strong, nonatomic) IBOutlet UILabel *lbl_ActivityType;

@property (strong, nonatomic) IBOutlet UILabel *lbl_CustomerNumber;


@property (strong, nonatomic) IBOutlet UILabel *lbl_DSEName;

@property (strong, nonatomic) IBOutlet UILabel *lbl_AcitivtyPendinf;



@end

/*
 NSLog(@" TGM / TKM name  %@",ActiveInActive);
 NSLog(@" Cust Name %@",txtCustomerName.text);
 NSLog(@" Cust Mob %@",txtCustomerMobile.text);
 NSLog(@" From Date  %@",txtFromDate.text);
 NSLog(@" To date %@",txtToDate.text);
 NSLog(@" Sales Stages %@",txtSalesStage.text);
 NSLog(@" PPL%@",txtPPL.text);
 NSLog(@" Taluka %@",txtTaluka.text);
 NSLog(@" Assing TO  %@",txtAssignTO.text);*/