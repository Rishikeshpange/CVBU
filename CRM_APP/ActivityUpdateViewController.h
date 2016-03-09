//
//  ActivityUpdateViewController.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/15/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RequestDelegate.h"
#import "UserDetails_Var.h"

@interface ActivityUpdateViewController : UIViewController<UIActionSheetDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
}

@property(strong,nonatomic)NSMutableArray *activityTypeArr;

@property (weak, nonatomic) IBOutlet UILabel *lblCustomerName;

@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblMobileNo;

@property (weak, nonatomic) IBOutlet UILabel *lblTGMTKM_Name;

@property (weak, nonatomic) IBOutlet UILabel *lblAccountType;

@property (weak, nonatomic) IBOutlet UILabel *lblTGMTKMNumber;

@property (weak, nonatomic) IBOutlet UILabel *lblOptyId;
@property int flagset;


- (IBAction)btn_Activitytype:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *textfieldType;


@property (weak, nonatomic) IBOutlet UITextField *txtfldDate;

@property (weak, nonatomic) IBOutlet UITextField *txtfldTym;
- (IBAction)btnDate:(id)sender;

//- (IBAction)btnTime:(id)sender;
- (IBAction)btnTime:(id)sender;


@property (weak, nonatomic) IBOutlet UITextView *txDescription;


- (IBAction)btnUpdate:(id)sender;

- (IBAction)btnCancel:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btn_cancel;

@property (strong, nonatomic) IBOutlet UIButton *btn_update;


@end
