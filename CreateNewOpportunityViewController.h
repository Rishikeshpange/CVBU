

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
#import "MLPAutoCompleteTextField.h"



@class DEMODataSource;
@class MLPAutoCompleteTextField;
@interface CreateNewOpportunityViewController : UIViewController<MLPAutoCompleteTextFieldDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;

}

@property (weak, nonatomic) IBOutlet UIView *texttitle1;

@property (weak, nonatomic) IBOutlet UIView *texttitle2;


@property (strong, nonatomic) IBOutlet NSMutableDictionary *dict;

- (IBAction)button1:(id)sender;


- (IBAction)button2:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *DETAILS1;

@property (weak, nonatomic) IBOutlet UIView *DETAILS2;

- (IBAction)btn_createnewopty:(id)sender;

- (IBAction)btn_existingcontactopty:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *Btn_createnewopty;

@property (weak, nonatomic) IBOutlet UIButton *Btn_createExistingopty;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollvieoutlet;



//Opportunity mandatory fields


@property (weak, nonatomic) IBOutlet UITextField *txt_firstname;

@property (weak, nonatomic) IBOutlet UITextField *txt_lastname;
@property (weak, nonatomic) IBOutlet UITextField *txt_mobilenumber;
@property (weak, nonatomic) IBOutlet UITextField *txt_accountName;
@property (weak, nonatomic) IBOutlet UITextField *txt_site;
@property (weak, nonatomic) IBOutlet UITextField *txt_mainphonenumber;
@property (weak, nonatomic) IBOutlet UITextField *txt_LOB;
@property (weak, nonatomic) IBOutlet UITextField *txt_ppl;
@property (weak, nonatomic) IBOutlet UITextField *txt_pl;
@property (weak, nonatomic) IBOutlet UITextField *txt_quantity;
@property (weak, nonatomic) IBOutlet UITextField *txt_Vehicleapplication;
@property (weak, nonatomic) IBOutlet UITextField *txt_sourceOfcontact;
@property (weak, nonatomic) IBOutlet UITextField *txt_customerType;
@property (weak, nonatomic) IBOutlet UITextField *txt_vcnumber;

@property (weak, nonatomic) IBOutlet UITextField *txt_geography;
@property (weak, nonatomic) IBOutlet UITextField *txt_bodytype;

@property (weak, nonatomic) IBOutlet UITextField *txt_usagecatagory;
@property (weak, nonatomic) IBOutlet UITextField *txt_fleetsize;
@property (weak, nonatomic) IBOutlet UITextField *txt_TMLfleetsize;

@property (weak, nonatomic) IBOutlet UITextField *txt_contactpannumber;
@property (weak, nonatomic) IBOutlet UITextField *txt_contactemailid;



@property (weak, nonatomic) IBOutlet UITextField *txt_financier;
@property (weak, nonatomic) IBOutlet UITextField *txt_campaign;
@property (weak, nonatomic) IBOutlet UITextField *txt_accountstate;
@property (weak, nonatomic) IBOutlet UITextField *txt_accountdistrict;
@property (weak, nonatomic) IBOutlet UITextField *txt_accountcity;
@property (weak, nonatomic) IBOutlet UITextField *txt_accounttaluka;
@property (weak, nonatomic) IBOutlet UITextField *txt_accountarea;
@property (weak, nonatomic) IBOutlet UITextField *txt_accountpanchayat;
@property (weak, nonatomic) IBOutlet UITextField *txt_accountpincode;
@property (weak, nonatomic) IBOutlet UITextField *txt_accountaddressline1;
@property (weak, nonatomic) IBOutlet UITextField *txt_accountaddressline2;

@property (weak, nonatomic) IBOutlet UITextField *txt_contactstate;

@property (weak, nonatomic) IBOutlet UITextField *txt_contactdistrict;
@property (weak, nonatomic) IBOutlet UITextField *txt_contactcity;
@property (weak, nonatomic) IBOutlet UITextField *txt_contacttaluka;
@property (weak, nonatomic) IBOutlet UITextField *txt_contactarea;
@property (weak, nonatomic) IBOutlet UITextField *txt_contactpanchayat;
@property (weak, nonatomic) IBOutlet UITextField *txt_contactpincode;

@property (weak, nonatomic) IBOutlet UITextField *txt_contactAddressline1;

@property (weak, nonatomic) IBOutlet UITextField *txt_addressline2;

//actions for button click

- (IBAction)btnaction_LOB:(id)sender;
- (IBAction)btnaction_PPL:(id)sender;
- (IBAction)btnaction_pl:(id)sender;
- (IBAction)btnaction_qty:(id)sender;
- (IBAction)btnaction_application:(id)sender;
- (IBAction)btnaction_customertype:(id)sender;
- (IBAction)btnaction_sourceofcontact:(id)sender;
- (IBAction)btnaction_VCnumber:(id)sender;
- (IBAction)btnaction_geography:(id)sender;
- (IBAction)btnactaction_bodytype:(id)sender;
- (IBAction)btnaction_usagecatagory:(id)sender;
- (IBAction)btnaction_fleetsize:(id)sender;
- (IBAction)btnaction_TMLfleetsize:(id)sender;
- (IBAction)btn_financier:(id)sender;
- (IBAction)btnaction_linkcampaign:(id)sender;
- (IBAction)btnaction_accountpickgromgps:(id)sender;
- (IBAction)btnaction_contactpickfromgps:(id)sender;
- (IBAction)btnaction_sameasaccount:(id)sender;



- (IBAction)btnaction_accountstate:(id)sender;

- (IBAction)btnaction_accountdistrict:(id)sender;

- (IBAction)btnaction_accounttaluka:(id)sender;
- (IBAction)btnaction_city:(id)sender;








@end

