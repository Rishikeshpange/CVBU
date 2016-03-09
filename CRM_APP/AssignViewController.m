//
//  AssignViewController.m
//  CRM_APP
//
//  Created by admin on 19/10/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import "AssignViewController.h"
#import "Opportunity_List.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "AssignViewModel.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "ManageOpportunityViewController.h"
#import "LoginViewController.h"
#import "OpportunitySearchResultController.h"


@interface AssignViewController () {
    UIAlertView* alert;
    int flag;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
    
    NSMutableArray *ActivityIDArray;
    NSString* envelopeText;
    NSString* Contactidforassignactivity;


}
@end

@implementation AssignViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; //usedetails instance

    NSLog(@"User Position :%@", userDetailsVal_.POSTN);
    NSLog(@"User Postion :%@", userDetailsVal_.POSTN);
    
    
    

    if (![self connected]) {
        NSLog(@"Contact NAme : %@", opportunity_list.CONTACT_NAME);
        self.lab_contact_name.text = opportunity_list.CONTACT_NAME;
        self.lbl_phone_no.text = opportunity_list.CONTACT_CELL_NUMBER;
        self.lbl_product_name.text = opportunity_list.PRODUCT_NAME;
        self.lbl_date.text = opportunity_list.OPTY_CREAT_DATE;
        self.lbl_Sales_Stages.text = opportunity_list.SALE_STAGE_NAME;

        // not connected
        NSLog(@"Newtwork not Available...");
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        self.container.layer.borderWidth = 1.0f;
        self.container.layer.cornerRadius = 5;

        self.container.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;
    }
    else {
        NSLog(@"Contact NAme : %@", opportunity_list.CONTACT_NAME);
        self.lab_contact_name.text = opportunity_list.CONTACT_NAME;
        self.lbl_phone_no.text = opportunity_list.CONTACT_CELL_NUMBER;
        self.lbl_product_name.text = opportunity_list.PRODUCT_NAME;
        self.lbl_date.text = opportunity_list.OPTY_CREAT_DATE;
        self.lbl_Sales_Stages.text = opportunity_list.SALE_STAGE_NAME;

        self.container.layer.borderWidth = 1.0f;
        self.container.layer.cornerRadius = 5;

        self.btn_Assign.layer.cornerRadius = 3;
        self.btn_Assign.layer.masksToBounds = YES;

        self.container.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AssignDSE_Found:) name:@"AssignDSE_Found" object:nil]; //For Sale Satge PPL Dropdown Count
    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ModeLostOpty_Found:) name:@"ModeLostOpty_Found" object:nil];//For sale SatgeFailed DropDown fail
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActivityListFound:) name:@"ActivityListFound" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActivityListFound:) name:@"Activityassign_Found" object:nil];
    
    //Activityassign_Found}
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AssignDSE_Found" object:nil];
    
       [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ActivityListFound" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Activityassign_Found" object:nil];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)callAssignOpty
{
    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                       @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                                       @"<Opportunity operation=\"update\">"
                                       @"<Id>%@</Id>"
                                       @"<ListOfOpportunityRelatedSalesRep>"
                                       @"<OpportunityRelatedSalesRep IsPrimaryMVG=\"Y\">"
                                       @"<PositionId>%@</PositionId>"
                                       @"</OpportunityRelatedSalesRep>"
                                       @"</ListOfOpportunityRelatedSalesRep>"
                                       @"</Opportunity>"
                                       @"</ListOfTMOpportunityInterface>"
                                       @"</SFATMCVOPTYInsertOrUpdate_Input>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",
                                       opportunity_list.OPTY_ID, assign_list.POSITION_ID];

    NSLog(@"\n envlopeString Of user details....Assign!!!!%@", envelopeText);

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
    [[RequestDelegate alloc] initiateRequest:request name:@"getAssignOptyConnection"];
}

- (void)AssignDSE_Found:(NSNotification*)notification
{
    ListofDSE_Arr = [[NSMutableArray alloc] init];
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ", response);

    if ([response isEqual:@""]) {
        if ([response isEqual:@""]) {
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                [self hideAlert];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                [self hideAlert];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
        else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                [self hideAlert];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                [self hideAlert];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
          }
        }

        else {
            if (ListofDSE_Arr) {
                [ListofDSE_Arr removeAllObjects];
            }

            TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

            NSLog(@"Which.."); //ListOfTMOpportunityInterface
            TBXMLElement* container = [TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]]];
            NSLog(@"Which..1");
            TBXMLElement* Opportunity = [TBXML childElementNamed:@"Opportunity" parentElement:container];

            NSLog(@"Which..2");

            NSLog(@"Which..3");

            if (Opportunity) {
                [self hideAlert];
                TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
                [self hideAlert];
                updateActivty.Id_ = [TBXML textForElement:Id];
                NSLog(@"\nListOfContactInterface.....!!!!!%@", updateActivty.Id_);
                flag=1;
                
                
                
                
                
                if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                    [self hideAlert];

                    alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Opportunity Assigned successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                    [self hideAlert];

                    alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Opportunity Assigned successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
                
                
                
             //   [self searchActivity];
                
                
            }
            else {
                [self hideAlert];
                if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                    alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }
    //  [self hideAlert];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_Assign:(id)sender
{

    if (![self connected]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            NSLog(@"Newtwork not Available...");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else {

        NSLog(@".. Postion Id %@", assign_list.POSITION_ID);
        NSLog(@".. Opty Id %@", opportunity_list.OPTY_ID);
        NSLog(@"App tableCounter %@", userDetailsVal_.POSTN);
        NSLog(@"App tableCounter %d", appdelegate.flagcheck);

        [self showAlert];
        if (!appdelegate.flagcheck == 1) {
            [self hideAlert];
            NSLog(@"12222");

            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                NSLog(@"12");
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                                   message:@"Please select DSE"
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                NSLog(@"125");

                alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                                   message:@"Please select DSE"
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else {
            NSLog(@"123");

            [self showAlert];
            [self callAssignOpty];
        }
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    NSLog(@"Button Index =%d",appdelegate.flagget);

    if (buttonIndex == 0) {
        
        NSLog(@"David Miller");
        
        if(flag==1)
        {
            if(appdelegate.flagget==1){
                NSLog(@"111");
                for (UIViewController *controller in self.navigationController.viewControllers)
                {
                    if ([controller isKindOfClass:[OpportunitySearchResultController class]])
                    {
                        [self.navigationController popToViewController:controller
                                                              animated:YES];
                        break;
                    }
                }
            }else
            {
                for (UIViewController *controller in self.navigationController.viewControllers)
                {
                    if ([controller isKindOfClass:[ManageOpportunityViewController class]])
                    {
                        [self.navigationController popToViewController:controller
                                                              animated:YES];
                        break;
                    }
                }
            }
        }
    }
    if (buttonIndex==1) {
        NSLog(@"Glen Maxwell");
        LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //[self.navigationController pushViewController:secondViewController animated:YES];
        [self presentViewController:secondViewController animated:YES completion:nil ];
        //  [self.navigationController popToRootViewControllerAnimated:TRUE];
        // [self dismissViewControllerAnimated:YES completion:nil];
        //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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

- (void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
- (void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)searchActivity{



    
    
    
         if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
             
             NSLog(@"NDRM Opportunuty List");
             
               envelopeText= [NSString stringWithFormat:
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
         
         else {
             
             NSLog(@"DSM Opportunuty List");
             
             envelopeText= [NSString stringWithFormat:
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

- (void)ActivityListFound:(NSNotification*)notification // Activity Response
{
    ActivityIDArray =[[NSMutableArray alloc]init];
    

    
    if (ActivityIDArray) {
        [ActivityIDArray removeAllObjects];
    }
    
    NSError* err;
    // TBXMLElement *X_PROSPECT_SRC;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n ActivityDetails_Connection response... %@ ", response);
    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    TBXMLElement* soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement* container = [TBXML childElementNamed:@"GetListOfActivityForOpportunityResponse" parentElement:soapBody];
    if (container) {
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
      
        if (tuple) {
            do {

               
                TBXMLElement* table = [TBXML childElementNamed:@"S_OPTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
               
                TBXMLElement* CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                Contactidforassignactivity = [TBXML textForElement:CONTACT_ID];
                
                
                
                TBXMLElement* ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
              NSString *actvityID = [TBXML textForElement:ACTIVITY_ID];
          
                //
                
                
                
                
                
                [ActivityIDArray addObject:actvityID];
                
                
                
                
            } while ((tuple = tuple->nextSibling));
            NSLog(@"Opty Id's 11%@", ActivityIDArray);
           // [self.TableView reloadData];
            if ([ActivityIDArray count] > 0) {
                NSLog(@"position :%@",userDetailsVal_.POSTN);
                
                [self hideAlert];
                
                
              //  [self AssignActivity];
                
            }
        }
        else {

            }
    
            }
            }



-(void)AssignActivity{




   envelopeText=[NSString stringWithFormat:@" <soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:con=\"http://www.siebel.com/xml/Contact%%20Interface\">"
    @"<soapenv:Header/>"
    @"<soapenv:Body>"
    @"<asi:TMCVSiebelContactInsertOrUpdate_Input>"
    @"<con:ListOfContactInterface>"
    @"<Contact>"
    @"<Id>%@</Id>"
    @"<ListOfOpportunity>"
    @"<Opportunity>"
    @"<Id>%@</Id>"
    @"<ListOfOpportunityRelatedActivities>"
    @"<OpportunityRelatedActivities>"
    @"<ActivityUID>1-7GOXNC1</ActivityUID>"
    @"<OpportunityId>%@</OpportunityId>"
    @"<ListOfActivitiesRelatedSalesRep>"
    @"<ActivitiesRelatedSalesRep IsPrimaryMVG=\"Y\">"
    @"<Id>%@</Id>"
    @"<Login>%@</Login>"
    @"</ActivitiesRelatedSalesRep>"
    @"</ListOfActivitiesRelatedSalesRep>"
    @"<Comments/>"
    @"</OpportunityRelatedActivities>"
    @"</ListOfOpportunityRelatedActivities>"
    @"</Opportunity>"
    @"</ListOfOpportunity>"
    @"</Contact>"
    @"</con:ListOfContactInterface>"
    @"</asi:TMCVSiebelContactInsertOrUpdate_Input>"
    @"</soapenv:Body>"
    @"</soapenv:Envelope>",Contactidforassignactivity,opportunity_list.OPTY_ID,opportunity_list.OPTY_ID,assign_list.POSITION_ID,assign_list.NSE_LOBDSE_NAME];
                  
                  
                  NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
                  
                  NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    
                  NSLog(@"URL IS %@", theurl);
           NSLog(@"REQUEST IS %@",envelopeText);                  
                  NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
                  
                  NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
                  
                  [request setHTTPMethod:@"POST"];
                  [request setHTTPBody:envelope];
                  [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                  [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
                  
                  [[RequestDelegate alloc] initiateRequest:request name:@"AssignActivityforopportunity"];


}

- (void)Activityassign_Found:(NSNotification*)notification{


    NSError* err;

    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n ActivityDetails_Connection response... %@ ", response);
    
    
    
    
    
    
    
    
    
    
    





}


@end
