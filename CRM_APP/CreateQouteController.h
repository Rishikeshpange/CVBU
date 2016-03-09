//
//  CreateQouteController.h
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 13/05/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
@interface CreateQouteController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    CreateAccountQoute *createAccountQoute;
    UpdateOptyQoute *updateOptyQoute;
    UIActionSheet *actionSheet; // ACtionsheet

}

@property (weak, nonatomic) IBOutlet UIView *btnFirstView;

@property (weak, nonatomic) IBOutlet UIView *btnSecondView;


@property (weak, nonatomic) IBOutlet UITextField *txtAccountName;

@property (weak, nonatomic) IBOutlet UITextField *txtAddress1;

@property (weak, nonatomic) IBOutlet UITextField *txtAddress2;

@property (weak, nonatomic) IBOutlet UITextField *txtDistrict;


@property (weak, nonatomic) IBOutlet UITextField *txtLandmark;

@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNo;

@property (weak, nonatomic) IBOutlet UITextField *txtAllStaes
;
@property (weak, nonatomic) IBOutlet UITextField *txtCIty;

@property (weak, nonatomic) IBOutlet UITextField *txtTaluka;

@property (weak, nonatomic) IBOutlet UITextField *txtSelectPincode;

@property (weak, nonatomic) IBOutlet UITextField *txtPanchayat;

- (IBAction)btnStates:(id)sender;

- (IBAction)btnCity:(id)sender;

- (IBAction)btnDistrict:(id)sender;

- (IBAction)btnTaluka:(id)sender;

- (IBAction)btnPincode:(id)sender;


@property(strong,nonatomic)NSMutableArray *GetLOB_Arr;
@property(strong,nonatomic)NSMutableArray *GetPPL_LOB_Arr;
@property(strong,nonatomic)NSMutableArray *GetPL_LOBPPL_Arr;

@property(strong,nonatomic)NSMutableArray *GetAppType_Arr;
@property(strong,nonatomic)NSMutableArray *GetAllstates_Arr;
@property(strong,nonatomic)NSMutableArray *GetAllDistrict_Arr;
@property(strong,nonatomic)NSMutableArray *GetAllCities;
@property(strong,nonatomic)NSMutableArray *GetAllTaluka;
@property(strong,nonatomic)NSMutableArray *GetAllPincode;
@property(strong,nonatomic)NSMutableArray *GetProductName_Arr;
@property(strong,nonatomic)NSMutableArray *GetProductID_Arr;
@property(strong,nonatomic)NSMutableArray *ProductDetailsUpdate_Arr;
@property(strong,nonatomic)NSMutableArray *GetAddressData_Arr;
@property(strong,nonatomic)NSMutableArray *UpdateOptyQoute_Arr;

@property(strong,nonatomic)NSMutableArray *ShowStates;

@property(strong,nonatomic)NSMutableDictionary *GetStatesAll;

@property(strong,nonatomic)NSMutableDictionary *GetAllStateCodes;

@property(strong, nonatomic)NSString *SelectedStateCode;

@property(strong, nonatomic)NSString *optyContact;


@property (weak, nonatomic) IBOutlet UIButton *btnCreate;

- (IBAction)btnCreate:(id)sender;


@end
