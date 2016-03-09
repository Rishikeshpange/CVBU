//
//  OpportunityDetailsViewController.m
//  CRM_APP
//
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "OpportunityDetailsViewController.h"
#import "ManageOpportunity_ViewCell.h"
#import "ManageOpportunityViewController.h"
#import "Opportunity_List.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "ActivityViewController.h"
#import "LostOpportunityViewController.h"
#import "AssignViewController.h"
#import "PendingActivitiesViewController.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "LinkCampaignListView.h"
#import "CreateQouteController.h"
#import "LoginViewController.h"
#import "UpdateOpportunityViewController.h"


@interface OpportunityDetailsViewController () {
    UIAlertView* alert;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
    int flag,flagQoute,setflag;
    bool flag_check,flagDSE;
    NSString *optyIdCreated;
    NSString *envelopeText;
    UIActionSheet *actionSheet;
    
    NSString *linkcampaignselectedname;
    
      NSString *linkcampaignselectedid;

}
@end

@implementation OpportunityDetailsViewController

@synthesize opportunity_view, Contact_view, Account_view, Activity_view;
@synthesize lbl_optyID, lbl_Accountname, lbl_contactName, lbl_productName, lbl_Acctivitytype, lbl_contactCellno, lbl_contactAddress, lbl_customerCellno, lbl_salesStagename, lbl_doneActivitydate, lbl_doneActivitytype, lbl_optyCreationdate, lbl_activityPendingdate, lbl_AccountcustomerCellno, lbl_doneActivitydescription, lbl_pendingActivitydescription;
@synthesize ProductDetailsUpdate_Arr;
- (void)viewDidLoad
{
    [super viewDidLoad];

    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    NSLog(@"Samlp Art Master: %@", appdelegate.artifact);
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"Samlp Art Master: %@", userDetailsVal_.ROW_ID);
    
    appdelegate.optyflow=@"fromdetails";

    if (![self connected]) {
        NSLog(@"Newtwork not Available...");
        alert = [[UIAlertView alloc] initWithTitle:@"" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    // Border

    opportunity_view.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;

    opportunity_view.layer.borderWidth = 2.0f;

    Activity_view.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;

    Activity_view.layer.borderWidth = 2.0f;

    Account_view.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;

    Account_view.layer.borderWidth = 2.0f;

    Contact_view.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;

    Contact_view.layer.borderWidth = 2.0f;

    _btn_lostDSE.layer.cornerRadius = 3.0;
    _btn_lostDSM.layer.cornerRadius = 3.0;
    _btn_lostNEEV.layer.cornerRadius = 3.0;

    _btn_updateDSE.layer.cornerRadius = 3.0;
    _btn_updateDSM.layer.cornerRadius = 3.0;
    _btn_updateNEEV.layer.cornerRadius = 3.0;

    _btn_pendingDSE.layer.cornerRadius = 3.0;
    _btn_pendingDSM.layer.cornerRadius = 3.0;
    _btn_pendingNEEV.layer.cornerRadius = 3.0;

    _btn_newAcxtivityDSE.layer.cornerRadius = 3.0;
    _btn_newAcxtivityDSM.layer.cornerRadius = 3.0;
    _btn_newAcxtivityNEEV.layer.cornerRadius = 3.0;

    _btn_linkCampaignDSE.layer.cornerRadius = 3.0;
    _btn_linkCampaignDSM.layer.cornerRadius = 3.0;

    _btn_assignDSM.layer.cornerRadius = 3.0;
    _btn_assignNEEV.layer.cornerRadius = 3.0;

    _btn_createquoteDSE.layer.cornerRadius = 3.0;
    _btn_createquoteNEEV.layer.cornerRadius = 3.0;

    //view corner

    opportunity_view.layer.cornerRadius = 6.0;

    Activity_view.layer.cornerRadius = 6.0;

    Account_view.layer.cornerRadius = 6.0;

    Contact_view.layer.cornerRadius = 6.0;

    // opty details values
    
    NSLog(@"Account Id Details: %@",opportunity_list.ACCOUNT_ID);


    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

        _DSMMENU_view.hidden = YES;
        _DSEMENU_view.hidden = YES;
        _NEEVMENU_view.hidden = NO;

        lbl_optyID.text = opportunity_list.OPTY_ID;
        lbl_customerCellno.text = opportunity_list.CONTACT_CELL_NUMBER;
        lbl_optyCreationdate.text = opportunity_list.OPTY_CREAT_DATE;
        lbl_salesStagename.text = opportunity_list.SALE_STAGE_NAME;
        lbl_productName.text = opportunity_list.PRODUCT_NAME;

        //contact details

        lbl_contactName.text = opportunity_list.CONTACT_NAME;
        lbl_contactCellno.text = opportunity_list.CONTACT_CELL_NUMBER;
        lbl_contactAddress.text = opportunity_list.CONTACT_ADDRESS;

        //Account Details

        lbl_Accountname.text = opportunity_list.ACCOUNT_NAME;
        lbl_AccountcustomerCellno.text = opportunity_list.CUSTOMER_PHONE_NUMBER;

        //Activity Details

        lbl_activityPendingdate.text = opportunity_list.LAST_PEND_ACTIVIY_START_DATE;
        lbl_doneActivitydate.text = opportunity_list.LAST_DONE_ACTIVITY_DATE;
        lbl_Acctivitytype.text = opportunity_list.LAST_PENDING_ACTIVITY_TYPE;
        lbl_doneActivitytype.text = opportunity_list.LAST_DONE_ACTIVITY_TYPE;
        lbl_pendingActivitydescription.text = opportunity_list.LAST_PENDING_ACTIVITY_DESC;
        lbl_doneActivitydescription.text = opportunity_list.LAST_DONE_ACTIVITY_DESC;

        if ([opportunity_list.LAST_PEND_ACTIVIY_START_DATE isEqual:@""]) {

            lbl_activityPendingdate.text = @"None";
        }

        if ([opportunity_list.LAST_DONE_ACTIVITY_DATE isEqual:@""]) {

            lbl_doneActivitydate.text = @"None";
        }

        if ([opportunity_list.LAST_PENDING_ACTIVITY_TYPE isEqual:@""]) {

            lbl_Acctivitytype.text = @"None";
        }

        if ([opportunity_list.LAST_DONE_ACTIVITY_TYPE isEqual:@""]) {

            lbl_doneActivitytype.text = @"None";
        }

        if ([opportunity_list.LAST_PENDING_ACTIVITY_DESC isEqual:@""]) {

            lbl_pendingActivitydescription.text = @"None";
        }

        if ([opportunity_list.LAST_DONE_ACTIVITY_DESC isEqual:@""]) {

            lbl_doneActivitydescription.text = @"None";
        }
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
        
        
        
        
        [self optydetail];
        
        
        
        
        
        
        

        _DSMMENU_view.hidden = NO;
        _DSEMENU_view.hidden = YES;
        _NEEVMENU_view.hidden = YES;
        
        
        
        
        
        
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

        _DSMMENU_view.hidden = YES;
        _DSEMENU_view.hidden = NO;
        _NEEVMENU_view.hidden = YES;

        //opty details

        lbl_optyID.text = opportunity_list.OPTY_ID;
        lbl_customerCellno.text = opportunity_list.CONTACT_CELL_NUMBER;
        lbl_optyCreationdate.text = opportunity_list.OPTY_CREAT_DATE;
        lbl_salesStagename.text = opportunity_list.SALE_STAGE_NAME;
        lbl_productName.text = opportunity_list.PRODUCT_NAME;
 appdelegate.opty_idDetailPage= lbl_optyID.text;
        //contact details

        lbl_contactName.text = opportunity_list.CONTACT_NAME;
        lbl_contactCellno.text = opportunity_list.CONTACT_CELL_NUMBER;
        lbl_contactAddress.text = opportunity_list.CONTACT_ADDRESS;

        //Account Details

        lbl_Accountname.text = opportunity_list.LEAD_ASSIGNED_NAME;
        lbl_AccountcustomerCellno.text = opportunity_list.LEAD_ASSIGNED_CELL_NUMBER;

        //Activity Details

        lbl_activityPendingdate.text = opportunity_list.LAST_PEND_ACTIVIY_START_DATE;
        lbl_doneActivitydate.text = opportunity_list.LAST_DONE_ACTIVITY_DATE;
        lbl_Acctivitytype.text = opportunity_list.LAST_PENDING_ACTIVITY_TYPE;
        lbl_doneActivitytype.text = opportunity_list.LAST_DONE_ACTIVITY_TYPE;
        lbl_pendingActivitydescription.text = opportunity_list.LAST_PENDING_ACTIVITY_DESC;
        lbl_doneActivitydescription.text = opportunity_list.LAST_DONE_ACTIVITY_DESC;

        NSLog(@"activity pending date %d", lbl_activityPendingdate.text.length);

        if (lbl_activityPendingdate.text.length == 0) {

            lbl_activityPendingdate.text = @"Not Available";
        }

        if (lbl_doneActivitydate.text.length == 0) {

            lbl_doneActivitydate.text = @"Not Available";
        }

        if (lbl_Acctivitytype.text.length == 0) {

            lbl_Acctivitytype.text = @"Not Available";
        }

        if (lbl_doneActivitytype.text.length == 0) {

            lbl_doneActivitytype.text = @"Not Available";
        }

        if (lbl_pendingActivitydescription.text.length == 0) {

            lbl_pendingActivitydescription.text = @"Not Available";
        }

        if (lbl_doneActivitydescription.text.length == 0) {

            lbl_doneActivitydescription.text = @"Not Available";
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//network connectivity status

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

- (void)viewWillAppear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LinkCampaignListFound:) name:@"LinkCampaign_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectLinkCampaignListFound:) name:@"SelectLinkCampaign_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CreateQouteOptyUpdatedConnection_Found:) name:@"CreateQouteOptyUpdatedConnection_Found" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DoneUPdateOptyLastData_Found:) name:@"DoneUPdateOptyLastData_Found" object:nil];
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ProceedToQuoteCreationFound:) name:@"ProceedToQuoteCreation_Found" object:nil];
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AfterQuoteCreationFound:) name:@"AfterQuoteCreation_Found" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(detailsforopportunity_found:) name:@"detailsforopportunity_found" object:nil];
    
    //DoneUPdateOptyLastData_Found
}





-(void)viewWillDisappear:(BOOL)animated{


    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LinkCampaign_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SelectLinkCampaign_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CreateQouteOptyUpdatedConnection_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DoneUPdateOptyLastData_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ProceedToQuoteCreation_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AfterQuoteCreation_Found"object:nil];
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"detailsforopportunity_found" object:nil];


}

- (void)viewDidDisappear:(BOOL)animated
{



}

- (void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
- (void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

//DSE ACTIONS

- (IBAction)DSEupdateAction:(id)sender
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
    }else if([opportunity_list.SALE_STAGE_NAME containsString:@"Closed Lost at"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"This Opportunity is already Lost!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else if([opportunity_list.SALE_STAGE_NAME containsString:@"C3"] ||[opportunity_list.SALE_STAGE_NAME containsString:@"C2"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"You cannot update opty after sale stage C1A"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else {
        
        UpdateOpportunityViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"update_opty"];
        //searchOpportunityResult_VC1.flagset=flag;
        
        [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
    }
}

- (IBAction)DSEpendingAction:(id)sender
{
    flag=1;

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

    PendingActivitiesViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"PendingActivity"];
        searchOpportunityResult_VC1.flagset=flag;

    [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
    }
}

- (IBAction)DSElinkcampaignAction:(id)sender
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

        if ([opportunity_list.SALE_STAGE_NAME containsString:@"Closed Lost at"]) {
            if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

                alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                   message:@"Lost opportunity. can't link a campaign"
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

                alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                                   message:@"Lost opportunity. can't link a campaign"
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
        }

        else if ([opportunity_list.SALE_STAGE_NAME containsString:@"C2 "]) {
            if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                   message:@"Cant link campaign."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                                   message:@"Cant link campaign."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else if ([opportunity_list.SALE_STAGE_NAME containsString:@"C3"]) {
            if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

                alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                   message:@"Cant link campaign."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

                alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                                   message:@"Cant link campaign."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
        }

        else {
            NSString* envelopeText2 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                                @"<SOAP:Body>"
                                                @"<GetCampainDetailsForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                                @"<plname>%@</plname>"
                                                @"</GetCampainDetailsForDSM>"
                                                @"</SOAP:Body>"
                                                @"</SOAP:Envelope>",
                                                opportunity_list.PRODUCT_NAME1];

            NSData* envelope = [envelopeText2 dataUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText2);

            NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
            NSLog(@"URL IS %@", theurl);
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
            NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText2 length]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

            [[RequestDelegate alloc] initiateRequest:request name:@"Linkcampaign_Connection"];
        }
    }
}

- (IBAction)DSElostAction:(id)sender
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

    if ([opportunity_list.SALE_STAGE_NAME containsString:@"Closed Lost at"]) {
        if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                               message:@"This Opportunity is already Lost!"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                               message:@"This Opportunity is already Lost!"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if ([opportunity_list.SALE_STAGE_NAME containsString:@"C3"]) {
        if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                               message:@"Vehicle already delivered!"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

            alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                               message:@"Vehicle already delivered!"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        //storyBoard_LostOpty
        LostOpportunityViewController* lostOpportunity_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyBoard_LostOpty"];
        [self.navigationController pushViewController:lostOpportunity_VC1 animated:YES];
    }
    }
}

- (IBAction)DSEquoteAction:(id)sender
{
    
    //storyBoard_Assign

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
    if([opportunity_list.SALE_STAGE_NAME containsString:@"C1 (Quote Tendered)"] || [opportunity_list.SALE_STAGE_NAME containsString:@"C2"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                           message:@"Quote is already Created"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else if([opportunity_list.SALE_STAGE_NAME containsString:@"Closed Lost at"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                           message:@"This Opportunity is already lost!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
        
    }
    else if([opportunity_list.SALE_STAGE_NAME containsString:@"C3"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                           message:@"Vehicle is already delivered!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else if([opportunity_list.SALE_STAGE_NAME containsString:@"C1"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                           message:@"Vehicle is already delivered!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else
    {
        flagDSE=1;

       /* alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                           message:@"Do you want to create quote for this Opportunity ?"
                                          delegate:self
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Yes",nil];
        [alert show];*/
        
        appdelegate.fromCreatequote=@"fromCreatequote";
        
        UIAlertView *alertView = [UIAlertView new];
        alertView.title = @"Create Quote";
        alertView.delegate=self;
        alertView.tag = 1;
                // Adding Your Buttons
        [alertView addButtonWithTitle:@"Update Account"];
        [alertView addButtonWithTitle:@"Update Opportunity"];
        [alertView addButtonWithTitle:@"Proceed To Quote Creation"];
        [alertView addButtonWithTitle:@"Cancel"];
        [alertView show];

        /*
         if ([opportunity_list.ACCOUNT_ID isEqual:@""])
         {
         // call create Account
         CreateQouteController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"createQoute_StoryBoard"];
         searchOpportunityResult_VC.optyContact=opportunity_list.CONTACT_ID;
         [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
         }
         else
         {
         NSLog(@"Account Id :");
         //createQoute_StoryBoard
         // Call create Qoute
         
         
         }*/
        
    }
    }
    
   // AssignViewController* lostOpportunity_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyBoard_Assign"];
   // [self.navigationController pushViewController:lostOpportunity_VC1 animated:YES];
}

- (IBAction)DSEactivityAction:(id)sender
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
        ActivityViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateActivity"];
        [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
    }
}

/////DSM ACTIONS

- (IBAction)DSMupdateAction:(id)sender
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
    }else if([opportunity_list.SALE_STAGE_NAME containsString:@"Closed Lost at"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"This Opportunity is already Lost!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else if([opportunity_list.SALE_STAGE_NAME containsString:@"C3"] ||[opportunity_list.SALE_STAGE_NAME containsString:@"C2"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"You cannot update opty after sale stage C1A"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else {
        
        UpdateOpportunityViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"update_opty"];
        //searchOpportunityResult_VC1.flagset=flag;
        
        [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
    }
    

}

- (IBAction)DSMassignAction:(id)sender
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
        //storyBoard_Assign
        AssignViewController* lostOpportunity_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyBoard_Assign"];
        [self.navigationController pushViewController:lostOpportunity_VC1 animated:YES];

    }
}

- (IBAction)DSMlinkcampaignAction:(id)sender
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
        
        if ([opportunity_list.SALE_STAGE_NAME containsString:@"Closed Lost at"]) {
            if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                
                alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                   message:@"Lost opportunity. can't link a campaign"
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                
                alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                                   message:@"Lost opportunity. can't link a campaign"
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        
        else if ([opportunity_list.SALE_STAGE_NAME containsString:@"C2"]) {
            if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                   message:@"Cant link campaign."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                                   message:@"Cant link campaign."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else if ([opportunity_list.SALE_STAGE_NAME containsString:@"C3"]) {
            if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                
                alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                   message:@"Cant link campaign."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                
                alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                                   message:@"Cant link campaign."
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        
        else {
            NSString* envelopeText2 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetCampainDetailsForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<plname>%@</plname>"
                                       @"</GetCampainDetailsForDSM>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",
                                       opportunity_list.PRODUCT_NAME1];
            
            NSData* envelope = [envelopeText2 dataUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText2);
            
            NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
            NSLog(@"URL IS %@", theurl);
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
            NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText2 length]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
            
            [[RequestDelegate alloc] initiateRequest:request name:@"Linkcampaign_Connection"];
        }
    }

    
}

- (IBAction)DSMlostAction:(id)sender
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
    if ([opportunity_list.SALE_STAGE_NAME containsString:@"Closed Lost at"]) {
        alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                           message:@"This Opportunity is already Lost!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([opportunity_list.SALE_STAGE_NAME containsString:@"C3"]) {
        alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                           message:@"Vehicle already delivered!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        //storyBoard_LostOpty
        LostOpportunityViewController* lostOpportunity_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyBoard_LostOpty"];
        [self.navigationController pushViewController:lostOpportunity_VC1 animated:YES];
    }
    }
}

- (IBAction)DSMactivityAction:(id)sender
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
        ActivityViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateActivity"];
        [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
    }
    //ActivityViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateActivity"];
    //[self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
}

- (IBAction)DSMpendingAction:(id)sender
{
    flag=1;

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
    PendingActivitiesViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"PendingActivity"];
        searchOpportunityResult_VC1.flagset=flag;

    [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
    }
}

//NEEV  ACTION

- (IBAction)NEEVupdateaction:(id)sender
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
    }else if([opportunity_list.SALE_STAGE_NAME containsString:@"Closed Lost at"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"This Opportunity is already Lost!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else if([opportunity_list.SALE_STAGE_NAME containsString:@"C3"] ||[opportunity_list.SALE_STAGE_NAME containsString:@"C2"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"You cannot update opty after sale stage C1A"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else {
        
        UpdateOpportunityViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"update_opty"];
        //searchOpportunityResult_VC1.flagset=flag;
        
        [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
    }
    
}

- (IBAction)NEEVassignAction:(id)sender
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
        //storyBoard_Assign
        AssignViewController* lostOpportunity_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyBoard_Assign"];
        [self.navigationController pushViewController:lostOpportunity_VC1 animated:YES];
        
    }

}

- (IBAction)NEEVquoteAction:(id)sender
{
    NSLog(@"Account Id: %@",opportunity_list.ACCOUNT_ID);
    
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
    if([opportunity_list.SALE_STAGE_NAME containsString:@"C1 (Quote Tendered)"] || [opportunity_list.SALE_STAGE_NAME containsString:@"C2"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"Quote is already Created"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else if([opportunity_list.SALE_STAGE_NAME containsString:@"Closed Lost at"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"This Opportunity is already lost!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
        
    }
    else if([opportunity_list.SALE_STAGE_NAME containsString:@"C3"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"Vehicle is already delivered!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else if([opportunity_list.SALE_STAGE_NAME containsString:@"C1"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"Vehicle is already delivered!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
    }
    else
    {
        flagQoute=1;
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"Do you want to create quote for this Opportunity ?"
                                          delegate:self
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Yes",nil];
        [alert show];
        
        /*
         if ([opportunity_list.ACCOUNT_ID isEqual:@""])
         {
         // call create Account
         CreateQouteController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"createQoute_StoryBoard"];
         searchOpportunityResult_VC.optyContact=opportunity_list.CONTACT_ID;
         [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
         }
         else
         {
         NSLog(@"Account Id :");
         //createQoute_StoryBoard
         // Call create Qoute
         
         
         }*/
      }
    }
}

- (IBAction)NEEVLostaction:(id)sender
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
    if ([opportunity_list.SALE_STAGE_NAME containsString:@"Closed Lost at"]) {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"This Opportunity is already Lost!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([opportunity_list.SALE_STAGE_NAME containsString:@"C3"]) {
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"Vehicle already delivered!"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        //storyBoard_LostOpty
        LostOpportunityViewController* lostOpportunity_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyBoard_LostOpty"];
        [self.navigationController pushViewController:lostOpportunity_VC1 animated:YES];
     }
    }
}

- (IBAction)NEEVpendingaction:(id)sender
{
    flag=1;

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
    PendingActivitiesViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"PendingActivity"];
    searchOpportunityResult_VC1.flagset=flag;
    [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
    }

}

- (IBAction)NEEVnewactivityaction:(id)sender
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
    ActivityViewController* searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateActivity"];
    [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
    }
}

- (int)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

- (int)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
   
    return 3;
}

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    
   return [NSString stringWithFormat:@"Choice-%d",row];
}

- (void)pickerView:(UIPickerView*)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{

    self.selectedLinkCampaignValue = [NSString stringWithFormat:@"%@", [[self.LinkCampaignList objectAtIndex:row] valueForKey:@"CAM_ID"]];
    
    
    NSLog(@"link campaign value %@", self.selectedLinkCampaignValue);
}

- (void)LinkCampaignListFound:(NSNotification*)notification // Activity Response
{
    NSString* response = [[notification userInfo] objectForKey:@"response"];

    NSLog(@"\n PendingActivityDetails_Connection response... %@ ", response);
    NSError* err;
    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

    TBXMLElement* soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement* container = [TBXML childElementNamed:@"GetCampainDetailsForDSMResponse" parentElement:soapBody];
    if (container) {
        self.LinkCampaignList = [[NSMutableArray alloc] init];
        
        self.Linkcampaignname =[[NSMutableArray alloc] init];
      self.LinkcampaignID =[[NSMutableArray alloc] init];
        
        
        
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        ///  NSLog(@"Tuple..%@",tuple);
        if (tuple) {
            do {
                // activityPending_list = nil;
                LinkCampaignListView* LinkCampaign_list = [[LinkCampaignListView alloc] init];

                TBXMLElement* S_SRC = [TBXML childElementNamed:@"S_SRC" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];

                TBXMLElement* CAM_NAME = [TBXML childElementNamed:@"CAM_NAME" parentElement:S_SRC];
                LinkCampaign_list.CAM_NAME = [TBXML textForElement:CAM_NAME];
                
                
                [self.Linkcampaignname addObject:LinkCampaign_list.CAM_NAME];
                
                
                if (![TBXML textForElement:CAM_NAME]) {
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Campaign list not found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }
                TBXMLElement* CAM_ID = [TBXML childElementNamed:@"CAM_ID" parentElement:S_SRC];
                LinkCampaign_list.CAM_ID = [TBXML textForElement:CAM_ID];
                
                [self.LinkcampaignID addObject:LinkCampaign_list.CAM_ID];
                

                TBXMLElement* CAMPAIGN_DESCRIPTION = [TBXML childElementNamed:@"CAMPAIGN_DESCRIPTION" parentElement:S_SRC];
                LinkCampaign_list.CAMPAIGN_DESCRIPTION = [TBXML textForElement:CAMPAIGN_DESCRIPTION];

                [self.LinkCampaignList addObject:LinkCampaign_list];
                
                
            } while ((tuple = tuple->nextSibling));
            // [self._tableView reloadData];
        }
        else {

            [self hideAlert];

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Campaign list not found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            alert.tag = 200;

            [alertView show];
            NSLog(@"here ");
        }

        int counterString1 = [self.LinkCampaignList count];
        if (counterString1 >= 0) {
            
            
            
            
          actionSheet = [[UIActionSheet alloc] initWithTitle:@"Link Campaign"
                                                      delegate:self
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil];
            
            for (NSString* title in self.Linkcampaignname) {
                [actionSheet addButtonWithTitle:title];
            }
            actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
            actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
               [actionSheet showInView:self.view];
                
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 5;

        }
        else {
            NSLog(@"failed");
        }
    }
}

- (void)DoneButton
{
    NSLog(@"link  %@", self.selectedLinkCampaignValue);
    [self showAlert];

    if (linkcampaignselectedid.length == 0) {

        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please select value " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Please  select value " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        NSLog(@"opty id %@%@%@", opportunity_list.CONTACT_ID, opportunity_list.OPTY_ID, self.selectedLinkCampaignValue);

        NSString* envelopeText1 = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:con=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                            @"<soapenv:Header/>"
                                            @"<soapenv:Body>"
                                            @"<asi:SFATMCVContactInsertOrUpdate_Input>"
                                            @"<con:ListOfContactInterface>"
                                            @"<con:Contact operation=\"?\">"
                                            @"<con:Id>%@</con:Id>"
                                            @"<con:ListOfOpportunity>"
                                            @"<con:Opportunity operation=\"?\">"
                                            @"<con:Id>%@</con:Id>"
                                            @"<con:ListOfOpportunityRelatedCampaigns>"
                                            @"<con:OpportunityRelatedCampaigns operation=\"Insert\">"
                                            @"<con:Id>%@</con:Id>"
                                            @"</con:OpportunityRelatedCampaigns>"
                                            @"</con:ListOfOpportunityRelatedCampaigns>"
                                            @"</con:Opportunity>"
                                            @"</con:ListOfOpportunity>"
                                            @"</con:Contact>"
                                            @"</con:ListOfContactInterface>"
                                            @"<asi:StatusObject>?</asi:StatusObject>"
                                            @"</asi:SFATMCVContactInsertOrUpdate_Input>"
                                            @"</soapenv:Body>"
                                            @"</soapenv:Envelope>",
                                            opportunity_list.CONTACT_ID, opportunity_list.OPTY_ID,linkcampaignselectedid];

        NSData* envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];

        NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
        NSLog(@"URL IS %@", envelopeText1);
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
        NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText1 length]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

        [[RequestDelegate alloc] initiateRequest:request name:@"Linkcampaign_select_request"];
//        self.LinkCampaignList = nil;
//        CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
//        CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height + 44, 320, 216);
//        [UIView beginAnimations:@"MoveOut" context:nil];
//        [self.view viewWithTag:9].alpha = 0;
//        [self.view viewWithTag:10].frame = datePickerTargetFrame;
//        [self.view viewWithTag:11].frame = toolbarTargetFrame;
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationDidStopSelector:@selector(removeViews:)];
//        [UIView commitAnimations];
    }
}
- (void)removeViews:(id)object
{
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

- (void)CancelButtonClicked:(id)sender
{
    self.LinkCampaignList = nil;
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height + 44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
    self.selectedLinkCampaignValue = @"";
}

- (void)dismissDatePicker:(id)sender
{
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height + 44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
}

- (void)SelectLinkCampaignListFound:(NSNotification*)notification // Activity Response
{
    NSString* response = [[notification userInfo] objectForKey:@"response"];

    NSLog(@"\n Select_link_Campaign_Connection response... %@ ", response);

    NSError* err;

    if ([response isEqual:@""]) {
        // [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        }else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if ([response rangeOfString:@"soapenv:Fault"].location != NSNotFound) {
        if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong . Please try agin" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong . Please try agin" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }

    else {

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        //
        TBXMLElement* soapBody = [TBXML childElementNamed:@"soapenv:Body" parentElement:tbxml.rootXMLElement];
        TBXMLElement* container = [TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:soapBody];
        if (container) {

            TBXMLElement* ListOfContactInterface = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];

            TBXMLElement* Contact = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];

            TBXMLElement* IntegrationId = [TBXML childElementNamed:@"IntegrationId" parentElement:Contact];

            if ([TBXML textForElement:IntegrationId]) {
                [self hideAlert];

                if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

                    alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                                       message:@"Campaign linked successfully"
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
                    [alert show];
                    self.selectedLinkCampaignValue = @"";
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                       message:@"Campaign linked successfully"
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
                    [alert show];
                    self.selectedLinkCampaignValue = @"";
                }
            }

            else {

                [self hideAlert];

                if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

                    alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                                       message:@"Campaign linking failed"
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
                    [alert show];
                    self.selectedLinkCampaignValue = @"";
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                       message:@"Campaign linking failed "
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
                    [alert show];
                    self.selectedLinkCampaignValue = @"";
                }
            }
        }
    }
}

-(void)CallCreateQoute {
    
    [self showAlert];
    
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
     "</Name></Quote_SalesTeam></ListOfQuote_SalesTeam></Quote></ListOfQuoteInterface>" +
     "</SFATMCVQuoteInsertOrUpdate_Input></SOAP:Body></SOAP:Envelope>"
     */
    
    
    NSString * envelopeText = [NSString stringWithFormat:
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
                               @"</SOAP:Envelope>",opportunity_list.ACCOUNT_ID];
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getCreateQouteConnection"];
}


///
-(void)CallCreateQouteAgain {
    
    
    NSLog(@"Account Id :%@",opportunity_list.ACCOUNT_ID);
    
    //[self showAlert];
    
    /*<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body>" +
     "<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">" +
     "<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%20Opportunity%20Interface\"><Opportunity><Id>" +
     _ad.OPTY_ID +
     "</Id><SalesStage>C1A (Papers submitted)</SalesStage></Opportunity></ListOfTMOpportunityInterface></SFATMCVOPTYInsertOrUpdate_Input></SOAP:Body></SOAP:Envelope> */
    /*
     
     NSString * envelopeText = [NSString stringWithFormat:
     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     @"<SOAP:Body>"
     @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
     @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
     @"<Opportunity>"
     @"<Id></Id>"
     @"<SalesStage>C1A (Papers submitted)</SalesStage>"
     @"</Opportunity>"
     @"</ListOfTMOpportunityInterface>"
     @"</SFATMCVOPTYInsertOrUpdate_Input>"
     @"</SOAP:Body>"
     @"</SOAP:Envelope>"];
     
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
     
     [[RequestDelegate alloc]initiateRequest:request name:@"getCreateQouteConnection"];*/
}

-(void)CallCreateAccount {
    
    
    
    //[self showAlert];
    
    /*"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"> <SOAP:Body> <SFATMCVAccountInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\"><ListOfAccountInterface xmlns=\"http://www.siebel.com/xml/Account%20Interface\"> <Account operation=\"insert\"> <MainPhoneNumber>" +
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
     "</ListOfRelatedContact> </Account></ListOfAccountInterface></SFATMCVAccountInsertOrUpdate_Input></SOAP:Body></SOAP:Envelope>"/
     */
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                               @"<Opportunity>"
                               @"<Id></Id>"
                               @"<SalesStage>C1A (Papers submitted)</SalesStage>"
                               @"</Opportunity>"
                               @"</ListOfTMOpportunityInterface>"
                               @"</SFATMCVOPTYInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"];
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getCreateQouteConnection"];
}
-(void)call_CreateQoute
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
    
    NSLog(@"Login Name : %@",userDetailsVal_.Login_Name);
    
    NSString * envelopeText = [NSString stringWithFormat:
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
                               @"</Quote></ListOfQuoteInterface></SFATMCVQuoteInsertOrUpdate_Input></SOAP:Body></SOAP:Envelope>",(long)[[NSDate date]timeIntervalSince1970],opportunity_list.ACCOUNT_ID,opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,opportunity_list.PRODUCT_NAME,opportunity_list.PRODUCT_NAME1,userDetailsVal_.Login_Name,userDetailsVal_.POSITION_NAME,userDetailsVal_.ROW_ID,userDetailsVal_.ORGNAME,(long)[[NSDate date]timeIntervalSince1970],opportunity_list.VC,opportunity_list.VC,userDetailsVal_.Login_Name,userDetailsVal_.POSITION_NAME];
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getupdateOptyQouteConnection"];
}
//CreateQouteOptyUpdatedConnection_Found
-(void)CreateQouteOptyUpdatedConnection_Found:(NSNotification*)notification
{
    
    NSError *err;
    
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n Opportunity :  %@ ",response);
    
    if([response isEqual:@""])
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"There has been a technical issue. We couldn't create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"There has been a technical issue. We couldn't Create Qoute for this Opportunity !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    else{
        if (ProductDetailsUpdate_Arr)
        {
            [ProductDetailsUpdate_Arr removeAllObjects];
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        TBXMLElement *container = [TBXML childElementNamed:@"ListOfQuoteInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVQuoteInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]]];
        
        TBXMLElement *tuple =[TBXML childElementNamed:@"Quote" parentElement:container];
        
        if (tuple)
        {
            TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:tuple];
            
            optyIdCreated = [TBXML textForElement:Id];
            
            [self Call_DoneUPdateOptyLast];
            
        }else
        {
            [self hideAlert];
            alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
-(void)Call_DoneUPdateOptyLast
{
    NSLog(@"... Opty Id L %@",opportunity_list.OPTY_ID);
    NSString * envelopeText = [NSString stringWithFormat:
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
                               @"</SOAP:Envelope>",opportunity_list.OPTY_ID];
    
    NSLog(@"\n envlopeString Of Product Name details....!!!!%@",envelopeText);
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getDoneUPdateOptyLastConnection"];
    
}

-(void)DoneUPdateOptyLastData_Found:(NSNotification*)notification
{
    
    NSError *err;
    
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n Create Qoute Opty done Response : %@ ",response);
    
    if([response isEqual:@""]){
        [self hideAlert];
        NSLog(@"Data....nhi ahe ");
    }
    else{
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        TBXMLElement *container = [TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]]];
        
        TBXMLElement *Opportunity =[TBXML childElementNamed:@"Opportunity" parentElement:container];
        if (Opportunity)
        {
            TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
            NSString *str_NAME = [TBXML textForElement:S_Lst_Of_Val];
            NSLog(@"\n str_NSE : %@",str_NAME);
            if (str_NAME.length!=0) {
                NSLog(@"Qoute created ");
                [self hideAlert];
                setflag=1;
                alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Qoute Created successfully !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                NSLog(@"Error While updating Sales Stage");
                [self hideAlert];

                alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Error While updating Sales Stage.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        if(flagDSE==1)
        {
            [self performSegueWithIdentifier:@"Create Account" sender:nil];

        }else if(setflag==1){
            NSLog(@"David Miller");
        }
        else
        {
            
        }
    }
    if (buttonIndex==1) {
        if (flagQoute==1) {
            
            if ([opportunity_list.ACCOUNT_ID isEqual:@""])
            {
                
                // call create Account
                CreateQouteController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"createQoute_StoryBoard"];
               // searchOpportunityResult_VC.optyContact=opportunity_list.CONTACT_ID;
                //searchOpportunityResult_VC.optyContact=opportunity_list.CONTACT_ID;
                searchOpportunityResult_VC.optyContact=opportunity_list.CONTACT_ID;
                [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
            }
            else
            {
                NSLog(@"Account Id :");
                
                [self showAlert];
                [self call_CreateQoute];
            }
        }else if (flagDSE==1)
        {
            [self performSegueWithIdentifier:@"UpdateOpty" sender:nil];
 
        }else{
            LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self presentViewController:secondViewController animated:YES completion:nil ];
        }
    } if (buttonIndex==2) {
    
        if (flagDSE==1)
        {
            [self proceedToQuoteCreation];
        }
    }
    if (buttonIndex==3) {
        
        if (flagDSE==1)
        {
            
        }
    }
    if (buttonIndex==4) {
        if (flagDSE==1)
        {
            
        }
        
    }if (buttonIndex==5) {
        
        if (flagDSE==1)
        {
            
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*if ([[segue identifier] isEqualToString:@"pendingActivity"])
    {
        flag=1;
        ActivityDetailsViewController *detailViewController =
        [segue destinationViewController];
        detailViewController.flagset=flag;
    }*/
}


-(void)proceedToQuoteCreation
{
    if([opportunity_list.SALE_STAGE_NAME containsString:@"C1 (Quote Tendered)"] || [opportunity_list.SALE_STAGE_NAME containsString:@"C2"]){
        
        alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Your Quote Has Been Already Generated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

   /* if ([self.SALES_STAGE_NAME.text isEqualToString:@"C1 (Quote Tendered)"])
    {
        alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Your Quote Has Been Already Generated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }*/
    else
    {
        [self showAlert];
    
        NSLog(@"%@",userDetailsVal_.Login_Name);

        envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        "<SOAP:Body>"
                        "<SFATMCVQuoteInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                        "<ListOfQuoteInterface xmlns=\"http://www.siebel.com/xml/Quote%%20Interface\">"
                        "<Quote operation=\"insert\">"
                        "<IntegrationId>%ld</IntegrationId>"
                        "<ContactId>%@</ContactId>"
                        "<OpportunityId>%@</OpportunityId>"
                        "<TMParentProductLine>%@</TMParentProductLine>"
                        "<TMProductLine>%@</TMProductLine>"
                        "<SalesRepLogin>%@</SalesRepLogin>"
                        "<SalesRepPosition>%@</SalesRepPosition>"
                        "<SalesRepPositionId>%@</SalesRepPositionId>"
                        "<ListOfRelatedOrganization>"
                        "<RelatedOrganization IsPrimaryMVG=\"Y\">"
                        "<Organization>%@</Organization>"
                        "</RelatedOrganization>"
                        "</ListOfRelatedOrganization>"
                        "<ListOfLineItems>"
                        "<LineItems>"
                        "<ProductType>Vehicle</ProductType>"
                        "<IntegrationId>%ld</IntegrationId>"
                        "<ProductName>%@</ProductName>"
                        "<RequestedQuantity>1</RequestedQuantity>"
                        "<ProductVCNo>%@</ProductVCNo>"
                        "</LineItems>"
                        "</ListOfLineItems>"
                        "<ListOfQuote_SalesTeam>"
                        "<Quote_SalesTeam IsPrimaryMVG=\"Y\">"
                        "<SalesTeam>%@</SalesTeam>"
                        "<Name>%@</Name>"
                        "</Quote_SalesTeam>"
                        "</ListOfQuote_SalesTeam>"
                        "</Quote>"
                        "</ListOfQuoteInterface>"
                        "</SFATMCVQuoteInsertOrUpdate_Input>"
                        "</SOAP:Body>"
                        "</SOAP:Envelope>",(long)[[NSDate date] timeIntervalSince1970],opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,opportunity_list.PRODUCT_NAME,opportunity_list.PRODUCT_NAME1,userDetailsVal_.Login_Name,userDetailsVal_.POSITION_NAME,userDetailsVal_.ROW_ID,userDetailsVal_.ORGNAME,(long)[[NSDate date] timeIntervalSince1970],opportunity_list.VC,opportunity_list.VC,userDetailsVal_.Login_Name,userDetailsVal_.POSITION_NAME];
        
        /*
         (long)[[NSDate date] timeIntervalSince1970],
         appdelegate.CONTACT_ID,
         appdelegate.opty_idDetailPage,
         appdelegate.PRODUCT_NAME,
         appdelegate.PRODUCT_NAME1,
         userDetailsVal_.Login_Name,
         userDetailsVal_.POSITION_NAME,
         userDetailsVal_.ROW_ID,
         userDetailsVal_.ORGNAME,
         (long)[[NSDate date] timeIntervalSince1970],
         appdelegate.VC,
         appdelegate.VC,
         userDetailsVal_.Login_Name,
         userDetailsVal_.POSITION_NAME
         */

        NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
        NSLog(@"URL IS %@",theurl);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
        NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
        
        [[RequestDelegate alloc]initiateRequest:request name:@"ProceedToQuoteCreation_Connection"];
    }
}
-(void)ProceedToQuoteCreationFound:(NSNotification*)notification
{
    
    [self hideAlert];//Abhishek
    
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n ProceedTo_Quote_Creation_Connection response... %@ ",response);
    NSError *err;
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
        
        TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVQuoteInsertOrUpdate_Output" parentElement:soapBody];
        if(container)
        {
            TBXMLElement *ListOfQuoteInterface =[TBXML childElementNamed:@"ListOfQuoteInterface" parentElement:container];
            TBXMLElement *Quote =[TBXML childElementNamed:@"Quote" parentElement:ListOfQuoteInterface];
            if(Quote)
            {
                //container = [TBXML childElementNamed:@"S_USER" parentElement:[TBXML childElementNamed:@"old" parentElement:Contact]];
                TBXMLElement *ListOfPersonalAddress = [TBXML childElementNamed:@"Id" parentElement:Quote];
                TBXMLElement *IntegrationId = [TBXML childElementNamed:@"IntegrationId" parentElement:Quote];
                NSString * IntegrationIdstring = [TBXML textForElement:IntegrationId];
                
                if (IntegrationIdstring)
                {
                    //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Done" message:@"Quote Generation has been Successfull" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //                [alert show];
                    
                    NSString * envelopeText1 = [NSString stringWithFormat: @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
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
                                                @"</SOAP:Envelope>",opportunity_list.OPTY_ID];
                    
                    
                    NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
                    NSLog(@"URL IS %@",theurl);
                    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
                    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
                    [request setHTTPMethod:@"POST"];
                    [request setHTTPBody:envelope];
                    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
                    
                    [[RequestDelegate alloc]initiateRequest:request name:@"AfterQuoteCreation_Connection"];
                    
                }
                else  if (!IntegrationIdstring)
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Quote not Generated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
                
            }
            else
            {
                // [appdelegate hideAlert];
                alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }
        else
        {
            // [appdelegate hideAlert];
            alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
-(void)AfterQuoteCreationFound:(NSNotification*)notification
{
    
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n AfterQuoteCreationFoundConnection response... %@ ",response);
    NSError *err;
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
        
        TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:soapBody];
        if(container)
        {
            TBXMLElement *ListOfTMOpportunityInterface =[TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:container];
            TBXMLElement *Opportunity =[TBXML childElementNamed:@"Opportunity" parentElement:ListOfTMOpportunityInterface];
            if(Opportunity)
            {
                TBXMLElement *IntegrationId = [TBXML childElementNamed:@"IntegrationId" parentElement:Opportunity];
                TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
                NSString * IntegrationIdstring = [TBXML textForElement:IntegrationId];
                
                if (IntegrationIdstring)
                {
                    //self.SALES_STAGE_NAME.text=@"C1 (Quote Tendered)";
                    lbl_salesStagename.text=@"C1 (Quote Tendered)";
                    alert=[[UIAlertView alloc]initWithTitle:@"Done" message:@"Quote has been generated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }
            else
            {
                alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Error While Generating Quote" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}



-(void)optydetail{

 
        NSLog(@"\n envlopeString Of OPP....!!!!%@",userDetailsVal_.ROW_ID);
        
        NSString * envelopeText = [NSString stringWithFormat:
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
                                   @"<GetListOfOpportunityDsm xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                   @"<positionid>%@</positionid>"
                                   @"<optyid>%@</optyid>"
                                   @"</GetListOfOpportunityDsm>"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,opportunity_list.OPTY_ID];
        
        
        
        
        NSLog(@"\n envlopeString Of OPP....!!!!%@",envelopeText);
        //NSLog(@"URL : %@",appdelegate.artifact);
        NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
        // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
        NSLog(@"URL IS %@",theurl);
        // NSLog(@"REQUEST IS %@",envelopeText);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
        
        NSLog(@"Request.... %@",request);
        
        NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
        
        [[RequestDelegate alloc]initiateRequest:request name:@"getdetailsforopportunity"];
        
        
        
    }
    
    
-(void)detailsforopportunity_found:(NSNotification*)notification
    {
        OpportunityList_ArrList=[[NSMutableArray alloc] init];
        OpportunityListDisplayArr=[[NSMutableArray alloc] init];
        
        
        int i = 0; //for test loop
        NSError *err;
        NSString *response=[[notification userInfo]objectForKey:@"response"];
        NSLog(@"\n opportuntyCount response..... %@ ",response);
        if ([response isEqual:@""])
        {
            //[self hideAlert];
            NSLog(@"Nko re..");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
        {
            // [self hideAlert];
            NSLog(@"Dishkyauuu");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        else
        {
            NSLog(@"Wachnag...");
            // [self hideAlert];
            TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            TBXMLElement *container = [TBXML childElementNamed:@"GetListOfOpportunityDsmResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            if (OpportunityList_ArrList)
            {
                [ OpportunityList_ArrList removeAllObjects];
                
            }
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
         
                do {
                    opportunity_list = nil;
                    opportunity_list = [[Opportunity_List alloc]init];
                    
                   
                    TBXMLElement *table  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    
                    
                    
                    TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                    opportunity_list.OPTY_ID = [TBXML textForElement:OPTY_ID];
                    
                    
                    NSLog(@"OptyID : %@",opportunity_list.OPTY_ID);
                    
                    
                    TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                    opportunity_list.OPTY_NAME = [TBXML textForElement:OPTY_NAME];
                    
                    NSLog(@"name : %@",opportunity_list.OPTY_NAME);
                    
                    
                    
                    
                    
                    TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME1" parentElement:table];
                    opportunity_list.PRODUCT_NAME1 = [TBXML textForElement:PRODUCT_NAME];
                    NSLog(@"productname : %@",opportunity_list.PRODUCT_NAME1);
                    
                    
                    
                    
                    TBXMLElement *OPTY_CREATED_DATE = [TBXML childElementNamed:@"OPTY_CREATED_DATE" parentElement:table];
                    opportunity_list.OPTY_CREATED_DATE = [TBXML textForElement:OPTY_CREATED_DATE];
                    NSLog(@"optycreateddate : %@",opportunity_list.OPTY_CREATED_DATE);
                    
                    
                    
                    TBXMLElement *PRODUCT_ID = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:table];
                    opportunity_list.PRODUCT_ID = [TBXML textForElement:PRODUCT_ID];
                    NSLog(@"optycreateddate : %@",opportunity_list.PRODUCT_ID);
                    
                    
                    
                    TBXMLElement *SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                    opportunity_list.SALE_STAGE_NAME = [TBXML textForElement:SALES_STAGE_NAME];
                    
                    
                    
                    
                    
                    
                    TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                    opportunity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                    
                TBXMLElement *SALE_STAGE_UPDATED_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
               opportunity_list.SALES_STAGE_DATE = [TBXML textForElement:SALE_STAGE_UPDATED_DATE];
                    
                    
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
                    
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_TYPE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_TYPE" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_TYPE = [TBXML textForElement:LAST_DONE_ACTIVITY_TYPE];
                    
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_ID = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_ID" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_ID = [TBXML textForElement:LAST_DONE_ACTIVITY_ID];
                    
                    
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_DATE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DATE" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_DATE = [TBXML textForElement:LAST_DONE_ACTIVITY_DATE];
                    
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_DESC = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DESC" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_DESC = [TBXML textForElement:LAST_DONE_ACTIVITY_DESC];
                    
                    
                    
                    TBXMLElement *PRODUCT_NAME1 = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                    opportunity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME1];
                    
                    TBXMLElement *REV_PRODUCT_ID = [TBXML childElementNamed:@"REV_PRODUCT_ID" parentElement:table];
                    opportunity_list.REV_PRODUCT_ID = [TBXML textForElement:REV_PRODUCT_ID];
                    
                    
                    
                    TBXMLElement *CUSTOMER_ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                    opportunity_list.CUSTOMER_ACCOUNT_NAME = [TBXML textForElement:CUSTOMER_ACCOUNT_NAME];
                    
      
                    
                    
                
                    
                            lbl_optyID.text = opportunity_list.OPTY_ID;
                            lbl_customerCellno.text = opportunity_list.CONTACT_CELL_NUMBER;
                            lbl_optyCreationdate.text = opportunity_list.OPTY_CREATED_DATE;
                            lbl_salesStagename.text = opportunity_list.SALE_STAGE_NAME;
                            lbl_productName.text = opportunity_list.PRODUCT_NAME;
                    
                            //contact details
                    
                            lbl_contactName.text = opportunity_list.CONTACT_NAME;
                            lbl_contactCellno.text = opportunity_list.CONTACT_CELL_NUMBER;
                            lbl_contactAddress.text = opportunity_list.CONTACT_ADDRESS;
                    
                            //Account Details
                    
                            lbl_Accountname.text = opportunity_list.LEAD_ASSIGNED_NAME;
                            lbl_AccountcustomerCellno.text = opportunity_list.LEAD_ASSIGNED_CELL_NUMBER;
                    
                            //Activity Details
                    
                            lbl_activityPendingdate.text = opportunity_list.LAST_PEND_ACTIVIY_START_DATE;
                            lbl_doneActivitydate.text = opportunity_list.LAST_DONE_ACTIVITY_DATE;
                            lbl_Acctivitytype.text = opportunity_list.LAST_PENDING_ACTIVITY_TYPE;
                            lbl_doneActivitytype.text = opportunity_list.LAST_DONE_ACTIVITY_TYPE;
                            lbl_pendingActivitydescription.text = opportunity_list.LAST_PENDING_ACTIVITY_DESC;
                            lbl_doneActivitydescription.text = opportunity_list.LAST_DONE_ACTIVITY_DESC;
                    
                    
                    
                            if ([lbl_activityPendingdate isEqual:@""]) {
                    
                                lbl_activityPendingdate.text = @"None";
                            }
                    
                            if ([lbl_doneActivitydate isEqual:@""]) {
                    
                                lbl_doneActivitydate.text = @"None";
                            }
                    
                            if ([lbl_Acctivitytype isEqual:@""]) {
                    
                                lbl_Acctivitytype.text = @"None";
                            }
                    
                            if ([lbl_doneActivitytype isEqual:@""]) {
                    
                                lbl_doneActivitytype.text = @"None";
                            }
                    
                            if ([lbl_pendingActivitydescription isEqual:@""]) {
                    
                                lbl_pendingActivitydescription.text = @"None";
                            }
                    
                            if ([lbl_doneActivitydescription isEqual:@""]) {
                    
                                lbl_doneActivitydescription.text = @"None";
                            }
                            
  
                 
                    
                    
                                   [self hideAlert];
                    
                    
                    
               
                    
                    
                    i++;
                    
                    NSLog(@"\n test opp.... %d!!!\n",i);
                    
               
                    
                    
                } while ((tuple = tuple->nextSibling));
              //  NSLog(@"\nOpportunityListDisplayArr......%d",[opportunitydetailsArr count]);
             
                
                
            }
            else
            {
                //  [self.opportunoity_tv setHidden:YES];
                [self hideAlert];
                alert=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"No Records Found."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    
    
- (void)actionSheet:(UIActionSheet*)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"button click ....%ld", (long)buttonIndex);
    
   
        switch (popup.tag) {
              
            case 5:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    NSLog(@"ek..");
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    
                    NSLog(@"%@", NSLocalizedString([self.Linkcampaignname objectAtIndex:buttonIndex], @""));
                 linkcampaignselectedname= NSLocalizedString([self.Linkcampaignname objectAtIndex:buttonIndex], @"");
                    linkcampaignselectedid= NSLocalizedString([self.LinkcampaignID objectAtIndex:buttonIndex], @"");
                    
                    
                }
        }
    [self DoneButton];

}

@end
