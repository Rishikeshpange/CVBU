//
//  AccountViewController.m
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 31/03/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface AccountViewController () {
    UIAlertView* alert;
    NSString* _strAccount;
    NSMutableArray* ProductName;
    UIActionSheet* actionSheet;
    NSString *str_States, *mobileNumberPattern;
    NSPredicate* mobileNumberPred;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
}
@end

@implementation AccountViewController
@synthesize txtTGMName, txtTGMNumber, txtTaluka, txtPincode, txtAddress, txtAddress2, txtArea, txtCity, txtDistrict, txtPanchayat, txtState;
@synthesize GetLOB_Arr, GetPPL_LOB_Arr, GetPL_LOBPPL_Arr, GetAppType_Arr, GetAllstates_Arr, GetAllDistrict_Arr, GetAllCities, GetAllTaluka, GetAllPincode, GetProductName_Arr, GetProductID_Arr, ProductDetailsUpdate_Arr, GetAddressData_Arr, ShowStates;
@synthesize UpdateOptyQoute_Arr;
@synthesize GetStatesAll;
@synthesize GetAllStateCodes;
@synthesize SelectedStateCode;

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (![self connected]) {
        // not connected
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            NSLog(@"Newtwork not Available...");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            NSLog(@"Newtwork not Available...");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            NSLog(@"Newtwork not Available...");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        [self textFiledText];
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance

        appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance

        mobileNumberPattern = @"[789][0-9]{9}";
        mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];

        self.btnSearch.layer.cornerRadius = 3;
        self.btnSearch.layer.masksToBounds = YES;

        self.btnCancel.layer.cornerRadius = 3;
        self.btnCancel.layer.masksToBounds = YES;

        self.btnSave.layer.cornerRadius = 3;
        self.btnSave.layer.masksToBounds = YES;

        // Text Fileds Border Color
        self.txtTGMName.layer.borderWidth = 2.0f;
        self.txtAddress.layer.borderWidth = 2.0f;

        self.txtAddress2.layer.borderWidth = 2.0f;
        self.txtTGMNumber.layer.borderWidth = 2.0f;

        self.txtTaluka.layer.borderWidth = 2.0f;
        self.txtArea.layer.borderWidth = 2.0f;

        self.txtState.layer.borderWidth = 2.0f;
        self.txtDistrict.layer.borderWidth = 2.0f;

        self.txtCity.layer.borderWidth = 2.0f;
        self.txtTaluka.layer.borderWidth = 2.0f;

        self.txtPincode.layer.borderWidth = 2.0f;
        self.txtPanchayat.layer.borderWidth = 2.0f;

        self.txtTGMName.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtAddress.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtAddress2.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtTGMNumber.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtTaluka.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtArea.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtArea.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtState.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtDistrict.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtCity.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtTaluka.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtPincode.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtPanchayat.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.tabView.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;
        // Do any additional setup after loading the view.
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
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
    }
    else {

        [self textFiledText];
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance

        appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance

        mobileNumberPattern = @"[789][0-9]{9}";
        mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];

        self.btnSearch.layer.cornerRadius = 3;
        self.btnSearch.layer.masksToBounds = YES;

        self.btnCancel.layer.cornerRadius = 3;
        self.btnCancel.layer.masksToBounds = YES;

        self.btnSave.layer.cornerRadius = 3;
        self.btnSave.layer.masksToBounds = YES;

        // Text Fileds Border Color
        self.txtTGMName.layer.borderWidth = 2.0f;
        self.txtAddress.layer.borderWidth = 2.0f;

        self.txtAddress2.layer.borderWidth = 2.0f;
        self.txtTGMNumber.layer.borderWidth = 2.0f;

        self.txtTaluka.layer.borderWidth = 2.0f;
        self.txtArea.layer.borderWidth = 2.0f;

        self.txtState.layer.borderWidth = 2.0f;
        self.txtDistrict.layer.borderWidth = 2.0f;

        self.txtCity.layer.borderWidth = 2.0f;
        self.txtTaluka.layer.borderWidth = 2.0f;

        self.txtPincode.layer.borderWidth = 2.0f;
        self.txtPanchayat.layer.borderWidth = 2.0f;

        self.txtTGMName.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtAddress.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtAddress2.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtTGMNumber.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtTaluka.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtArea.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtArea.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtState.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtDistrict.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtCity.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtTaluka.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.txtPincode.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtPanchayat.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

        self.tabView.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;
        // Do any additional setup after loading the view.
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
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
        
        self.splitViewController.delegate = self;
        self.masterPopoverController.delegate=self;
        UIBarButtonItem *barButtonItem = self.splitViewController.displayModeButtonItem;
        barButtonItem.title = @"Show master";
        self.navigationItem.leftBarButtonItem = barButtonItem;


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
        txtState.text = userDetailsVal_.STATE;
        // NSLog(@"States Found :%@",SelectedStateCode);
        // NSLog(@"Sates Code : %@",[GetAllStateCodes objectForKey:@"Maharashtra"]);
        str_States = [GetAllStateCodes objectForKey:txtState.text];
    }
}

- (void)textFiledText
{
    UIColor* color = [UIColor colorWithRed:(131 / 255.0)green:(131 / 255.0)blue:(131 / 255.0)alpha:1];
    //self.txtCustomerName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Customer name" attributes:@{NSForegroundColorAttributeName:color}];

    //self.txtCustomerMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Customer Mobile Number" attributes:@{NSForegroundColorAttributeName:color}];

    self.txtTGMName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"TGM Name" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtTGMNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"TGM Number" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtAddress.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address 1" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtAddress2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Address 2" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtArea.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Area" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtDistrict.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Select District" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtCity.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Select City" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtTaluka.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Select Taluka" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtPincode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Select Pincode" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtPanchayat.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Panchayat" attributes:@{ NSForegroundColorAttributeName : color }];
}

- (void)viewWillAppear:(BOOL)animated
{

    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CreateContact_FromAccountFound:) name:@"CreateContact_FromAccountFound" object:nil]; //Gautam //For Search Account found

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCreateAccountE_Found:) name:@"getCreateAccountE_Found" object:nil]; //Gautam //For Search Account found

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllStates_Found:) name:@"AllStates_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllDistrict_Found:) name:@"AllDistrict_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllCity_Found:) name:@"AllCity_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllTalukas_Found:) name:@"AllTalukas_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllPincode_Found:) name:@"AllPincode_Found" object:nil];
    
    [super viewWillAppear:animated];
    self.splitViewController.delegate = self;
    UIBarButtonItem *barButtonItem = self.splitViewController.displayModeButtonItem;
    barButtonItem.title = @"Show master";
    self.navigationItem.leftBarButtonItem = barButtonItem;

} //getCreateAccountE_Found

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CreateContact_FromAccountFound" object:nil]; //Gautam // For Serach Account Found
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getCreateAccountE_Found" object:nil]; //Gautam // For Serach Account Found

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllStates_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllDistrict_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllCity_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllCities_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllPincode_Found" object:nil];
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
// delegate mehod for uialertView

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld", (long)buttonIndex);
    if (buttonIndex == 0) {

        NSLog(@"Button Index  0");
    }
    if (buttonIndex == 1) {
        NSLog(@"Button Index  1");
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
- (void)callCreateContact_FromAccount
{

    //    [self callCreateContact_FromAccount ];

    /*NSString * envelopeText1 = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SFATMCVAccountInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfAccountInterface xmlns=\"http://www.siebel.com/xml/Account%%20Interface\">"
                               @"<Account operation=\"insert\">"
                               @"<MainPhoneNumber>%@</MainPhoneNumber>"
                               @"<AccountStatus>%@</AccountStatus>"
                               @"<Name>%@</Name>"
                               @"<IntegrationId>%ld</IntegrationId>"
                               @"<Location>%@</Location>"
                               @"<Type>%@</Type>"
                               @"<ListOfBusinessAddress>"
                               @"<BusinessAddress>"
                               @"<AddressIntegrationId>%ld</AddressIntegrationId>"
                               @"<PostalCode>%@</PostalCode>"
                               @"<StreetAddress>%@</StreetAddress>"
                               @"</BusinessAddress>"
                               @"</ListOfBusinessAddress>"
                               @"<ListOfRelatedSalesRep><RelatedSalesRep IsPrimaryMVG=\"Y\">"
                               @"<Position>%@</Position>"
                               @"<PositionId>%@</PositionId>"
                               @"</RelatedSalesRep>"
                               @"</ListOfRelatedSalesRep>"
                               @"<ListOfRelatedOrganization>"
                               @"<RelatedOrganization IsPrimaryMVG=\"Y\">"
                               @"<Organization>%@</Organization>"
                               @"</RelatedOrganization>"
                               @"</ListOfRelatedOrganization>"
                               @"</Account>"
                               @"</ListOfAccountInterface>"
                               @"</SFATMCVAccountInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",txtTGMNumber.text,@"Active",txtTGMName.text,(long)[[NSDate date]timeIntervalSince1970],txtTaluka.text,@"Not Specified",(long)[[NSDate date]timeIntervalSince1970],txtPincode.text,txtAddress.text,userDetailsVal_.POSITION_NAME,userDetailsVal_.ROW_ID,userDetailsVal_.ORGNAME];*/

    /*NSString * envelopeText2 = [NSString stringWithFormat:
                                @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:acc=\"http://www.siebel.com/xml/Account%%20Interface/\">"
                                @"<soapenv:Header/>"
                                @"<soapenv:Body>"
                                @"<asi:SFATMCVAccountInsertOrUpdate_Input>"
                                @"<acc:ListOfAccountInterface>"
                                @"<Account operation=\"\">"
                                @"<MainPhoneNumber>9078563444</MainPhoneNumber>"
                                @"<AccountStatus>Active</AccountStatus>"
                                @"<Name>AB</Name>"
                                @"<IntegrationId>%ld</IntegrationId>"
                                @"<Location>Mumbai</Location>"
                                @"<Type>Not Specified</Type>"
                                @"<ListOfBusinessAddress>"
                                @"<BusinessAddress IsPrimaryMVG=\"Y\">"
                                @"<AddressIntegrationId>%ld</AddressIntegrationId>"
                                @"<StreetAddress>viveakanandaa raoroad Western</StreetAddress>"
                                @"<StreetAddress2>kuchipudi PanipudiA</StreetAddress2>"
                                @"<County>India</County>"
                                @"<State>MH</State>"
                                @"<TMDistrict>THANE</TMDistrict>"
                                @"<City>THANE</City>"
                                @"<TMTaluka>MUMBAI</TMTaluka>"
                                @"<PostalCode>400607</PostalCode>"
                                @"</BusinessAddress>"
                                @"</ListOfBusinessAddress>"
                                @"<ListOfRelatedSalesRep>"
                                @"<RelatedSalesRep IsPrimaryMVG=\"Y\">"
                                @"<Position>TMCV-Sal-W-MUM-1001680-Thane-NDRM</Position>"
                                @"<PositionId>1-70CX8VQ</PositionId>"
                                @"</RelatedSalesRep>"
                                @"</ListOfRelatedSalesRep>"
                                @"<ListOfRelatedOrganization>"
                                @"<RelatedOrganization IsPrimaryMVG=\"Y\">"
                                @"<Organization>BAFNA Motors (Mumbai) Pvt. Ltd.</Organization>"
                                @"</RelatedOrganization>"
                                @"</ListOfRelatedOrganization>"
                                @"</Account>"
                                @"</acc:ListOfAccountInterface>"
                                @"<asi:StatusObject>?</asi:StatusObject>"
                                @"</asi:SFATMCVAccountInsertOrUpdate_Input>"
                                @"</soapenv:Body>"
                                @"</soapenv:Envelope>",(long)[[NSDate date]timeIntervalSince1970],(long)[[NSDate date]timeIntervalSince1970]];*/

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:acc=\"http://www.siebel.com/xml/Account%%20Interface/\">"
                                       @"<soapenv:Header/>"
                                       @"<soapenv:Body>"
                                       @"<asi:SFATMCVAccountInsertOrUpdate_Input>"
                                       @"<acc:ListOfAccountInterface>"
                                       @"<Account operation=\"\">"
                                       @"<MainPhoneNumber>%@</MainPhoneNumber>"
                                       @"<AccountStatus>Active</AccountStatus>"
                                       @"<Name>%@</Name>"
                                       @"<IntegrationId>%ld</IntegrationId>"
                                       @"<Location>Mumbai</Location>"
                                       @"<Type>Not Specified</Type>"
                                       @"<ListOfBusinessAddress>"
                                       @"<BusinessAddress IsPrimaryMVG=\"Y\">"
                                       @"<AddressIntegrationId>%ld</AddressIntegrationId>"
                                       @"<StreetAddress>%@</StreetAddress>"
                                       @"<StreetAddress2>%@</StreetAddress2>"
                                       @"<County>India</County>"
                                       @"<State>%@</State>"
                                       @"<TMDistrict>%@</TMDistrict>"
                                       @"<City>%@</City>"
                                       @"<TMTaluka>%@</TMTaluka>"
                                       @"<PostalCode>%@</PostalCode>"
                                       @"</BusinessAddress>"
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
                                       @"</Account>"
                                       @"</acc:ListOfAccountInterface>"
                                       @"<asi:StatusObject>?</asi:StatusObject>"
                                       @"</asi:SFATMCVAccountInsertOrUpdate_Input>"
                                       @"</soapenv:Body>"
                                       @"</soapenv:Envelope>",
                                       txtTGMNumber.text, txtTGMName.text, (long)[[NSDate date] timeIntervalSince1970], (long)[[NSDate date] timeIntervalSince1970], txtAddress.text, txtAddress2.text, str_States, txtDistrict.text, txtCity.text, txtTaluka.text, txtPincode.text, userDetailsVal_.POSITION_NAME, userDetailsVal_.ROW_ID, userDetailsVal_.ORGNAME];

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

    [[RequestDelegate alloc] initiateRequest:request name:@"CreateContacWithAccountDetails_Connection"];
}

- (void)CreateContact_FromAccountFound:(NSNotification*)notification
{
    [self hideAlert];
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

    NSLog(@"\nResponse....%@", response);
    if ([response rangeOfString:@"soapenv:Fault"].location != NSNotFound) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"There has been a technical issue. We could not create the Account !!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        TBXMLElement* container = [TBXML childElementNamed:@"ns:SFATMCVAccountInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"soapenv:Body" parentElement:tbxml.rootXMLElement]];

        TBXMLElement* ListOfContactInterface = [TBXML childElementNamed:@"ListOfAccountInterface" parentElement:container];

        TBXMLElement* Contact = [TBXML childElementNamed:@"Account" parentElement:ListOfContactInterface];
        if (Contact) {
            TBXMLElement* Id = [TBXML childElementNamed:@"AccountId" parentElement:Contact];

            //TBXMLElement *X_TGM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_PHONE_NUMBER" parentElement:S_Lst_Of_Val];
            
            createAccount.Id_ = [TBXML textForElement:Id];
            _strAccount = [TBXML textForElement:Id];

            txtTGMName.text = @"";
            txtTGMNumber.text = @"";
            txtAddress.text = @"";
            txtTaluka.text = @"";
            txtPincode.text = @"";
            txtAddress2.text = @"";
            txtArea.text = @"";
            txtState.text = @"";
            txtDistrict.text = @"";
            txtPanchayat.text = @"";
            txtCity.text = @"";
            if (_strAccount.length != 0) {
                // Call Account create :
                [self callCreate_Account];
            }
        }
        //self.myAlert = [[[UIAlertView alloc] initWithTitle:@"MNB" message:[NSString strinWithFormat:@"%@ video deleted successfully",str] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil] autorelease];
    }
    //   [appdelegate hideAlert];
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

- (void)callCreate_Account
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<SFATMCVAccountInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                       @"<ListOfAccountInterface xmlns=\"http://www.siebel.com/xml/Account%%20Interface\">"
                                       @"<Account operation=\"update\">"
                                       @"<AccountId>%@</AccountId>"
                                       @"<Type>Tata Gramin Mitra</Type>"
                                       @"</Account>"
                                       @"</ListOfAccountInterface>"
                                       @"</SFATMCVAccountInsertOrUpdate_Input>"
                                       @"</SOAP:Body></SOAP:Envelope>",
                                       _strAccount];

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

    [[RequestDelegate alloc] initiateRequest:request name:@"CreateAccount_Connection"];
} //getCreateAccountE_Found

- (void)getCreateAccountE_Found:(NSNotification*)notification
{
    [self hideAlert];
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];

    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

    NSLog(@"\nResponse....%@", response);
    if ([response isEqual:@""]) {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        TBXMLElement* container = [TBXML childElementNamed:@"ns:SFATMCVAccountInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];

        TBXMLElement* ListOfContactInterface = [TBXML childElementNamed:@"ListOfAccountInterface" parentElement:container];

        TBXMLElement* Contact = [TBXML childElementNamed:@"Account" parentElement:ListOfContactInterface];
        if (Contact) {
            TBXMLElement* Id = [TBXML childElementNamed:@"AccountId" parentElement:Contact];

            //createAccount.Id_ = [TBXML textForElement:Id];
            _strAccount = [TBXML textForElement:Id];

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:[NSString stringWithFormat:@"Account created Successfully ! "] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:[NSString stringWithFormat:@"Error while creating account ! "] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    //   [appdelegate hideAlert];
}
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

    NSLog(@"\n envlopeString Of user details...  All State .!!!!%@", envelopeText);
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

    [[RequestDelegate alloc] initiateRequest:request name:@"getAllStatesConnection"];
}
- (void)AllStates_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        if (GetAllstates_Arr) {
            [GetAllstates_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianStatesResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];

        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        //TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

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

            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        //  [self hideAlert];
    }
}

- (IBAction)btnstate:(id)sender
{

    [self showAlert];
    txtDistrict.text = @"";
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

            [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.secondView animated:YES];
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

    if (txtState.text.length == 0) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select STATE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (txtDistrict.text.length == 0) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please Select the District" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        txtTaluka.text = @"";
        //  [self callActivity_PPL];

        /*<SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
         <SOAP:Body>
         <GetAllIndianCity xmlns="http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps" preserveSpace="no" qAccess="0" qValues="">
         <state>MH</state>
         <dist>THANE</dist>
         </GetAllIndianCity>
         </SOAP:Body>
         </SOAP:Envelope>*/

        NSString* envelopeText = [NSString stringWithFormat:
                                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetAllIndianCity xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<state>%@</state>"
                                           @"<dist>%@</dist>"
                                           @"</GetAllIndianCity>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",
                                           str_States, txtDistrict.text];

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

        [[RequestDelegate alloc] initiateRequest:request name:@"getAllCityConnection"];
    }
}
- (void)AllCity_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n City response....... %@ ", response);

    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response isEqual:@""]) {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
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
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Data not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }

        if ((GetAllCities) > 0) {
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
                [actionSheet showFromRect:[self.txtCity frame] inView:self.secondView animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 3;

            //[appdelegate hideAlert];
        }
    }
}

- (IBAction)btnPincode:(id)sender
{
    [self showAlert];
    if (txtState.text.length == 0) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select STATE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (txtDistrict.text.length == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please Select the District" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (txtCity.text.length == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please Select the City" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        {
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
                                               SelectedStateCode, txtDistrict.text, txtCity.text, txtTaluka.text];

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
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
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
                    [actionSheet showFromRect:[self.txtPincode frame] inView:self.secondView animated:YES];
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
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (IBAction)btnDistrict:(id)sender
{
    [self showAlert];
    if (txtState.text.length == 0) {
        [self hideAlert];
        // [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select STATE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        {
            txtCity.text = @"";
            NSString* envelopeText = [NSString stringWithFormat:
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
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"there is some technical problem while fetching data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        //[self hideAlert];
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
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }

        if ((GetAllDistrict_Arr) > 0) {
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
                [actionSheet showFromRect:[self.txtDistrict frame] inView:self.firstView animated:YES];
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
    if (txtState.text.length == 0) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select STATE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (txtDistrict.text.length == 0) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the district" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (txtCity.text.length == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select the city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [self hideAlert];
        [alert show];
    }
    else {

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
                                           str_States, txtDistrict.text, txtCity.text];

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
- (void)AllTalukas_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        //[self hideAlert];
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
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }

        if ((GetAllTaluka) > 0) {
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
                [actionSheet showFromRect:[self.txtTaluka frame] inView:self.firstView animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 4;
        }
    }
}

- (void)actionSheet:(UIActionSheet*)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{

    NSLog(@"button click ....%ld", (long)buttonIndex);
    if (txtState) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 1:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                return;
            }
            else {
                str_States = [ProductName objectAtIndex:buttonIndex];
                self.txtState.text = NSLocalizedString([ShowStates objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txtDistrict) {
        switch (popup.tag) {
        case 2:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtDistrict.text = NSLocalizedString([GetAllDistrict_Arr objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txtCity) {
        switch (popup.tag) {
        case 3:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtCity.text = NSLocalizedString([GetAllCities objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txtTaluka) {
        switch (popup.tag) {
        case 4:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtTaluka.text = NSLocalizedString([GetAllTaluka objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txtPincode) {
        switch (popup.tag) {
        case 5:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtPincode.text = NSLocalizedString([GetAllPincode objectAtIndex:buttonIndex], @"");
            }
        }
    }
}
- (IBAction)btnSaveAccount:(id)sender
{

    if (![self connected]) {
        // not connected
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {

        if ([txtTGMName.text isEqual:@""] || [txtTGMNumber.text isEqual:@""] || [txtAddress.text isEqual:@""] || [txtTaluka.text isEqual:@""] || [txtDistrict.text isEqual:@""] || [txtState.text isEqual:@""] || [txtCity.text isEqual:@""]) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please enter mandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        } /*
    else if ([txtTGMName.text isEqual:@""])
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Please enter TGM name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([txtTGMNumber.text isEqual:@""])
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Please enter TGM cell number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([txtAddress.text isEqual:@""])
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Please enter address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([txtTaluka.text isEqual:@""])
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Please Select Taluka" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([txtDistrict.text isEqual:@""])
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Please Select STATE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([txtCity.text isEqual:@""])
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Please Select City" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([txtTGMNumber.text isEqual:@""]) {
        [self hideAlert];
        
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message:@"Please enter cell number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }*/
        else if (txtTGMNumber.text && txtTGMNumber.text.length < 10) {
            [self hideAlert];

            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"cell number must be of 10 digits" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }

        else if ([mobileNumberPred evaluateWithObject:txtTGMNumber.text] != YES && [txtTGMNumber.text length] != 0) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please enter valid cell number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        //[txtState.text isEqual:@""]
        else if ([txtState.text isEqual:@""]) {
        }
        else {
            [self showAlert];
            [self callCreateContact_FromAccount];
        }
    }
    /*
     else if (_textnumber.text && _textnumber.text.length < 10) {
     [self hideAlert];
     
     UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message:@"contact number must be of 10 digits" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alertView show];
     }
     
     else if  ([mobileNumberPred evaluateWithObject:_textnumber.text] != YES && [_textnumber.text length]!=0)
     {
     [self hideAlert];
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please enter valid phone number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [alert show];
     
     
     }

     */
}

- (IBAction)btnCancel:(id)sender
{

    txtTGMName.text = @"";
    txtTGMNumber.text = @"";
    txtAddress.text = @"";
    txtTaluka.text = @"";
    txtPincode.text = @"";
    txtAddress2.text = @"";
    txtArea.text = @"";
    txtState.text = @"";
    txtDistrict.text = @"";
    txtPanchayat.text = @"";
    txtCity.text = @"";
}

- (void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
- (void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#define kOFFSET_FOR_KEYBOARD 100.0

- (void)keyboardWillShow
{
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0) {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0) {
        [self setViewMovedUp:NO];
    }
}

- (void)keyboardWillHide
{
    if (self.view.frame.origin.y >= 0) {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0) {
        [self setViewMovedUp:NO];
    }
}

- (void)textFieldDidBeginEditing:(UITextView*)sender
{
    if ([sender isEqual:txtPincode]) {
        //move the main view, so that the keyboard does not hide it.
        if (self.view.frame.origin.y >= 0) {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
- (void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view

    CGRect rect = self.view.frame;
    if (movedUp) {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;

    [UIView commitAnimations];
}
@end
