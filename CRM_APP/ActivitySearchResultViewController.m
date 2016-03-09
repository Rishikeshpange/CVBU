//
//  ActivitySearchResultViewController.m
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 27/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import "ActivitySearchResultViewController.h"
#import "LoginViewController.h"
#import "dashboardTodaysActivity_Cell_VC.h"
#import "RequestDelegate.h"
#import "Activity_List.h"
#import "TBXML.h"
#import "MBProgressHUD.h"

NSString* RESULTCOUNT;
NSInteger NO_OF_PAGECOUNT;
NSInteger CURRENT_PAGE;
NSInteger INT_RESULTCOUNT;
@interface ActivitySearchResultViewController () {
    UIAlertView* alert;
    NSString* envelopeText;
}
@end

@implementation ActivitySearchResultViewController
@synthesize ActiveInActive, assignTO, ActivityType, ppl, Status, FromDate, taluka, Todate;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showAlert];
    [self._tableView setHidden:YES];
    
    self._tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // NSLog(@" test,%@%%@%@%@", ActiveInActive, assignTO, ActivityType, ppl, Status, FromDate, taluka, Todate);
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    
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
    /*
     if([FromDate isEqual:@""])
     {
     
     }else
     {
     
     }*/
    [self CallSearch];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"searchActivities_Found" object:nil]; //abhishek // For searchActivities_Found Count
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"searchActivities_Found1" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchActivities_Found:) name:@"searchActivities_Found" object:nil]; //Gautam //for search activites after pressing search button
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchActivities_Found1:) name:@"searchActivities_Found1" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [Activities_ListArr count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1; // in your case, there are 3 cells
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 0;
//}
/*
 - (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
 {
 return 0; // you can have your own choice, of course
 }
 - (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
 {
 return 0;
 }
 - (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
 {
 UIView* headerView = [[UIView alloc] init];
 headerView.backgroundColor = [UIColor clearColor];
 return headerView;
 }*/
- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    [bgColorView setBackgroundColor:[UIColor colorWithRed:(178 / 255.0)green:(183 / 255.0)blue:(63 / 255.0)alpha:1]];
    bgColorView.layer.cornerRadius = 10;
    
    cell.backgroundColor = [UIColor colorWithRed:(255 / 255.0)green:(255 / 255.0)blue:(255 / 255.0)alpha:1];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithRed:(164 / 255.0)green:(163 / 255.0)blue:(163 / 255.0)alpha:1];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    //cell.selectedBackgroundView=bgColorView;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    activity_list = nil;
    activity_list = [[Activity_List alloc] init];
    activity_list = [Activities_ListArr objectAtIndex:indexPath.row];
    
    dashboardTodaysActivity_Cell_VC* cell;
    if (tableView == self._tableView) {
        static NSString* MyIdentifier = @"TodaysActivitiesViewCellIdentifier";
        
        cell = [self._tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil) {
            cell = [[dashboardTodaysActivity_Cell_VC alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:MyIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        //  NSLog(@"Cell Data: %@",activity_list.CONTACT_NAME,activity_list.CONTACT_CELL_NUM,activity_list.ACTIVITY_TYPE,activity_list.SALES_STAGE_NAME,activity_list.ACTIVITY_PENDING_TYPE,activity_list.LEAD_ASSIGNED_NAME);
        
        NSLog(@"activity type %@%@%@%@%@",activity_list.CONTACT_NAME,activity_list.CONTACT_CELL_NUM,activity_list.ACTIVITY_TYPE,activity_list.SALES_STAGE_NAME,activity_list.ACTIVITY_PENDING_TYPE);
        
        if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            
            
            cell.lbl_CustomerName.text = activity_list.CONTACT_NAME;
            cell.lbl_OptyId.text = activity_list.CONTACT_CELL_NUM;
            cell.lbl_ActivityType.text = activity_list.ACTIVITY_TYPE;
            cell.lbl_SaleStage.text = activity_list.SALES_STAGE_NAME;
            cell.lbl_ActivityPending.text = activity_list.ACTIVITY_TYPE;
            cell.lbl_DSEName.text = activity_list.LEAD_ASSIGNED_NAME;
            
            
            if ([activity_list.CONTACT_NAME isEqual:@""]) {
                
                cell.lbl_CustomerName.text=@"Not Available";
                
            }
            if ([activity_list.CONTACT_CELL_NUM isEqual:@""]) {
                
                cell.lbl_OptyId.text=@"Not Available";
            }
            if ([activity_list.ACTIVITY_TYPE isEqual:@""]) {
                
                cell.lbl_ActivityType.text=@"Not Available";
                
            }
            if ([activity_list.LEAD_ASSIGNED_NAME isEqual:@""]) {
                
                cell.lbl_DSEName.text=@"Not Available";
            }
            
            if ([activity_list.SALES_STAGE_NAME isEqual:@""]) {
                
                cell.lbl_SaleStage.text=@"Not Available";
            }
        }
        else{
            
            
            cell.lbl_CustomerName.text = activity_list.CONTACT_NAME;
            cell.lbl_OptyId.text = activity_list.CONTACT_CELL_NUM;
            cell.lbl_ActivityType.text = activity_list.ACTIVITY_TYPE;
            cell.lbl_SaleStage.text = activity_list.SALES_STAGE_NAME;
            cell.lbl_ActivityPending.text = activity_list.ACTIVITY_PENDING_TYPE;
            cell.lbl_DSEName.text = activity_list.LEAD_ASSIGNED_NAME;
            
            
        }
        
        
        
        
        
        
        
        
        
        
        return cell;
    }
    return 0;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    NSLog(@"Row Selected ... %ld", (long)indexPath.row);
    activity_list = [Activities_ListArr objectAtIndex:indexPath.row];
}
- (void)CallSearch
{
    
    if (FromDate.length == 0 && Todate.length == 0) {
        // [appdelegate hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Date Selection Are Missing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else {
        //[self showAlert];
        NSLog(@"Passed Data : %@ %@ %@ %@ %@ %@ %@ %@ %@", userDetailsVal_.ROW_ID, ActiveInActive, assignTO, ActivityType, ppl, Status, FromDate, taluka, Todate);
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            
            envelopeText = [NSString stringWithFormat:
                            @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                            @"<SOAP:Body>"
                            @"<GetActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                            @"<positionid>%@</positionid>"
                            @"<fromdate>%@</fromdate>"
                            @"<todate>%@</todate>"
                            @"<activitytype>%@</activitytype>"
                            @"<activitystatus>%@</activitystatus>"
                            @"<assignedperson>%@</assignedperson>"
                            @"<tehsilname>%@</tehsilname>"
                            @"<pplname>%@</pplname>"
                            @"<tgmname>%@</tgmname>"
                            @"<tkmname></tkmname>"
                            @"</GetActivityBasedOnSearchCriteria>"
                            @"</SOAP:Body>"
                            @"</SOAP:Envelope>",
                            userDetailsVal_.ROW_ID, FromDate, Todate, ActivityType, Status, assignTO, taluka, ppl, ActiveInActive];
            
            NSLog(@"\n envlopeString Search Activity....!!!!%@", envelopeText);
            NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
            
            NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
            
            NSLog(@"URL IS %@", theurl);
            
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
            
            NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];
            
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
            
            [[RequestDelegate alloc] initiateRequest:request name:@"SearchActivities_Connection"];
            
        }else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            
            
            envelopeText =[NSString stringWithFormat:
                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                           @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                           @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                           @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e53d-0391e62b1f10</DC>"
                           @"</Logger>"
                           @"</header>"
                           @"</SOAP:Header>"
                           @"<SOAP:Body>"
                           @"<GetActivityBasedOnSearchCriteriaForDsm xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                           @"<positionid>%@</positionid>"
                           @"<fromdate>%@</fromdate>"
                           @"<todate>%@</todate>"
                           @"<activitytype>%@</activitytype>"
                           @"<activitystatus>%@</activitystatus>"
                           @"<assignedperson/>"
                           @"<tehsilname>%@</tehsilname>"
                           @"<pplname>%@</pplname>"
                           @"<dsepositionid></dsepositionid>"
                           @"</GetActivityBasedOnSearchCriteriaForDsm>"
                           @"</SOAP:Body>"
                           @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,FromDate, Todate,ActivityType, Status,taluka,ppl];
            
            NSLog(@"\n envlopeString Search Activity....!!!!%@", envelopeText);
            NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
            
            NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
            
            NSLog(@"URL IS %@", theurl);
            
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
            
            NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];
            
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
            
            [[RequestDelegate alloc] initiateRequest:request name:@"SearchActivities_Connection"];
            
        }else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            
            envelopeText =[NSString stringWithFormat:
                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                           @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                           @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                           @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e53d-0391e62b1f10</DC>"
                           @"</Logger>"
                           @"</header>"
                           @"</SOAP:Header>"
                           @"<SOAP:Body>"
                           @"<GetActivityBasedOnSearchCriteriaForDsm xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                           @"<positionid>%@</positionid>"
                           @"<fromdate>%@</fromdate>"
                           @"<todate>%@</todate>"
                           @"<activitytype></activitytype>"
                           @"<activitystatus></activitystatus>"
                           @"<assignedperson />"
                           @"<tehsilname></tehsilname>"
                           @"<pplname></pplname>"
                           @"<dsepositionid></dsepositionid>"
                           @"</GetActivityBasedOnSearchCriteriaForDsm>"
                           @"</SOAP:Body>"
                           @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,FromDate, Todate];
            
            
            
            
            
            
            
            if (self.FromDate== nil)
            {
                self.FromDate=@"";
            }
            if (self.Todate== nil)
            {
                self.Todate=@"";
            }
            if (self.ppl== nil)
            {
                self.ppl=@"";
            }
            if (self.Status== nil)
            {
                self.Status=@"";
            }
            if (self.ActivityType== nil)
            {
                self.ActivityType=@"";
            }
            
            
            
            
            
            
            
            
            NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<positionid>%@</positionid>"
                                       @"<PPLName>%@</PPLName>"
                                       @"<fromdate>%@</fromdate>"
                                       @"<todate>%@</todate>"
                                       @"<activitystatus>%@</activitystatus>"
                                       @"<activitytype>%@</activitytype>"
                                       @"<rang1>1</rang1>"
                                       @"<rang2>1</rang2>"
                                       @"<attr1></attr1>"
                                       @"<attr2></attr2>"
                                       @"<attr3></attr3>"
                                       @"<salestage></salestage>"
                                       @"<Loginid>1-5DVL4B</Loginid>"
                                       @"</GetSFAActivityBasedOnSearchCriteria>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,ppl,self.FromDate,self.Todate,self.Status,self.ActivityType];
            
            NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText1);
            NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
            
            NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
            // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
            NSLog(@"URL IS %@",theurl);
            // NSLog(@"REQUEST IS %@",envelopeText);
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
            
            NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
            
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
            
            [[RequestDelegate alloc]initiateRequest:request name:@"SearchActivities_Connection"];
            
        }
        
        /*
         NSString * envelopeText = [NSString stringWithFormat:
         @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
         @"<SOAP:Body>"
         @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
         @"<positionid>%@</positionid>"
         @"<PPLName>%@</PPLName>"
         @"<fromdate>%@</fromdate>"
         @"<todate>%@</todate>"
         @"<activitystatus>%@</activitystatus>"
         @"<activitytype>%@</activitytype>"
         @"<rang1>%ld</rang1>"
         @"<rang2>%ld</rang2>"
         @"<attr1></attr1>"
         @"<attr2></attr2>"
         @"<attr3></attr3>"
         @"</GetSFAActivityBasedOnSearchCriteria>"
         @"</SOAP:Body>"
         @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtSelectPPL.text,txtFromDate.text,txtTODate.text,txtSelectStatus.text,txtActivityType.text,startIndex,endIndex] ;
         */
        //please change range make dynamic insted of
        /*
         search_activitiesresultpage_variables.pplName_ = txtSelectTal.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
         search_activitiesresultpage_variables.fromDate_ = txtFromDate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
         search_activitiesresultpage_variables.todate_ = txtTODate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
         search_activitiesresultpage_variables.activityStatus_ = txtSelectAssTo.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
         search_activitiesresultpage_variables.activityType_ = txtActivityType.text;// use of instance variable is ,which we can use in next class/// for search and pagination purpose
         */
        
        /* NSLog(@"\n envlopeString Search Activity....!!!!%@", envelopeText);
         NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
         
         NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
         
         NSLog(@"URL IS %@", theurl);
         
         NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
         
         NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];
         
         [request setHTTPMethod:@"POST"];
         [request setHTTPBody:envelope];
         [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
         [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
         
         [[RequestDelegate alloc] initiateRequest:request name:@"SearchActivities_Connection"];*/
    }
}
- (void)searchActivities_Found:(NSNotification*)notification
{
    Activities_ListArr = [[NSMutableArray alloc] init];
    Activities_Customer_list = [[NSMutableArray alloc] init];
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n _ActivitySearch_Found response...Data %@ ", response);
    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
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
    else {
        
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            
            if (Activities_ListArr) {
                [Activities_ListArr removeAllObjects];
            }
            
            TBXMLElement* soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
            TBXMLElement* container = [TBXML childElementNamed:@"GetActivityBasedOnSearchCriteriaResponse" parentElement:soapBody];
            TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
            ///  NSLog(@"Tuple..%@",tuple);
            if (tuple) {
                [self hideAlert];
                do {
                    activity_list = nil;
                    activity_list = [[Activity_List alloc] init];
                    
                    /*
                     <old>
                     <S_OPTY_POSTN xmlns="com.cordys.tatamotors.Neevsiebelwsapp">
                     <OPTY_NAME>1-7CTRELI</OPTY_NAME>
                     <OPTY_ID>1-7CTRELI</OPTY_ID>
                     <PRODUCT_NAME>207 CC FBV</PRODUCT_NAME>
                     <PARENT_PRODUCT_NAME>Xenon Pickups</PARENT_PRODUCT_NAME>
                     <OPTY_CREATED>22-APR-2015</OPTY_CREATED>
                     <TGM_TKM_NAME null="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"/>
                     <TGM_TKM_PHONE_NUMBER null="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"/>
                     <ACCOUNT_TYPE>TKM</ACCOUNT_TYPE>
                     <ACCOUNT_ID null="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"/>
                     <SALES_STAGE_NAME>C0 (Prospecting)</SALES_STAGE_NAME>
                     <SALE_STAGE_UPDATED_DATE>21-MAY-2015</SALE_STAGE_UPDATED_DATE>
                     <LEAD_ASSIGNED_NAME>AJAY PARAB</LEAD_ASSIGNED_NAME>
                     <LEAD_ASSIGNED_CELL_NUMBER>9999999999</LEAD_ASSIGNED_CELL_NUMBER>
                     <LEAD_ASSIGNED_POSITION_NAME>TMCV-Sal-W-MUM-1001680-Jogeshwari-Pickup-DSE-33</LEAD_ASSIGNED_POSITION_NAME>
                     <LEAD_ASSIGNED_POSITION_ID>1-7F0Y20</LEAD_ASSIGNED_POSITION_ID>
                     <POSTN_TYPE_CD>DSE</POSTN_TYPE_CD>
                     <CONTACT_NAME>HEMANTHA AD ADLAP</CONTACT_NAME>
                     <CONTACT_ID>1-7CTRELB</CONTACT_ID>
                     <ADDRESS_ID>1-7CTRELG</ADDRESS_ID>
                     <CONTACT_ADDRESS>OPTY ROAD 2</CONTACT_ADDRESS>
                     <CONTACT_CELL_NUMBER>8787890236</CONTACT_CELL_NUMBER>
                     <ACTIVITY_PENDING_TYPE>Visit Customer</ACTIVITY_PENDING_TYPE>
                     <ACTIVITY_ID>1-7DL072L</ACTIVITY_ID>
                     <PLANNED_START_DATE>21-MAY-2015 08:28:15</PLANNED_START_DATE>
                     <ACTIVITY_DESCRIPTION>CHANGES UPDATE</ACTIVITY_DESCRIPTION>
                     <ACTIVITY_STATUS>Done</ACTIVITY_STATUS>
                     <X_TALUKA null="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"/>
                     <X_PROSPECT_SRC>TKM</X_PROSPECT_SRC>
                     <X_DISTRICT null="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"/>
                     <INFLUENCER>TKM</INFLUENCER>
                     </S_OPTY_POSTN>
                     </old>
                     */
                    
                    TBXMLElement* table = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    TBXMLElement* X_OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                    activity_list.OPPTY_NAME = [TBXML textForElement:X_OPTY_NAME];
                    NSLog(@"OptyNAmE : %@", activity_list.OPPTY_NAME);
                    
                    TBXMLElement* X_OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                    activity_list.OPTY_ID = [TBXML textForElement:X_OPTY_ID];
                    NSLog(@"OptyID : %@", activity_list.OPTY_ID);
                    
                    // TBXMLElement *X_PRODUCT_NAME1 = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                    // activity_list.PRODUCT_NAME1 =[TBXML textForElement:X_PRODUCT_NAME1];
                    
                    TBXMLElement* X_OPTY_CREATED = [TBXML childElementNamed:@"OPTY_CREATED" parentElement:table];
                    activity_list.OPTY_CREAT_DATE = [TBXML textForElement:X_OPTY_CREATED];
                    
                    TBXMLElement* X_TGM_TKM_NAME = [TBXML childElementNamed:@"TGM_TKM_NAME" parentElement:table];
                    activity_list.TGM_TKM_NAME = [TBXML textForElement:X_TGM_TKM_NAME];
                    
                    TBXMLElement* X_TGM_TKM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_TKM_PHONE_NUMBER" parentElement:table];
                    activity_list.TGM_TKM_PHONE_NUMBER = [TBXML textForElement:X_TGM_TKM_PHONE_NUMBER];
                    
                    TBXMLElement* X_ACCOUNT_TYPE = [TBXML childElementNamed:@"ACCOUNT_TYPE" parentElement:table];
                    activity_list.ACCOUNT_TYPE = [TBXML textForElement:X_ACCOUNT_TYPE];
                    
                    TBXMLElement* X_ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                    activity_list.ACCOUNT_ID = [TBXML textForElement:X_ACCOUNT_ID];
                    
                    TBXMLElement* X_SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                    activity_list.SALES_STAGE_NAME = [TBXML textForElement:X_SALES_STAGE_NAME];
                    
                    TBXMLElement* X_SALE_STAGE_UPDATED_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                    activity_list.SALES_STAGE_DATE = [TBXML textForElement:X_SALE_STAGE_UPDATED_DATE];
                    
                    TBXMLElement* X_LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                    activity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:X_LEAD_ASSIGNED_NAME];
                    
                    TBXMLElement* X_LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                    activity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:X_LEAD_ASSIGNED_CELL_NUMBER];
                    
                    TBXMLElement* X_LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                    activity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:X_LEAD_ASSIGNED_POSITION_ID];
                    
                    TBXMLElement* X_CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                    activity_list.CONTACT_NAME = [TBXML textForElement:X_CONTACT_NAME];
                    
                    TBXMLElement* X_CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                    activity_list.CONTACT_ID = [TBXML textForElement:X_CONTACT_ID];
                    
                    TBXMLElement* X_ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
                    activity_list.ADDRESS_ID = [TBXML textForElement:X_ADDRESS_ID];
                    
                    TBXMLElement* X_CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                    activity_list.CONTACT_ADDRESS = [TBXML textForElement:X_CONTACT_ADDRESS];
                    
                    TBXMLElement* X_CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                    activity_list.CONTACT_CELL_NUM = [TBXML textForElement:X_CONTACT_CELL_NUMBER];
                    
                    TBXMLElement* X_ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:table];
                    activity_list.ACTIVITY_PENDING_TYPE = [TBXML textForElement:X_ACTIVITY_PENDING_TYPE];
                    
                    TBXMLElement* X_ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
                    activity_list.ACTIVITY_ROW_ID = [TBXML textForElement:X_ACTIVITY_ID];
                    
                    TBXMLElement* X_PLANNED_START_DATE = [TBXML childElementNamed:@"PLANNED_START_DATE" parentElement:table];
                    activity_list.ACTIVITY_PLAN_START_DATE = [TBXML textForElement:X_PLANNED_START_DATE];
                    
                    TBXMLElement* X_ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"ACTIVITY_DESCRIPTION" parentElement:table];
                    activity_list.DESCRIPTION = [TBXML textForElement:X_ACTIVITY_DESCRIPTION];
                    
                    TBXMLElement* X_ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:table];
                    activity_list.ACTIVITY_STATUS = [TBXML textForElement:X_ACTIVITY_STATUS];
                    
                    TBXMLElement* X_PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                    activity_list.PRODUCT_LINE = [TBXML textForElement:X_PRODUCT_NAME];
                    
                    [Activities_ListArr addObject:activity_list];
                } while ((tuple = tuple->nextSibling));
                [self._tableView reloadData];
                NSLog(@"Counter.. Search %lu", (unsigned long)[Activities_ListArr count]);
                if (Activities_ListArr >= 0) {
                    [self._tableView setHidden:NO];
                    [self hideAlert];
                }
                else {
                    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                        
                        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                        
                        alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                        
                        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
            }
            else {
                [self hideAlert];
                if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No Activities Found in Search Criteria " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No Activities Found in Search Criteria " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No Activities Found in Search Criteria " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }
        }else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            
            if (Activities_ListArr) {
                [Activities_ListArr removeAllObjects];
            }
            
            
            TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            TBXMLElement *container = [TBXML childElementNamed:@"GetActivityBasedOnSearchCriteriaForDsmResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            
            
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
                
                do {
                    
                    activity_list = nil;
                    activity_list = [[Activity_List alloc]init];
                    
                    TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    
                    TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                    
                    activity_list.OPTY_NAME = [TBXML textForElement:OPTY_NAME];
                    NSLog(@"X_PROSPECT_SRC : %@",activity_list.OPTY_NAME);
                    
                    TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                    activity_list.OPTY_ID = [TBXML textForElement:OPTY_ID];
                    
                    TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                    activity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                    
                    TBXMLElement *PARENT_PRODUCT_NAME = [TBXML childElementNamed:@"PARENT_PRODUCT_NAME" parentElement:table];
                    activity_list.PARENT_PRODUCT_NAME = [TBXML textForElement:PARENT_PRODUCT_NAME];
                    
                    TBXMLElement *OPTY_CREATED = [TBXML childElementNamed:@"OPTY_CREATED" parentElement:table];
                    activity_list.OPTY_CREATED = [TBXML textForElement:OPTY_CREATED];
                    
                    TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"ACCOUNT_NAME" parentElement:table];
                    activity_list.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
                    
                    TBXMLElement *ACCOUNT_PHONE_NUMBER = [TBXML childElementNamed:@"ACCOUNT_PHONE_NUMBER" parentElement:table];
                    activity_list.ACCOUNT_PHONE_NUMBER = [TBXML textForElement:ACCOUNT_PHONE_NUMBER];
                    
                    TBXMLElement* X_ACCOUNT_TYPE = [TBXML childElementNamed:@"ACCOUNT_TYPE" parentElement:table];
                    activity_list.ACCOUNT_TYPE = [TBXML textForElement:X_ACCOUNT_TYPE];
                    
                    TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                    activity_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                    
                    TBXMLElement *SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                    activity_list.SALES_STAGE_NAME = [TBXML textForElement:SALES_STAGE_NAME];
                    
                    TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                    activity_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                    
                    TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                    activity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
                    
                    TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                    activity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
                    
                    
                    TBXMLElement *LEAD_ASSIGNED_POSITION_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_NAME" parentElement:table];
                    activity_list.LEAD_ASSIGNED_POSITION_NAME = [TBXML textForElement:LEAD_ASSIGNED_POSITION_NAME];
                    
                    TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                    activity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
                    
                    TBXMLElement *POSTN_TYPE_CD = [TBXML childElementNamed:@"POSTN_TYPE_CD" parentElement:table];
                    activity_list.POSTN_TYPE_CD = [TBXML textForElement:POSTN_TYPE_CD];
                    
                    TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                    activity_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                    
                    TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                    activity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                    
                    TBXMLElement *CONTACT_CELL_NUM = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                    activity_list.CONTACT_CELL_NUM = [TBXML textForElement:CONTACT_CELL_NUM];
                    
                    TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                    activity_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                    
                    TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
                    activity_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                    
                    TBXMLElement *ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:table];
                    activity_list.ACTIVITY_PENDING_TYPE = [TBXML textForElement:ACTIVITY_PENDING_TYPE];
                    
                    
                    TBXMLElement *ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
                    activity_list.ACTIVITY_ID = [TBXML textForElement:ACTIVITY_ID];
                    
                    TBXMLElement *PLANNED_START_DATE = [TBXML childElementNamed:@"PLANNED_START_DATE" parentElement:table];
                    activity_list.PLANNED_START_DATE = [TBXML textForElement:PLANNED_START_DATE];
                    
                    TBXMLElement *ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"ACTIVITY_DESCRIPTION" parentElement:table];
                    activity_list.ACTIVITY_DESCRIPTION = [TBXML textForElement:ACTIVITY_DESCRIPTION];
                    
                    TBXMLElement *ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:table];
                    activity_list.ACTIVITY_STATUS = [TBXML textForElement:ACTIVITY_STATUS];
                    
                    TBXMLElement *X_TALUKA = [TBXML childElementNamed:@"X_TALUKA" parentElement:table];
                    activity_list.X_TALUKA = [TBXML textForElement:X_TALUKA];
                    
                    
                    TBXMLElement *X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:table];
                    activity_list.X_PROSPECT_SRC = [TBXML textForElement:X_PROSPECT_SRC];
                    
                    RESULTCOUNT = activity_list.RESULT_COUNT;
                    [Activities_ListArr addObject:activity_list];
                    
                }while ((tuple = tuple->nextSibling));
                [self._tableView reloadData];
                NSLog(@"Counter.. Search %lu", (unsigned long)[Activities_ListArr count]);
                NSLog(@"\n\nshow result...... resultcount....%@",RESULTCOUNT);
                NSLog(@"\n resultcount...... %u ",(unsigned)Activities_ListArr.count);
                if (Activities_ListArr >= 0) {
                    [self._tableView setHidden:NO];
                    [self hideAlert];
                }
            }
        }else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            
            
            
            [self hideAlert];
            
            
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No Activities Found in Search Criteria " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
            //
            //
            //
            //
            //
            //            if (Activities_ListArr) {
            //                [Activities_ListArr removeAllObjects];
            //            }
            //
            //            /*
            //             <SOAP:Body>
            //             <GetActivityBasedOnSearchCriteriaForDsmResponse xmlns="com.cordys.tatamotors.Dsmsiebelwsapp" preserveSpace="no" qAccess="0">
            //             <tuple>
            //             <old>
            //             <S_OPTY_POSTN>
            //             <OPTY_NAME>1-7GOXHPC</OPTY_NAME>
            //             <OPTY_ID>1-7GOXHPC</OPTY_ID>
            //             <PRODUCT_NAME>Ace HT_Old</PRODUCT_NAME>
            //             <PARENT_PRODUCT_NAME>Ace HT PPL</PARENT_PRODUCT_NAME>
            //             <OPTY_CREATED>03-NOV-2015</OPTY_CREATED>
            //             <ACCOUNT_NAME>TEST RR 15.11</ACCOUNT_NAME>
            //             <ACCOUNT_PHONE_NUMBER>8419980020</ACCOUNT_PHONE_NUMBER>
            //             <ACCOUNT_TYPE xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
            //             <ACCOUNT_ID>1-7GOVZ9T</ACCOUNT_ID>
            //             <SALES_STAGE_NAME>Closed Lost at C2</SALES_STAGE_NAME>
            //             <SALE_STAGE_UPDATED_DATE>03-NOV-2015</SALE_STAGE_UPDATED_DATE>
            //             <LEAD_ASSIGNED_NAME>JIGNA JOSHI</LEAD_ASSIGNED_NAME>
            //             <LEAD_ASSIGNED_CELL_NUMBER>9999999999</LEAD_ASSIGNED_CELL_NUMBER>
            //             <LEAD_ASSIGNED_POSITION_NAME>TMCV-Sal-W-MUM-1001680-Nerul-LCV-DSE-21</LEAD_ASSIGNED_POSITION_NAME>
            //             <LEAD_ASSIGNED_POSITION_ID>1-1LQFGP</LEAD_ASSIGNED_POSITION_ID>
            //             <POSTN_TYPE_CD>DSE</POSTN_TYPE_CD>
            //             <CONTACT_NAME>SUSHANT YADAV</CONTACT_NAME>
            //             <CONTACT_ID>1-7GOVZ9N</CONTACT_ID>
            //             <ADDRESS_ID>1-7GOVZ9R</ADDRESS_ID>
            //             <CONTACT_ADDRESS>A-450,SIABABAA ASHIRWAD COMPLEX SEC- 1E</CONTACT_ADDRESS>
            //             <CONTACT_CELL_NUMBER>9892251446</CONTACT_CELL_NUMBER>
            //             <ACTIVITY_PENDING_TYPE>Papers Submitted</ACTIVITY_PENDING_TYPE>
            //             <ACTIVITY_ID>1-7GOXHQB</ACTIVITY_ID>
            //             <PLANNED_START_DATE>03-NOV-2015 17:31:07</PLANNED_START_DATE>
            //             <ACTIVITY_DESCRIPTION xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
            //             <ACTIVITY_STATUS>Done</ACTIVITY_STATUS>
            //             <X_TALUKA xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
            //             <X_PROSPECT_SRC xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
            //             <X_DISTRICT>HYDERABAD</X_DISTRICT>
            //             <INFLUENCER xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
            //             </S_OPTY_POSTN>
            //             </old>
            //             </tuple>
            //             */
            //
            //
            //            TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            //            TBXMLElement *container = [TBXML childElementNamed:@"GetSFAActivityBasedOnSearchCriteriaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            //
            //
            //            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            //            //   TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
            //            //       TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
            //            if (tuple)
            //            {
            //                //        TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
            //                //        TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
            //                do {
            //                    TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
            //                    TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
            //                    activity_list = nil;
            //                    activity_list = [[Activity_List alloc]init];
            //
            //                    // TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            //
            //                    TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPPTY_NAME" parentElement:TABLE];
            //
            //                    activity_list.OPPTY_NAME = [TBXML textForElement:OPTY_NAME];
            //                    // NSLog(@"X_PROSPECT_SRC : %@",searchActivity_list.OPTY_NAME);
            //
            //
            //                    TBXMLElement *OPPTY_ROWID = [TBXML childElementNamed:@"OPPTY_ROWID" parentElement:TABLE];
            //                    activity_list.OPPTY_ROWID = [TBXML textForElement:OPPTY_ROWID];
            //                    //   NSLog(@"searchActivity_list.OPTY_ID: %@",searchActivity_list.OPTY_ID);
            //
            //                    //            TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:TABLE];
            //                    //            searchActivity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
            //
            //                    TBXMLElement *PARENT_PRODUCT_NAME = [TBXML childElementNamed:@"PARENT_PRODUCT_NAME" parentElement:TABLE];
            //                    activity_list.PARENT_PRODUCT_NAME = [TBXML textForElement:PARENT_PRODUCT_NAME];
            //
            //
            //                    TBXMLElement *OPTY_CREAT_DATE = [TBXML childElementNamed:@"OPTY_CREAT_DATE" parentElement:TABLE];
            //                    activity_list.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREAT_DATE];
            //
            //                    TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"ACCOUNT_NAME" parentElement:TABLE];
            //                    activity_list.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
            //
            //                    TBXMLElement *ACCOUNT_PHONE_NUMBER = [TBXML childElementNamed:@"ACCOUNT_PHONE_NUMBER" parentElement:TABLE];
            //                    activity_list.ACCOUNT_PHONE_NUMBER = [TBXML textForElement:ACCOUNT_PHONE_NUMBER];
            //
            //
            //                    TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:TABLE];
            //                    activity_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
            //
            //                    TBXMLElement *SALE_STAGE = [TBXML childElementNamed:@"SALE_STAGE" parentElement:TABLE];
            //                    activity_list.SALE_STAGE = [TBXML textForElement:SALE_STAGE];
            //
            //                    TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALES_STAGE_DATE" parentElement:TABLE];
            //                    activity_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
            //
            //
            //
            //
            //                    TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:TABLE];
            //                    activity_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
            //
            //                    TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:TABLE];
            //                    activity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
            //
            //                    TBXMLElement *CONTACT_CELL_NUM = [TBXML childElementNamed:@"CONTACT_CELL_NUM" parentElement:TABLE];
            //                    activity_list.CONTACT_CELL_NUM = [TBXML textForElement:CONTACT_CELL_NUM];
            //
            //                    TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:TABLE];
            //                    activity_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
            //
            //                    TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:TABLE];
            //                    activity_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
            //
            //                    //            TBXMLElement *ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:TABLE];
            //                    //            searchActivity_list.ACTIVITY_PENDING_TYPE = [TBXML textForElement:ACTIVITY_PENDING_TYPE];
            //
            //
            //                    TBXMLElement *ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ROW_ID" parentElement:TABLE];
            //                    activity_list.ACTIVITY_ROW_ID = [TBXML textForElement:ACTIVITY_ID];
            //                    NSLog(@"searchActivity_list.OPTY_ID: %@",activity_list.ACTIVITY_ROW_ID);
            //
            //
            //
            //                    TBXMLElement *PLANNED_START_DATE = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DATE" parentElement:TABLE];
            //                    activity_list.ACTIVITY_PLAN_START_DATE = [TBXML textForElement:PLANNED_START_DATE];
            //
            //                    TBXMLElement *ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"DESCRIPTION" parentElement:TABLE];
            //                    activity_list.DESCRIPTION = [TBXML textForElement:ACTIVITY_DESCRIPTION];
            //
            //                    TBXMLElement *ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:TABLE];
            //                    activity_list.ACTIVITY_STATUS = [TBXML textForElement:ACTIVITY_STATUS];
            //
            //                    //            TBXMLElement *X_TALUKA = [TBXML childElementNamed:@"X_TALUKA" parentElement:TABLE];
            //                    //            searchActivity_list.X_TALUKA = [TBXML textForElement:X_TALUKA];
            //
            //
            //                    TBXMLElement *X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:TABLE];
            //                    activity_list.X_PROSPECT_SRC = [TBXML textForElement:X_PROSPECT_SRC];
            //
            //
            //                    TBXMLElement *ACCOUNT_LOCATION = [TBXML childElementNamed:@"ACCOUNT_LOCATION" parentElement:TABLE];
            //                    activity_list.ACCOUNT_LOCATION = [TBXML textForElement:ACCOUNT_LOCATION];
            //
            //                    TBXMLElement *ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:TABLE];
            //                    activity_list.ACTIVITY_TYPE = [TBXML textForElement:ACTIVITY_TYPE];
            //
            //
            //
            //
            //                    TBXMLElement *ACTIVITY_COMPLETION_DATE = [TBXML childElementNamed:@"ACTIVITY_COMPLETION_DATE" parentElement:TABLE];
            //                    activity_list.ACTIVITY_COMPLETION_DATE = [TBXML textForElement:ACTIVITY_COMPLETION_DATE];
            //
            //                    TBXMLElement *PRODUCT_LINE = [TBXML childElementNamed:@"PRODUCT_LINE" parentElement:TABLE];
            //                    activity_list.PRODUCT_LINE = [TBXML textForElement:PRODUCT_LINE];
            //                    TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:TABLE];
            //                    activity_list.VC = [TBXML textForElement:VC];
            //
            //                    TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:TABLE];
            //                    activity_list.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
            //
            //
            //
            //                    RESULTCOUNT = activity_list.RESULT_COUNT;
            //
            //                    [Activities_ListArr addObject:activity_list];
            //                    //[appdelegate.ActivityList addObject:activity_list];
            //
            //                    // tuple= tuple->nextSibling;
            //                }
            //                while ((tuple = tuple->nextSibling));
            //
            //                [self._tableView reloadData];
            //                NSLog(@"Counter.. Search %lu", (unsigned long)[Activities_ListArr count]);
            //                NSLog(@"\n\nshow result...... resultcount....%@",RESULTCOUNT);
            //                NSLog(@"\n resultcount...... %u ",(unsigned)Activities_ListArr.count);
            //                if (Activities_ListArr >= 0) {
            //                    [self._tableView setHidden:NO];
            //                    [self hideAlert];
            //                }
            //
            //
            //
            //
            //            }
            //           // [self CallSearch1];
            
            
        }
    }
}

-(void)CallSearch1
{
    
    NSString * envelopeText =[NSString stringWithFormat:
                              @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                              @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                              @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                              @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                              @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                              @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                              @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                              @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e53d-0391e62b1f10</DC>"
                              @"</Logger>"
                              @"</header>"
                              @"</SOAP:Header>"
                              @"<SOAP:Body>"
                              @"<GetActivityBasedOnSearchCriteriaForDsm xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                              @"<positionid>%@</positionid>"
                              @"<fromdate>%@</fromdate>"
                              @"<todate>%@</todate>"
                              @"<activitytype></activitytype>"
                              @"<activitystatus></activitystatus>"
                              @"<assignedperson />"
                              @"<tehsilname></tehsilname>"
                              @"<pplname></pplname>"
                              @"<dsepositionid></dsepositionid>"
                              @"</GetActivityBasedOnSearchCriteriaForDsm>"
                              @"</SOAP:Body>"
                              @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,self.FromDate,self.Todate];
    
    
    NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<PPLName>%@</PPLName>"
                               @"<fromdate>%@</fromdate>"
                               @"<todate>%@</todate>"
                               @"<activitystatus>%@</activitystatus>"
                               @"<activitytype>%@</activitytype>"
                               @"<rang1>1</rang1>"
                               @"<rang2>%@</rang2>"
                               @"<attr1></attr1>"
                               @"<attr2></attr2>"
                               @"<attr3></attr3>"
                               @"<salestage></salestage>"
                               @"</GetSFAActivityBasedOnSearchCriteria>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,ppl,self.FromDate,self.Todate,self.Status,self.ActivityType,RESULTCOUNT];
    
    
    
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"SearchActivities_Connection1"];
    
    // }
}
-(void)searchActivities_Found1:(NSNotification*)notification
{
    [self hideAlert];//Abhishek
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityType_Found1 response... %@ ",response);
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
        
        if (Activities_ListArr) {
            [Activities_ListArr removeAllObjects];
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetSFAActivityBasedOnSearchCriteriaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        
        
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        
        if(tuple)
        {
            
            
            do {
                TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
                TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
                activity_list = nil;
                activity_list = [[Activity_List alloc]init];
                
                // TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPPTY_NAME" parentElement:TABLE];
                
                activity_list.OPPTY_NAME = [TBXML textForElement:OPTY_NAME];
                
                
                //NSLog(@"X_PROSPECT_SRC : %@",searchActivity_list.OPTY_NAME);
                
                
                
                
                TBXMLElement *OPPTY_ROWID = [TBXML childElementNamed:@"OPPTY_ROWID" parentElement:TABLE];
                activity_list.OPPTY_ROWID = [TBXML textForElement:OPPTY_ROWID];
                NSLog(@"searchActivity_list.OPTY_ID: %@",activity_list.OPPTY_ROWID);
                
                //            TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:TABLE];
                //            searchActivity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                
                TBXMLElement *PARENT_PRODUCT_NAME = [TBXML childElementNamed:@"PARENT_PRODUCT_NAME" parentElement:TABLE];
                activity_list.PARENT_PRODUCT_NAME = [TBXML textForElement:PARENT_PRODUCT_NAME];
                
                
                TBXMLElement *OPTY_CREAT_DATE = [TBXML childElementNamed:@"OPTY_CREAT_DATE" parentElement:TABLE];
                activity_list.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREAT_DATE];
                
                TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"ACCOUNT_NAME" parentElement:TABLE];
                activity_list.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
                
                TBXMLElement *ACCOUNT_PHONE_NUMBER = [TBXML childElementNamed:@"ACCOUNT_PHONE_NUMBER" parentElement:TABLE];
                activity_list.ACCOUNT_PHONE_NUMBER = [TBXML textForElement:ACCOUNT_PHONE_NUMBER];
                
                
                TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:TABLE];
                activity_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                
                TBXMLElement *SALE_STAGE = [TBXML childElementNamed:@"SALE_STAGE" parentElement:TABLE];
                activity_list.SALE_STAGE = [TBXML textForElement:SALE_STAGE];
                
                TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALES_STAGE_DATE" parentElement:TABLE];
                activity_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                
                TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:TABLE];
                activity_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                
                TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:TABLE];
                activity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                
                TBXMLElement *CONTACT_CELL_NUM = [TBXML childElementNamed:@"CONTACT_CELL_NUM" parentElement:TABLE];
                activity_list.CONTACT_CELL_NUM = [TBXML textForElement:CONTACT_CELL_NUM];
                
                TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:TABLE];
                activity_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                
                TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:TABLE];
                activity_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                
                //            TBXMLElement *ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:TABLE];
                //            searchActivity_list.ACTIVITY_PENDING_TYPE = [TBXML textForElement:ACTIVITY_PENDING_TYPE];
                
                
                TBXMLElement *ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ROW_ID" parentElement:TABLE];
                activity_list.ACTIVITY_ROW_ID = [TBXML textForElement:ACTIVITY_ID];
                NSLog(@"searchActivity_list.OPTY_ID: %@",[TBXML textForElement:ACTIVITY_ID]);
                
                TBXMLElement *PLANNED_START_DATE = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DATE" parentElement:TABLE];
                activity_list.ACTIVITY_PLAN_START_DATE = [TBXML textForElement:PLANNED_START_DATE];
                
                TBXMLElement *ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"DESCRIPTION" parentElement:TABLE];
                activity_list.DESCRIPTION = [TBXML textForElement:ACTIVITY_DESCRIPTION];
                
                TBXMLElement *ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:TABLE];
                activity_list.ACTIVITY_STATUS = [TBXML textForElement:ACTIVITY_STATUS];
                
                //            TBXMLElement *X_TALUKA = [TBXML childElementNamed:@"X_TALUKA" parentElement:TABLE];
                //            searchActivity_list.X_TALUKA = [TBXML textForElement:X_TALUKA];
                
                
                TBXMLElement *X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:TABLE];
                activity_list.X_PROSPECT_SRC = [TBXML textForElement:X_PROSPECT_SRC];
                
                
                TBXMLElement *ACCOUNT_LOCATION = [TBXML childElementNamed:@"ACCOUNT_LOCATION" parentElement:TABLE];
                activity_list.ACCOUNT_LOCATION = [TBXML textForElement:ACCOUNT_LOCATION];
                
                TBXMLElement *ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:TABLE];
                activity_list.ACTIVITY_TYPE = [TBXML textForElement:ACTIVITY_TYPE];
                //            TBXMLElement *ACTIVITY_CREATED_DATE = [TBXML childElementNamed:@"ACTIVITY_CREATED_DATE" parentElement:TABLE];
                //            searchActivity_list.activity_c= [TBXML textForElement:ACTIVITY_CREATED_DATE];
                
                TBXMLElement *ACTIVITY_COMPLETION_DATE = [TBXML childElementNamed:@"ACTIVITY_COMPLETION_DATE" parentElement:TABLE];
                activity_list.ACTIVITY_COMPLETION_DATE = [TBXML textForElement:ACTIVITY_COMPLETION_DATE];
                
                TBXMLElement *PRODUCT_LINE = [TBXML childElementNamed:@"PRODUCT_LINE" parentElement:TABLE];
                activity_list.PRODUCT_LINE = [TBXML textForElement:PRODUCT_LINE];
                TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:TABLE];
                activity_list.VC = [TBXML textForElement:VC];
                
                TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:TABLE];
                activity_list.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
                
                
                
                RESULTCOUNT = activity_list.RESULT_COUNT;
                
                [Activities_ListArr addObject:activity_list];
                // [appdelegate.ActivityList addObject:searchActivity_list];
                
                
            }
            while ((tuple = tuple->nextSibling));
            [self hideAlert];
            //ActivityListViewController* activityListViewController_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityListViewController"];
            // searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
            
            //    activityListViewController_VC. =txtSalesStage.text;
            //    searchOpportunityResult_VC.txtFromDate=txtFromDate.text;
            //    searchOpportunityResult_VC.txtToDate=txtToDate.text;
            
            //[self.navigationController pushViewController:activityListViewController_VC animated:YES];
        }
        else
        {
            [self hideAlert];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"No activities Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        NSLog(@"\n\nshow result...... resultcount....%@",RESULTCOUNT);
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
@end
