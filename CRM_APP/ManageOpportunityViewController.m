//
//  ManageOpportunityViewController.m
//  CRM_APP
//
//  Created by admin on 23/09/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import "ManageOpportunityViewController.h"
#import "ManageOpportunity_ViewCell.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "RequestDelegate.h"
#import "Opportunity_List.h"
#import "TBXML.h"
#import "MBProgressHUD.h"
#import "ManageOpportunity_ViewCell.h"
#import "OpportunityDetailsViewController.h"
#import "DSE.h"
#import "DSM.h"


@interface ManageOpportunityViewController ()
{
    UIAlertView *alert;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive,hostActive;
    NSArray *datearray;
    NSString *optycreationdate,*date,*time,*stringdate;
    NSMutableArray *optydate,*datens;
    NSArray* drafts;
    
    
}
@end

@implementation ManageOpportunityViewController
@synthesize tbl_opportunity;
@synthesize ResultCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showAlert];
    NSLog(@"Manage Opportunity :");
    [tbl_opportunity setHidden:YES];
    self.tbl_opportunity.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
    self.splitViewController.delegate = self;
    self.masterPopoverController.delegate=self;
    UIBarButtonItem *barButtonItem = self.splitViewController.displayModeButtonItem;
    barButtonItem.title = @"Show master";
    self.navigationItem.leftBarButtonItem = barButtonItem;
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    NSLog(@"Samlp Art Master: %@",appdelegate.artifact);
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"Samlp Art Master: %@",userDetailsVal_.ROW_ID);
    
     appdelegate.flagget=0;
    
    
    if (![self connected])
    {
        [tbl_opportunity setHidden:YES];
        NSLog(@"Newtwork not Available...");
        alert=[[UIAlertView alloc]initWithTitle:@"CRM" message :@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        self.tbl_opportunity.delegate = self;
        self.tbl_opportunity.dataSource = self;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DSM"
                                              inManagedObjectContext:appdelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
   drafts = [appdelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"count value %lu",(unsigned long)[drafts count]);
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self CallOpportunityList];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OpportunityList_Found:) name:@"OpportunityList_Found" object:nil];
    
    [super viewWillAppear:animated];
    self.splitViewController.delegate = self;
    UIBarButtonItem *barButtonItem = self.splitViewController.displayModeButtonItem;
    barButtonItem.title = @"Show master";
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"OpportunityList_Found" object:nil];//Gomzy // For opportunity Count
    
    NSLog(@"End1");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return OpportunityList_ArrList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // in your case, there are 3 cells
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    opportunity_list = [OpportunityList_ArrList objectAtIndex:indexPath.row ];
    
    
    NSLog(@"Row Selected ... %ld",(long)indexPath.row);
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    opportunity_list = nil;
    opportunity_list = [[Opportunity_List alloc]init];
    opportunity_list = [OpportunityList_ArrList objectAtIndex:indexPath.row];
    NSLog(@"...Print . %@",OpportunityList_ArrList);
    
    static NSString *MyIdentifier = @"Manage_Cell";
    
    ManageOpportunity_ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[ManageOpportunity_ViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor=[UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.manage_main_view.layer setBorderColor:[UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor];
    [cell.manage_main_view.layer setBorderWidth:2.0f];
    cell.manage_main_view.layer.cornerRadius=5;
    
    
    cell.lbl_productname.text=opportunity_list.PRODUCT_NAME;
    cell.lbl_salesstage.text=opportunity_list.SALE_STAGE_NAME;
    cell.lbl_customername.text=opportunity_list.CONTACT_NAME;
    cell.lbl_customercellno.text=opportunity_list.CONTACT_CELL_NUMBER;
    cell.lbl_optycreationdate.text=opportunity_list.OPTY_CREAT_DATE;
    cell.lbl_lastpendingactivity.text=opportunity_list.LAST_PENDING_ACTIVITY_TYPE;
    
    if (cell.lbl_productname.text.length==0 ) {
        
        cell.lbl_productname.text=@"Not Available";
        
        
    }
    if (cell.lbl_salesstage.text.length==0 ) {
        
        
        cell.lbl_salesstage.text=@"Not Available";
        
        
    }
    
    if (cell.lbl_customername.text.length==0 ) {
        
        
        
        cell.lbl_customername.text=@"Not Available";
        
        
        
    }
    if (cell.lbl_customercellno.text.length==0 ) {
        
        
        cell.lbl_customercellno.text=@"Not Available";
        
        
    }
    if (cell.lbl_optycreationdate.text.length==0 ) {
        
        cell.lbl_optycreationdate.text=@"Not Available";
        
    }
    if (cell.lbl_lastpendingactivity.text.length==0 ) {
        
        cell.lbl_lastpendingactivity.text=@"Not Available";
        
    }
    return cell;
    
}



// Internet check code :
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}
-(void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            self->internetActive = NO;
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            self->internetActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            self->internetActive = YES;
            
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            self->hostActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            self->hostActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            self->hostActive = YES;
            
            break;
        }
    }
}

-(void)info_btn
{
    
    [self performSegueWithIdentifier:@"infoView" sender:self];
    
}
-(void)logOut_btn
{
    
    alert = [[UIAlertView alloc] initWithTitle:@""
                                       message:@"Are you sure you want to Logout ?"
                                      delegate:self
                             cancelButtonTitle:@"No"
                             otherButtonTitles:@"Yes",nil];
    [alert show];
}


-(void)CallOpportunityList
{
    
    NSLog(@"inside...List of opportunity %@",userDetailsVal_.POSTN);
    NSString * envelopeText ;
    if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
        NSLog(@"NDRM Opportunuty List");
        
        envelopeText = [NSString stringWithFormat:
                        @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        @"<SOAP:Body>"
                        @"<GetListOfOpportunityNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                        @"<positionid>%@</positionid>"
                        @"<position_name></position_name>"
                        @"<businessname></businessname>"
                        @"</GetListOfOpportunityNeev>"
                        @"</SOAP:Body>"
                        @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
        
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSM"])
        
    {
        NSLog(@"DSM Opportunuty List");
        
        
      /*  envelopeText =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                       @"<SOAP:Body>"
                       @"<bpmLast7daysoptyListAndDetails xmlns=\"http://schemas.cordys.com/default\">"
                       @"<POSITIONID>1-70Z</POSITIONID>"
                       @"</bpmLast7daysoptyListAndDetails>"
                       @"</SOAP:Body>"
                       @"</SOAP:Envelope>"];*/
        
        NSLog(@"request%@",envelopeText);
        
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
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e713-b975c163dd4a</DC>"
                               @"</Logger>"
                               @"</header>"
                               @"</SOAP:Header>"
                               @"<SOAP:Body>"
                               @"<SearchOptyforLast7daysDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"</SearchOptyforLast7daysDSM>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
        
        
        
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSE"]){
        
        
        
        
        NSLog(@"DSE Opportunuty List");
        
        envelopeText =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                       @"  <SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                       @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                       @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e4a1-376f7691964d</DC>"
                       @"</Logger>"
                       @"</header>"
                       @"</SOAP:Header>"
                       @"<SOAP:Body>"
                       @"<GetListOfOpportunitySFA xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                       @"<positionid>%@</positionid>"
                       @" <position_name />"
                       @"<businessname />"
                       @"<rang1>1</rang1>"
                       @"<rang2>15</rang2>"
                       @"</GetListOfOpportunitySFA>"
                       @"</SOAP:Body>"
                       @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
        
    }
    NSLog(@"\n envlopeString Of OPP!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSLog(@"Request.... %@",request);
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"getListofOpportunity"];
    
}
-(void)OpportunityList_Found:(NSNotification*)notification
{
    OpportunityList_ArrList=[[NSMutableArray alloc] init];
    OpportunityListDisplayArr=[[NSMutableArray alloc] init];
    
    if(OpportunityList_ArrList)
    {
        
    }
    NSError *err;
    int i = 0;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n List of Opportunity Response %@ ",response);
    if ([response isEqual:@""])
    {
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Something gone wrong . Please try agin" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([@"SearchOpptyBasedOnCriteriaResponse" isEqual:@""]){
        
    }
    else
    {
        
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            
            
            TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            TBXMLElement *container = [TBXML childElementNamed:@"GetListOfOpportunityNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            if (OpportunityList_ArrList)
            {
                [ OpportunityList_ArrList removeAllObjects];
            }
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
                [self.tbl_opportunity setHidden:NO];
                
                do {
                    
                    
                    opportunity_list = nil;
                    opportunity_list = [[Opportunity_List alloc]init];
                    
                    TBXMLElement *table  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    
                    TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                    opportunity_list.OPTY_ID = [TBXML textForElement:OPTY_ID];
                    NSLog(@"OptyID Opty Id : %@",opportunity_list.OPTY_ID);
                    
                    TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                    opportunity_list.OPTY_NAME = [TBXML textForElement:OPTY_NAME];
                    NSLog(@"OptyNAme : %@",opportunity_list.OPTY_NAME);
                    
                    
                    TBXMLElement *OPTY_CREATED_DATE = [TBXML childElementNamed:@"OPTY_CREATED_DATE" parentElement:table];
                    opportunity_list.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREATED_DATE];
                    NSLog(@"OptyNAme : %@",opportunity_list.OPTY_CREAT_DATE);
                    
                    
                    TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                    opportunity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                    NSLog(@"OptyNAme : %@",opportunity_list.PRODUCT_NAME);
                    
                    
                    TBXMLElement *PRODUCT_ID = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:table];
                    opportunity_list.PRODUCT_ID = [TBXML textForElement:PRODUCT_ID];
                    NSLog(@"OptyNAme : %@",opportunity_list.PRODUCT_ID);
                    
                    
                    TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:table];
                    opportunity_list.VC = [TBXML textForElement:VC];
                    NSLog(@"OptyNAme : %@",opportunity_list.VC);
                    
                    
                    TBXMLElement *TGM_TKM_NAME = [TBXML childElementNamed:@"TGM_TKM_NAME" parentElement:table];
                    opportunity_list.TGM_TKM_NAME = [TBXML textForElement:TGM_TKM_NAME];
                    NSLog(@"OptyNAme : %@",opportunity_list.TGM_TKM_NAME);
                    
                    
                    TBXMLElement *TGM_TKM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_TKM_PHONE_NUMBER" parentElement:table];
                    opportunity_list.TGM_TKM_PHONE_NUMBER = [TBXML textForElement:TGM_TKM_PHONE_NUMBER];
                    NSLog(@"OptyNAme : %@",opportunity_list.TGM_TKM_PHONE_NUMBER);
                    
                    
                    TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                    opportunity_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                    NSLog(@"OptyNAme : %@",opportunity_list.ACCOUNT_ID);
                    
                    
                    TBXMLElement *ACCOUNT_TYPE = [TBXML childElementNamed:@"ACCOUNT_TYPE" parentElement:table];
                    opportunity_list.ACCOUNT_TYPE = [TBXML textForElement:ACCOUNT_TYPE];
                    NSLog(@"OptyNAme : %@",opportunity_list.ACCOUNT_TYPE);
                    
                    
                    TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                    opportunity_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                    NSLog(@"OptyNAme : %@",opportunity_list.SALES_STAGE_DATE);
                    
                    
                    TBXMLElement *SALE_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                    opportunity_list.SALE_STAGE_NAME = [TBXML textForElement:SALE_STAGE_NAME];
                    NSLog(@"OptyNAme : %@",opportunity_list.SALE_STAGE_NAME);
                    
                    
                    TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                    opportunity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
                    
                    
                    TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                    opportunity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
                    
                    TBXMLElement *LEAD_POSITION = [TBXML childElementNamed:@"LEAD_POSITION" parentElement:table];
                    opportunity_list.LEAD_POSITION = [TBXML textForElement:LEAD_POSITION];
                    
                    TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                    opportunity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
                    
                    TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                    opportunity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                    
                    TBXMLElement *CONTACT_FIRST_NAME = [TBXML childElementNamed:@"CONTACT_FIRST_NAME" parentElement:table];
                    opportunity_list.CONTACT_FIRST_NAME = [TBXML textForElement:CONTACT_FIRST_NAME];
                    
                    TBXMLElement *CONTACT_LAST_NAME = [TBXML childElementNamed:@"CONTACT_LAST_NAME" parentElement:table];
                    opportunity_list.CONTACT_LAST_NAME = [TBXML textForElement:CONTACT_LAST_NAME];
                    
                    
                    TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                    opportunity_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                    
                    TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                    opportunity_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                    
                    TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
                    opportunity_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                    
                    TBXMLElement *CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                    opportunity_list.CONTACT_CELL_NUMBER = [TBXML textForElement:CONTACT_CELL_NUMBER];
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_TYPE = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_TYPE" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_TYPE = [TBXML textForElement:LAST_PENDING_ACTIVITY_TYPE];
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_ID = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_ID" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_ID = [TBXML textForElement:LAST_PENDING_ACTIVITY_ID];
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_STATUS = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_STATUS" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_STATUS = [TBXML textForElement:LAST_PENDING_ACTIVITY_STATUS];
                    
                    
                    TBXMLElement *LAST_PEND_ACTIVIY_START_DATE = [TBXML childElementNamed:@"LAST_PEND_ACTIVIY_START_DATE" parentElement:table];
                    opportunity_list.LAST_PEND_ACTIVIY_START_DATE = [TBXML textForElement:LAST_PEND_ACTIVIY_START_DATE];
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_DESC = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_DESC" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_DESC = [TBXML textForElement:LAST_PENDING_ACTIVITY_DESC];
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_ID = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_ID" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_ID = [TBXML textForElement:LAST_DONE_ACTIVITY_ID];
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_DATE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DATE" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_DATE = [TBXML textForElement:LAST_DONE_ACTIVITY_DATE];
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_DESC = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DESC" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_DESC = [TBXML textForElement:LAST_DONE_ACTIVITY_DESC];
                    /*
                     TBXMLElement *X_TALUKA = [TBXML childElementNamed:@"X_TALUKA" parentElement:table];
                     opportunity_list.X_TALUKA = [TBXML textForElement:X_TALUKA];
                     */
                    TBXMLElement *PRODUCT_NAME1 = [TBXML childElementNamed:@"PRODUCT_NAME1" parentElement:table];
                    opportunity_list.PRODUCT_NAME1 = [TBXML textForElement:PRODUCT_NAME1];
                    
                    TBXMLElement *CUSTOMER_ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                    opportunity_list.CUSTOMER_ACCOUNT_NAME = [TBXML textForElement:CUSTOMER_ACCOUNT_NAME];
                    
                    TBXMLElement *CUSTOMER_ACCOUNT_ID = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_ID" parentElement:table];
                    opportunity_list.CUSTOMER_ACCOUNT_ID = [TBXML textForElement:CUSTOMER_ACCOUNT_ID];
                    
                    TBXMLElement *REV_PRODUCT_ID = [TBXML childElementNamed:@"REV_PRODUCT_ID" parentElement:table];
                    opportunity_list.REV_PRODUCT_ID = [TBXML textForElement:REV_PRODUCT_ID];
                    
                    
                    [OpportunityList_ArrList addObject:opportunity_list];
                    
                    
                } while ((tuple = tuple->nextSibling));
                NSLog(@"\nOpportunityListDisplayArr......%lu",(unsigned long)[OpportunityList_ArrList count]);
                
                if([OpportunityList_ArrList count]>0)
                {
                    [self hideAlert];
                    [self.tbl_opportunity reloadData];
                    
                }
            }
            else
            {
                [self hideAlert];
                [self.tbl_opportunity setHidden:YES];
                alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No opportunities found for last 7 days" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
            }
        }else if ([userDetailsVal_.POSTN isEqual:@"DSM"]){
            
            NSLog(@"User Postion :%@",userDetailsVal_.POSTN);
            TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            TBXMLElement *container = [TBXML childElementNamed:@"SearchOptyforLast7daysDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            if (OpportunityList_ArrList)
            {
                [ OpportunityList_ArrList removeAllObjects];
            }
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
                [self.tbl_opportunity setHidden:NO];
                do {
                    opportunity_list = nil;
                    opportunity_list = [[Opportunity_List alloc]init];
                    
                    TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    
                    TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                    opportunity_list.OPTY_ID = [TBXML textForElement:OPTY_ID];
                    
                    
                    NSLog(@"OptyID : %@",opportunity_list.OPTY_ID);
                    
                    
                    TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                    opportunity_list.OPTY_NAME = [TBXML textForElement:OPTY_NAME];
                    
                    
                    TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                    opportunity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                    
                    
                    TBXMLElement *OPTY_CREATED_DATE = [TBXML childElementNamed:@"OPTY_CREATED_DATE" parentElement:table];
                    opportunity_list.OPTY_CREAT_DATE= [TBXML textForElement:OPTY_CREATED_DATE];
                    NSLog(@"opty creation date %@",opportunity_list.OPTY_CREAT_DATE);
                    
                    
                    
                    TBXMLElement *SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                    opportunity_list.SALE_STAGE_NAME = [TBXML textForElement:SALES_STAGE_NAME];
                    
                    
                    TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                    opportunity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                    
                    NSLog(@"OptyID : %@",opportunity_list.CONTACT_NAME);
                    
                    
                    
                    TBXMLElement *CUSTOMER_ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                    opportunity_list.CUSTOMER_ACCOUNT_NAME = [TBXML textForElement:CUSTOMER_ACCOUNT_NAME];
                    
                    NSLog(@"ACCOUNT : %@",opportunity_list.CUSTOMER_ACCOUNT_NAME);
                    
                    
                    
                    TBXMLElement *CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                    opportunity_list.CONTACT_CELL_NUMBER = [TBXML textForElement:CONTACT_CELL_NUMBER];
                    
                    NSLog(@"contact no : %@",opportunity_list.CONTACT_CELL_NUMBER);
                    
                    datearray = [opportunity_list.OPTY_CREAT_DATE  componentsSeparatedByString:@"T"];
                    
                    date= [datearray objectAtIndex: 0];
                    
                    time= [datearray objectAtIndex: 1];
                    
                    
                    NSLog(@"split date and time : %@",date);
                    
                    [datens addObject:date];
                    
                    NSLog(@"opty date array %@",datens);
                    
                    i++;
                    
                    NSLog(@"\n test opp.... %d!!!\n",i);
                    
                    [OpportunityList_ArrList addObject:opportunity_list];
                    
                    
                } while ((tuple = tuple->nextSibling));
                NSLog(@"\nOpportunityListDisplayArr......%d",[OpportunityList_ArrList count]);
                if([OpportunityList_ArrList count]>0)
                {
                    [self hideAlert];
                    [self.tbl_opportunity reloadData];
                    
                }
            }
            else
            {
                [self hideAlert];
                [self.tbl_opportunity setHidden:YES];
                alert=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"No opportunities found"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }else if ([userDetailsVal_.POSTN isEqual:@"DSE"]){
            
            
             [self hideAlert];
            TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            TBXMLElement *container = [TBXML childElementNamed:@"GetListOfOpportunitySFAResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            if (OpportunityList_ArrList)
            {
                [ OpportunityList_ArrList removeAllObjects];
            }
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
                [self.tbl_opportunity setHidden:NO];
                
                do {
                    
                    opportunity_list = nil;
                    opportunity_list = [[Opportunity_List alloc]init];
                    
                    TBXMLElement *table  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    
                    TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                    opportunity_list.OPTY_ID = [TBXML textForElement:OPTY_ID];
                    
                    TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                    opportunity_list.OPTY_NAME = [TBXML textForElement:OPTY_NAME];
                    NSLog(@"OptyID : %@",opportunity_list.OPTY_ID);
                    
                    TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                    opportunity_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                    
                    TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
                    opportunity_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                    
                    
                    TBXMLElement *OPTY_CREAT_DATE = [TBXML childElementNamed:@"OPTY_CREATED_DATE" parentElement:table];
                    opportunity_list.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREAT_DATE];
                    NSLog(@"OptyID : %@",opportunity_list.OPTY_CREAT_DATE);
                    
                    
                    TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:table];
                    opportunity_list.VC = [TBXML textForElement:VC];
                    
                    
                    TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                    opportunity_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                    
                    
                    TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                    opportunity_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                    
                    
                    TBXMLElement *SALE_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                    opportunity_list.SALE_STAGE_NAME = [TBXML textForElement:SALE_STAGE_NAME];
                    
                    
                    TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                    opportunity_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                    
                    
                    TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                    opportunity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                    
                    
                    TBXMLElement *CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                    opportunity_list.CONTACT_CELL_NUMBER = [TBXML textForElement:CONTACT_CELL_NUMBER];
                    NSLog(@"CONTACT_CELL_NUMBER:%@", opportunity_list.CONTACT_CELL_NUMBER);
                    
                    TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                    opportunity_list.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
                    
                    TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:table];
                    opportunity_list.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
                    self.ResultCount=opportunity_list.RESULT_COUNT;
                    
                    TBXMLElement *RNUM = [TBXML childElementNamed:@"RNUM" parentElement:table];
                    opportunity_list.RNUM = [TBXML textForElement:RNUM];
                    
                    TBXMLElement *PRODUCT_NAME1 = [TBXML childElementNamed:@"PRODUCT_NAME1" parentElement:table];
                    opportunity_list.PRODUCT_NAME1 = [TBXML textForElement:PRODUCT_NAME1];
                    
                    TBXMLElement *PRODUCT_ID = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:table];
                    opportunity_list.PRODUCT_ID = [TBXML textForElement:PRODUCT_ID];
                    
                    
                    
                    TBXMLElement *TGM_TKM_NAME = [TBXML childElementNamed:@"TGM_TKM_NAME" parentElement:table];
                    opportunity_list.TGM_TKM_NAME = [TBXML textForElement:TGM_TKM_NAME];
                    
                    TBXMLElement *TGM_TKM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_TKM_PHONE_NUMBER" parentElement:table];
                    opportunity_list.TGM_TKM_PHONE_NUMBER = [TBXML textForElement:TGM_TKM_PHONE_NUMBER];
                    
                    
                    TBXMLElement *ACCOUNT_TYPE = [TBXML childElementNamed:@"ACCOUNT_TYPE" parentElement:table];
                    opportunity_list.ACCOUNT_TYPE = [TBXML textForElement:ACCOUNT_TYPE];
                    
                    
                    TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                    opportunity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
                    
                    
                    
                    TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                    opportunity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
                    
                    
                    TBXMLElement *LEAD_POSITION = [TBXML childElementNamed:@"LEAD_POSITION" parentElement:table];
                    opportunity_list.LEAD_POSITION = [TBXML textForElement:LEAD_POSITION];
                    
                    
                    TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                    opportunity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
                    
                    
                    TBXMLElement *CONTACT_FIRST_NAME = [TBXML childElementNamed:@"CONTACT_FIRST_NAME" parentElement:table];
                    opportunity_list.CONTACT_FIRST_NAME = [TBXML textForElement:CONTACT_FIRST_NAME];
                    
                    
                    
                    TBXMLElement *CONTACT_LAST_NAME = [TBXML childElementNamed:@"CONTACT_LAST_NAME" parentElement:table];
                    opportunity_list.CONTACT_LAST_NAME = [TBXML textForElement:CONTACT_LAST_NAME];
                    
                    
                    
                    
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_TYPE = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_TYPE" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_TYPE = [TBXML textForElement:LAST_PENDING_ACTIVITY_TYPE];
                    
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_ID = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_ID" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_ID = [TBXML textForElement:LAST_PENDING_ACTIVITY_ID];
                    
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_STATUS = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_STATUS" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_STATUS = [TBXML textForElement:LAST_PENDING_ACTIVITY_STATUS];
                    
                    
                    TBXMLElement *LAST_PEND_ACTIVIY_START_DATE = [TBXML childElementNamed:@"LAST_PEND_ACTIVIY_START_DATE" parentElement:table];
                    opportunity_list.LAST_PEND_ACTIVIY_START_DATE = [TBXML textForElement:LAST_PEND_ACTIVIY_START_DATE];
                    
                    
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_DESC = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_DESC" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_DESC = [TBXML textForElement:LAST_PENDING_ACTIVITY_DESC];
                    
                    
                    
                    
                    TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                    opportunity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                    
                    
                    TBXMLElement *CUSTOMER_ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                    opportunity_list.CUSTOMER_ACCOUNT_NAME = [TBXML textForElement:CUSTOMER_ACCOUNT_NAME];
                    NSLog(@"OptyID : %@",opportunity_list.CUSTOMER_ACCOUNT_NAME);
                    
                    TBXMLElement *CUSTOMER_ACCOUNT_ID = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_ID" parentElement:table];
                    opportunity_list.CUSTOMER_ACCOUNT_ID = [TBXML textForElement:CUSTOMER_ACCOUNT_ID];
                    
                    
                    TBXMLElement *CUSTOMER_PHONE_NUMBER = [TBXML childElementNamed:@"CUSTOMER_PHONE_NUMBER" parentElement:table];
                    opportunity_list.CUSTOMER_PHONE_NUMBER = [TBXML textForElement:CUSTOMER_PHONE_NUMBER];
                    NSLog(@"OptyID : %@",opportunity_list.CUSTOMER_PHONE_NUMBER);
                    
                    
                    TBXMLElement *CUSTOMER_ACCOUNT_LOCATION = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_LOCATION" parentElement:table];
                    opportunity_list.CUSTOMER_ACCOUNT_LOCATION = [TBXML textForElement:CUSTOMER_ACCOUNT_LOCATION];
                    
                    TBXMLElement *REV_PRODUCT_ID = [TBXML childElementNamed:@"REV_PRODUCT_ID" parentElement:table];
                    opportunity_list.REV_PRODUCT_ID = [TBXML textForElement:REV_PRODUCT_ID];
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_DATE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DATE" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_DATE = [TBXML textForElement:LAST_DONE_ACTIVITY_DATE];
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_TYPE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_TYPE" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_TYPE = [TBXML textForElement:LAST_DONE_ACTIVITY_TYPE];
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_DESC = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DESC" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_DESC = [TBXML textForElement:LAST_DONE_ACTIVITY_DESC];
                    
                    i++;
                    
                    NSLog(@"\n test opp.... %d!!!\n",i);
                    
                    [OpportunityList_ArrList addObject:opportunity_list];
                    //[appdelegate.OppurtunityList addObject:opportunity_list];
                    
                } while ((tuple = tuple->nextSibling));
                NSLog(@"\nOpportunityListDisplayArr......%d",[OpportunityList_ArrList count]);
                if([OpportunityList_ArrList count]>0)
                {
                    [self hideAlert];
                    [self.tbl_opportunity reloadData];
                }
            }
            else
            {
                [self.tbl_opportunity setHidden:YES];
                [self hideAlert];
                alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"No Opportunity Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushoptylistdetail"])
    {
        
        OpportunityDetailsViewController *detailViewController =
        [segue destinationViewController];
        
    }
}




-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
    
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
@end
