//
//  AccountViewController.h
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 31/03/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GlobalVariables.h"
#import "UserDetails_Var.h"
@interface AccountViewController : UIViewController <UIActionSheetDelegate,UISplitViewControllerDelegate,UIPopoverControllerDelegate> {
    AppDelegate* appdelegate;
    GlobalVariables* globalVariables_;
    UserDetails_Var* userDetailsVal_;
    CreateAccount* createAccount;
}
@property (weak, nonatomic) IBOutlet UITextField* txtTGMName;

@property (weak, nonatomic) IBOutlet UITextField* txtTGMNumber;

@property (weak, nonatomic) IBOutlet UITextField* txtAddress;

@property (weak, nonatomic) IBOutlet UITextField* txtAddress2;

@property (weak, nonatomic) IBOutlet UITextField* txtArea;

@property (weak, nonatomic) IBOutlet UITextField* txtState;

@property (weak, nonatomic) IBOutlet UITextField* txtDistrict;

@property (weak, nonatomic) IBOutlet UITextField* txtCity;

@property (weak, nonatomic) IBOutlet UITextField* txtTaluka;

@property (weak, nonatomic) IBOutlet UITextField* txtPincode;

@property (weak, nonatomic) IBOutlet UITextField* txtPanchayat;

@property (weak, nonatomic) IBOutlet UIButton* btnSave;

@property (weak, nonatomic) IBOutlet UIButton* btnCancel;

@property (weak, nonatomic) IBOutlet UIButton* btnSearch;

- (IBAction)btnstate:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton* btnCity;

- (IBAction)btnCity:(id)sender;

- (IBAction)btnPincode:(id)sender;

- (IBAction)btnDistrict:(id)sender;

- (IBAction)btnTaluka:(id)sender;

- (IBAction)btnSaveAccount:(id)sender;

- (IBAction)btnCancel:(id)sender;

@property (weak, nonatomic) IBOutlet UIView* tabView;

@property (strong, nonatomic) NSMutableArray* GetLOB_Arr;
@property (strong, nonatomic) NSMutableArray* GetPPL_LOB_Arr;
@property (strong, nonatomic) NSMutableArray* GetPL_LOBPPL_Arr;
@property (strong, nonatomic) NSMutableArray* GetAppType_Arr;
@property (strong, nonatomic) NSMutableArray* GetAllstates_Arr;
@property (strong, nonatomic) NSMutableArray* GetAllDistrict_Arr;
@property (strong, nonatomic) NSMutableArray* GetAllCities;
@property (strong, nonatomic) NSMutableArray* GetAllTaluka;
@property (strong, nonatomic) NSMutableArray* GetAllPincode;
@property (strong, nonatomic) NSMutableArray* GetProductName_Arr;
@property (strong, nonatomic) NSMutableArray* GetProductID_Arr;
@property (strong, nonatomic) NSMutableArray* ProductDetailsUpdate_Arr;
@property (strong, nonatomic) NSMutableArray* GetAddressData_Arr;
@property (strong, nonatomic) NSMutableArray* UpdateOptyQoute_Arr;
@property (strong, nonatomic) NSMutableArray* ShowStates;
@property (strong, nonatomic) NSMutableDictionary* GetStatesAll;
@property (strong, nonatomic) NSMutableDictionary* GetAllStateCodes;
@property (strong, nonatomic) NSString* SelectedStateCode;
@property (weak, nonatomic) IBOutlet UIView* firstView;
@property (weak, nonatomic) IBOutlet UIView* secondView;

@property (strong, nonatomic) UIPopoverController* masterPopoverController;

@property(weak,nonatomic)UISplitViewController *splitController;


@end
