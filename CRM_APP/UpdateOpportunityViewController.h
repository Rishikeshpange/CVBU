//
//  UpdateOpportunityViewController.h
//  CRM_APP
//
//  Created by admin on 19/10/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"
@interface UpdateOpportunityViewController : UIViewController<UIActionSheetDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    UIActionSheet *actionSheet; // ACtionsheet
    UpdateOptyProduct *updateOptyProduct;
    UpdateContactOpty *updateContactOpty;

}
 // UIVIew

@property (strong, nonatomic) IBOutlet UIView *View_Contact;

@property (strong, nonatomic) IBOutlet UIView *View_Product;

@property (strong, nonatomic) IBOutlet UIView *View_Title;


// UIButton

@property (strong, nonatomic) IBOutlet UIButton *btn_UpdateContact;

- (IBAction)btn_UpdateContact:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_UpdateProduct;

- (IBAction)btn_UpdateProduct:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_ProductSwitch;

@property (strong, nonatomic) IBOutlet UIButton *btn_ContactSwitch;

- (IBAction)btn_ProductSwitch:(id)sender;

- (IBAction)btn_ContactSwitch:(id)sender;


// Button Actions for popup :

- (IBAction)btn_LOB:(id)sender;

- (IBAction)btn_PPL:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btn_PPL;

@property (strong, nonatomic) IBOutlet UIButton *btn_PL;

- (IBAction)btn_PL:(id)sender;

- (IBAction)btn_APPTYPE:(id)sender;

- (IBAction)btn_BODYTYPE:(id)sender;

- (IBAction)btn_CUSTOMERSEG:(id)sender;

- (IBAction)btn_MMG:(id)sender;

// Buttton Contacts

- (IBAction)btn_STATE:(id)sender;

- (IBAction)btn_CITY:(id)sender;

- (IBAction)btn_PINCODE:(id)sender;

- (IBAction)btn_DISTRICT:(id)sender;

- (IBAction)btn_TALUKA:(id)sender;

- (IBAction)btn_PANCHAYAT:(id)sender;


// NSMutable

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
@property(strong,nonatomic)NSMutableArray *ContactDetailsUpdate_Arr;

@property(strong,nonatomic)NSMutableArray *GetAddressData_Arr;
@property(strong,nonatomic)NSMutableArray *ShowStates;

@property(strong,nonatomic)NSMutableDictionary *GetStatesAll;

@property(strong,nonatomic)NSMutableDictionary *GetAllStateCodes;

@property(strong, nonatomic)NSString *SelectedStateCode;

@property(strong,nonatomic)NSMutableArray *Getbodytype_Arr;

@property(strong,nonatomic)NSMutableArray *Getusagecatagory_Arr;




// UITextfileds


@property (strong, nonatomic) IBOutlet UITextField *txt_LOB;

@property (strong, nonatomic) IBOutlet UITextField *txt_PPL;

@property (strong, nonatomic) IBOutlet UITextField *txt_PL;

@property (strong, nonatomic) IBOutlet UITextField *txt_AppType;


@property (strong, nonatomic) IBOutlet UITextField *txt_BodyType;


@property (strong, nonatomic) IBOutlet UITextField *txt_CustomerSegment;


@property (strong, nonatomic) IBOutlet UITextField *txt_MMG;



@property (strong, nonatomic) IBOutlet UITextField *txt_FirstName;


@property (strong, nonatomic) IBOutlet UITextField *txt_AddressLine1;


@property (strong, nonatomic) IBOutlet UITextField *txt_AREA;


@property (strong, nonatomic) IBOutlet UITextField *txt_AddressLine2;


@property (strong, nonatomic) IBOutlet UITextField *txt_PINCODE;


@property (strong, nonatomic) IBOutlet UITextField *txt_DISTRICT;

@property (strong, nonatomic) IBOutlet UITextField *txt_STATE;

@property (strong, nonatomic) IBOutlet UITextField *txt_CITY;

@property (strong, nonatomic) IBOutlet UITextField *txt_LASTNAME;


@property (strong, nonatomic) IBOutlet UITextField *txt_PANCHAYAT;

@property (strong, nonatomic) IBOutlet UITextField *txt_TALUKA;

// UILables

@property (strong, nonatomic) IBOutlet UILabel *lbl_Opty_Id;

@property (strong, nonatomic) IBOutlet UILabel *lbl_Sales_Stages;

@property (strong, nonatomic) IBOutlet UILabel *lbl_Last_updated;

@property (strong, nonatomic) IBOutlet UILabel *lbl_Opty_Created;





@end
