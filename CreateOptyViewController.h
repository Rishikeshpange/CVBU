//
//  CreateOptyViewController.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 9/29/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
#import "MLPAutoCompleteTextFieldDelegate.h"
#import "MLPAutoCompleteTextFieldDataSource.h"

@class DEMODataSource;
@class MLPAutoCompleteTextField;

@interface CreateOptyViewController : UIViewController<UISplitViewControllerDelegate,UIPopoverControllerDelegate,MLPAutoCompleteTextFieldDelegate,UITextFieldDelegate,MLPAutoCompleteTextFieldDataSource>
{
    
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    
    
}


-(BOOL) isNumeric :(NSString *)s;

@property (strong, nonatomic) UIPopoverController* masterPopoverController;

@property(weak,nonatomic)UISplitViewController *splitController;


@property (weak, nonatomic) IBOutlet UIView *optyStatus_iconView;

@property (strong, nonatomic)NSMutableArray *Financier_List_PickerArr;


@property(strong ,nonatomic)NSMutableArray *getallpincodeArr; //Abhishek PinCode


@property(nonatomic, strong) IBOutlet NSMutableArray *pickerData;


@property(strong,nonatomic)NSMutableArray *GetPPL_LOB_Arr;
@property(strong,nonatomic)NSMutableArray *GetPL_LOBPPL_Arr;

@property(strong,nonatomic)NSMutableArray *GetAppType_Arr;

@property(strong,nonatomic)NSMutableArray *Getusagecatagory_Arr;

@property(strong,nonatomic)NSMutableArray *Getbodytype_Arr;


@property(strong,nonatomic)NSMutableArray *Micromarket_Arr;

//create contact


@property (weak, nonatomic) IBOutlet UIView *Contact_View;


@property (weak, nonatomic) IBOutlet UITextField *txt_firstname;

@property (weak, nonatomic) IBOutlet UITextField *txt_phonenumber;


@property (weak, nonatomic) IBOutlet UITextField *txt_lastName;


@property (weak, nonatomic) IBOutlet UITextField *txt_emailId;



//Address Details


@property (weak, nonatomic) IBOutlet UITextField *txt_addressLine1;

@property (weak, nonatomic) IBOutlet UITextField *txt_addressLine2;

@property (weak, nonatomic) IBOutlet UITextField *txt_area;


@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *txt_state;

@property (weak, nonatomic) IBOutlet UITextField *txt_District;

@property (weak, nonatomic) IBOutlet UITextField *txt_Taluka;

@property (weak, nonatomic) IBOutlet UITextField *txt_City;



//create opportunity
@property (weak, nonatomic) IBOutlet UIView *addressView;



@property (weak, nonatomic) IBOutlet UIView *createOptyview;


@property (weak, nonatomic) IBOutlet UITextField *txt_lob;

@property (weak, nonatomic) IBOutlet UITextField *txt_PL;


@property (weak, nonatomic) IBOutlet UITextField *txt_sourceOfcontact;

@property (weak, nonatomic) IBOutlet UITextField *txt_ppl;

@property (weak, nonatomic) IBOutlet UITextField *txt_financier;

@property (weak, nonatomic) IBOutlet UITextField *txt_application;






- (IBAction)contact:(id)sender;

- (IBAction)address:(id)sender;


- (IBAction)opportunity:(id)sender;












- (IBAction)contactArrowBtn:(id)sender;


- (IBAction)addressarrowBtn:(id)sender;


- (IBAction)addressarrowBackwordBtn:(id)sender;

- (IBAction)optyarrowbackwordbtn:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *existingoutlet;


- (IBAction)existingcontact:(id)sender;

- (IBAction)NewContact:(id)sender;

- (IBAction)btn_Back:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *newcontactoutlet;


@property (weak, nonatomic) IBOutlet UIButton *btnCreateopty;


- (IBAction)btnactionCreateOpty:(id)sender;

//Mutable arrays

@property(strong,nonatomic)NSMutableArray *GetAllstates_Arr;

@property(strong,nonatomic)NSMutableArray *GetAlldistricts_Arr;
@property(strong,nonatomic)NSMutableArray *GetAllcities_Arr;
@property(strong,nonatomic)NSMutableArray *GetAlltaluka_Arr;

// Create OPty View :

- (IBAction)btn_PL:(id)sender;

- (IBAction)btn_Source_Contact:(id)sender;

- (IBAction)btn_Finaincer:(id)sender;

- (IBAction)btn_Application:(id)sender;

// Address View


- (IBAction)btn_State:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_District;

- (IBAction)btn_District:(id)sender;

- (IBAction)btn_Taluka:(id)sender;

- (IBAction)btn_City:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btn_Contactclick;


@property (strong, nonatomic) IBOutlet UIButton *btn_AddressClick;


@property (strong, nonatomic) IBOutlet UIButton *btn_Optyclick;


@property (weak, nonatomic) IBOutlet UITextField *txtGetUsagedetails;
@property (weak, nonatomic) IBOutlet UIButton *btnGetusagedetails;

@property (weak, nonatomic) IBOutlet UITextField *txtBodytype;

- (IBAction)btnBodytype:(id)sender;

- (IBAction)btnCustomeusage:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtMMgeography;


- (IBAction)Btngeography:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *pannooutlet;


@property (weak, nonatomic) IBOutlet UITextField *adharidoutlet;


// New TextFields
// Create Opty View

@property (weak, nonatomic) IBOutlet UITextField *txtFleetSize; // For FleetSize
@property (weak, nonatomic) IBOutlet UITextField *txtProductQuantity;// For Product Quantity

@property (weak, nonatomic) IBOutlet UITextField *txtCustomerType; // For Customer Type


//AddressView

@property (weak, nonatomic) IBOutlet UITextField *txtPanchayat; // For text Panchayat

@property (weak, nonatomic) IBOutlet UITextField *txtPincode; // For Pincode

@property (weak, nonatomic) IBOutlet UIButton *btnFetchPincode;



//Abhishek For Auto Complete


@property (weak) IBOutlet MLPAutoCompleteTextField *autocompleteTextField;

@property (strong, nonatomic) IBOutlet UILabel *demoTitle;
@property (strong, nonatomic) IBOutlet UILabel *author;
@property (strong, nonatomic) IBOutlet UISegmentedControl *typeSwitch;

@property (strong, nonatomic) IBOutlet DEMODataSource *autocompleteDataSource;




@end
