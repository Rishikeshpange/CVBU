//
//  CreateProspectViewController.h
//  CRM_APP
//
//  Created by Admin on 29/01/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"


@interface CreateProspectViewController : UIViewController<UISplitViewControllerDelegate,UIPopoverControllerDelegate,UITextFieldDelegate>

{
    
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    
}


@property (strong, nonatomic) UIPopoverController* masterPopoverController;

@property(weak,nonatomic)UISplitViewController *splitController;



@property (weak, nonatomic) IBOutlet UITextField *txt_firstname;

@property (weak, nonatomic) IBOutlet UITextField *txt_lastname;

@property (weak, nonatomic) IBOutlet UITextField *txt_phonenumber;

@property (weak, nonatomic) IBOutlet UITextField *txt_emailID;

@property (weak, nonatomic) IBOutlet UITextField *txt_addressline1;

@property (weak, nonatomic) IBOutlet UITextField *txt_addressline2;

@property (weak, nonatomic) IBOutlet UITextField *txt_Area;


@property (weak, nonatomic) IBOutlet UITextField *txt_state;


@property (weak, nonatomic) IBOutlet UITextField *tx_district;

@property (weak, nonatomic) IBOutlet UITextField *txt_city;

@property (weak, nonatomic) IBOutlet UITextField *txt_taluka;

@property (strong, nonatomic) IBOutlet UITextField *txt_pincode;

@property (strong, nonatomic) IBOutlet NSMutableDictionary *dict;

- (IBAction)btnState:(id)sender;

- (IBAction)BtnDistrict:(id)sender;

- (IBAction)Btn_city:(id)sender;

- (IBAction)Btn_Taluka:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txt_pannumber;

- (IBAction)btncreatecontact:(id)sender;

@end
