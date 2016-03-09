//
//  SearchAccountViewController.m
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 02/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import "SearchAccountViewController.h"
#import "LoginViewController.h"
#import "searchAccount_Cell.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "SearchAccountDetails.h"
#import "Activity_List.h"
#import "MBProgressHUD.h"
#import "UpdateAccountController.h"
#import "Reachability.h"
@interface SearchAccountViewController () {
    UIAlertView* alert;
    NSString* ActiveInActive;
    BOOL isCellClicked;
    long selectedRow;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
}
@end

@implementation SearchAccountViewController
@synthesize AccountSearch_ListArr, lastIndexPath;
- (void)viewDidLoad
{

    [super viewDidLoad];

    if (![self connected]) {
        // not connected
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];

        [self._tableView setHidden:YES];
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance

        // Button Border Color
        self.btnActive.layer.borderColor = [UIColor colorWithRed:(54 / 255.0)green:(180 / 255.0)blue:(220 / 255.0)alpha:1].CGColor;
        self.btnActive.layer.borderWidth = 2;

        self.btnInActive.layer.borderColor = [UIColor colorWithRed:(143 / 255.0)green:(145 / 255.0)blue:(152 / 255.0)alpha:1].CGColor;
        self.btnInActive.layer.borderWidth = 2;
        // AccountSearch_ListArr=[[NSMutableArray alloc] init];

        self.btnSearch.layer.cornerRadius = 3;
        self.btnSearch.layer.masksToBounds = YES;

        self.viewFirst.layer.cornerRadius = 3;
        self.viewFirst.layer.masksToBounds = YES;

        self.btnUpdate.layer.cornerRadius = 3;
        self.btnUpdate.layer.masksToBounds = YES;

        self.viewFirst.layer.borderColor = [UIColor colorWithRed:(1 / 255.0)green:(43 / 255.0)blue:(98 / 255.0)alpha:1].CGColor;

        self.automaticallyAdjustsScrollViewInsets = NO;

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
    }
    else {

        [self._tableView setHidden:YES];
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
        // appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance

        // Button Border Color
        self.btnActive.layer.borderColor = [UIColor colorWithRed:(54 / 255.0)green:(180 / 255.0)blue:(220 / 255.0)alpha:1].CGColor;
        self.btnActive.layer.borderWidth = 2;

        self.btnInActive.layer.borderColor = [UIColor colorWithRed:(143 / 255.0)green:(145 / 255.0)blue:(152 / 255.0)alpha:1].CGColor;
        self.btnInActive.layer.borderWidth = 2;
        // AccountSearch_ListArr=[[NSMutableArray alloc] init];

        self.btnSearch.layer.cornerRadius = 3;
        self.btnSearch.layer.masksToBounds = YES;

        self.viewFirst.layer.cornerRadius = 3;
        self.viewFirst.layer.masksToBounds = YES;

        self.btnUpdate.layer.cornerRadius = 3;
        self.btnUpdate.layer.masksToBounds = YES;

        self.viewFirst.layer.borderColor = [UIColor colorWithRed:(1 / 255.0)green:(43 / 255.0)blue:(98 / 255.0)alpha:1].CGColor;

        self.automaticallyAdjustsScrollViewInsets = NO;

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


    }
    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Account_Search_Found" object:nil]; //Gomzy // For Activity_PPL Count
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ActivityType_Found" object:nil]; //Gomzy // For ActivityType Count
}
- (void)viewWillAppear:(BOOL)animated
{
    [self callAccount_Search];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Account_Search_Found:) name:@"Account_Search_Found" object:nil]; //Gomzy //For Activity Type Dropdown Count
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActivityType_Found:) name:@"ActivityType_Found" object:nil]; //Gomzy //For activity type

    // NSIndexPath *tableSelection = [self._tableView indexPathForSelectedRow];
    // [self._tableView deselectRowAtIndexPath:tableSelection animated:NO];
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

- (void)callAccount_Search
{

    [self showAlert];
    /*
     <SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"> <SOAP:Body><GetAccountListBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\"><positionid>"
					+ UserDetails.ROW_ID
					+ "</positionid><activeaccountflag>"
					+ activeaccountflag
					+ "</activeaccountflag>"
					+ "<inactiveaccountflag></inactiveaccountflag>"
					+ "<attr1></attr1>"
					+ "<attr2></attr2>"
					+ "</GetAccountListBasedOnSearchCriteria>"
					+ "</SOAP:Body>"
					+ "</SOAP:Envelope>
     */
    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetAccountListBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<positionid>%@</positionid>"
                                       @"<activeaccountflag>%@</activeaccountflag>"
                                       @"<inactiveaccountflag></inactiveaccountflag>"
                                       @"<attr1></attr1>"
                                       @"<attr2></attr2>"
                                       @"</GetAccountListBasedOnSearchCriteria>"
                                       @"</SOAP:Body>"
                                        "</SOAP:Envelope>",
                                       userDetailsVal_.ROW_ID, ActiveInActive];

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

    [[RequestDelegate alloc] initiateRequest:request name:@"AccountSearch_Connection"];
    //getAccountSearchConnection
}

- (void)Account_Search_Found:(NSNotification*)notification
{
    AccountSearch_ListArr = [[NSMutableArray alloc] init];
    // Activities_Customer_list=[[NSMutableArray alloc] init];
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n _Sear Account response... %@ ", response);

    // NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"The username or password you entered is incorrect.\n*The user account will be locked after 3 unsucessfull attempts." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self hideAlert];
    }
    else {
        if (AccountSearch_ListArr) {
            [AccountSearch_ListArr removeAllObjects];
        }
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetAccountListBasedOnSearchCriteriaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            do {
                Search_list = nil;
                Search_list = [[SearchAccountDetails alloc] init];
                /*
                 <tuple>
                 <old>
                 <S_ORG_EXT>
                 <TGM_NAME>RAJEEV</TGM_NAME>
                 <TGM_PHONE_NUMBER>789</TGM_PHONE_NUMBER>
                 <ACCOUNT_ID>1-7BNIZHZ</ACCOUNT_ID>
                 <ACCOUNT_STATUS>Active</ACCOUNT_STATUS>
                 </S_ORG_EXT>
                 </old>
                 </tuple>
                 */
                TBXMLElement* S_Lst_Of_Val = [TBXML childElementNamed:@"S_ORG_EXT" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* X_NAME = [TBXML childElementNamed:@"TGM_NAME" parentElement:S_Lst_Of_Val];
                NSString* s = [TBXML textForElement:X_NAME];
                NSLog(@"Strong..%@", s);
                Search_list.TGM_NAME = [TBXML textForElement:X_NAME];
                NSLog(@"NAmE : %@", Search_list.TGM_NAME);

                TBXMLElement* X_TGM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_PHONE_NUMBER" parentElement:S_Lst_Of_Val];
                Search_list.TGM_PHONE_NUMBER = [TBXML textForElement:X_TGM_PHONE_NUMBER];
                NSLog(@"NAmE number: %@", Search_list.TGM_PHONE_NUMBER);

                TBXMLElement* X_ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:S_Lst_Of_Val];
                Search_list.ACCOUNT_ID = [TBXML textForElement:X_ACCOUNT_ID];
                NSLog(@"Account ID : %@", Search_list.ACCOUNT_ID);

                TBXMLElement* X_ACCOUNT_STATUS = [TBXML childElementNamed:@"ACCOUNT_STATUS" parentElement:S_Lst_Of_Val];
                Search_list.ACCOUNT_STATUS = [TBXML textForElement:X_ACCOUNT_STATUS];

                [AccountSearch_ListArr addObject:Search_list];

            } while ((tuple = tuple->nextSibling));
            [self._tableView reloadData];
        }
        NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ", (unsigned long)[AccountSearch_ListArr count]);
        if (AccountSearch_ListArr >= 0) {
            [self hideAlert];
            [self._tableView setHidden:NO];
        }
    }
    //[self hideAlert];
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
// delegate mehod for uialertView

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0 || indexPath.row == ([indexPath length]-1))
    {
       // cell.layer.cornerRadius = 10;
        
        
    }
  //  cell.layer.cornerRadius = 10;
  //  cell.layer.borderWidth=2.0f;
  //  cell.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
     UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 320, 3)];/// change size as you need.
     separatorLineView.backgroundColor = [UIColor redColor];// you can also put image here
     [cell.contentView addSubview:separatorLineView];*/

/*
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(63/255.0) alpha:1]];
    bgColorView.layer.cornerRadius = 10;
    // [cell setSelectedBackgroundView:bgColorView];
    // [bgColorView release];
    
    cell.backgroundColor = [UIColor colorWithRed:(1/255.0) green:(31/255.0) blue:(65/255.0) alpha:1] ;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor=[UIColor colorWithRed:(216/255.0) green:(218/255.0) blue:(221/255.0) alpha:1];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
    cell.selectedBackgroundView=bgColorView;*/

//}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    return [AccountSearch_ListArr count]; //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    Search_list = nil;
    Search_list = [[SearchAccountDetails alloc] init];
    Search_list = [AccountSearch_ListArr objectAtIndex:indexPath.row];

    /*
    static NSString *MyIdentifier = @"searchAccountCell";
    //static NSString *CELL_ID2 = @"SOME_STUPID_ID2";
    
    searchAccount_Cell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // cell.accessoryType = UITableViewCellAccessoryNone;
    // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[searchAccount_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    //cell.lblNAme.text=Search_list.TGM_NAME;

    
    
    cell.backgroundColor=[UIColor clearColor];
    [cell.search_view.layer setBorderColor:[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor];
    [cell.search_view.layer setBorderWidth:2.0f];
    cell.search_view.layer.cornerRadius=5;
    
    //cell.lblNAme.text=
    
     */
    searchAccount_Cell* cell;
    if (tableView == self._tableView) {
        static NSString* MyIdentifier = @"searchAccountCell";

        cell = [self._tableView dequeueReusableCellWithIdentifier:MyIdentifier];

        if (cell == nil) {
            cell = [[searchAccount_Cell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:MyIdentifier];
            cell.imgTik.image = [UIImage imageNamed:@"checkbox.png"];
            //  cell =[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];

            //  [cell._tikBtn setBackgroundImage: [UIImage imageNamed:@"tik_uncheckUp.png"] forState:UIControlStateNormal];
        }
        /*  if ([indexPath compare:self.lastIndexPath] == NSOrderedSame)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }*/

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        UIView* bgColorView = [[UIView alloc] init];
        //[bgColorView setBackgroundColor:[UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(63/255.0) alpha:1]];
        [bgColorView setBackgroundColor:[UIColor redColor]];
        bgColorView.layer.cornerRadius = 10;

        cell.textLabel.highlightedTextColor = [UIColor redColor];
        cell.backgroundColor = [UIColor clearColor];
        [cell.search_view.layer setBorderColor:[UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor];
        [cell.search_view.layer setBorderWidth:2.0f];
        cell.search_view.layer.cornerRadius = 5;

        cell.lblNAme.text = Search_list.TGM_NAME;
        cell.lblPhoneNumber.text = Search_list.TGM_PHONE_NUMBER;
        cell.lblAccountId.text = Search_list.ACCOUNT_ID;
        cell.lblAccountStatus.text = Search_list.ACCOUNT_STATUS;
        //cell.selectedBackgroundView=bgColorView;
        cell.imgTik.image = [UIImage imageNamed:@"checkbox.png"];

        /*
        [cell.layer setBorderColor:[UIColor colorWithRed:(183/255.0) green:(178/255.0) blue:(63/255.0) alpha:1].CGColor];
        [cell.layer setBorderWidth:2.0f];
        cell.layer.cornerRadius=5;
*/

        //cell.selectedBackgroundView=bgColorView;
        //cell.layer.borderColor=[UIColor redColor].CGColor;
        return cell;
    }
    return 0;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    isCellClicked = true;
    searchAccount_Cell* cell = (searchAccount_Cell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.imgTik.image = [UIImage imageNamed:@"checkbox_12.png"];
    Search_list = [AccountSearch_ListArr objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView*)tableView
    didDeselectRowAtIndexPath:(NSIndexPath*)indexPath
{
    searchAccount_Cell* cell = (searchAccount_Cell*)[tableView cellForRowAtIndexPath:indexPath];

    cell.imgTik.image = [UIImage imageNamed:@"checkbox.png"];
}
/*
- (NSIndexPath *)tableView:(UITableView *)tableView
willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"... Diselect %ld",(long)indexPath.row);
    searchAccount_Cell *cell =(searchAccount_Cell*) [tableView cellForRowAtIndexPath:indexPath];

    cell.imgTik.image=[UIImage imageNamed:@"tik_uncheckUp.png"];

    return 0;
}*/
- (IBAction)btnActive:(id)sender
{

    self.btnActive.layer.borderColor = [UIColor colorWithRed:(54 / 255.0)green:(180 / 255.0)blue:(220 / 255.0)alpha:1].CGColor;
    self.btnActive.layer.borderWidth = 2;

    self.btnInActive.layer.borderColor = [UIColor colorWithRed:(143 / 255.0)green:(145 / 255.0)blue:(152 / 255.0)alpha:1].CGColor;
    self.btnInActive.layer.borderWidth = 2;

    [self.btnActive setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];

    [self.btnInActive setBackgroundImage:[UIImage imageNamed:@"icon_check.png"] forState:UIControlStateNormal];
    ActiveInActive = @"Active";
}
- (IBAction)btnInActive:(id)sender
{

    self.btnActive.layer.borderColor = [UIColor colorWithRed:(143 / 255.0)green:(145 / 255.0)blue:(152 / 255.0)alpha:1].CGColor;
    self.btnActive.layer.borderWidth = 2;

    self.btnInActive.layer.borderColor = [UIColor colorWithRed:(54 / 255.0)green:(180 / 255.0)blue:(220 / 255.0)alpha:1].CGColor;
    self.btnInActive.layer.borderWidth = 2;

    [self.btnInActive setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];

    [self.btnActive setBackgroundImage:[UIImage imageNamed:@"icon_check.png"] forState:UIControlStateNormal];
    ActiveInActive = @"Inactive";
}
- (IBAction)btnSearch:(id)sender
{
    [self callAccount_Search];
    //[self showAlert];
}
- (void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
- (void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (IBAction)btnUpdate:(id)sender
{
    if (isCellClicked == true) {

        //  UpdateAccountController *newController = [[UpdateAccountController alloc] init];

        UpdateAccountController* updateViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"updateViewController"];

        [self.navigationController pushViewController:updateViewController animated:YES];

        updateViewController.tgmName = Search_list.TGM_NAME;

        /*
        UpdateAccountController *updateViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"updateViewController"];
        
        [self.navigationController pushViewController:updateViewController animated:YES];
        
        [self presentViewController:updateViewController animated:YES completion:nil ];*/
    }
    else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please select ACCOUNT" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

@end
