//
//  ActivityListViewController.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/19/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "ActivityListViewController.h"
#import "Reachability.h"
#import "Activity_List.h"
#import "dashboardTodaysActivity_Cell_VC.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "MBProgressHUD.h"

@interface ActivityListViewController () {
    UIAlertView* alert;

    Boolean isdataAvailable;

    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
    NSMutableArray* Activities_ListArr;
}
@end

@implementation ActivityListViewController
@synthesize TableView;

- (void)viewWillAppear:(BOOL)animated
{
    [self callActivityList];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActivityListFound:) name:@"ActivityListFound" object:nil]; //Abhishek //For Activity Count
    [self.TableView reloadData];

    NSLog(@"Same To Same");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ActivityListFound" object:nil]; //Abhishek // for artifact fail
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showAlert];
    NSLog(@"Manage Opportunity111 :");
    self.TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    // Navigation bar button on right side
    UIButton *btnInfo =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnInfo setImage:[UIImage imageNamed:@"header_icon_1.png"] forState:UIControlStateNormal];
    [btnInfo addTarget:self action:@selector(info_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnInfo setFrame:CGRectMake(-15, -5, 40, 40)];
    
    UIButton *btnLogout =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogout setImage:[UIImage imageNamed:@"header_icon_2.png"] forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(logOut_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnLogout setFrame:CGRectMake(44, -5, 40, 40)];
    
    UIView *rightBarButtonItems = [[UIView alloc] initWithFrame:CGRectMake(10,10,90,40)];
    [rightBarButtonItems addSubview:btnInfo];
    [rightBarButtonItems addSubview:btnLogout];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];
    self.splitViewController.delegate = self;
    self.masterPopoverController.delegate=self;
    UIBarButtonItem *barButtonItem = self.splitViewController.displayModeButtonItem;
    barButtonItem.title = @"Show master";
    self.navigationItem.leftBarButtonItem = barButtonItem;
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    NSLog(@"Samlp Art Master: %@",appdelegate.artifact);
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"Samlp Art Master: %@",userDetailsVal_.ROW_ID);
    if (![self connected])
    {
        [TableView setHidden:YES];
        NSLog(@"Newtwork not Available...");
        alert=[[UIAlertView alloc]initWithTitle:@"CRM" message :@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        self.TableView.delegate = self;
        self.TableView.dataSource = self;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)info_btn
{

    [self performSegueWithIdentifier:@"infoView" sender:self];
    //  NSLog(@"Home biscuit from Sanfrancisco");
}
- (void)logOut_btn
{
    // flag=true;
    alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                       message:@"Do you want to Logout ?"
                                      delegate:self
                             cancelButtonTitle:@"No"
                             otherButtonTitles:@"Yes", nil];
    [alert show];
    NSLog(@"Home biscuit from Sanfrancisco");
}
// delegate mehod for uialertView

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld", (long)buttonIndex);
    if (buttonIndex == 0) {

        NSLog(@"David Miller");
    }
    if (buttonIndex == 1) {

        //  LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //[self.navigationController pushViewController:secondViewController animated:YES];
        //  [self presentViewController:secondViewController animated:YES completion:nil ];
        //  [self.navigationController popToRootViewControllerAnimated:TRUE];
        // [self dismissViewControllerAnimated:YES completion:nil];
        //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    return [Activities_ListArr count];
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0 || indexPath.row == ([indexPath length] - 1)) {
        cell.layer.cornerRadius = 10;
    }
    cell.layer.cornerRadius = 10;
    cell.layer.borderWidth = 2.0f;
    cell.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;

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
    /*
     UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 320, 3)];/// change size as you need.
     separatorLineView.backgroundColor = [UIColor redColor];// you can also put image here
     [cell.contentView addSubview:separatorLineView];*/

    UIView* bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:(245 / 255.0)green:(244 / 255.0)blue:(244 / 255.0)alpha:1]];
    bgColorView.layer.cornerRadius = 10;
    // [cell setSelectedBackgroundView:bgColorView];
    // [bgColorView release];

    cell.backgroundColor = [UIColor colorWithRed:(245 / 255.0)green:(244 / 255.0)blue:(244 / 255.0)alpha:1];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithRed:(65 / 255.0)green:(68 / 255.0)blue:(77 / 255.0)alpha:1];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView = bgColorView;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    activity_list = nil;
    activity_list = [[Activity_List alloc] init];
    activity_list = [Activities_ListArr objectAtIndex:indexPath.row];

    dashboardTodaysActivity_Cell_VC* cell;
    if (tableView == self.TableView)

    {
        static NSString* MyIdentifier = @"TodaysActivitiesViewCellIdentifier";

        cell = [self.TableView dequeueReusableCellWithIdentifier:MyIdentifier];

        if (cell == nil) {
            cell = [[dashboardTodaysActivity_Cell_VC alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:MyIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        cell.lbl_CustomerName.text = activity_list.CONTACT_NAME;
        cell.lbl_OptyId.text = activity_list.CONTACT_CELL_NUM;
        
        cell.lbl_SaleStage.text=activity_list.SALES_STAGE_NAME;
        cell.lbl_DSEName.text=activity_list.CONTACT_NAME;
        cell.lbl_ActivityType.text=activity_list.ACTIVITY_TYPE;
        
        
        NSLog(@"activity type %@",activity_list.ACTIVITY_PENDING_TYPE);
        cell.lbl_ActivityPending.text=activity_list.ACTIVITY_PENDING_TYPE;
       // cell.optyCounter.text = @"4";
        
        return cell;
    }
    return 0;
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showActivity"]) {
        ActivityListViewController* detailViewController =
            [segue destinationViewController];
        NSLog(@"0 -- %@", detailViewController);
    }
}

- (void)callActivityList
{
    NSLog(@"Extra..");

    NSString* envelopeText;

    if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 @"<SOAP:Body>"
                                 @"<GetListOfActivityForNSELOBDSE xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                 @"<positionid>%@</positionid>"
                                 @"<activitystatus></activitystatus>"
                                 @"</GetListOfActivityForNSELOBDSE>"
                                 @"</SOAP:Body>"
                                 @"</SOAP:Envelope>",
                                 userDetailsVal_.ROW_ID];
    }

    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 @"<SOAP:Body>"
                                 @"<GetListOfActivityForNSELOBDSE xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                 @"<positionid>%@</positionid>"
                                 @"<activitystatus>Open</activitystatus>"
                                 @"</GetListOfActivityForNSELOBDSE>"
                                 @"</SOAP:Body>"
                                 @"</SOAP:Envelope>",
                                 userDetailsVal_.ROW_ID];
    }

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

    [[RequestDelegate alloc] initiateRequest:request name:@"ActivityDetails_Connection"];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    NSLog(@"Row Selected ... %ld", (long)indexPath.row);
    activity_list = [Activities_ListArr objectAtIndex:indexPath.row];
}

//ActivityListFound
- (void)ActivityListFound:(NSNotification*)notification // Activity Response
{

    // int i = 0; //for test loop
    Activities_ListArr = [[NSMutableArray alloc] init];
    Activities_Customer_list = [[NSMutableArray alloc] init];

    if (Activities_ListArr) {
        [Activities_ListArr removeAllObjects];
    }

    NSError* err;
    // TBXMLElement *X_PROSPECT_SRC;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n ActivityDetails_Connection response... %@ ", response);
    
    
    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No Taluka found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No Taluka found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            
            alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            
            alert=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
       
    }
    else
    {
    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

    TBXMLElement* soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement* container = [TBXML childElementNamed:@"GetListOfActivityForNSELOBDSEResponse" parentElement:soapBody];
    if (container) {
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        ///  NSLog(@"Tuple..%@",tuple);
        if (tuple) {
            do {
                activity_list = nil;
                activity_list = [[Activity_List alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];

                TBXMLElement* OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];

                activity_list.OPPTY_NAME = [TBXML textForElement:OPTY_NAME];
                NSLog(@"X_PROSPECT_SRC : %@", activity_list.OPPTY_NAME);

                TBXMLElement* OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                activity_list.OPTY_ID = [TBXML textForElement:OPTY_ID];
                NSLog(@"Opty Id List :%@",activity_list.OPTY_ID);

                TBXMLElement* PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                activity_list.PRODUCT_NAME1 = [TBXML textForElement:PRODUCT_NAME];

                TBXMLElement* OPTY_CREATED = [TBXML childElementNamed:@"OPTY_CREATED" parentElement:table];
                activity_list.OPTY_CREATED = [TBXML textForElement:OPTY_CREATED];

                TBXMLElement* SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                activity_list.SALES_STAGE_NAME = [TBXML textForElement:SALES_STAGE_NAME];
                //
                TBXMLElement* SALES_STAGE_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                activity_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];

                TBXMLElement* LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                activity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];

                TBXMLElement* LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                activity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];

                TBXMLElement* LEAD_ASSIGNED_POSITION_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_NAME" parentElement:table];
                activity_list.LEAD_ASSIGNED_POSITION_NAME = [TBXML textForElement:LEAD_ASSIGNED_POSITION_NAME];

                TBXMLElement* LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                activity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];

                TBXMLElement* CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                activity_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];

                TBXMLElement* CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                activity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];

                TBXMLElement* CONTACT_CELL_NUM = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                activity_list.CONTACT_CELL_NUM = [TBXML textForElement:CONTACT_CELL_NUM];

                TBXMLElement* CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                activity_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                
                
                
                
                TBXMLElement* ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:table];
                activity_list.ACTIVITY_PENDING_TYPE = [TBXML textForElement:ACTIVITY_PENDING_TYPE];
                
                TBXMLElement* ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
                activity_list.ACTIVITY_ROW_ID = [TBXML textForElement:ACTIVITY_ID];
                
                TBXMLElement* PLANNED_START_DATE = [TBXML childElementNamed:@"PLANNED_START_DATE" parentElement:table];
                activity_list.PLANNED_START_DATE = [TBXML textForElement:PLANNED_START_DATE];
                
                TBXMLElement* ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"ACTIVITY_DESCRIPTION" parentElement:table];
                activity_list.ACTIVITY_DESCRIPTION = [TBXML textForElement:ACTIVITY_DESCRIPTION];
                
                
                
                
                TBXMLElement* ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:table];
                activity_list.ACTIVITY_STATUS = [TBXML textForElement:ACTIVITY_STATUS];
                

                
                
                
                
                

                [Activities_ListArr addObject:activity_list];

            } while ((tuple = tuple->nextSibling));
            NSLog(@"Opty Id's 11%@", Activities_ListArr);
            [self.TableView reloadData];
            if ([Activities_ListArr count] > 0) {
                NSLog(@"position :%@",userDetailsVal_.POSTN);

                [self hideAlert];
            }
        }
        else {
            [self hideAlert];
            NSLog(@"position :%@",userDetailsVal_.POSTN);
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No Records Found. Please search for activities" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            }else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No Records Found. Please search for activities" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        NSLog(@"Opty Id's 12%@", Activities_ListArr);
        NSLog(@"Counter.. %lu", (unsigned long)[Activities_ListArr count]);
    }
    
    
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
@end
