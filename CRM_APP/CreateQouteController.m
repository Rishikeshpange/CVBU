//
//  CreateQouteController.m
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 13/05/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import "CreateQouteController.h"
#import "TBXML.h"
#import "RequestDelegate.h"
#import "Opportunity_List.h"
#import "UserDetails_Var.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "ManageOpportunityViewController.h"
#import "OpportunitySearchResultController.h"
@interface CreateQouteController () {
    NSMutableArray* ProductName;
    UIAlertView* alert;
    NSString *str_States, *optyIdCreated;
    NSString *_strAccountID, *_strUpdateQoute, *mobileNumberPattern;
    NSPredicate* mobileNumberPred;
    int flag;
    NSString* envelopeText;
}
@end

@implementation CreateQouteController

@synthesize GetLOB_Arr, GetPPL_LOB_Arr, GetPL_LOBPPL_Arr, GetAppType_Arr, GetAllstates_Arr, GetAllDistrict_Arr, GetAllCities, GetAllTaluka, GetAllPincode, GetProductName_Arr, GetProductID_Arr, ProductDetailsUpdate_Arr, GetAddressData_Arr, ShowStates;
@synthesize UpdateOptyQoute_Arr;
@synthesize GetStatesAll;
@synthesize GetAllStateCodes;
@synthesize SelectedStateCode;
@synthesize txtAccountName, txtAddress1, txtAddress2, txtAllStaes, txtCIty, txtDistrict, txtLandmark, txtPanchayat, txtPhoneNo, txtSelectPincode, txtTaluka, optyContact;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self textFiledText];

    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    mobileNumberPattern = @"[789][0-9]{9}";
    mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
    //self.txtPanchayat.delegate=self;
    txtPanchayat.delegate = self;
    txtAddress2.delegate = self;
    txtAddress1.delegate = self;
    txtLandmark.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];

    //createAccountQoute=[[CreateAccountQoute alloc] init];

    self.btnCreate.layer.cornerRadius = 3;
    self.btnCreate.layer.masksToBounds = YES;

    self.txtAccountName.layer.borderWidth = 2.0f;
    self.txtAddress1.layer.borderWidth = 2.0f;

    self.txtAddress2.layer.borderWidth = 2.0f;
    self.txtPhoneNo.layer.borderWidth = 2.0f;

    self.txtTaluka.layer.borderWidth = 2.0f;
    self.txtLandmark.layer.borderWidth = 2.0f;

    self.txtAllStaes.layer.borderWidth = 2.0f;
    self.txtDistrict.layer.borderWidth = 2.0f;

    self.txtCIty.layer.borderWidth = 2.0f;
    self.txtTaluka.layer.borderWidth = 2.0f;

    self.txtSelectPincode.layer.borderWidth = 2.0f;
    self.txtPanchayat.layer.borderWidth = 2.0f;

    self.txtAccountName.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txtAddress1.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txtAddress2.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txtPhoneNo.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txtTaluka.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txtLandmark.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txtAllStaes.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txtDistrict.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txtCIty.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txtTaluka.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    self.txtSelectPincode.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txtPanchayat.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    // Do any additional setup after loading the view.
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
    // Do any additional setup after loading the view.

    NSLog(@"Contact Id : %@", optyContact);

    // Do any additional setup after loading the view.
    GetAllStateCodes = [[NSMutableDictionary alloc] init];

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

    //[self showAlert];

    //   appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    //   userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance

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
    UpdateOptyQoute_Arr = [[NSMutableArray alloc] init];
    ProductDetailsUpdate_Arr = [[NSMutableArray alloc] init];
    GetAddressData_Arr = [[NSMutableArray alloc] init];
    GetStatesAll = [[NSMutableDictionary alloc] init];
    ProductName = [[NSMutableArray alloc] init];
    //GetAllStateCodes = [[NSMutableDictionary alloc] init];

    [self call_AllStates];

    alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                       message:@"You need to first create account for quote this opportunity "
                                      delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil, nil];

    txtAllStaes.text = userDetailsVal_.STATE;

    // NSLog(@"States Found :%@",SelectedStateCode);
    // NSLog(@"Sates Code : %@",[GetAllStateCodes objectForKey:@"Maharashtra"]);
    str_States = [GetAllStateCodes objectForKey:txtAllStaes.text];
    NSLog(@"States Found :%@", str_States);
}

- (void)textFiledText
{
    UIColor* color = [UIColor colorWithRed:(131 / 255.0)green:(131 / 255.0)blue:(131 / 255.0)alpha:1];

    self.txtAllStaes.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select State" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtDistrict.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select District" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtCIty.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select City" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtTaluka.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Taluka" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtSelectPincode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Pincode" attributes:@{ NSForegroundColorAttributeName : color }];
}

- (void)info_btn
{
    //  NSLog(@"Home biscuit from Sanfrancisco");
    [self performSegueWithIdentifier:@"infoView" sender:self];
}
- (void)logOut_btn
{
    // flag=true;
    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"Are you sure you want to Logout ?"
                                          delegate:self
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Yes", nil];
        [alert show];
        NSLog(@"Home biscuit from Sanfrancisco");
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

        alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                           message:@"Are you sure you want to Logout ?"
                                          delegate:self
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld", (long)buttonIndex);
    if (buttonIndex == 0) {

        NSLog(@"David Miller");
        if (flag == 1) {
            NSLog(@"Appdeledate Values:%d", appdelegate.flagget);
            if (appdelegate.flagget == 1) {
                for (UIViewController* controller in self.navigationController.viewControllers) {
                     if ([controller isKindOfClass:[OpportunitySearchResultController class]])
                    {
                        NSLog(@"Final");
                        
                        [self.navigationController popToViewController:controller
                                                              animated:YES];
                        break;
                    }
                }
            }
            else {
                for (UIViewController* controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[ManageOpportunityViewController class]]) {
                        [self.navigationController popToViewController:controller
                                                              animated:YES];
                        break;
                    }
                }
            }
        }
        else {
            NSLog(@"Not Created..");
        }
    }
    if (buttonIndex == 1) {
        NSLog(@"Glen Maxwell");
        LoginViewController* secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //[self.navigationController pushViewController:secondViewController animated:YES];
        [self presentViewController:secondViewController animated:YES completion:nil];
        //  [self.navigationController popToRootViewControllerAnimated:TRUE];
        // [self dismissViewControllerAnimated:YES completion:nil];
        //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LOB_Data_Found:) name:@"LOB_Data_Found" object:nil]; //For Sale Satge PPL Dropdown Count
    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ModeLostOpty_Found:) name:@"ModeLostOpty_Found" object:nil];//For sale SatgeFailed DropDown fail
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Activity_PPL_Found:) name:@"Activity_PPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PLUpdateOpty_Found:) name:@"PLUpdateOpty_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppType_Data_Found:) name:@"AppType_Data_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllStates_Found:) name:@"AllStates_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllDistrict_Found:) name:@"AllDistrict_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllCity_Found:) name:@"AllCity_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllTalukas_Found:) name:@"AllTalukas_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllPincode_Found:) name:@"AllPincode_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllProductName_Found:) name:@"AllProductName_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProductUpdate_Found:) name:@"ProductUpdate_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ContactUpdate_Found:) name:@"ContactUpdate_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddressData_Found:) name:@"AddressData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CreateQouteConnection_Found:) name:@"CreateQouteConnection_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CreateQouteOptyUpdatedConnection_Found:) name:@"CreateQouteOptyUpdatedConnection_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllProductName_Found:) name:@"AllProductName_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MainCreateQouteConnection_Found:) name:@"MainCreateQouteConnection_Found" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QouteCreationupdateOptyData_Found:) name:@"QouteCreationupdateOptyData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QouteCreationupdateOptyConnection_Found:) name:@"QouteCreationupdateOptyConnection_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DoneUPdateOptyLastData_Found:) name:@"DoneUPdateOptyLastData_Found" object:nil];

    // register for keyboard notifications
    /* [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];*/

    //DoneUPdateOptyLastData_Found
}

- (void)viewWillDisappear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DoneUPdateOptyLastData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LOB_Data_Found" object:nil]; //Gomzy // For opportunity Count
    //  [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ModeLostOpty_Found" object:nil];//Gomzy // For opportunity Count
    //AllDistrict_Found

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Activity_PPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PLUpdateOpty_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AppType_Data_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllStates_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllDistrict_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllCity_Found" object:nil];
    //Alltaluka_Found

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllTalukas_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllCities_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllPincode_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllProductName_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ProductUpdate_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ContactUpdate_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AddressData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CreateQouteConnection_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CreateQouteOptyUpdatedConnection_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllProductName_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MainCreateQouteConnection_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QouteCreationupdateOptyData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QouteCreationupdateOptyConnection_Found" object:nil];

    // unregister for keyboard notifications while not visible.
    /* [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];*/

} //QouteCreationupdateOptyData_Found

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)call_AllStates
{

    envelopeText = [NSString stringWithFormat:
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
    NSLog(@"URL IS %@", theurl);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc] initiateRequest:request name:@"getAllStatesConnection"];
}
- (void)AllStates_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

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

        //TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            NSLog(@"don");
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

                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        //  [self hideAlert];
    }
}
- (IBAction)btnStates:(id)sender
{
    [self showAlert];
    txtDistrict.text = @"";
    txtTaluka.text = @"";
    txtDistrict.text = @"";
    NSLog(@"Activity...Data %@", ProductName);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    if ([ProductName count] > 0) {
        [self hideAlert];
        // ObjC Fast Enumeration
        for (NSString* title in ShowStates) {
            [actionSheet addButtonWithTitle:title];
        }
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

            [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.btnSecondView animated:YES];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        }
        else {
            [self hideAlert];
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 1;
    }
    else {
        NSLog(@"Empty array ");
    }
}

- (IBAction)btnCity:(id)sender
{
    [self showAlert];

    if (txtAllStaes.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txtDistrict.text.length == 0) {
        [self hideAlert];

        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the district" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select the district" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        NSLog(@"District Selected  ");
        txtTaluka.text = @"";
        //[self callActivity_PPL];
        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 @"<SOAP:Body>"
                                 @"<GetAllIndianCity xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                 @"<state>%@</state>"
                                 @"<dist>%@</dist>"
                                 @"</GetAllIndianCity>"
                                 @"</SOAP:Body>"
                                 @"</SOAP:Envelope>",
                                 str_States, txtDistrict.text];

        NSLog(@"\n envlopeString Of user details....City!!!!%@", envelopeText);
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

        [[RequestDelegate alloc] initiateRequest:request name:@"getAllCityConnection"];
    }
}
- (void)AllCity_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n City response....... %@ ", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }

    else {
        //[self hideAlert];
        if (GetAllCities) {
            [GetAllCities removeAllObjects];
            // [activityPPLNamePickerArr removeAllObjects];
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

                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }

        if ((GetAllCities) > 0) {
            NSLog(@"In..");
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
                [actionSheet showFromRect:[self.txtCIty frame] inView:self.btnSecondView animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 3;

            //[appdelegate hideAlert];
        }
    }
}

- (IBAction)btnDistrict:(id)sender
{
    [self showAlert];
    if (txtAllStaes.text.length == 0) {
        [self hideAlert];
        // [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        NSLog(@"staes Selected  ");
        {
            txtCIty.text = @"";
            //  [self callActivity_PPL];

            /*<SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
             <SOAP:Body>
             <GetAllIndianDistricts xmlns="http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps" preserveSpace="no" qAccess="0" qValues="">
             <state>MH</state>
             </GetAllIndianDistricts>
             </SOAP:Body>
             </SOAP:Envelope>*/

            envelopeText = [NSString stringWithFormat:
                                         @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetAllIndianDistricts xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<state>%@</state>"
                                     @"</GetAllIndianDistricts>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                     str_States];
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
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

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
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"X_DISTRICT" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetAllDistrict_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            if (GetAllDistrict_Arr.count > 0) {
                [self hideAlert];
            }
            NSLog(@" PPL %@", GetAllDistrict_Arr);
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }

        if ((GetAllDistrict_Arr) > 0) {
            NSLog(@"In..");
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
                [actionSheet showFromRect:[self.txtDistrict frame] inView:self.btnFirstView animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 2;

            //[appdelegate hideAlert];
        }
    }
}
- (IBAction)btnTaluka:(id)sender
{

    [self showAlert];
    if (txtAllStaes.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select the state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txtDistrict.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the district" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select the district" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txtCIty.text.length == 0) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select the city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [self hideAlert];
    }
    else {
        NSLog(@"Citi  Selected  ");

        //  [self callActivity_PPL];

        /*<SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
             <SOAP:Body>
             <GetAllIndianTaluka xmlns="http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps" preserveSpace="no" qAccess="0" qValues="">
             <state>MH</state>
             <dist>THANE</dist>
             <city>BHIWANDI</city>
             </GetAllIndianTaluka>
             </SOAP:Body>
             </SOAP:Envelope>*/

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 @"<SOAP:Body>"
                                 @"<GetAllIndianTaluka xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                 @"<state>%@</state>"
                                 @"<dist>%@</dist>"
                                 @"<city>%@</city>"
                                 @"</GetAllIndianTaluka>"
                                 @"</SOAP:Body>"
                                 @"</SOAP:Envelope>",
                                 str_States, txtDistrict.text, txtCIty.text];

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

        [[RequestDelegate alloc] initiateRequest:request name:@"getAllTalukasConnection"];
    }
}

- (IBAction)btnPincode:(id)sender
{

    [self showAlert];
    if (txtCIty.text.length == 0 || txtAllStaes.text.length == 0 || txtDistrict.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select mandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please select mandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        NSLog(@"District Selected  ");
        {

            envelopeText = [NSString stringWithFormat:
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
                                     SelectedStateCode, txtDistrict.text, txtCIty.text, txtTaluka.text];

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

    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

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
                    [actionSheet showFromRect:[self.txtSelectPincode frame] inView:self.btnSecondView animated:YES];
                }
                else {
                    [actionSheet showInView:self.view];
                }
                actionSheet.tag = 5;

                //[appdelegate hideAlert];
            }
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}

- (void)AllTalukas_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

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
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                [actionSheet showFromRect:[self.txtTaluka frame] inView:self.btnFirstView animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 4;

            //[appdelegate hideAlert];
        }
    }
}

- (void)actionSheet:(UIActionSheet*)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{

    NSLog(@"button click ....%ld", (long)buttonIndex);
    if (txtAllStaes) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 1:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                str_States = [ProductName objectAtIndex:buttonIndex];
                NSLog(@"Sates : %@", str_States);
                self.txtAllStaes.text = NSLocalizedString([ShowStates objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txtDistrict) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 2:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtDistrict.text = NSLocalizedString([GetAllDistrict_Arr objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txtCIty) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 3:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtCIty.text = NSLocalizedString([GetAllCities objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txtTaluka) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 4:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtTaluka.text = NSLocalizedString([GetAllTaluka objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txtSelectPincode) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 5:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtSelectPincode.text = NSLocalizedString([GetAllPincode objectAtIndex:buttonIndex], @"");
            }
        }
    }
}

- (IBAction)btnCreate:(id)sender
{

    //[self showAlert];
    if (txtAccountName.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please enter the Account name " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please enter the Account name " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txtAddress1.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please enter the Address line 1" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please enter the Address line 1" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txtLandmark.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please enter the Lanmark" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please enter the Lanmark" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txtDistrict.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please Select District" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please Select District" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txtAllStaes.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please Select STATE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please Select STATE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txtCIty.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please Select City" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please Select City" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txtTaluka.text.length == 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please Select Taluka" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please Select Taluka" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if ([txtPhoneNo.text isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please enter cell number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please enter cell number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (txtPhoneNo.text && txtPhoneNo.text.length < 10) {
        [self hideAlert];

        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"cell number must be of 10 digits" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"cell number must be of 10 digits" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }

    else if ([mobileNumberPred evaluateWithObject:txtPhoneNo.text] != YES && [txtPhoneNo.text length] != 0) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please enter valid cell number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please enter valid cell number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    else {
        NSLog(@"Now create Account Fire");
        [self showAlert];
        if ([opportunity_list.ACCOUNT_ID isEqual:@""]) {
            [self call_createAccountQoute];
        }
        else {
            NSLog(@"Account Id Present");
            [self call_CreateQoute];
        }
    }
}
- (void)call_createAccountQoute
{
    /*<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"> <SOAP:Body> <SFATMCVAccountInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\"><ListOfAccountInterface xmlns=\"http://www.siebel.com/xml/Account%20Interface\"> <Account operation=\"insert\"> <MainPhoneNumber>" +
     ((TextView) findViewById(R.id.txtNumber)).getText().toString() +
     "</MainPhoneNumber><AccountStatus>Active</AccountStatus> <Name>" +
     ((TextView) findViewById(R.id.txtName)).getText().toString() +
     "</Name><IntegrationId>" +
     System.currentTimeMillis() +
     "</IntegrationId> <Location>" +
     ((TextView) findViewById(R.id.txtTehsil)).getText().toString() +
     "</Location><Type>Not Specified</Type><ListOfBusinessAddress><BusinessAddress><AddressIntegrationId>" +
     System.currentTimeMillis() +
     "</AddressIntegrationId>"+
     "<City>"+((TextView) findViewById(R.id.city)).getText().toString() +"</City>"+
     "<Country>India</Country>"+
     "<County>"+((TextView) findViewById(R.id.landmark)).getText().toString() +"</County>"+
     "<PostalCode>"+((TextView) findViewById(R.id.txtPincode)).getText().toString() +"</PostalCode>"+
     "<State>"+stateCodeList.get(state.getSelectedItemPosition())+"</State>"+
     "<StreetAddress>"+((TextView) findViewById(R.id.txtAddress)).getText().toString() +"</StreetAddress>"+
     "<StreetAddress2>"+((TextView) findViewById(R.id.address2)).getText().toString()+"</StreetAddress2>"+
     
     "<TMTaluka>"+((TextView) findViewById(R.id.txtTehsil)).getText().toString()+"</TMTaluka>"+
     
     " </BusinessAddress> </ListOfBusinessAddress><ListOfRelatedSalesRep><RelatedSalesRep IsPrimaryMVG=\"Y\"><Position>" +
     UserDetails.POSITION_NAME +
     "</Position><PositionId>" +
     UserDetails.ROW_ID +
     "</PositionId></RelatedSalesRep></ListOfRelatedSalesRep><ListOfRelatedOrganization><RelatedOrganization IsPrimaryMVG=\"Y\"><Organization>" +
     UserDetails.ORGNAME +
     "</Organization></RelatedOrganization></ListOfRelatedOrganization><ListOfRelatedContact>"+
     "<RelatedContact IsPrimaryMVG=\"Y\" operation =\"?\">" +
     "<ContactId>"+contactId+"</ContactId>" +
     "</RelatedContact>" +
     "</ListOfRelatedContact> </Account></ListOfAccountInterface></SFATMCVAccountInsertOrUpdate_Input></SOAP:Body></SOAP:Envelope>"*/

    envelopeText = [NSString stringWithFormat:
                                 @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             @"<SOAP:Body>"
                             @"<SFATMCVAccountInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                             @"<ListOfAccountInterface xmlns=\"http://www.siebel.com/xml/Account%%20Interface\">"
                             @"<Account operation=\"insert\">"
                             @"<MainPhoneNumber>%@</MainPhoneNumber>"
                             @"<AccountStatus>Active</AccountStatus>"
                             @"<Name>%@</Name>"
                             @"<IntegrationId>%ld</IntegrationId>"
                             @"<Location>%@</Location>"
                             @"<Type>Not Specified</Type>"
                             @"<ListOfBusinessAddress>"
                             @"<BusinessAddress>"
                             @"<AddressIntegrationId>%ld</AddressIntegrationId>"
                             @"<City>%@</City>"
                             @"<Country>India</Country>"
                             @"<County>%@</County>"
                             @"<PostalCode>%@</PostalCode>"
                             @"<State>%@</State>"
                             @"<StreetAddress>%@</StreetAddress>"
                             @"<StreetAddress2>%@</StreetAddress2>"
                             @"<TMTaluka>%@</TMTaluka>"
                             @" </BusinessAddress>"
                             @"</ListOfBusinessAddress>"
                             @"<ListOfRelatedSalesRep>"
                             @"<RelatedSalesRep IsPrimaryMVG=\"Y\">"
                             @"<Position>%@</Position>"
                             @"<PositionId>%@</PositionId>"
                             @"</RelatedSalesRep>"
                             @"</ListOfRelatedSalesRep>"
                             @"<ListOfRelatedOrganization>"
                             @"<RelatedOrganization IsPrimaryMVG=\"Y\">"
                             @"<Organization>%@</Organization>"
                             @"</RelatedOrganization>"
                             @"</ListOfRelatedOrganization>"
                             @"<ListOfRelatedContact>"
                             @"<RelatedContact IsPrimaryMVG=\"Y\" operation =\"?\">"
                             @"<ContactId>%@</ContactId>"
                             @"</RelatedContact>"
                             @"</ListOfRelatedContact>"
                             @"</Account>"
                             @"</ListOfAccountInterface>"
                             @"</SFATMCVAccountInsertOrUpdate_Input>"
                             @"</SOAP:Body>"
                             @"</SOAP:Envelope>",
                             txtPhoneNo.text, txtAccountName.text, (long)[[NSDate date] timeIntervalSince1970], txtLandmark.text, (long)[[NSDate date] timeIntervalSince1970], txtCIty.text, txtLandmark.text, txtSelectPincode.text, str_States, txtAddress1.text, txtAddress2.text, txtTaluka.text, userDetailsVal_.POSITION_NAME, userDetailsVal_.ROW_ID, userDetailsVal_.ORGNAME, optyContact];

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getCreateQouteConnection"];
}

- (void)CreateQouteConnection_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else {
        if (ProductDetailsUpdate_Arr) {
            [ProductDetailsUpdate_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        NSLog(@"Which..");
        //ListOfTMOpportunityInterface
        TBXMLElement* container = [TBXML childElementNamed:@"ListOfAccountInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVAccountInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]]];

        //TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];

        TBXMLElement* Opportunity = [TBXML childElementNamed:@"Account" parentElement:container];

        NSLog(@"Which..2");

        NSLog(@"Which..3");

        if (Opportunity) {
            TBXMLElement* Id = [TBXML childElementNamed:@"AccountId" parentElement:Opportunity];

            //[self hideAlert];
            createAccountQoute.AccountId_ = [TBXML textForElement:Id];
            NSLog(@"\nListOfContactInterface.....!!!!!%@", createAccountQoute.AccountId_);
            _strAccountID = [TBXML textForElement:Id];
            ;

            TBXMLElement* ListOfPersonalAddress = [TBXML childElementNamed:@"ListOfBusinessAddress" parentElement:Opportunity];

            TBXMLElement* PersonalAddress = [TBXML childElementNamed:@"BusinessAddress" parentElement:ListOfPersonalAddress];

            if (PersonalAddress) {
                TBXMLElement* Id = [TBXML childElementNamed:@"AddressId" parentElement:PersonalAddress];

                createAccountQoute.AddressId_ = [TBXML textForElement:Id];
                NSLog(@"\nListOfContactInterface.....!!!!!%@", createAccountQoute.AddressId_);
            }
            [self call_updateOpty];
        }
        else {
            [self hideAlert];

            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                [alertView show];
            }
        }
    }
    //  [self hideAlert];// Call updateopty
}

- (void)call_updateOpty
{
    /*"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body>" +
     "<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">" +
     "<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%20Opportunity%20Interface\">"+
     "<Opportunity operation=\"Update\">"+
     "<Id>"+data.OPTY_ID+"</Id>"+
     "<AccountId>"+AccountId+"</AccountId>"+
     "</Opportunity>"+
     "</ListOfTMOpportunityInterface>"+
     "</SFATMCVOPTYInsertOrUpdate_Input>"+
     "</SOAP:Body>"+*/
    NSLog(@"Account Id : %@", _strAccountID);

    envelopeText = [NSString stringWithFormat:
                                 @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             @"<SOAP:Body>"
                             @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                             @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                             @"<Opportunity operation=\"Update\">"
                             @"<Id>%@</Id>"
                             @"<AccountId>%@</AccountId>"
                             @"</Opportunity>"
                             @"</ListOfTMOpportunityInterface>"
                             @"</SFATMCVOPTYInsertOrUpdate_Input>"
                             @"</SOAP:Body>"
                             @"</SOAP:Envelope>",
                             opportunity_list.OPTY_ID, _strAccountID];

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getupdateOptyQoute_Connection"];
}

//QouteCreationupdateOptyConnection_Found
- (void)QouteCreationupdateOptyConnection_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Opportunity Account :  %@ ", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else {
        if (UpdateOptyQoute_Arr) {
            [UpdateOptyQoute_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        NSLog(@"Which.."); //ListOfTMOpportunityInterface
        TBXMLElement* container = [TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]]];
        NSLog(@"Which..1");

        //TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];

        TBXMLElement* Opportunity = [TBXML childElementNamed:@"Opportunity" parentElement:container];

        NSLog(@"Which..2");

        NSLog(@"Which..3");

        if (Opportunity) {
            TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];

            updateOptyQoute.Id_ = [TBXML textForElement:Id];

            NSLog(@"\nListOfContactInterface.....!!!!!%@", updateOptyQoute.Id_);

            _strUpdateQoute = [TBXML textForElement:Id];

            [self call_CreateQoute];

            // Create Qoute
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                [alertView show];
            }
        }
    }
    //  [self hideAlert];//

    // Call ProductName

    //Call QouteCretion
}

- (void)call_CreateQoute
{
    /*"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body><SFATMCVQuoteInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">" +
     "<ListOfQuoteInterface xmlns=\"http://www.siebel.com/xml/Quote%20Interface\"><Quote operation=\"insert\"><IntegrationId>" +
     System.currentTimeMillis() +
     "</IntegrationId>"+"<AccountId>" + data.CUSTOMER_ACCOUNT_ID + "</AccountId>"+ "<ContactId>" +
     data.CONTACT_ID +
     "</ContactId><OpportunityId>" +
     data.OPTY_ID +
     "</OpportunityId><TMParentProductLine>" +
     data.PRODUCT_NAME +
     "</TMParentProductLine><TMProductLine>" +
     data.PRODUCT_NAME1 +
     "</TMProductLine><SalesRepLogin>" +
     UserDetails.LoginName +
     "</SalesRepLogin><SalesRepPosition>" +
     UserDetails.POSITION_NAME +
     "</SalesRepPosition><SalesRepPositionId>" +
     UserDetails.ROW_ID +
     "</SalesRepPositionId><ListOfRelatedOrganization><RelatedOrganization IsPrimaryMVG=\"Y\"><Organization>" +
     UserDetails.ORGNAME +
     "</Organization></RelatedOrganization></ListOfRelatedOrganization><ListOfLineItems><LineItems>" +
     "<ProductType>Vehicle</ProductType>"+
     "<IntegrationId>" +
     System.currentTimeMillis() +
     "</IntegrationId><ProductName>" +
     data.VC +
     "</ProductName><RequestedQuantity>1</RequestedQuantity><ProductVCNo>" +
     data.VC +
     "</ProductVCNo></LineItems></ListOfLineItems><ListOfQuote_SalesTeam><Quote_SalesTeam IsPrimaryMVG=\"Y\"><SalesTeam>" +
     UserDetails.LoginName +
     "</SalesTeam><Name>" +
     UserDetails.POSITION_NAME +
     "</Name></Quote_SalesTeam></ListOfQuote_SalesTeam></Quote></ListOfQuoteInterface>"*/

    NSLog(@"Login Name : %@", userDetailsVal_.Login_Name);

    envelopeText = [NSString stringWithFormat:
                                 @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             @"<SOAP:Body><SFATMCVQuoteInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                             @"<ListOfQuoteInterface xmlns=\"http://www.siebel.com/xml/Quote%%20Interface/\">"
                             @"<Quote operation=\"insert\">"
                             @"<IntegrationId>%ld</IntegrationId>"
                             @"<AccountId>%@</AccountId>"
                             @"<ContactId>%@</ContactId>"
                             @"<OpportunityId>%@</OpportunityId>"
                             @"<TMParentProductLine>%@</TMParentProductLine>"
                             @"<TMProductLine>%@</TMProductLine>"
                             @"<SalesRepLogin>%@</SalesRepLogin>"
                             @"<SalesRepPosition>%@</SalesRepPosition>"
                             @"<SalesRepPositionId>%@</SalesRepPositionId>"
                             @"<ListOfRelatedOrganization>"
                             @"<RelatedOrganization IsPrimaryMVG=\"Y\">"
                             @"<Organization>%@</Organization>"
                             @"</RelatedOrganization>"
                             @"</ListOfRelatedOrganization>"
                             @"<ListOfLineItems>"
                             @"<LineItems>"
                             @"<ProductType>Vehicle</ProductType>"
                             @"<IntegrationId>%ld</IntegrationId>"
                             @"<ProductName>%@</ProductName>"
                             @"<RequestedQuantity>1</RequestedQuantity>"
                             @"<ProductVCNo>%@</ProductVCNo>"
                             @"</LineItems></ListOfLineItems>"
                             @"<ListOfQuote_SalesTeam>"
                             @"<Quote_SalesTeam IsPrimaryMVG=\"Y\">"
                             @"<SalesTeam>%@</SalesTeam>"
                             @"<Name>%@</Name>"
                             @"</Quote_SalesTeam>"
                             @"</ListOfQuote_SalesTeam>"
                             @"</Quote></ListOfQuoteInterface></SFATMCVQuoteInsertOrUpdate_Input></SOAP:Body></SOAP:Envelope>",
                             (long)[[NSDate date] timeIntervalSince1970], _strAccountID, opportunity_list.CONTACT_ID, opportunity_list.OPTY_ID, opportunity_list.PRODUCT_NAME, opportunity_list.PRODUCT_NAME1, userDetailsVal_.Login_Name, userDetailsVal_.POSITION_NAME, userDetailsVal_.ROW_ID, userDetailsVal_.ORGNAME, (long)[[NSDate date] timeIntervalSince1970], opportunity_list.VC, opportunity_list.VC, userDetailsVal_.Login_Name, userDetailsVal_.POSITION_NAME];

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getupdateOptyQouteConnection"];
}
////CreateQouteConnection_Found

- (void)CreateQouteOptyUpdatedConnection_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Opportunity :  %@ ", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else {
        if (ProductDetailsUpdate_Arr) {
            [ProductDetailsUpdate_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        NSLog(@"Which..");
        //ListOfTMOpportunityInterface
        TBXMLElement* container = [TBXML childElementNamed:@"ListOfQuoteInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVQuoteInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]]];
        NSLog(@"Which..1");

        TBXMLElement* tuple = [TBXML childElementNamed:@"Quote" parentElement:container];

        if (tuple) {
            TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:tuple];
            optyIdCreated = [TBXML textForElement:Id];
            // cAll update opty
            [self Call_DoneUPdateOptyLast];

            //  alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Qoute Created Successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //  [alert show];
        }
        else {
            [self hideAlert];

            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                [alertView show];
            }
        }
    }
}

- (void)Call_DoneUPdateOptyLast
{
    NSLog(@"... Opty Id L %@", opportunity_list.OPTY_ID);
    envelopeText = [NSString stringWithFormat:
                                 @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             @"<SOAP:Body>"
                             @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                             @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                             @"<Opportunity>"
                             @"<Id>%@</Id>"
                             @"<SalesStage>C1 (Quote Tendered)</SalesStage>"
                             @"</Opportunity>"
                             @"</ListOfTMOpportunityInterface>"
                             @"</SFATMCVOPTYInsertOrUpdate_Input>"
                             @"</SOAP:Body>"
                             @"</SOAP:Envelope>",
                             opportunity_list.OPTY_ID];

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getDoneUPdateOptyLastConnection"];

} //DoneUPdateOptyLastData_Found

- (void)DoneUPdateOptyLastData_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Create Qoute Opty done Response : %@ ", response);

    // Called update opty with Sales Stages

    if ([response isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else {
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]]];

        TBXMLElement* Opportunity = [TBXML childElementNamed:@"Opportunity" parentElement:container];
        if (Opportunity) {
            [self hideAlert];
            TBXMLElement* S_Lst_Of_Val = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
            NSString* str_NAME = [TBXML textForElement:S_Lst_Of_Val];
            NSLog(@"\n str_NSE : %@", str_NAME);
            if (str_NAME.length != 0) {
                [self hideAlert];
                flag = 1;
                NSLog(@"Qoute created ");
                if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

                    alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Quote created successfully !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                    [alert show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

                    alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Quote created successfully !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                    [alert show];
                }
            }
            else {
                [self hideAlert];

                NSLog(@"Error While updating Sales Stage");
            }
        }
    }
}
- (void)MainCreateQouteConnection_Found:(NSNotification*)notification
{

    //  NSError *err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Create Qoute Response : %@ ", response);

    // Called update opty with Sales Stages
    /*
    if([response isEqual:@""]){
        
        NSLog(@"Data....nhi ahe ");
    }
    else{
        if (GetProductName_Arr && GetProductID_Arr)
        {
            [GetProductName_Arr removeAllObjects];
            [GetProductID_Arr removeAllObjects];
            
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        NSLog(@"Which..");
        TBXMLElement *container = [TBXML childElementNamed:@"GetProductfromPLDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            do
            {
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"PRODUCT" parentElement:S_Lst_Of_Val];
                NSString *str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_NSE : %@",str_NAME);
                [GetProductName_Arr addObject:str_NAME];
                
                // TBXMLElement *NAME1 = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:S_Lst_Of_Val];
                // NSString *str_NAME1 = [TBXML textForElement:NAME1];
                // NSLog(@"\n str_NSE 1: %@",str_NAME1);
                // [GetProductID_Arr addObject:str_NAME1];
                
            }while ((tuple = tuple->nextSibling));
            
            NSLog(@"Sales Stages : %@",GetProductName_Arr);
        }
        if ((GetProductName_Arr.count) > 0)
        {
            //  [appdelegate hideAlert];
            // [self callModeLost];
        }
    }
    // [self hideAlert];
    */
}

//

- (void)Call_Product_Name
{
    /*
     <SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">
     <SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"+
     "<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"+
     "<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"+
     "<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"+
     "<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"+
     "<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"+
     "<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"+
     "<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"+
     "<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"+
     "<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e719-d95a1a869db9</DC>"+
     "</Logger>"+
     "</header>"+
     "</SOAP:Header>"+
     "<SOAP:Body>"+
     "<GetProductfromPLDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"+
     "<PLName>"+pl.get(spn3.getSelectedItemPosition())+"</PLName>"+
     "</GetProductfromPLDSM>"+
     "</SOAP:Body>"+
     "</SOAP:Envelope>";
     */
    NSLog(@"... Opty Id L %@", opportunity_list.OPTY_ID);
    envelopeText = [NSString stringWithFormat:
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
                             opportunity_list.PRODUCT_NAME];

    /*NSString * envelopeText1 = [NSString stringWithFormat:
                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<getListSaleStageJavaCall xmlns=\"http://schemas.cordys.com/NeevJavaCall\" />"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>"] ;*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getQouteCreationConnection"];

} //AllProductName_Found

- (void)AllProductName_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

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
                NSString* str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_NSE : %@", str_NAME);
                [GetProductName_Arr addObject:str_NAME];

                // TBXMLElement *NAME1 = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:S_Lst_Of_Val];
                // NSString *str_NAME1 = [TBXML textForElement:NAME1];
                // NSLog(@"\n str_NSE 1: %@",str_NAME1);
                // [GetProductID_Arr addObject:str_NAME1];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages : %@", GetProductName_Arr);
        }
        if ((GetProductName_Arr.count) > 0) {
            //  [appdelegate hideAlert];
            // [self callModeLost];
        }
    }
    // [self hideAlert];
}

// Update Opty SalesStages

- (void)Call_UpdateOptyWithSalestages
{
    /*
     "<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body>" +
     "<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">" +
     "<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%20Opportunity%20Interface\"><Opportunity><Id>" +
     data.OPTY_ID +
     "</Id><SalesStage>C1 (Quote Tendered)</SalesStage></Opportunity></ListOfTMOpportunityInterface></SFATMCVOPTYInsertOrUpdate_Input></SOAP:Body></SOAP:Envelope>"
     */
    NSLog(@"... Opty Id L %@", opportunity_list.OPTY_ID);
    envelopeText = [NSString stringWithFormat:
                                 @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             @"<SOAP:Body>"
                             @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                             @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                             @"<Opportunity>"
                             @"<Id>%@</Id>"
                             @"<SalesStage>C1 (Quote Tendered)</SalesStage></Opportunity>"
                             @"</ListOfTMOpportunityInterface>"
                             @"</SFATMCVOPTYInsertOrUpdate_Input>"
                             @"</SOAP:Body>"
                             @"</SOAP:Envelope>",
                             opportunity_list.OPTY_ID];

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getQouteCreationupdateOptySales"];

} //QouteCreationupdateOptyData_Found

- (void)QouteCreationupdateOptyData_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ", response);

    if ([response isEqual:@""]) {
        [self hideAlert];

        NSLog(@"Data....nhi ahe ");
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
                NSString* str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_NSE : %@", str_NAME);
                [GetProductName_Arr addObject:str_NAME];

                // TBXMLElement *NAME1 = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:S_Lst_Of_Val];
                // NSString *str_NAME1 = [TBXML textForElement:NAME1];
                // NSLog(@"\n str_NSE 1: %@",str_NAME1);
                // [GetProductID_Arr addObject:str_NAME1];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages : %@", GetProductName_Arr);
        }
        if ((GetProductName_Arr.count) > 0) {
            [self hideAlert];

            //  [appdelegate hideAlert];
            // [self callModeLost];
        }
    }
    // [self hideAlert];
}
- (void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
- (void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField*)sender
{
    if ([sender isEqual:txtPanchayat]) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.center = CGPointMake(self.view.center.x, 100.0);
        [UIView commitAnimations];
    }

    if ([sender isEqual:txtLandmark]) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.center = CGPointMake(self.view.center.x, 140.0);
        [UIView commitAnimations];
    }
}

- (void)keyboardWillHide
{

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.center = CGPointMake(self.view.center.x, 385.0);
    [UIView commitAnimations];
}
/*
#define kOFFSET_FOR_KEYBOARD 280.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextView *)sender
{
    if ([sender isEqual:txtDistrict])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}*/
@end
