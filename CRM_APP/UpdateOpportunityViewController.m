//
//  UpdateOpportunityViewController.m
//  CRM_APP
//
//  Created by admin on 19/10/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import "UpdateOpportunityViewController.h"
#import "Reachability.h"
#import "TBXML.h"
#import "RequestDelegate.h"
#import "Opportunity_List.h"
#import "MBProgressHUD.h"
#import "Address.h"

@interface UpdateOpportunityViewController () {
    UIAlertView* alert;
    NSString* str_States;
    int check;
    NSMutableArray* ProductName;
    NSString *str_NAME, *str_NAME1;
    int flag;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
    int cntchange;
    NSMutableArray *Micromarket_Arr;
    NSString *updatecount;
    


}
@end

@implementation UpdateOpportunityViewController

@synthesize GetLOB_Arr, GetPPL_LOB_Arr, GetPL_LOBPPL_Arr, GetAppType_Arr, GetAllstates_Arr, GetAllDistrict_Arr, GetAllCities, GetAllTaluka, GetAllPincode, GetProductName_Arr, GetProductID_Arr, ProductDetailsUpdate_Arr, GetAddressData_Arr, ShowStates, ContactDetailsUpdate_Arr, GetAllStateCodes, Getbodytype_Arr, GetStatesAll,Getusagecatagory_Arr;
@synthesize SelectedStateCode;
@synthesize txt_LOB, txt_AddressLine1, txt_AddressLine2, txt_AppType, txt_AREA, txt_BodyType, txt_CITY, txt_CustomerSegment, txt_DISTRICT, txt_FirstName, txt_LASTNAME, txt_MMG, txt_PANCHAYAT, txt_PINCODE, txt_PL, txt_PPL, txt_STATE, txt_TALUKA;
@synthesize lbl_Last_updated, lbl_Opty_Created, lbl_Opty_Id, lbl_Sales_Stages;
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.View_Product.layer setBorderColor:[UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor];
    [self.View_Product.layer setBorderWidth:2.0f];

    [self.View_Contact.layer setBorderColor:[UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor];
    [self.View_Contact.layer setBorderWidth:2.0f];

    GetAllStateCodes = [[NSMutableDictionary alloc] init];
    Micromarket_Arr=[[NSMutableArray alloc] init];
    
    //self.txtPanchayat.delegate=self;

    ShowStates = [[NSMutableArray alloc] initWithObjects:@"Andaman and Nicobar Island", @"Andhra Pradesh", @"Arunachal Pradesh", @"Assam", @"Bihar", @"Chandigarh", @"Chattishgarh", @"Daman and Diu", @"Delhi", @"Dadra and Nagar Haveli", @"Goa", @"Gujarat", @"Himachal Pradesh", @"Haryana", @"Jharkhand", @"Jammu & Kashmir", @"Karnataka", @"Kerala", @"Lakshwadeep", @"Maharashtra", @"Meghalaya", @"Manipur", @"Madhya Pradesh", @"Mizoram", @"Nagaland", @"Orissa", @"Punjab", @"Pondicherry", @"Rajasthan", @"Sikkim", @"Telangana", @"Tamil Nadu", @"Tripura", @"Uttarakhand", @"Uttar Pradesh", @"West Bengal", nil];

    [GetAllStateCodes setObject:@"AN" forKey:@"Andaman and Nicobar Island"];
    [GetAllStateCodes setObject:@"AP" forKey:@"Andhra Pradesh"];
    [GetAllStateCodes setObject:@"AR" forKey:@"Arunachal Pradesh"];
    [GetAllStateCodes setObject:@"AS" forKey:@"Assam"];
    [GetAllStateCodes setObject:@"BR" forKey:@"Bihar"];
    [GetAllStateCodes setObject:@"CG" forKey:@"Chandigarh"];
    [GetAllStateCodes setObject:@"CH" forKey:@"Chhattisgarh"];
    [GetAllStateCodes setObject:@"DD" forKey:@"Daman and Diu"];
    [GetAllStateCodes setObject:@"DL" forKey:@"Delhi"];
    [GetAllStateCodes setObject:@"DN" forKey:@"Dadra and Nagar Haveli"];
    [GetAllStateCodes setObject:@"GA" forKey:@"Goa"];
    [GetAllStateCodes setObject:@"GJ" forKey:@"Gujarat"];
    [GetAllStateCodes setObject:@"HP" forKey:@"Himachal Pradesh"];
    [GetAllStateCodes setObject:@"HR" forKey:@"Haryana"];
    [GetAllStateCodes setObject:@"JH" forKey:@"Jharkhand"];
    [GetAllStateCodes setObject:@"JK" forKey:@"Jammu and Kashmir"];
    [GetAllStateCodes setObject:@"KA" forKey:@"Karnataka"];
    [GetAllStateCodes setObject:@"KL" forKey:@"Kerala"];
    [GetAllStateCodes setObject:@"LD" forKey:@"Lakshadweep"];
    [GetAllStateCodes setObject:@"MH" forKey:@"Maharashtra"];
    [GetAllStateCodes setObject:@"ML" forKey:@"Meghalaya"];
    [GetAllStateCodes setObject:@"MN" forKey:@"Manipur"];
    [GetAllStateCodes setObject:@"MP" forKey:@"Madhya Pradesh"];
    [GetAllStateCodes setObject:@"MZ" forKey:@"Mizoram"];
    [GetAllStateCodes setObject:@"NL" forKey:@"Nagaland"];
    [GetAllStateCodes setObject:@"OR" forKey:@"Orissa"];
    [GetAllStateCodes setObject:@"PB" forKey:@"Punjab"];
    [GetAllStateCodes setObject:@"PY" forKey:@"Pondicherry"];
    [GetAllStateCodes setObject:@"RJ" forKey:@"Rajasthan"];
    [GetAllStateCodes setObject:@"SK" forKey:@"Sikkim"];
    [GetAllStateCodes setObject:@"TG" forKey:@"Telangana"];
    [GetAllStateCodes setObject:@"TN" forKey:@"Tamil Nadu"];
    [GetAllStateCodes setObject:@"TR" forKey:@"Tripura"];
    [GetAllStateCodes setObject:@"UA" forKey:@"Uttarakhand"];
    [GetAllStateCodes setObject:@"UP" forKey:@"Uttar Pradesh"];
    [GetAllStateCodes setObject:@"WB" forKey:@"West Bengal"];

    NSLog(@"Count : %lu", (unsigned long)[ShowStates count]);

    /*
     AN,AP,AR,AS,BR,CG,CH,DD,DL,DN,GA,
     GJ,HP,HR,JH,JK,KA,KL,LD,MH,ML,MN,MP,MZ,NL,OR,PB,PY,RJ,SK,TG,TN,TR,UA,UP,WB
     stateList.add("Andaman & Nicobar");
     stateList.add("Andhra Pradesh");
     stateList.add("Telangana");
     stateList.add("Arunachal Pradesh");
     stateList.add("Assam");
     stateList.add("Bihar");
     stateList.add("Chandigarh");
     stateList.add("Chattishgarh");
     stateList.add("Chennai");
     stateList.add("Dadra, Nagarhaveli");
     stateList.add("Daman & Diu");
     stateList.add("Delhi");
     stateList.add("Goa");
     stateList.add("Gujarat");
     stateList.add("Haryana");
     stateList.add("Himachal Pradesh");
     stateList.add("Jammu & Kashmir");
     stateList.add("Jharkhand");
     stateList.add("Karnataka");
     stateList.add("Kerala");
     stateList.add("Lakshwadeep");
     stateList.add("Madhya Pradesh");
     stateList.add("Maharashtra");
     stateList.add("Manipur");
     stateList.add("Meghalaya");
     stateList.add("Mizoram");
     stateList.add("Nagaland");
     stateList.add("North Tamil Nadu");
     stateList.add("Orrisa");
     stateList.add("Pondicherry");
     stateList.add("Punjab");
     stateList.add("Rajasthan");
     stateList.add("Sikkim");
     stateList.add("Tamil Nadu");
     stateList.add("Tripura");
     stateList.add("Uttarkhand");
     stateList.add("Uttar Pradesh");
     stateList.add("West Bengal");
     stateList.add("APO");
     stateList.add("Others");
     */

    //[self showAlert];

    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance

    [self textFiledText];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Navigation bar button on right side
    UIButton* btnInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnInfo setImage:[UIImage imageNamed:@"header_icon_1.png"] forState:UIControlStateNormal];
    [btnInfo addTarget:self action:@selector(info_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnInfo setFrame:CGRectMake(-15, -5, 40, 40)];

    UIButton* btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogout setImage:[UIImage imageNamed:@"header_icon_2.png"] forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(logOut_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnLogout setFrame:CGRectMake(44, -5, 40, 40)];

    UIView* rightBarButtonItems = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 90, 40)];
    [rightBarButtonItems addSubview:btnInfo];
    [rightBarButtonItems addSubview:btnLogout];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];

    GetPPL_LOB_Arr = [[NSMutableArray alloc] init];
    GetPL_LOBPPL_Arr = [[NSMutableArray alloc] init];
    GetAppType_Arr = [[NSMutableArray alloc] init];
    GetAllstates_Arr = [[NSMutableArray alloc] init];
    GetAllDistrict_Arr = [[NSMutableArray alloc] init];
    GetAllCities = [[NSMutableArray alloc] init];
    GetAllTaluka = [[NSMutableArray alloc] init];
    GetAllPincode = [[NSMutableArray alloc] init];
    GetProductName_Arr = [[NSMutableArray alloc] init];
    GetProductID_Arr = [[NSMutableArray alloc] init];
    ProductDetailsUpdate_Arr = [[NSMutableArray alloc] init];
    GetAddressData_Arr = [[NSMutableArray alloc] init];
    ProductName = [[NSMutableArray alloc] init];
    GetStatesAll = [[NSMutableDictionary alloc] init];
    Getbodytype_Arr = [[NSMutableArray alloc] init];
    Getusagecatagory_Arr = [[NSMutableArray alloc] init];

    self.txt_LOB.layer.borderWidth = 2.0f;
    self.txt_PL.layer.borderWidth = 2.0f;

    self.txt_PPL.layer.borderWidth = 2.0f;
    self.txt_AppType.layer.borderWidth = 2.0f;

    self.txt_LOB.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txt_PL.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txt_PPL.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txt_AppType.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    //Contsct View

    self.txt_FirstName.layer.borderWidth = 2.0f;
    self.txt_LASTNAME.layer.borderWidth = 2.0f;

    self.txt_AddressLine1.layer.borderWidth = 2.0f;
    self.txt_AddressLine2.layer.borderWidth = 2.0f;

    self.txt_PINCODE.layer.borderWidth = 2.0f;
    self.txt_STATE.layer.borderWidth = 2.0f;

    self.txt_CITY.layer.borderWidth = 2.0f;

    self.txt_DISTRICT.layer.borderWidth = 2.0f;

    self.txt_TALUKA.layer.borderWidth = 2.0f;

    self.txt_PINCODE.layer.borderWidth = 2.0f;

    self.txt_PANCHAYAT.layer.borderWidth = 2.0f;

    self.txt_FirstName.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txt_LASTNAME.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txt_AddressLine1.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txt_AddressLine2.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txt_PINCODE.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txt_STATE.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txt_DISTRICT.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txt_CITY.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txt_TALUKA.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txt_PINCODE.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txt_PANCHAYAT.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.btn_PPL.userInteractionEnabled = NO;
    self.btn_PL.userInteractionEnabled = NO;

    [self.View_Title.layer setBorderColor:[UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor];
    [self.View_Title.layer setBorderWidth:2.0f];

    self.View_Title.layer.cornerRadius = 3;
    self.View_Title.layer.masksToBounds = YES;
    // Do any additional setup after loading the view.
    
    
    
   
    if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
      
        
        self.btn_ContactSwitch.enabled=NO;
        self.btn_ContactSwitch.hidden=YES;
        
        
    }
    else {
        
        
        
       
    }
    
    
    
    

    if (![self connected]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        [self callGetAddressRequest];
        [self call_AllStates];
        [self call_LOB];
        [self callgeography];
        
        if ([opportunity_list.OPTY_ID isEqual:@""]) {
            
            lbl_Opty_Id.text=@"Not Available";
        }
        else{
       lbl_Opty_Id.text = opportunity_list.OPTY_ID;
          
        }
        if ([opportunity_list.SALE_STAGE_NAME isEqual:@""]) {
            
            lbl_Sales_Stages.text=@"Not Available";
        }
        else{
           lbl_Sales_Stages.text = opportunity_list.SALE_STAGE_NAME;
            
        }
        if ([opportunity_list.LAST_DONE_ACTIVITY_DATE isEqual:@""]) {
            
            lbl_Last_updated.text=@"Not Available";
        }
        else{
            lbl_Last_updated.text = opportunity_list.LAST_DONE_ACTIVITY_DATE;
            
        }
        if ([opportunity_list.OPTY_CREAT_DATE isEqual:@""]) {
            
            lbl_Opty_Created.text=@"Not Available";
        }
        else{
            lbl_Opty_Created.text = opportunity_list.OPTY_CREAT_DATE;
            
        }
      
        
        



        self.txt_FirstName.text = opportunity_list.CONTACT_FIRST_NAME;
        self.txt_LASTNAME.text = opportunity_list.CONTACT_LAST_NAME;

        self.txt_AddressLine1.text = opportunity_list.CONTACT_ADDRESS;

        self.txt_PPL.text = opportunity_list.PRODUCT_NAME;
        self.txt_PL.text = opportunity_list.PRODUCT_NAME1;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    /*
     // register for keyboard notifications
     [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(keyboardWillShow)
     name:UIKeyboardWillShowNotification
     object:nil];
     
     [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(keyboardWillHide)
     name:UIKeyboardWillHideNotification
     object:nil];*/

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LobListFound:) name:@"LobListFound" object:nil]; //For Sale Satge PPL Dropdown Count
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Activity_PPL_Found:) name:@"Activity_PPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PLUpdateOpty_Found:) name:@"PLUpdateOpty_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppType_Data_Found:) name:@"AppType_Data_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(All_States_Found:) name:@"All_States_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllDistrict_Found:) name:@"AllDistrict_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Allcities_Found:) name:@"Allcities_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllTaluka_CallFound:) name:@"AllTaluka_CallFound" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllPincode_Found:) name:@"AllPincode_Found" object:nil];

  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllProductName_Found:) name:@"AllProductName_Found" object:nil];

   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProductUpdate_Found:) name:@"ProductUpdate_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ContactUpdate_Found:) name:@"ContactUpdate_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddressData_Found:) name:@"AddressData_Found" object:nil];

    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCheckExceptionalCityFlag_Found:) name:@"getCheckExceptionalCityFlag_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ApplicationBodyType_Found:) name:@"ApplicationBodyType_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CustomerSegmentData_Found:) name:@"CustomerSegmentData_Found" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProductUpdateConnection_Found:) name:@"ProductUpdateConnection_Found" object:nil];
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PL_ProductID_RequestData_Found:) name:@"PL_ProductID_RequestData_Found" object:nil];    
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ListofActiveMicroMarketDSMData_Found:) name:@"ListofActiveMicroMarketDSMData_Found" object:nil];
    
    //ProductUpdateConnection_Found
}

- (void)viewWillDisappear:(BOOL)animated
{
    /*
     // unregister for keyboard notifications while not visible.
     [[NSNotificationCenter defaultCenter] removeObserver:self
     name:UIKeyboardWillShowNotification
     object:nil];
     
     [[NSNotificationCenter defaultCenter] removeObserver:self
     name:UIKeyboardWillHideNotification
     object:nil];*/

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LobListFound" object:nil]; //Gomzy //

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Activity_PPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PLUpdateOpty_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AppType_Data_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"All_States_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllDistrict_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Allcities_Found" object:nil];

    //AllTalukas_Found

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllTaluka_CallFound" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllPincode_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllProductName_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ProductUpdate_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ContactUpdate_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AddressData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getCheckExceptionalCityFlag_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ApplicationBodyType_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CustomerSegmentData_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ListofActiveMicroMarketDSMData_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ProductUpdateConnection_Found" object:nil];
    
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PL_ProductID_RequestData_Found" object:nil];
}

- (void)textFiledText
{
    UIColor* color = [UIColor colorWithRed:(131 / 255.0)green:(131 / 255.0)blue:(131 / 255.0)alpha:1];

    self.txt_STATE.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select State" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txt_DISTRICT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select District" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txt_CITY.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select City" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txt_TALUKA.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Taluka" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txt_PINCODE.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Pincode" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txt_LOB.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select LOB" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txt_AppType.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Application Type" attributes:@{ NSForegroundColorAttributeName : color }];
}

- (void)info_btn
{
    //  NSLog(@"Home biscuit from Sanfrancisco");
    [self performSegueWithIdentifier:@"infoView" sender:self];
}
- (void)logOut_btn
{
    // flag=true;
    alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                       message:@"Are you sure you want to Logout ?"
                                      delegate:self
                             cancelButtonTitle:@"No"
                             otherButtonTitles:@"Yes", nil];
    [alert show];
}
- (void)callGetAddressRequest
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                       @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\"/>"
                                       @"</header>"
                                       @"</SOAP:Header>"
                                       @"<SOAP:Body>"
                                       @"<SFATMCVContactQueryById_Input xmlns=\"http://siebel.com/asi/\">"
                                       @"<PrimaryRowId>%@</PrimaryRowId>"
                                       @"</SFATMCVContactQueryById_Input>"
                                       @"</SOAP:Body>"
                                        "</SOAP:Envelope>",
                                       opportunity_list.CONTACT_ID];

    NSLog(@"\n envlopeString Of user details....%@", envelopeText);
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

    NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

    [[RequestDelegate alloc] initiateRequest:request name:@"getAddressConnection"];
}

- (void)AddressData_Found:(NSNotification*)notification
{
    // int i = 0;
    // int i = 0; //for test loop
    GetAddressData_Arr = [[NSMutableArray alloc] init];
    //Activities_Customer_list=[[NSMutableArray alloc] init];
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];

    NSLog(@"\n Response.. Address Data %@", response);

    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
        [self hideAlert];
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"Contact" parentElement:[TBXML childElementNamed:@"ListOfContactInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVContactQueryById_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]]]];

        if (GetAddressData_Arr) {
            [GetAddressData_Arr removeAllObjects];
        }
        if (container) {

            // do {

            address = nil;
            address = [[Address alloc] init];
            /*
             <ListOfPersonalAddress>
             <PersonalAddress IsPrimaryMVG="Y">
             <Id>1-788U6TN</Id>
             <IntegrationId />
             <PersonalAddressName>1411117316814</PersonalAddressName>
             <PersonalCity>MUMBAI</PersonalCity>
             <PersonalCountry>India</PersonalCountry>
             <PersonalPostalCode>400012</PersonalPostalCode>
             <PersonalState>Maharashtra</PersonalState>
             <PersonalStreetAddress>ONE INDIA BULLS, 20TH FLOOR,</PersonalStreetAddress>
             <PersonalStreetAddress2 />
             <AddressId>1-788U6TN</AddressId>
             <TMPanchayat />
             <TMTaluka />
             <TMDistrict>MUMBAI</TMDistrict>
             <TMArea />
             </PersonalAddress>
             <PersonalAddress IsPrimaryMVG="N">
             <Id>1-74ZPM1B</Id>
             <IntegrationId />
             <PersonalAddressName>1404708483826</PersonalAddressName>
             <PersonalCity>THANE</PersonalCity>
             <PersonalCountry>India</PersonalCountry>
             <PersonalPostalCode>400604</PersonalPostalCode>
             <PersonalState>Maharashtra</PersonalState>
             <PersonalStreetAddress>D8,HIRANANDANI,THANE</PersonalStreetAddress>
             <PersonalStreetAddress2 />
             <AddressId>1-74ZPM1B</AddressId>
             <TMPanchayat />
             <TMTaluka>THANE</TMTaluka>
             <TMDistrict>THANE</TMDistrict>
             <TMArea />
             </PersonalAddress>
             </ListOfPersonalAddress>
             */
            TBXMLElement* Opportunity1 = [TBXML childElementNamed:@"ListOfPersonalAddress" parentElement:container];


            TBXMLElement* table = [TBXML childElementNamed:@"PersonalAddress" parentElement:Opportunity1];
            TBXMLElement* OPTY_ID = [TBXML childElementNamed:@"PersonalAddressName" parentElement:table];
            address.PersonalAddressName = [TBXML textForElement:OPTY_ID];
            NSString* s = [TBXML textForElement:OPTY_ID];
            NSLog(@"NAme : %@", s);

            TBXMLElement* PersonalCity = [TBXML childElementNamed:@"PersonalCity" parentElement:table];
            address.PersonalCity = [TBXML textForElement:PersonalCity];

            TBXMLElement* PersonalCountry = [TBXML childElementNamed:@"PersonalCountry" parentElement:table];
            address.PersonalCountry = [TBXML textForElement:PersonalCountry];

            TBXMLElement* PersonalPostalCode = [TBXML childElementNamed:@"PersonalPostalCode" parentElement:table];
            address.PersonalPostalCode = [TBXML textForElement:PersonalPostalCode];

            TBXMLElement* PersonalState = [TBXML childElementNamed:@"PersonalState" parentElement:table];
            address.PersonalState = [TBXML textForElement:PersonalState];

            TBXMLElement* PersonalStreetAddress = [TBXML childElementNamed:@"PersonalStreetAddress" parentElement:table];
            address.PersonalAddressName = [TBXML textForElement:PersonalStreetAddress];

            TBXMLElement* PersonalStreetAddress2 = [TBXML childElementNamed:@"PersonalStreetAddress2" parentElement:table];
            address.PersonalStreetAddress2 = [TBXML textForElement:PersonalStreetAddress2];

            TBXMLElement* AddressId = [TBXML childElementNamed:@"AddressId" parentElement:table];
            address.AddressId = [TBXML textForElement:AddressId];

            TBXMLElement* TMPanchayat = [TBXML childElementNamed:@"TMPanchayat" parentElement:table];
            address.TMPanchayat = [TBXML textForElement:TMPanchayat];

            TBXMLElement* TMTaluka = [TBXML childElementNamed:@"TMTaluka" parentElement:table];
            address.TMTaluka = [TBXML textForElement:TMTaluka];

            TBXMLElement* TMDistrict = [TBXML childElementNamed:@"TMDistrict" parentElement:table];
            address.TMDistrict = [TBXML textForElement:TMDistrict];

            TBXMLElement* TMArea = [TBXML childElementNamed:@"TMArea" parentElement:table];
            address.TMArea = [TBXML textForElement:TMArea];

            [GetAddressData_Arr addObject:address];
            NSLog(@"\nOpportunityListDisplayArr...... Print %@", GetAddressData_Arr);

            NSLog(@"\nOpportunityListDisplayArr......%d", [GetAddressData_Arr count]);

            if (GetAddressData_Arr >= 0) {
                // [self.tableViewData setHidden:NO];
                [self hideAlert];
            }
            else {
                [self hideAlert];
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }

            txt_STATE.text = address.PersonalState;
            NSLog(@"States : %@", address.PersonalState);
            SelectedStateCode = [GetAllStateCodes objectForKey:address.PersonalState];
            NSLog(@"States Found :%@", SelectedStateCode);
            NSLog(@"Sates Code : %@", [GetAllStateCodes objectForKey:@"Maharashtra"]);

            txt_DISTRICT.text = address.TMDistrict;
            txt_CITY.text = address.PersonalCity;
            txt_TALUKA.text = address.TMTaluka;
            txt_PINCODE.text = address.PersonalPostalCode;
            txt_PANCHAYAT.text = address.TMPanchayat;
            txt_AddressLine2.text = address.PersonalStreetAddress2;
            txt_AREA.text = address.TMArea;
        }
        /*else
         {
         
         alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         }*/
    }
}

- (void)call_AllStates
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                       @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                                        "@<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-faf1-0ea55009db29</DC>"
                                       @"</Logger>"
                                        "@</header>"
                                       @"</SOAP:Header>"
                                       @"<SOAP:Body>"
                                       @"<GetAllIndianStates xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\"/>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>"];

    NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

    NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

    [[RequestDelegate alloc] initiateRequest:request name:@"getStatesConnection"];
}
- (void)All_States_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ", response);

    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
        if (GetAllstates_Arr) {
            [GetAllstates_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        NSLog(@"Which.."); //ListOfTMOpportunityInterface
        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianStatesResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        NSLog(@"Which..1");

        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            [self hideAlert];
            do {

                TBXMLElement* table = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];

                TBXMLElement* OPTY_ID = [TBXML childElementNamed:@"X_STATE" parentElement:table];

                NSString* C0_value = [TBXML textForElement:OPTY_ID];

                [GetStatesAll setObject:C0_value forKey:@"OPTY_ID"];
                NSArray* ProductName1 = [GetStatesAll objectForKey:@"OPTY_ID"];
                NSLog(@"\n Object Data :  %@", [GetStatesAll objectForKey:@"OPTY_ID"]);
                [ProductName addObject:ProductName1];

            } while ((tuple = tuple->nextSibling));
            NSLog(@"Objects : %@", ProductName);
        }
        else {

            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            // [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SearchOptyViewController"] animated:NO];
        }
        //  [self hideAlert];
    }
}

- (void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
- (void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)call_LOB
{
   

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetAllLOB xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                                       @" </SOAP:Body>"
                                       @"</SOAP:Envelope>"];

    NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc] initiateRequest:request name:@"GetLOB"];
}

- (void)LobListFound:(NSNotification*)notification
{
    GetLOB_Arr = [[NSMutableArray alloc] init];
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ", response);

    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
        if (GetLOB_Arr) {
            [GetLOB_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        NSLog(@"Which..");
        TBXMLElement* container = [TBXML childElementNamed:@"GetAllLOBResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            do {
                TBXMLElement* S_Lst_Of_Val = [TBXML childElementNamed:@"S_LST_OF_VAL" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* NAME = [TBXML childElementNamed:@"VAL" parentElement:S_Lst_Of_Val];
                str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_NSE : %@", str_NAME);
                // activity_list.OPPTY_NAME =[TBXML textForElement:X_OPTY_NAME];
                //assign_list.NSE_LOBDSE_NAME =[TBXML textForElement:NAME];
                [GetLOB_Arr addObject:str_NAME];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages : %@", GetLOB_Arr);

            if ((GetLOB_Arr.count) > 0) {
            }
        }
        else {
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        //  [self hideAlert];
    }
}

- (BOOL)connected
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}
- (void)checkNetworkStatus:(NSNotification*)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus) {
    case NotReachable: {
        NSLog(@"The internet is down.");
        self->internetActive = NO;
        break;
    }
    case ReachableViaWiFi: {
        NSLog(@"The internet is working via WIFI.");
        self->internetActive = YES;

        break;
    }
    case ReachableViaWWAN: {
        NSLog(@"The internet is working via WWAN.");
        self->internetActive = YES;

        break;
    }
    }

    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus) {
    case NotReachable: {
        NSLog(@"A gateway to the host server is down.");
        self->hostActive = NO;

        break;
    }
    case ReachableViaWiFi: {
        NSLog(@"A gateway to the host server is working via WIFI.");
        self->hostActive = YES;

        break;
    }
    case ReachableViaWWAN: {
        NSLog(@"A gateway to the host server is working via WWAN.");
        self->hostActive = YES;

        break;
    }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_UpdateContact:(id)sender
{

    if (![self connected]) {
        // not connected
        NSLog(@"Newtwork not Available...");
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {

        [self showAlert];
        if (txt_FirstName.text.length == 0 || txt_LASTNAME.text.length == 0 || txt_AddressLine1.text.length == 0 || txt_STATE.text.length == 0 || txt_DISTRICT.text.length == 0 || txt_CITY.text.length == 0 ) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Select Mandatory Fields ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {

            // [self Call_CheckExceptionalCityFlag];

            [self Call_Update_Contact_Details];
        }
    }
}
- (IBAction)btn_UpdateProduct:(id)sender
{
    [self Call_Update_Product_Details];
}

-(void)Call_Update_Product_Details
{
    /*
     <SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">
     <SOAP:Body>" +
     "<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">
     <ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%20Opportunity%20Interface\">" +
     "<Opportunity operation=\"update\">
     <Id>" +
     data.OPTY_ID +
     "</Id>" +
     "<TMLOB>" +
     lobVal +
     "</TMLOB>
     <ParentProductLine>" +
     PPL +
     "</ParentProductLine>
     <ProductLine>" +
     PL +
     "</ProductLine>
     <IntendedApplication>" +
     application.get(spn4.getSelectedItemPosition()) +
     "</IntendedApplication>
     <ListOfOpportunityRelatedProducts>
     <OpportunityRelatedProducts operation=\"update\">
     <Product>
     
     </Product><Id>" +
     data.REV_PRODUCT_ID +
     "</Id><ProductQuantity>" +
     "1" +
     "</ProductQuantity><ParentProductLine>" +
     PPL +
     "</ParentProductLine><ProductLine>" +
     PL +
     "</ProductLine><OpptyId>" +
     data.OPTY_ID +
     "</OpptyId></OpportunityRelatedProducts></ListOfOpportunityRelatedProducts></Opportunity></ListOfTMOpportunityInterface></SFATMCVOPTYInsertOrUpdate_Input></SOAP:Body></SOAP:Envelope>";
     */
    // NSLog(@"... Opty Id L %@",[GetProductName_Arr objectAtIndex:0]);
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                               @"<Opportunity operation=\"update\">"
                               @"<Id>1-7GO069T</Id>"
                               @"<TMLOB>Pickups</TMLOB>"
                               @"<ParentProductLine>Xenon Pickups</ParentProductLine>"
                               @"<ProductLine>Tatamobile FBV</ProductLine>"
                               @"<IntendedApplication>Egg</IntendedApplication>"
                               @"<TMBodyType>Cab</TMBodyType>"
                               @"<TMCustomerSegment>Market Load Operator</TMCustomerSegment>"
                               @"<TMFleetSize>2</TMFleetSize>"
                               @"<TMMMGeography>AALI</TMMMGeography>"
                               @"<TMNonFleetSize>2</TMNonFleetSize>"
                               @"<ListOfOpportunityRelatedProducts>"
                               @"<OpportunityRelatedProducts operation=\"update\">"
                               @"<Product>265328280BFRLA00</Product>"
                               @"<Id>1-1LPY7-2</Id>"
                               @"<ProductQuantity>1</ProductQuantity>"
                               @"<ParentProductLine>Xenon Pickups</ParentProductLine>"
                               @"<ProductLine>Tatamobile FBV</ProductLine>"
                               @"<OpptyId>1-7GO069T</OpptyId>"
                               @"</OpportunityRelatedProducts>"
                               @"</ListOfOpportunityRelatedProducts>"
                               @"</Opportunity>"
                               @"</ListOfTMOpportunityInterface>"
                               @"</SFATMCVOPTYInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"];
    
    
    NSString * envelopeText1 = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                               @"<Opportunity operation=\"update\">"
                               @"<Id>%@</Id>"
                               @"<TMLOB>%@</TMLOB>"
                               @"<ParentProductLine>%@</ParentProductLine>"
                               @"<ProductLine>%@</ProductLine>"
                               @"<IntendedApplication>%@</IntendedApplication>"
                               @"<TMBodyType>Cab</TMBodyType>"
                               @"<TMCustomerSegment>%@</TMCustomerSegment>"
                               @"<TMFleetSize>2</TMFleetSize>"
                               @"<TMMMGeography>%@</TMMMGeography>"
                               @"<TMNonFleetSize>2</TMNonFleetSize>"
                               @"<ListOfOpportunityRelatedProducts>"
                               @"<OpportunityRelatedProducts operation=\"update\">"
                               @"<Product>%@</Product>"
                               @"<Id>%@</Id>"
                               @"<ProductQuantity>1</ProductQuantity>"
                               @"<ParentProductLine>%@</ParentProductLine>"
                               @"<ProductLine>%@</ProductLine>"
                               @"<OpptyId>%@</OpptyId>"
                               @"</OpportunityRelatedProducts>"
                               @"</ListOfOpportunityRelatedProducts>"
                               @"</Opportunity>"
                               @"</ListOfTMOpportunityInterface>"
                               @"</SFATMCVOPTYInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",opportunity_list.OPTY_ID,txt_LOB.text,txt_PPL.text,txt_PL.text,txt_AppType.text,txt_CustomerSegment.text,txt_MMG.text,str_NAME,str_NAME1,txt_PPL.text,txt_PL.text,opportunity_list.OPTY_ID];
    
    

    
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getProductUpdateConnection"];
    
}//ProductUpdateConnection_Found
-(void)ProductUpdateConnection_Found:(NSNotification*)notification
{
    
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost Contact  %@ ", response);
    
    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
        if (ProductDetailsUpdate_Arr) {
            [ProductDetailsUpdate_Arr removeAllObjects];
        }
        
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        NSLog(@"Which.."); //ListOfTMOpportunityInterface
        TBXMLElement* container = [TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]]];
        
        //TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        
        TBXMLElement* Opportunity = [TBXML childElementNamed:@"Opportunity" parentElement:container];
        
      
        
        if (Opportunity) {
            [self hideAlert];
            
            TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
            
            NSString *productid = [TBXML textForElement:Id];
            NSLog(@"\nListOfContactInterface.....!!!!!%@", updateContactOpty.Id_);
            
           
            
            if ([productid isEqualToString:@""]) {
                
                alert = [[UIAlertView alloc] initWithTitle:nil message:@"Product details updation failed!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
           
            else {
                
                if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Product details updated successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Product details updated successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Product details updated successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }
    }
}
- (IBAction)btn_ProductSwitch:(id)sender
{
}

- (IBAction)btn_ContactSwitch:(id)sender
{

    [self.View_Contact setHidden:NO];
    [self.View_Product setHidden:YES];

    [self.btn_ProductSwitch setBackgroundImage:[UIImage imageNamed:@"product_tab_normal.png"] forState:UIControlStateNormal];

    [self.btn_ContactSwitch setBackgroundImage:[UIImage imageNamed:@"contact_tab_active.png"] forState:UIControlStateNormal];
}

- (IBAction)btn_Productswitch:(id)sender
{

    [self.View_Contact setHidden:YES];
    [self.View_Product setHidden:NO];

    [self.btn_ProductSwitch setBackgroundImage:[UIImage imageNamed:@"product_tab_active.png"] forState:UIControlStateNormal];

    [self.btn_ContactSwitch setBackgroundImage:[UIImage imageNamed:@"contact_tab_normal.png"] forState:UIControlStateNormal];
}
- (IBAction)btn_LOB:(id)sender
{

    self.btn_PPL.userInteractionEnabled = YES;
   

    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString* title in GetLOB_Arr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

        [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.View_Product animated:YES];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    }
    else {
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 1;
}

- (IBAction)btn_PPL:(id)sender
{

    [self showAlert];
    self.btn_PL.userInteractionEnabled = YES;
    if ([txt_LOB.text isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select LOB " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select LOB " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select LOB " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
      

        NSString* envelopeText = [NSString stringWithFormat:
                                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetPPLFromLOB xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<LOB>%@</LOB>"
                                           @"</GetPPLFromLOB>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",
                                           txt_LOB.text];

        NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
        NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

        NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
        // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
        NSLog(@"URL IS %@", theurl);
        // NSLog(@"REQUEST IS %@",envelopeText);

        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

        NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

        [[RequestDelegate alloc] initiateRequest:request name:@"getActivityPPLConnection"];
    }
}

- (void)Activity_PPL_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PPL_Found response....... %@ ", response);

    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        if (GetPPL_LOB_Arr) {
            [GetPPL_LOB_Arr removeAllObjects];
            // [activityPPLNamePickerArr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetPPLFromLOBResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetPPL_LOB_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetPPL_LOB_Arr);

            if ((GetPPL_LOB_Arr.count) > 0) {
                NSLog(@"In..");
                [self hideAlert];

                actionSheet = [[UIActionSheet alloc]
                             initWithTitle:nil
                                  delegate:self
                         cancelButtonTitle:nil
                    destructiveButtonTitle:nil
                         otherButtonTitles:nil];

                for (int i = 0; i < [self.GetPPL_LOB_Arr count]; i++) {
                    [actionSheet addButtonWithTitle:[self.GetPPL_LOB_Arr objectAtIndex:i]];
                }
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    [actionSheet showFromRect:[self.txt_PPL frame] inView:self.View_Product animated:YES];
                }
                else {
                    [actionSheet showInView:self.view];
                }
                actionSheet.tag = 2;
            }
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}

- (IBAction)btn_PL:(id)sender
{

    [self showAlert];
    if ([txt_LOB.text isEqual:@""] && [txt_PPL.text isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select mandatory fields " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select mandatory fields " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select mandatory fields " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        NSString* envelopeText = [NSString stringWithFormat:
                                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetPLFromPPL xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<PPL_Name>%@</PPL_Name>"
                                           @"<LOB>%@</LOB>"
                                           @"</GetPLFromPPL>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",
                                           txt_PPL.text, txt_LOB.text];

        NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
        NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

        NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
        NSLog(@"URL IS %@", theurl);

        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

        NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

        [[RequestDelegate alloc] initiateRequest:request name:@"getActivityPLConnection"];
    }
}
- (void)PLUpdateOpty_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response ....... %@ ", response);
    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        if (GetPL_LOBPPL_Arr) {
            [GetPL_LOBPPL_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetPLFromPPLResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"s_prod_int" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"PL" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetPL_LOBPPL_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetPL_LOBPPL_Arr);

            if ((GetPL_LOBPPL_Arr.count) > 0) {

                [self hideAlert];
                actionSheet = [[UIActionSheet alloc]
                             initWithTitle:nil
                                  delegate:self
                         cancelButtonTitle:nil
                    destructiveButtonTitle:nil
                         otherButtonTitles:nil];

                for (int i = 0; i < [self.GetPL_LOBPPL_Arr count]; i++) {
                    [actionSheet addButtonWithTitle:[self.GetPL_LOBPPL_Arr objectAtIndex:i]];
                }
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    [actionSheet showFromRect:[self.txt_PL frame] inView:self.View_Product animated:YES];
                    // [self Call_Product_Name];
                }
                else {
                    [actionSheet showInView:self.view];
                }
                actionSheet.tag = 3;
            }
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}

- (IBAction)btn_APPTYPE:(id)sender
{

    [self showAlert];
    if ([txt_LOB.text isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select LOB" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select LOB" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select LOB" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        //alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Please select LOB" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alert show];
    }
    else {
        //  [self callActivity_PPL];
        NSString* envelopeText = [NSString stringWithFormat:
                                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetTMCVIndentAppsNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<lob>%@</lob>"
                                           @"</GetTMCVIndentAppsNeev>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",
                                           txt_LOB.text];

        NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
        NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

        NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
        // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
        NSLog(@"URL IS %@", theurl);
        // NSLog(@"REQUEST IS %@",envelopeText);

        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

        NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

        [[RequestDelegate alloc] initiateRequest:request name:@"getApplicationTypeConnection"];
    }
}
- (void)AppType_Data_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        if (GetAppType_Arr) {
            [GetAppType_Arr removeAllObjects];
            // [activityPPLNamePickerArr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetTMCVIndentAppsNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            [self hideAlert];
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetAppType_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetAppType_Arr);
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }

        if ((GetAppType_Arr) > 0) {
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:nil
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [GetAppType_Arr count]; i++) {
                [actionSheet addButtonWithTitle:[self.GetAppType_Arr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_AppType frame] inView:self.View_Product animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 4;
        }
        [self hideAlert];
    }
}

- (IBAction)btn_BODYTYPE:(id)sender
{
    [self showAlert];
    if ([txt_PPL.text isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select PPL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select PPL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select PPL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
     
    }
    else {

        NSString* envelopeText = [NSString stringWithFormat:
                                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetBodyTypeDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<subtype>%@</subtype>"
                                           @"</GetBodyTypeDSM>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",
                                           txt_PPL.text];

        NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
        NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

        NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
        // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
        NSLog(@"URL IS %@", theurl);
        // NSLog(@"REQUEST IS %@",envelopeText);

        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

        NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

        [[RequestDelegate alloc] initiateRequest:request name:@"getApplicationbodyType"];
    }
}
- (void)ApplicationBodyType_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Body Type response....... %@ ", response);

    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        //[appdelegate hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self hideAlert];
    }
    else {

        if (Getbodytype_Arr) {
            [Getbodytype_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetBodyTypeDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"S_LST_OF_VAL" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"usage name: %@", PPL_ID_);
                [Getbodytype_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@"body type array %@", Getbodytype_Arr);
        }
        else {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Data not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }

        if ((Getbodytype_Arr) > 0) {
            NSLog(@"In..");
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:@" "
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [Getbodytype_Arr count]; i++) {
                [actionSheet addButtonWithTitle:[self.Getbodytype_Arr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_BodyType frame] inView:self.View_Product animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 10;
        }
    }
}

- (IBAction)btn_CUSTOMERSEG:(id)sender
{
    [self showAlert];
    if ([txt_LOB.text isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select PPL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select PPL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select PPL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        //alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Please select LOB" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alert show];
    }
    else {

        NSString* envelopeText = [NSString stringWithFormat:
                                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetUsageCategoryDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<subtype>%@</subtype>"
                                           @"</GetUsageCategoryDSM>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",
                                           txt_LOB.text];

        NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
        NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

        NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
        // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
        NSLog(@"URL IS %@", theurl);
        // NSLog(@"REQUEST IS %@",envelopeText);

        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

        NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

        [[RequestDelegate alloc] initiateRequest:request name:@"getCustomerSegment"];
    }
}

-(void)CustomerSegmentData_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ",response);
    
    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        //[appdelegate hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Something went wrong." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self hideAlert];
    }
    else{
        
        if (Getusagecatagory_Arr)
        {
            [Getusagecatagory_Arr removeAllObjects];
            
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        TBXMLElement *container = [TBXML childElementNamed:@"GetUsageCategoryDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        
        if (tuple)
        {
            do
            {
                TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"S_LST_OF_VAL" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *PPL_ID = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString *PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"usage name: %@",PPL_ID_);
                [Getusagecatagory_Arr addObject:PPL_ID_];
            }while ((tuple = tuple->nextSibling));
            NSLog(@"usage array %@",Getusagecatagory_Arr);
        }
        else
        {
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Data not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        if ((Getusagecatagory_Arr) > 0){
            NSLog(@"In..");
            [self hideAlert];
            
            actionSheet = [[UIActionSheet alloc]
                           initWithTitle:@" "
                           delegate:self
                           cancelButtonTitle:nil
                           destructiveButtonTitle:nil
                           otherButtonTitles:nil];
            
            
            for (int i=0; i<[Getusagecatagory_Arr count]; i++)
            {
                [actionSheet addButtonWithTitle:[self.Getusagecatagory_Arr objectAtIndex:i]];
                
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [actionSheet showFromRect:[self.txt_CustomerSegment frame] inView:self.View_Product animated:YES];
            }
            else
            {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 11;
            
            //[appdelegate hideAlert];
        }
    }
}

- (IBAction)btn_MMG:(id)sender
{
    
    if ((Micromarket_Arr) > 0){
        NSLog(@"In..");
        [self hideAlert];
        
        actionSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:self
                       cancelButtonTitle:nil
                       destructiveButtonTitle:nil
                       otherButtonTitles:nil];
        
        
        for (int i=0; i<[Micromarket_Arr count]; i++)
        {
            [actionSheet addButtonWithTitle:[Micromarket_Arr objectAtIndex:i]];
            
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [actionSheet showFromRect:[self.txt_MMG frame] inView:self.View_Product animated:YES];
        }
        else
        {
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 23;
        
        
    }
    else {
    
        [self hideAlert];
        
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Micromarket data not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    
    
    }
 
    
    
    
}
- (IBAction)btn_STATE:(id)sender
{

    if (![self connected]) {
        // not connected
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
        txt_DISTRICT.text = @"";
        txt_CITY.text = @"";
        txt_TALUKA.text = @"";
        check = 1;
        NSLog(@"Activity...Data %@", ProductName);
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        // ObjC Fast Enumeration
        for (NSString* title in ShowStates) {
            [actionSheet addButtonWithTitle:title];
        }
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

            [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.View_Contact animated:YES];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        }
        else {
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 5;
    }
}

- (IBAction)btn_CITY:(id)sender
{

    if (![self connected]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        [self showAlert];
        if (txt_STATE.text.length == 0) {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else if (txt_DISTRICT.text.length == 0) {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the district" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select the district" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else {
            NSLog(@"District Selected  ");
            txt_TALUKA.text = @"";
            NSString* envelopeText = [NSString stringWithFormat:
                                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                               @"<SOAP:Body>"
                                               @"<GetAllIndianCity xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                               @"<state>%@</state>"
                                               @"<dist>%@</dist>"
                                               @"</GetAllIndianCity>"
                                               @"</SOAP:Body>"
                                               @"</SOAP:Envelope>",
                                               SelectedStateCode, txt_DISTRICT.text];

            NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
            NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

            NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

            NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

            [[RequestDelegate alloc] initiateRequest:request name:@"Allcities"];
        }
    }
}
- (void)Allcities_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        if (GetAllCities) {
            [GetAllCities removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianCityResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"X_CITY" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetAllCities addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetAllCities);
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }

        if ([GetAllCities count] > 0) {
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:nil
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [GetAllCities count]; i++) {
                [actionSheet addButtonWithTitle:[GetAllCities objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_CITY frame] inView:self.View_Contact animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 7;
        }
    }
}

- (IBAction)btn_PINCODE:(id)sender
{

    [self showAlert];
    if (txt_CITY.text.length == 0 || txt_STATE.text.length == 0 || txt_DISTRICT.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select mandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select mandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select mandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        NSLog(@"District Selected  ");
        {
            //  [self callActivity_PPL];

            /*<SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
             <SOAP:Body>
             <GetAllIndianPostalCode xmlns="http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps" preserveSpace="no" qAccess="0" qValues="">
             <state>MH</state>
             <dist>THANE</dist>
             <city>THANE</city>
             <taluka></taluka>
             </GetAllIndianPostalCode>
             </SOAP:Body>
             </SOAP:Envelope>  */

            NSString* envelopeText = [NSString stringWithFormat:
                                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                               @"<SOAP:Body>"
                                               @"<GetAllIndianPostalCode xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                               @"<state>%@</state>"
                                               @"<dist>%@</dist>"
                                               @"<city>%@</city>"
                                               @"<taluka>%@</taluka>"
                                               @"</GetAllIndianPostalCode>"
                                               @"</SOAP:Body>"
                                               @"</SOAP:Envelope>",
                                               SelectedStateCode, txt_DISTRICT.text, txt_CITY.text, txt_TALUKA.text];

            NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
            NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

            NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
            // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
            NSLog(@"URL IS %@", theurl);
            // NSLog(@"REQUEST IS %@",envelopeText);

            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

            NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

            [[RequestDelegate alloc] initiateRequest:request name:@"getAllPincodeConnection"];
        }
    }
}

- (void)AllPincode_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        if (GetAllPincode) {
            [GetAllPincode removeAllObjects];
            // [activityPPLNamePickerArr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianPostalCodeResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"X_POSTAL_CODE" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetAllPincode addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetAllPincode);

            if ([GetAllPincode count] > 0) {
                NSLog(@"In..");
                [self hideAlert];

                actionSheet = [[UIActionSheet alloc]
                             initWithTitle:nil
                                  delegate:self
                         cancelButtonTitle:nil
                    destructiveButtonTitle:nil
                         otherButtonTitles:nil];

                for (int i = 0; i < [GetAllPincode count]; i++) {
                    [actionSheet addButtonWithTitle:[self.GetAllPincode objectAtIndex:i]];
                }
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    [actionSheet showFromRect:[self.txt_PINCODE frame] inView:self.View_Contact animated:YES];
                }
                else {
                    [actionSheet showInView:self.view];
                }
                actionSheet.tag = 9;

                //[appdelegate hideAlert];
            }
            else {
                [self hideAlert];
                if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}

- (IBAction)btn_DISTRICT:(id)sender
{

    [self showAlert];
    if (txt_STATE.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        NSLog(@"staes Selected  ");
        {

            txt_CITY.text = @"";
            txt_TALUKA.text = @"";
            NSString* envelopeText = [NSString stringWithFormat:
                                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                               @"<SOAP:Body>"
                                               @"<GetAllIndianDistricts xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                               @"<state>%@</state>"
                                               @"</GetAllIndianDistricts>"
                                               @"</SOAP:Body>"
                                               @"</SOAP:Envelope>",
                                               SelectedStateCode];
            NSLog(@"\n Object Data :  %@", str_States);

            NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
            NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

            NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
            // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
            NSLog(@"URL IS %@", theurl);
            // NSLog(@"REQUEST IS %@",envelopeText);

            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

            NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

            [[RequestDelegate alloc] initiateRequest:request name:@"getAllDistrictConnection"];
        }
    }
}
- (void)AllDistrict_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        if (GetAllDistrict_Arr) {
            [GetAllDistrict_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianDistrictsResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            [self hideAlert];
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"X_DISTRICT" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetAllDistrict_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetAllDistrict_Arr);
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }

        if ([GetAllDistrict_Arr count] > 0) {
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:nil
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [GetAllDistrict_Arr count]; i++) {
                [actionSheet addButtonWithTitle:[self.GetAllDistrict_Arr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_DISTRICT frame] inView:self.View_Contact animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 6;
        }
    }
}

- (IBAction)btn_TALUKA:(id)sender
{

    [self showAlert];
    if (txt_STATE.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txt_DISTRICT.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the district" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select the district" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txt_CITY.text.length == 0) {

        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select the city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        NSLog(@"Citi  Selected  ");

        NSString* envelopeText = [NSString stringWithFormat:
                                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetAllIndianTaluka xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<state>%@</state>"
                                           @"<dist>%@</dist>"
                                           @"<city>%@</city>"
                                           @"</GetAllIndianTaluka>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",
                                           SelectedStateCode, txt_DISTRICT.text, txt_CITY.text];

        NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
        NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

        NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
        // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
        NSLog(@"URL IS %@", theurl);
        // NSLog(@"REQUEST IS %@",envelopeText);

        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

        NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

        [[RequestDelegate alloc] initiateRequest:request name:@"getAllTalukaConnectionCall"];
    }
}
- (void)AllTaluka_CallFound:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Taluka response....... %@ ", response);

    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        if (GetAllTaluka) {
            [GetAllTaluka removeAllObjects];
            // [activityPPLNamePickerArr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianTalukaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"X_TALUKA" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetAllTaluka addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetAllTaluka);
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }

        if ((GetAllTaluka) > 0) {
            NSLog(@"In..");
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:nil
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [GetAllTaluka count]; i++) {
                [actionSheet addButtonWithTitle:[self.GetAllTaluka objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_TALUKA frame] inView:self.View_Contact animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 8;

            //[appdelegate hideAlert];
        }
    }
}

- (IBAction)btn_PANCHAYAT:(id)sender
{
}

- (void)actionSheet:(UIActionSheet*)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{

    NSLog(@"button click ....%ld", (long)buttonIndex);
    if (txt_LOB) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 1:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_LOB.text = NSLocalizedString([GetLOB_Arr objectAtIndex:buttonIndex], @"");
                
                
                self.txt_PL.text = @"";
                self.txt_PPL.text = @"";
                self.txt_AppType.text=@"";
                self.txt_BodyType.text=@"";
                self.txt_CustomerSegment.text=@"";
            
            }
        }
    }
    if (txt_PPL) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 2:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_PPL.text = NSLocalizedString([GetPPL_LOB_Arr objectAtIndex:buttonIndex], @"");
            }
              self.txt_PL.text = @"";
               self.txt_BodyType.text=@"";
        }
    }
    if (txt_PL) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 3:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_PL.text = NSLocalizedString([GetPL_LOBPPL_Arr objectAtIndex:buttonIndex], @"");
                
                [self Call_Product_Name];
            }
        }
    }
    if (txt_AppType) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 4:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_AppType.text = NSLocalizedString([GetAppType_Arr objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txt_STATE) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 5:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                str_States = [ProductName objectAtIndex:buttonIndex];
                self.txt_STATE.text = NSLocalizedString([ShowStates objectAtIndex:buttonIndex], @"");
                SelectedStateCode = [GetAllStateCodes objectForKey:txt_STATE.text];
                NSLog(@"Sates Extact : %@", SelectedStateCode);
            }
        }
    }
    if (txt_DISTRICT) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 6:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_DISTRICT.text = NSLocalizedString([GetAllDistrict_Arr objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txt_CITY) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 7:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_CITY.text = NSLocalizedString([GetAllCities objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txt_TALUKA) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 8:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_TALUKA.text = NSLocalizedString([GetAllTaluka objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txt_PINCODE) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 9:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_PINCODE.text = NSLocalizedString([GetAllPincode objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txt_BodyType) {
        NSLog(@"... in");
        switch (popup.tag) {
            case 10:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    NSLog(@"ek..");
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    self.txt_BodyType.text = NSLocalizedString([Getbodytype_Arr objectAtIndex:buttonIndex], @"");
                }
        }
    }
    if (txt_CustomerSegment) {
        NSLog(@"... in");
        switch (popup.tag) {
            case 11:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    NSLog(@"ek..");
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    self.txt_CustomerSegment.text = NSLocalizedString([Getusagecatagory_Arr objectAtIndex:buttonIndex], @"");
                }
        }
    }
    if (txt_MMG) {
        NSLog(@"... in");
        switch (popup.tag) {
            case 23:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    NSLog(@"ek..");
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    self.txt_MMG.text = NSLocalizedString([Micromarket_Arr objectAtIndex:buttonIndex], @"");
                }
        }
    }
    
    
    
}

- (void)Call_Update_Contact_Details
{

    NSLog(@"... Opty Id L %@", opportunity_list.OPTY_ID);
    
    
        updatecount=@"callfirst";
    
    NSString* envelopeText = [NSString stringWithFormat:
                              @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              @"<SOAP:Body>"
                              @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                              @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                              @"<Contact operation=\"\">"
                              @"<Id>%@</Id>"
                              @"<FirstName>%@</FirstName>"
                              @"<LastName>%@</LastName>"
                              @"<ListOfPersonalAddress operation=\"\">"
                              @"<PersonalAddress IsPrimaryMVG=\"Y\">"
                              @"<Id>%@</Id>"
                              @"<PersonalStreetAddress>%@</PersonalStreetAddress>"
                              @"<PersonalStreetAddress2>%@</PersonalStreetAddress2>"
                              @"<PersonalCountry>India</PersonalCountry>"
                              @"<PersonalState>%@</PersonalState>"
                              @"<TMDistrict>%@</TMDistrict>"
                              @"<PersonalCity>%@</PersonalCity>"
                              @"<TMTaluka>%@</TMTaluka>"
                              @"<TMPanchayat>%@</TMPanchayat>"
                              @"<TMArea>%@</TMArea>"
                              @"<PersonalPostalCode>%@</PersonalPostalCode>"
                              @"</PersonalAddress>"
                              @"</ListOfPersonalAddress>"
                              @"</Contact>"
                              @"</ListOfContactInterface>"
                              @"</SFATMCVContactInsertOrUpdate_Input>"
                              @"</SOAP:Body>"
                              @"</SOAP:Envelope>",
                              opportunity_list.CONTACT_ID, txt_FirstName.text, txt_LASTNAME.text, opportunity_list.ADDRESS_ID, txt_AddressLine1.text, txt_AddressLine2.text, SelectedStateCode, txt_DISTRICT.text,txt_CITY.text,txt_TALUKA.text, self.txt_PANCHAYAT.text, txt_AREA.text, txt_PINCODE.text];
    
    
    
    
    
    
    
    NSString* envelopeText1 = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                       @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                       @"<Contact operation=\"\">"
                                       @"<Id>%@</Id>"
                                       @"<FirstName>%@</FirstName>"
                                       @"<LastName>%@</LastName>"
                                       @"<ListOfPersonalAddress operation=\"\">"
                                       @"<PersonalAddress IsPrimaryMVG=\"Y\">"
                                       @"<Id>%@</Id>"
                                       @"<PersonalStreetAddress>%@</PersonalStreetAddress>"
                                       @"<PersonalStreetAddress2>%@</PersonalStreetAddress2>"
                                       @"<PersonalCountry>India</PersonalCountry>"
                                       @"<PersonalState>%@</PersonalState>"
                                       @"<TMDistrict>%@</TMDistrict>"
                                      // @"<PersonalCity>%@</PersonalCity>"
                                       @"<TMTaluka>%@</TMTaluka>"
                                       @"<TMPanchayat>%@</TMPanchayat>"
                                       @"<TMArea>%@</TMArea>"
                                       @"<PersonalPostalCode>%@</PersonalPostalCode>"
                                       @"</PersonalAddress>"
                                       @"</ListOfPersonalAddress>"
                                       @"</Contact>"
                                       @"</ListOfContactInterface>"
                                       @"</SFATMCVContactInsertOrUpdate_Input>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",
                                       opportunity_list.CONTACT_ID, txt_FirstName.text, txt_LASTNAME.text, opportunity_list.ADDRESS_ID, txt_AddressLine1.text, txt_AddressLine2.text, SelectedStateCode, txt_DISTRICT.text, txt_CITY.text, self.txt_PANCHAYAT.text, txt_AREA.text, txt_PINCODE.text];

    NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    

    
    
    [[RequestDelegate alloc] initiateRequest:request name:@"getContactUpdateConnection"];
}

- (void)ContactUpdate_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost Contact  %@ ", response);

    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        
        
        [self hideAlert];
        
       
        
        
        if ([response rangeOfString:@"Method 'WriteRecord' of business component 'CUT Address'"].location != NSNotFound) {
            
            
            NSLog(@"cut address issue ");
            
            
            
            [self cutaddress];
            
            
        }
        
        else{
         
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Contact update failed " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Contact update failed " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Contact update failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
            
        }
    }
    else {
        if (ProductDetailsUpdate_Arr) {
            [ProductDetailsUpdate_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        NSLog(@"Which.."); //ListOfTMOpportunityInterface
        TBXMLElement* container = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]]];

        //TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];

        TBXMLElement* Opportunity = [TBXML childElementNamed:@"Contact" parentElement:container];

        NSLog(@"Which..2");

        NSLog(@"Which..3");

        if (Opportunity) {
            [self hideAlert];

            TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];

            updateContactOpty.Id_ = [TBXML textForElement:Id];
            NSLog(@"\nListOfContactInterface.....!!!!!%@", updateContactOpty.Id_);

            TBXMLElement* ListOfPersonalAddress = [TBXML childElementNamed:@"ListOfPersonalAddress" parentElement:Opportunity];

            TBXMLElement* PersonalAddress = [TBXML childElementNamed:@"PersonalAddress" parentElement:ListOfPersonalAddress];

            if (PersonalAddress) {
                TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:PersonalAddress];

                updateContactOpty.Id_1 = [TBXML textForElement:Id];
                NSLog(@"\nListOfContactInterface.....!!!!!%@", updateContactOpty.Id_1);
                flag = 1;
            }
            
            
            
            
            
            
            if ([updatecount isEqual:@"callfirst"]) {
            
                [self Call_Update_Contact_DetailsOne];
          }
            
            if ([updatecount isEqual:@"callsecond"]) {
               [self Call_Update_Contact_DetailsTwo];
                
                if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Contact details updated successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Contact details updated successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Contact details updated successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
                
                
                
            }
        
            
            
//            
//            else {
//
//                if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
//                    alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Contact details updated successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//                else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
//                    alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Contact details updated successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//                else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
//                    alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Contact details updated successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//            }
            
            
        }
        else {
            [self hideAlert];

            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    //  [self hideAlert];}
}
- (void)Call_Update_Contact_DetailsOne
{

    NSLog(@"... Opty Id L %@", opportunity_list.OPTY_ID);
    
   updatecount=@"callsecond";
    
    
    NSString* envelopeText1 = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                               @"<Contact operation=\"\">"
                               @"<Id>%@</Id>"
                              // @"<FirstName>%@</FirstName>"
                             //  @"<LastName>%@</LastName>"
                               @"<ListOfPersonalAddress operation=\"\">"
                               @"<PersonalAddress IsPrimaryMVG=\"Y\">"
                               @"<Id>%@</Id>"
                              // @"<PersonalStreetAddress>%@</PersonalStreetAddress>"
                              // @"<PersonalStreetAddress2>%@</PersonalStreetAddress2>"
                              // @"<PersonalCountry>India</PersonalCountry>"
                              // @"<PersonalState>%@</PersonalState>"
                              // @"<TMDistrict>%@</TMDistrict>"
                             //  @"<PersonalCity>%@</PersonalCity>"
                               @"<TMTaluka>%@</TMTaluka>"
                               //@"<TMPanchayat>%@</TMPanchayat>"
                              // @"<TMArea>%@</TMArea>"
                              // @"<PersonalPostalCode>%@</PersonalPostalCode>"
                             //  @"</PersonalAddress>"
                               @"</ListOfPersonalAddress>"
                               @"</Contact>"
                               @"</ListOfContactInterface>"
                               @"</SFATMCVContactInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",
                               opportunity_list.CONTACT_ID, opportunity_list.ADDRESS_ID,txt_TALUKA.text];
    
    
    
    
    
    
    
    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                       @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                       @"<Contact operation=\"\">"
                                       @"<Id>%@</Id>"
                                       @"<FirstName>%@</FirstName>"
                                       @"<LastName>%@</LastName>"
                                       @"<ListOfPersonalAddress operation=\"\">"
                                       @"<PersonalAddress IsPrimaryMVG=\"Y\">"
                                       @"<Id>%@</Id>"
                                       @"<PersonalStreetAddress>%@</PersonalStreetAddress>"
                                       @"<PersonalStreetAddress2>%@</PersonalStreetAddress2>"
                                       @"<PersonalCountry>India</PersonalCountry>"
                                       @"<PersonalState>%@</PersonalState>"
                                       @"<TMDistrict>%@</TMDistrict>"
                                       @"<PersonalCity>%@</PersonalCity>"
                                       @"<TMTaluka>%@</TMTaluka>"
                                       @"<TMPanchayat>%@</TMPanchayat>"
                                       @"<TMArea>%@</TMArea>"
                                       @"<PersonalPostalCode>%@</PersonalPostalCode>"
                                       @"</PersonalAddress>"
                                       @"</ListOfPersonalAddress>"
                                       @"</Contact>"
                                       @"</ListOfContactInterface>"
                                       @"</SFATMCVContactInsertOrUpdate_Input>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",
                                       opportunity_list.CONTACT_ID, txt_FirstName.text, txt_LASTNAME.text, opportunity_list.ADDRESS_ID, txt_AddressLine1.text, txt_AddressLine2.text, SelectedStateCode, txt_DISTRICT.text,txt_CITY.text, txt_TALUKA.text, self.txt_PANCHAYAT.text, txt_AREA.text, txt_PINCODE.text];

    NSLog(@"\n new call%@", envelopeText);

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

    [[RequestDelegate alloc] initiateRequest:request name:@"getContactUpdateConnection"];
}

- (void)Call_Product_Name
{
    NSLog(@"... Opty Id L %@", opportunity_list.OPTY_ID);
    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                       @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e719-d95a1a869db9</DC>"
                                       @"</Logger>"
                                       @"</header>"
                                       @"</SOAP:Header>"
                                       @"<SOAP:Body>"
                                       @"<GetProductfromPLDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<PLName>%@</PLName>"
                                       @"</GetProductfromPLDSM>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",
                                       txt_PL.text];

    NSLog(@"\n envlopeString Of Product Name details....!!!!%@", envelopeText);

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

    [[RequestDelegate alloc] initiateRequest:request name:@"PL_ProductID_Request"];
}

- (void)PL_ProductID_RequestData_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Product get detials %@ ", response);

    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {
        if (GetProductName_Arr && GetProductID_Arr) {
            [GetProductName_Arr removeAllObjects];
            [GetProductID_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        NSLog(@"Which..");
        TBXMLElement* container = [TBXML childElementNamed:@"GetProductfromPLDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            do {
                TBXMLElement* S_Lst_Of_Val = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* NAME = [TBXML childElementNamed:@"PRODUCT" parentElement:S_Lst_Of_Val];
                str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_NSE : %@", str_NAME);
                [GetProductName_Arr addObject:str_NAME];

                TBXMLElement* NAME1 = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:S_Lst_Of_Val];
                str_NAME1 = [TBXML textForElement:NAME1];
                NSLog(@"\n str_NSE 1: %@", str_NAME1);
                [GetProductID_Arr addObject:str_NAME1];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages : %@", GetProductName_Arr);

            if ((GetProductName_Arr.count) > 0) {
                //  [appdelegate hideAlert];
                // [self callModeLost];
            }
        }
        else {
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    [self hideAlert];
}


-(void)callgeography {



    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetListofActiveMicroMarketDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<type>Micromarket</type>"
                               @"</GetListofActiveMicroMarketDSM>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"];
    
    
    
    NSLog(@"\n geography %@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetListofActiveMicroMarketDSM"];



}

-(void)ListofActiveMicroMarketDSMData_Found:(NSNotification*)notification
{
    
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n micromarket response....... %@ ",response);
    
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        //[appdelegate hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:nil message:@"Something went wrong ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
        //[self hideAlert];
    }
    else{
        
        if (Micromarket_Arr)
        {
            [Micromarket_Arr removeAllObjects];
            
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        TBXMLElement *container = [TBXML childElementNamed:@"GetListofActiveMicroMarketDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        
        if (tuple)
        {
            do
            {
                TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"CX_MMGEOGRAPHY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *PPL_ID = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString *PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"usage name: %@",PPL_ID_);
                [Micromarket_Arr addObject:PPL_ID_];
            }while ((tuple = tuple->nextSibling));
            NSLog(@"micro market array %@",Micromarket_Arr);
        }
        else
        {
            [self hideAlert];
            alert=[[UIAlertView alloc]initWithTitle:nil message:@"Data not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert setTag:0];
            [alert show];
        }
        
    }
    
    
    
}



-(void)cutaddress{
    
    
    updatecount=@"callfirst";
    
    NSString* envelopeText = [NSString stringWithFormat:
                              @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              @"<SOAP:Body>"
                              @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                              @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                              @"<Contact operation=\"\">"
                              @"<Id>%@</Id>"
                              @"<FirstName>%@</FirstName>"
                              @"<LastName>%@</LastName>"
                              @"<ListOfPersonalAddress operation=\"\">"
                              @"<PersonalAddress IsPrimaryMVG=\"Y\">"
                              @"<Id>%@</Id>"
                              @"<PersonalStreetAddress>%@</PersonalStreetAddress>"
                              @"<PersonalStreetAddress2>%@</PersonalStreetAddress2>"
                              @"<PersonalCountry>India</PersonalCountry>"
                              @"<PersonalState>%@</PersonalState>"
                              @"<TMDistrict>%@</TMDistrict>"
                            //  @"<PersonalCity>%@</PersonalCity>"
                              @"<TMTaluka>%@</TMTaluka>"
                              @"<TMPanchayat>%@</TMPanchayat>"
                              @"<TMArea>%@</TMArea>"
                              @"<PersonalPostalCode>%@</PersonalPostalCode>"
                              @"</PersonalAddress>"
                              @"</ListOfPersonalAddress>"
                              @"</Contact>"
                              @"</ListOfContactInterface>"
                              @"</SFATMCVContactInsertOrUpdate_Input>"
                              @"</SOAP:Body>"
                              @"</SOAP:Envelope>",
                              opportunity_list.CONTACT_ID, txt_FirstName.text, txt_LASTNAME.text, opportunity_list.ADDRESS_ID, txt_AddressLine1.text, txt_AddressLine2.text, SelectedStateCode, txt_DISTRICT.text, txt_TALUKA.text, self.txt_PANCHAYAT.text, txt_AREA.text, txt_PINCODE.text];
    
    NSLog(@"\n new call%@", envelopeText);
    
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    

    
    [[RequestDelegate alloc] initiateRequest:request name:@"getContactUpdateConnection"];
    
  

}


-(void)Call_Update_Contact_DetailsTwo
{
    updatecount=@"done";
    

    NSString* envelopeText = [NSString stringWithFormat:
                              @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              @"<SOAP:Body>"
                              @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                              @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                              @"<Contact operation=\"\">"
                              @"<Id>%@</Id>"
                              @"<FirstName>%@</FirstName>"
                              @"<LastName>%@</LastName>"
                              @"<ListOfPersonalAddress operation=\"\">"
                              @"<PersonalAddress IsPrimaryMVG=\"Y\">"
                              @"<Id>%@</Id>"
                              @"<PersonalStreetAddress>%@</PersonalStreetAddress>"
                              @"<PersonalStreetAddress2>%@</PersonalStreetAddress2>"
                              @"<PersonalCountry>India</PersonalCountry>"
                              @"<PersonalState>%@</PersonalState>"
                              @"<TMDistrict>%@</TMDistrict>"
                              @"<PersonalCity>%@</PersonalCity>"
                              @"<TMTaluka>%@</TMTaluka>"
                              @"<TMPanchayat>%@</TMPanchayat>"
                              @"<TMArea>%@</TMArea>"
                              @"<PersonalPostalCode>%@</PersonalPostalCode>"
                              @"</PersonalAddress>"
                              @"</ListOfPersonalAddress>"
                              @"</Contact>"
                              @"</ListOfContactInterface>"
                              @"</SFATMCVContactInsertOrUpdate_Input>"
                              @"</SOAP:Body>"
                              @"</SOAP:Envelope>",
                              opportunity_list.CONTACT_ID, txt_FirstName.text, txt_LASTNAME.text, opportunity_list.ADDRESS_ID, txt_AddressLine1.text, txt_AddressLine2.text, SelectedStateCode, txt_DISTRICT.text,txt_CITY.text, txt_TALUKA.text, self.txt_PANCHAYAT.text, txt_AREA.text, txt_PINCODE.text];
    
    NSLog(@"\n new call%@", envelopeText);
    
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    
    
    [[RequestDelegate alloc] initiateRequest:request name:@"getContactUpdateConnection"];
    




}




@end
