//
//  UpdateAccountController.m
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 03/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import "UpdateAccountController.h"
#import "SearchAccountDetails.h"
#import "SearchAccountViewController.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "Reachability.h"
@interface UpdateAccountController () {
    NSString* ActiveInActive;
    UIAlertView* alert;
    int flag;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
}
@end

@implementation UpdateAccountController
@synthesize txtName, txtMobileNo, btnCancel, btnSave;
@synthesize tgmName;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Button
    [self textFiledText];

    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    // appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance

    //self.btnSave.layer.cornerRadius=3;
    self.btnSave.layer.cornerRadius = 3;
    self.btnSave.layer.masksToBounds = YES;

    self.btnCancel.layer.cornerRadius = 3;
    self.btnCancel.layer.masksToBounds = YES;

    // Text Fileds Border Color
    self.txtName.layer.borderWidth = 2.0f;
    self.txtMobileNo.layer.borderWidth = 2.0f;
    self.viewAccountType.layer.borderWidth = 2.0f;

    self.txtName.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.txtMobileNo.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
    self.viewAccountType.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;

    txtName.text = Search_list.TGM_NAME;
    txtMobileNo.text = Search_list.TGM_PHONE_NUMBER;

    if ([Search_list.ACCOUNT_STATUS isEqual:@"Active"]) {

        [self.btnActive setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];

        [self.btnInActive setBackgroundImage:[UIImage imageNamed:@"icon_check.png"] forState:UIControlStateNormal];
    }
    else {
        [self.btnInActive setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];

        [self.btnActive setBackgroundImage:[UIImage imageNamed:@"icon_check.png"] forState:UIControlStateNormal];
    }

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
} //AccountUpdate_Found

- (void)textFiledText
{
    UIColor* color = [UIColor colorWithRed:(131 / 255.0)green:(131 / 255.0)blue:(131 / 255.0)alpha:1];

    self.txtMobileNo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Cell number" attributes:@{ NSForegroundColorAttributeName : color }];

    self.txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : color }];
}

- (void)info_btn
{
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
- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld", (long)buttonIndex);
    if (buttonIndex == 0) {

        NSLog(@"Button Index 0");
    }
    if (buttonIndex == 1) {
        NSLog(@"Button Index 1");
        LoginViewController* secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //[self.navigationController pushViewController:secondViewController animated:YES];
        [self presentViewController:secondViewController animated:YES completion:nil];
        //  [self.navigationController popToRootViewControllerAnimated:TRUE];
        // [self dismissViewControllerAnimated:YES completion:nil];
        //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}
// delegate mehod for uialertView
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AccountUpdate_Found" object:nil]; //Gomzy // For Activity_PPL Count
    //   [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityType_Found" object:nil];//Gomzy // For ActivityType Count
}
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AccountUpdate_Found:) name:@"AccountUpdate_Found" object:nil]; //Gomzy //For Activity Type Dropdown Count
    //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityType_Found:) name:@"ActivityType_Found" object:nil];//Gomzy //For activity type
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

- (IBAction)btnSave:(id)sender
{

    [self showAlert];

    if (![txtMobileNo.text isEqual:@""]) {
        [self callAccount_Update];
    }
    else {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please enter valid data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self hideAlert];
    }
}

- (IBAction)btnCancel:(id)sender
{

    txtMobileNo.text = @"";
    // txtName.text=@"";
}

- (void)callAccount_Update
{


    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Header>"
                                       @"<UsernameToken xmlns=\"http://siebel.com/webservices\">%@</UsernameToken>"
                                       @"<PasswordText xmlns=\"http://siebel.com/webservices\">%@</PasswordText>"
                                       @"</SOAP:Header>"
                                       @"<SOAP:Body>"
                                       @"<InsertOrUpdateNeev_Input xmlns=\"http://siebel.com/asi/\">"
                                       @"<ListOfAccountInterface xmlns=\"http://www.siebel.com/xml/Account%%20Interface\">"
                                       @"<Account operation=\"update\">"
                                       @"<AccountId>%@</AccountId>"
                                       @"<MainPhoneNumber>%@</MainPhoneNumber>"
                                       @"<AccountStatus>%@</AccountStatus>"
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
                                       @"</ListOfAccountInterface>"
                                       @"</InsertOrUpdateNeev_Input>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",
                                       userDetailsVal_.Login_Name, userDetailsVal_.Login_Name, Search_list.ACCOUNT_ID, txtMobileNo.text, Search_list.ACCOUNT_STATUS, userDetailsVal_.POSITION_NAME, userDetailsVal_.ROW_ID, userDetailsVal_.ORGNAME];

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

    [[RequestDelegate alloc] initiateRequest:request name:@"AccountUpdate_Connection"];
    //getAccountSearchConnection
}
- (void)AccountUpdate_Found:(NSNotification*)notification
{
    AccountSearch_ListArr = [[NSMutableArray alloc] init];
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n _Sear Account response... %@ ", response);

    // NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Server Error !." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self hideAlert];
    }
    else {
        if (AccountSearch_ListArr) {
            [AccountSearch_ListArr removeAllObjects];
        }
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"ns:SFATMCVInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];

        TBXMLElement* ListOfContactInterface = [TBXML childElementNamed:@"ListOfTmActionInterface" parentElement:container];

        TBXMLElement* Opportunity = [TBXML childElementNamed:@"Action" parentElement:ListOfContactInterface];
        TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
        if (Id) {
            [self hideAlert];
            updateAccount.Id_ = [TBXML textForElement:Id];
            flag = 1;
            alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Account Updated Successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }

        else {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    //[self hideAlert];
}

- (IBAction)btnActive:(id)sender
{
    [self.btnActive setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];

    [self.btnInActive setBackgroundImage:[UIImage imageNamed:@"icon_check.png"] forState:UIControlStateNormal];
    ActiveInActive = @"Active";

    Search_list.ACCOUNT_STATUS = ActiveInActive;
}
- (IBAction)btnInActive:(id)sender
{
    [self.btnInActive setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];

    [self.btnActive setBackgroundImage:[UIImage imageNamed:@"icon_check.png"] forState:UIControlStateNormal];
    ActiveInActive = @"Inactive";
    Search_list.ACCOUNT_STATUS = ActiveInActive;
}
- (void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
- (void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
