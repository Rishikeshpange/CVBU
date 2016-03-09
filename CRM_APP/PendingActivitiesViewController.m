//
//  PendingActivitiesViewController.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/14/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "PendingActivitiesViewController.h"
#import "ActvityDetailTableviewcellTableViewCell.h"
#import "PendingActivityList.h"
#import "UserDetails_Var.h"
#import "AppDelegate.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "Opportunity_List.h"
#import "Activity_List.h"
#import "ActivityUpdateViewController.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
@interface PendingActivitiesViewController () {
    
    NSString* envelopeText;
    UIAlertView *alert;
    NSString *counterString,*_ActivityId,*resetCounter,*_splitStr;
    bool flag_check;
    NSMutableArray *ResetCount_Arr;
    NSString *dateString;
    NSDateFormatter *df;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive,hostActive;
    
    NSMutableArray *activityId;
    
}
@end

@implementation PendingActivitiesViewController
@synthesize flagset;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // Do any additional setup after loading the view.
    
    [self.opty_view.layer setBorderColor:[UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor];
    [self.opty_view.layer setBorderWidth:2.0f];
    self.opty_view.layer.cornerRadius = 5;
    
    NSLog(@"from opty details %@", _Activityflag);
    NSLog(@"from opty details %d", flagset);
    
    NSLog(@"from opty details %@", activity_list.OPPTY_ROWID);
    NSLog(@"from opty details %@", activity_list.OPPTY_ROWID);
    
    
    NSDate *date = [NSDate date]; //I'm using this just to show the this is how you convert a date
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MMM-YYYY HH:mm:ss"];
    dateString= [df stringFromDate:date];
    NSLog(@"Date Final Month :%@",dateString);
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    userDetailsVal_ = [UserDetails_Var sharedmanager];
    
    if (flagset == 1) {
        NSLog(@"...Comew opty");
        _lbl_customerName.text = opportunity_list.CONTACT_NAME;
        _lbl_custtomerNumber.text = opportunity_list.CONTACT_CELL_NUMBER;
        _lbl_assigntoName.text = opportunity_list.LEAD_ASSIGNED_NAME;
        _lbl_assigntoNumber.text = opportunity_list.LEAD_ASSIGNED_CELL_NUMBER;
    }
    else {
        NSLog(@"Log %@",activity_list.OPTY_ID);
        _lbl_customerName.text = activity_list.CONTACT_NAME;
        _lbl_custtomerNumber.text = activity_list.CONTACT_CELL_NUM;
        _lbl_assigntoName.text = activity_list.LEAD_ASSIGNED_NAME;
        _lbl_assigntoNumber.text = activity_list.LEAD_ASSIGNED_CELL_NUMBER;
    }
    if ([_lbl_customerName.text isEqual:@""]) {
        _lbl_customerName.text = @"Not Available";
    }
    if ([_lbl_custtomerNumber.text isEqual:@""]) {
        _lbl_custtomerNumber.text = @"Not Available";
    }
    if ([_lbl_assigntoName.text isEqual:@""]) {
        _lbl_assigntoName.text = @"Not Available";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (flagset == 1) {
        [self CallactivitydetailsFromOpty];
    }
    else {
        [self callPendingActivityList];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActivityListfromopty_Found:) name:@"ActivityListfromopty_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Done_Found:) name:@"Done_Found" object:nil];  //For Activity Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityFinalDone_Found:) name:@"ActivityFinalDone_Found" object:nil];
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ActivityListfromopty_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Done_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityFinalDone_Found" object:nil];
    
    
}
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0 || indexPath.row == ([indexPath length] - 1)) {
        cell.layer.cornerRadius = 10;
    }
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [pendingActivities_ListArr count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1; // in your case, there are 3 cells
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10; // you can have your own choice, of course
//}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    NSLog(@"Row Selected ... %ld", (long)indexPath.row);
    activityPending_list = [pendingActivities_ListArr objectAtIndex:indexPath.row];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    activityPending_list = nil;
    activityPending_list = [[PendingActivityList alloc] init];
    activityPending_list = [pendingActivities_ListArr objectAtIndex:indexPath.row];
    
    NSLog(@"Pending activities list array%@", pendingActivities_ListArr);
    static NSString* MyIdentifier = @"activitydetailcell";
    ActvityDetailTableviewcellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (tableView == self.tableView) {
        if (cell == nil) {
            cell = [[ActvityDetailTableviewcellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        cell.activittyDonebtn.tag = indexPath.row;
        cell.activityUpdateBtn.tag = indexPath.row;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.activity_main_view.layer setBorderColor:[UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor];
        [cell.activity_main_view.layer setBorderWidth:2.0f];
        cell.activity_main_view.layer.cornerRadius = 5;
        cell.activittyDonebtn.layer.cornerRadius = 4;
        cell.activityUpdateBtn.layer.cornerRadius = 4;
        cell.activittyDonebtn.layer.masksToBounds = YES;
        cell.activityUpdateBtn.layer.masksToBounds = YES;
        NSLog(@"Activity Type %@", activityPending_list.ACTIVITY_TYPE);
        cell.lbl_Planned_Date.text = activityPending_list.ACTIVITY_PLAN_START_DT;
        cell.lbl_Activity_Type.text = activityPending_list.ACTIVITY_TYPE;
        cell.lbl_Activity_Status.text = activityPending_list.ACTIVITY_STATUS;
        cell.lbl_Description.text = activityPending_list.ACTIVITY_DESC;
        cell.lbl_Planned_Time.text = activityPending_list.ACTIVITY_PLAN_START_TM;
        NSLog(@"Timing :%@",activityPending_list.ACTIVITY_PLAN_START_TM);
        
        if ([activityPending_list.ACTIVITY_STATUS isEqualToString:@"Done"]) {
            
            cell.activittyDonebtn.enabled = NO;
            cell.activityUpdateBtn.enabled = NO;
            [cell.activityUpdateBtn setBackgroundColor:[UIColor grayColor]];
            [cell.activittyDonebtn setBackgroundColor:[UIColor grayColor]];
        }
        else if ([activityPending_list.ACTIVITY_STATUS isEqualToString:@"Open"]) {
            
            cell.activittyDonebtn.enabled = YES;
            cell.activityUpdateBtn.enabled = YES;
        }
        
        [cell.activittyDonebtn addTarget:self action:@selector(callactivityDone:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.activityUpdateBtn addTarget:self action:@selector(callactivityUpdate:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    return 0;
}

- (void)callactivityDone:(UIButton*)sender
{
    if (![self connected])
    {
        // not connected
        NSLog(@"Newtwork not Available...");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
        
    }else{
        
        //activityPending_list = [pendingActivities_ListArr objectAtIndex:indexPath.row];
        NSLog(@"Account Id : %@",activityPending_list.ACTIVITY_ID);
        NSLog(@"AcitivityType Id : %@",activityPending_list.ACTIVITY_TYPE);
        NSLog(@"Acitivity status : : %@",activityPending_list.ACTIVITY_STATUS);
        NSLog(@"Acitivity Plan Date : %@",activityPending_list.ACTIVITY_PLAN_START_DT);
        dateString=[dateString uppercaseString];
        NSLog(@"Current Date        : %@",dateString);
        
        /* NSString *dateString11 = dateString;
         
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         [dateFormatter setDateFormat:@"dd-MM-yyyy"];
         NSDate *dateFromString = [[NSDate alloc] init];
         dateFromString = [dateFormatter dateFromString:activityPending_list1.ACTIVITY_PLAN_START_DT];
         NSLog(@"Form :%@",dateFromString);*/
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MMM-YYYY HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:dateString];//chnage symbal here.
        NSLog(@"%@",date);
        
        if([activityPending_list.ACTIVITY_STATUS isEqual:@"Done"])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                               message:@"This activity is already marked as Done!"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil,nil];
            [alert show];
        }
        else if([activityPending_list.ACTIVITY_PLAN_START_DT compare:dateString] == NSOrderedDescending){
            NSLog(@"myDate is LATER than today");
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                               message:@"Future date activity could not Done!"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil,nil];
            [alert show];
            
            
        }
        else if ([activityPending_list.ACTIVITY_PLAN_START_DT compare:dateString]== NSOrderedAscending) {
            NSLog(@"myDate is earlier than getDate");
            [self CallDoneActivity];
            
            
        }
        /* else if([activityPending_list1.ACTIVITY_PLAN_START_DT compare: dateString] == NSOrderedDescending) // if start is later in time than end
         {
         NSLog(@"Print date : %@",dateString);
         // do something
         }*/
        else
        {
            if([activityPending_list.ACTIVITY_TYPE isEqual:@"Papers Submitted"])
            {
                NSLog(@"set Flag");
                flag_check=1;
            }
            
            [self CallDoneActivity];
        }
    }
    
}

-(void)CallDoneActivity {
    
    [self showAlert];
    NSLog(@"Activity Id :%@",activityPending_list.ACTIVITY_ID);
    /*<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body><SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
					+ "<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TMActionInterface\"><Action><Status>Done</Status><ActivityId>"
					+ _ad.ACTIVITY_ID
					+ "</ActivityId></Action></ListOfTmActionInterface></SFATMCVInsertOrUpdate_Input></SOAP:Body></SOAP:Envelope>  */
    
    envelopeText = [NSString stringWithFormat:
                    @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                    @"<SOAP:Body>"
                    @"<SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                    @"<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TMActionInterface/\">"
                    @"<Action>"
                    @"<Status>Done</Status>"
                    @"<ActivityId>%@</ActivityId>"
                    @"</Action>"
                    @"</ListOfTmActionInterface>"
                    @"</SFATMCVInsertOrUpdate_Input>"
                    @"</SOAP:Body>"
                    @"</SOAP:Envelope>",activityPending_list.ACTIVITY_ID];
    
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    
    NSLog(@"URL IS %@",theurl);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityDoneConnection"];
}

-(void)Done_Found:(NSNotification*)notification  // Activity Response
{
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n PendingActivityDetails_Connection response... %@ ",response);
    
    if([response isEqual:@""]){
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"[Project Item Parent Actual Start]"].location != NSNotFound  )
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Cannot done Activity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else{
        
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        
        TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfTmActionInterface" parentElement:container];
        
        TBXMLElement *Opportunity = [TBXML childElementNamed:@"Action" parentElement:ListOfContactInterface];
        TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
        if (Id)
        {
            [self hideAlert];
            activityDone.Id_ = [TBXML textForElement:Id];
            _ActivityId=[TBXML textForElement:Id];
            NSLog(@"\nListOfContactInterface.....!!!!!%@",_ActivityId);
            if (flag_check==1 && [activityPending_list.SALES_STAGE_NAME isEqual:@"C1 (Quote Tendered)"])
            {
                NSLog(@"AcitivityType Id : %@",activityPending_list.ACTIVITY_TYPE);
                NSLog(@"Check..%d",flag_check);
                [self CallActivityDoneAgain];
            }
            else
            {
                if(flagset==1)
                {
                    [self CallactivitydetailsFromOpty];
                }
                else{
                    [self callPendingActivityList];
                }
                alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Activity marked as Done !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                
            }
        }/*
          else
          {
          [self hideAlert];
          alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"There has been a technical issue. We could not marked as Done this Activity !!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
          [alert show];
          }*/
    }
}



-(void)CallActivityDoneAgain {
    
    NSLog(@"Called Again ");
    
    NSLog(@"AcitivityType Id : %@",activityPending_list.ACTIVITY_TYPE);
    
    /*<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body>" +
     "<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">" +
     "<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%20Opportunity%20Interface\"><Opportunity><Id>" +
     _ad.OPTY_ID +
     "</Id><SalesStage>C1A (Papers submitted)</SalesStage></Opportunity></ListOfTMOpportunityInterface></SFATMCVOPTYInsertOrUpdate_Input></SOAP:Body></SOAP:Envelope> */
    
    
    envelopeText = [NSString stringWithFormat:
                    @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                    @"<SOAP:Body>"
                    @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                    @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                    @"<Opportunity>"
                    @"<Id>%@</Id>"
                    @"<SalesStage>C1A (Papers submitted)</SalesStage>"
                    @"</Opportunity>"
                    @"</ListOfTMOpportunityInterface>"
                    @"</SFATMCVOPTYInsertOrUpdate_Input>"
                    @"</SOAP:Body>"
                    @"</SOAP:Envelope>",activityPending_list.OPTY_ID];
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivitiyFinalDoneConnection"];
}


-(void)ActivityFinalDone_Found:(NSNotification*)notification  // Activity Response
{
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n PendingActivityDetails_Connection response... %@ ",response);
    if([response isEqual:@""]){
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"There has been a technical issue. We could not update the sales stage of this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        
        TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:container];
        
        TBXMLElement *Opportunity = [TBXML childElementNamed:@"Opportunity" parentElement:ListOfContactInterface];
        
        TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
        if (Id)
        {
            [self hideAlert];
            
            activityFinalDone.Id_ = [TBXML textForElement:Id];
            
            NSLog(@"\nListOfContactInterface.....!!!!!%@",activityFinalDone.Id_);
            
            alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Activity Marked as Done !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }
        
        else
        {
            [self hideAlert];
            alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (void)callactivityUpdate:(UIButton*)sender
{
    
    activityPending_list = [pendingActivities_ListArr objectAtIndex:sender.tag];
    
    NSLog(@"Test Pass %@", activityPending_list.ACTIVITY_PLAN_START_TM);
    ActivityUpdateViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboard_UpdateActivity"];
    searchOpportunityResult_VC1.flagset=flagset;
    
    [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
    
    
    
}

- (void)CallactivitydetailsFromOpty
{
    
    [self showAlert];
    NSLog(@"inside...List of opportunity %@", userDetailsVal_.POSTN);
    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
        
        NSLog(@"NDRM Opportunuty List");
        
        envelopeText = [NSString stringWithFormat:
                        @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        @"<SOAP:Body>"
                        @"<GetListOfActivityForOpportunity xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                        @"<positionid>%@</positionid>"
                        @"<activitystatus>Open</activitystatus>"
                        @"</GetListOfActivityForOpportunity>"
                        @"</SOAP:Body>"
                        @"</SOAP:Envelope>",
                        opportunity_list.OPTY_ID];
    }
    
    else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
        
        NSLog(@"DSM Opportunuty List");
        
        envelopeText = [NSString stringWithFormat:
                        @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        @"<SOAP:Body>"
                        @"<GetListOfActivityForOpportunity xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                        @"<positionid>%@</positionid>"
                        @"<activitystatus></activitystatus>"
                        @"</GetListOfActivityForOpportunity>"
                        @"</SOAP:Body>"
                        @"</SOAP:Envelope>",
                        opportunity_list.OPTY_ID];
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
        
        NSLog(@"DSE Opportunuty List");
        
        envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                        @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\" />"
                        @"</header>"
                        @"</SOAP:Header>"
                        @"<SOAP:Body>"
                        @"<GetListOfActivityForOpportunitySFA xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                        @"<activitystatus>Open</activitystatus>"
                        @"<optyid>%@</optyid>"
                        @"</GetListOfActivityForOpportunitySFA>"
                        @"</SOAP:Body>"
                        @"</SOAP:Envelope>",
                        opportunity_list.OPTY_ID];
    }
    NSLog(@"\n pending activities request%@", envelopeText);
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    NSLog(@"URL IS %@", theurl);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    NSLog(@"Request.... %@", request);
    NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc] initiateRequest:request name:@"ActivitydetailsListfromopty"];
}

- (void)ActivityListfromopty_Found:(NSNotification*)notification
{
    
    pendingActivities_ListArr = [[NSMutableArray alloc] init];
    pendingActivities_Customer_list = [[NSMutableArray alloc] init];
    activityId=[[NSMutableArray alloc]init];
    
    if (pendingActivities_ListArr) {
        [pendingActivities_ListArr removeAllObjects];
    }
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n List of Opportunity Response %@ ", response);
    
    if ([response isEqual:@""]) {
        
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        
        [self hideAlert];
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else {
        
        if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            
            TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            
            TBXMLElement* soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
            TBXMLElement* container = [TBXML childElementNamed:@"GetListOfActivityForOpportunitySFAResponse" parentElement:soapBody];
            if (container) {
                TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
                ///  NSLog(@"Tuple..%@",tuple);
                if (tuple) {
                    do {
                        activityPending_list = nil;
                        activityPending_list = [[PendingActivityList alloc] init];
                        
                        TBXMLElement* table = [TBXML childElementNamed:@"S_OPTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                        
                        TBXMLElement* X_ACTIVITY_PLAN_START_DT = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DT" parentElement:table];
                        activityPending_list.ACTIVITY_PLAN_START_DT = [TBXML textForElement:X_ACTIVITY_PLAN_START_DT];
                        NSLog(@"Plan start :%@",activityPending_list.ACTIVITY_PLAN_START_DT);
                        if([activityPending_list.ACTIVITY_PLAN_START_DT isEqualToString:@""])
                        {
                        }else{
                        NSString* Date = [TBXML textForElement:X_ACTIVITY_PLAN_START_DT];
                        
                        NSLog(@"date%@", Date);
                        
                        NSArray* subStrings = [Date componentsSeparatedByString:@" "]; //or rather @" - "
                        NSString* firstString = [subStrings objectAtIndex:0];
                        NSString* lastString = [subStrings objectAtIndex:1];
                        activityPending_list.ACTIVITY_PLAN_START_DT = firstString;
                        
                        NSLog(@"%@", lastString);
                        
                        NSArray* Time = [lastString componentsSeparatedByString:@":"];
                        NSString* firstBit = [Time objectAtIndex:0];
                        NSString* secondBit = [Time objectAtIndex:1];
                        
                        NSString* ActivityTime = [NSString stringWithFormat:@"%@%@%@", firstBit, @":", secondBit];
                        
                        activityPending_list.ACTIVITY_PLAN_START_TM = ActivityTime;
                        }
                        
                        TBXMLElement* X_ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:table];
                        activityPending_list.ACTIVITY_STATUS = [TBXML textForElement:X_ACTIVITY_STATUS];
                        
                        TBXMLElement* X_ACTIVITY_DESC = [TBXML childElementNamed:@"ACTIVITY_DESC" parentElement:table];
                        activityPending_list.ACTIVITY_DESC = [TBXML textForElement:X_ACTIVITY_DESC];
                        
                        TBXMLElement* X_ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:table];
                        activityPending_list.ACTIVITY_TYPE = [TBXML textForElement:X_ACTIVITY_TYPE];
                        
                        TBXMLElement* X_ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
                        activityPending_list.ACTIVITY_ID = [TBXML textForElement:X_ACTIVITY_ID];
                        
                        
                        [activityId addObject:activityPending_list.ACTIVITY_ID];
                        
                        
                        TBXMLElement* X_CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                        activityPending_list.CONTACT_NAME = [TBXML textForElement:X_CONTACT_NAME];
                        
                        TBXMLElement* X_CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                        activityPending_list.CONTACT_ID = [TBXML textForElement:X_CONTACT_ID];
                        
                        TBXMLElement* X_CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                        activityPending_list.CONTACT_ADDRESS = [TBXML textForElement:X_CONTACT_ADDRESS];
                        
                        TBXMLElement* X_CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                        activityPending_list.CONTACT_CELL_NUMBER = [TBXML textForElement:X_CONTACT_CELL_NUMBER];
                        
                        TBXMLElement* X_OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                        //NSString *str_OpTyId = [TBXML textForElement:X_OPTY_ID];
                        activityPending_list.OPTY_ID = [TBXML textForElement:X_OPTY_ID];
                        
                        NSLog(@"OptyID :DSE %@", activityPending_list.OPTY_ID);
                        TBXMLElement* X_OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                        activityPending_list.OPTY_NAME = [TBXML textForElement:X_OPTY_NAME];
                        
                        TBXMLElement* X_OPTY_CREATED = [TBXML childElementNamed:@"OPTY_CREATED" parentElement:table];
                        activityPending_list.OPTY_CREATED = [TBXML textForElement:X_OPTY_CREATED];
                        
                        TBXMLElement* X_SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                        activityPending_list.SALES_STAGE_NAME = [TBXML textForElement:X_SALES_STAGE_NAME];
                        
                        TBXMLElement* X_SALE_STAGE_UPDATED_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                        activityPending_list.SALE_STAGE_UPDATED_DATE = [TBXML textForElement:X_SALE_STAGE_UPDATED_DATE];
                        
                        TBXMLElement* X_LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                        activityPending_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:X_LEAD_ASSIGNED_NAME];
                        
                        TBXMLElement* X_LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                        activityPending_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:X_LEAD_ASSIGNED_CELL_NUMBER];
                        
                        TBXMLElement* X_LEAD_POSITION = [TBXML childElementNamed:@"LEAD_POSITION" parentElement:table];
                        activityPending_list.LEAD_POSITION = [TBXML textForElement:X_LEAD_POSITION];
                        
                        TBXMLElement* X_LEAD_POSITION_ID = [TBXML childElementNamed:@"LEAD_POSITION_ID" parentElement:table];
                        activityPending_list.LEAD_POSITION_ID = [TBXML textForElement:X_LEAD_POSITION_ID];
                        
                        TBXMLElement* X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:table];
                        activityPending_list.X_PROSPECT_SRC = [TBXML textForElement:X_PROSPECT_SRC];
                        
                        TBXMLElement* X_RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:table];
                        activityPending_list.RESULT_COUNT = [TBXML textForElement:X_RESULT_COUNT];
                        
                        
                        
                        
                        [pendingActivities_ListArr addObject:activityPending_list];
                    } while ((tuple = tuple->nextSibling));
                    [self.tableView reloadData];
                }
                NSLog(@"Opty Id's 12%@", pendingActivities_ListArr);
                [self.tableView reloadData];
                
                NSLog(@"Counter.. %lu", (unsigned long)[pendingActivities_ListArr count]);
                
                if (pendingActivities_ListArr.count >0) {
               
                
                
                if (![activityId[0] isEqualToString:@""]) {
                    [self.tableView reloadData];
                    [self hideAlert];
                    _optyCounter.text = [NSString stringWithFormat:@"%d", [pendingActivities_ListArr count]];
                }
                else {
                    [self.tableView setHidden:YES];
                    [self hideAlert];
                     alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                                    message:@"There are no pending Activities"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                    
                }
                
                else{
                
                    [self.tableView setHidden:YES];
                    
                    [self hideAlert];
                    alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                       message:@"There are no pending Activities"
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
                    [alert show];
                
                
                
                }
                
                    
                    
            }
        }
        else {
            //NSArray  *array_=[[NSArray alloc] init];
            
            TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            
            TBXMLElement* soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
            TBXMLElement* container = [TBXML childElementNamed:@"GetListOfActivityForOpportunityResponse" parentElement:soapBody];
            if (container) {
                TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
                ///  NSLog(@"Tuple..%@",tuple);
                if (tuple) {
                    do {
                        activityPending_list = nil;
                        activityPending_list = [[PendingActivityList alloc] init];
                        
                        TBXMLElement* table = [TBXML childElementNamed:@"S_OPTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                        TBXMLElement* X_ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:table];
                        
                        activityPending_list.ACTIVITY_TYPE = [TBXML textForElement:X_ACTIVITY_TYPE];
                        
                        TBXMLElement* X_OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                        
                        activityPending_list.OPTY_ID = [TBXML textForElement:X_OPTY_ID];
                        
                        TBXMLElement* X_ACTIVITY_PLAN_START_DT = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DT" parentElement:table];
                        activityPending_list.ACTIVITY_PLAN_START_DT=[TBXML textForElement:X_ACTIVITY_PLAN_START_DT];
                        NSLog(@"Plan start :%@",activityPending_list.ACTIVITY_PLAN_START_DT);

                        if([activityPending_list.ACTIVITY_PLAN_START_DT isEqualToString:@""])
                        {
                        }else{

                        NSString* Date = [TBXML textForElement:X_ACTIVITY_PLAN_START_DT];
                        
                        NSLog(@"date%@", Date);
                        
                        NSArray* subStrings = [Date componentsSeparatedByString:@" "]; //or rather @" - "
                        NSString* firstString = [subStrings objectAtIndex:0];
                        NSString* lastString = [subStrings objectAtIndex:1];
                        activityPending_list.ACTIVITY_PLAN_START_DT = firstString;
                        
                        NSLog(@"%@", lastString);
                        
                        NSArray* Time = [lastString componentsSeparatedByString:@":"];
                        NSString* firstBit = [Time objectAtIndex:0];
                        NSString* secondBit = [Time objectAtIndex:1];
                        
                        NSString* ActivityTime = [NSString stringWithFormat:@"%@%@%@", firstBit, @":", secondBit];
                        
                        activityPending_list.ACTIVITY_PLAN_START_TM = ActivityTime;
                        }
                        
                        TBXMLElement* X_ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
                        activityPending_list.ACTIVITY_ID = [TBXML textForElement:X_ACTIVITY_ID];
                        
                        NSLog(@"ActivityID : %@", activityPending_list.ACTIVITY_ID);
                        
                        TBXMLElement* X_ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:table];
                        activityPending_list.ACTIVITY_STATUS = [TBXML textForElement:X_ACTIVITY_STATUS];
                        
                        TBXMLElement* X_ACTIVITY_DESC = [TBXML childElementNamed:@"ACTIVITY_DESC" parentElement:table];
                        activityPending_list.ACTIVITY_DESC = [TBXML textForElement:X_ACTIVITY_DESC];
                        
                        TBXMLElement* X_CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                        activityPending_list.CONTACT_NAME = [TBXML textForElement:X_CONTACT_NAME];
                        
                        TBXMLElement* X_CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                        activityPending_list.CONTACT_ID = [TBXML textForElement:X_CONTACT_ID];
                        
                        TBXMLElement* X_CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                        activityPending_list.CONTACT_ADDRESS = [TBXML textForElement:X_CONTACT_ADDRESS];
                        
                        TBXMLElement* X_CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                        activityPending_list.CONTACT_CELL_NUMBER = [TBXML textForElement:X_CONTACT_CELL_NUMBER];
                        
                        TBXMLElement* X_OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                        activityPending_list.OPTY_NAME = [TBXML textForElement:X_OPTY_NAME];
                        
                        TBXMLElement* X_OPTY_CREATED = [TBXML childElementNamed:@"OPTY_CREATED" parentElement:table];
                        activityPending_list.OPTY_CREATED = [TBXML textForElement:X_OPTY_CREATED];
                        
                        TBXMLElement* X_SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                        activityPending_list.SALES_STAGE_NAME = [TBXML textForElement:X_SALES_STAGE_NAME];
                        
                        TBXMLElement* X_SALE_STAGE_UPDATED_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                        activityPending_list.SALE_STAGE_UPDATED_DATE = [TBXML textForElement:X_SALE_STAGE_UPDATED_DATE];
                        
                        TBXMLElement* X_LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                        activityPending_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:X_LEAD_ASSIGNED_NAME];
                        
                        TBXMLElement* X_LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                        activityPending_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:X_LEAD_ASSIGNED_CELL_NUMBER];
                        
                        TBXMLElement* X_LEAD_POSITION = [TBXML childElementNamed:@"LEAD_POSITION" parentElement:table];
                        activityPending_list.LEAD_POSITION = [TBXML textForElement:X_LEAD_POSITION];
                        
                        TBXMLElement* X_LEAD_POSITION_ID = [TBXML childElementNamed:@"LEAD_POSITION_ID" parentElement:table];
                        activityPending_list.LEAD_POSITION_ID = [TBXML textForElement:X_LEAD_POSITION_ID];
                        
                        TBXMLElement* X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:table];
                        activityPending_list.X_PROSPECT_SRC = [TBXML textForElement:X_PROSPECT_SRC];
                        
                        [pendingActivities_ListArr addObject:activityPending_list];
                        
                    } while ((tuple = tuple->nextSibling));
                    [self hideAlert];
                    
                    NSLog(@"array list %@", pendingActivities_ListArr);
                    
                    /*if ([activityPending_list.ACTIVITY_ID isEqual:@""]) {
                        NSLog(@"no activities found");
                        
                        [self.tableView setHidden:YES];
                        if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                            [self hideAlert];
                            
                            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No Activity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        else if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                            [self hideAlert];
                            
                            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No Activity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                    }
                    else {
                        [self.tableView reloadData];
                    }*/
                    NSLog(@"Opty Id's 12%@", pendingActivities_ListArr);
                    [self.tableView reloadData];
                    NSLog(@"Counter.. %lu", (unsigned long)[pendingActivities_ListArr count]);
                    if ([pendingActivities_ListArr count] > 0) {
                        _optyCounter.text = [NSString stringWithFormat:@"%d", [pendingActivities_ListArr count]];
                        NSLog(@"zero count");
                        [self.tableView reloadData];
                    }else
                    {
                        if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                            [self hideAlert];
                            
                            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No Activity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        else if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                            [self hideAlert];
                            
                            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No Activity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                    }
                }
            }
            else {
                if ([activityPending_list.ACTIVITY_ID isEqual:@""]) {
                    NSLog(@"no activities found");
                    
                    [self.tableView setHidden:YES];
                    if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                        [self hideAlert];
                        
                        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No Activities found " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                    else if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                        [self hideAlert];
                        
                        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No Activities  found " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                }
            }
        }
    }
}

- (void)callPendingActivityList
{
    NSLog(@"Extra..");
    NSLog(@"inside...List of Activity %@", userDetailsVal_.POSTN);
    [self showAlert];
    if ([userDetailsVal_.POSTN isEqual:@"NDRM"])
    {
        if([activity_list.OPTY_ID isEqual:@""]){
            envelopeText = [NSString stringWithFormat:
                            @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                            @"<SOAP:Body>"
                            @"<GetListOfActivityForOpportunity xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                            @"<positionid>%@</positionid>"
                            @"<activitystatus>Open</activitystatus>"
                            @"</GetListOfActivityForOpportunity>"
                            @"</SOAP:Body>"
                            @"</SOAP:Envelope>",
                            activity_list.OPTY_ID];
        }else
        {
            envelopeText = [NSString stringWithFormat:
                            @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                            @"<SOAP:Body>"
                            @"<GetListOfActivityForOpportunity xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                            @"<positionid>%@</positionid>"
                            @"<activitystatus>Open</activitystatus>"
                            @"</GetListOfActivityForOpportunity>"
                            @"</SOAP:Body>"
                            @"</SOAP:Envelope>",
                            activity_list.OPTY_ID];
        }
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
        
        envelopeText = [NSString stringWithFormat:
                        @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        @"<SOAP:Body>"
                        @"<GetListOfActivityForOpportunity xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                        @"<positionid>%@</positionid>"
                        @"<activitystatus></activitystatus>"
                        @"</GetListOfActivityForOpportunity>"
                        @"</SOAP:Body>"
                        @"</SOAP:Envelope>",
                        activity_list.OPTY_ID];
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
        
        envelopeText = [NSString stringWithFormat:
                        @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        @"<SOAP:Body>"
                        @"<GetListOfActivityForOpportunity xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                        @"<positionid>%@</positionid>"
                        @"<activitystatus></activitystatus>"
                        @"</GetListOfActivityForOpportunity>"
                        @"</SOAP:Body>"
                        @"</SOAP:Envelope>",
                        activity_list.OPTY_ID];
        
    }
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
    
    [[RequestDelegate alloc] initiateRequest:request name:@"ActivitydetailsListfromopty"];
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
