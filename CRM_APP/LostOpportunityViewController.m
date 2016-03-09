//
//  LostOpportunityViewController.m
//  CRM_APP
//
//  Created by admin on 14/10/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import "LostOpportunityViewController.h"
#import "Reachability.h"
#import "TBXML.h"
#import "RequestDelegate.h"
#import "MBProgressHUD.h"
#import "ManageOpportunityViewController.h"
#import "LoginViewController.h"
#import "Opportunity_List.h"
#import "OpportunitySearchResultController.h"



@interface LostOpportunityViewController ()
{
    UIAlertView *alert;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive,hostActive;
    NSString * envelopeText;
    NSString *salesStages;
    UIActionSheet *actionSheet;
    int flag;

}
@end

@implementation LostOpportunityViewController

@synthesize view_Main,view_ShowDetails;
@synthesize txt_ReasonLost,txt_MakeLost,txt_ModeLost,txt_Description;
@synthesize btn_Save,btn_Clear;
@synthesize ReasonLostOptyArr,MakeLostOptyArr,MakeLostSalesStageArr,ModeofLostArr;
@synthesize lbl_ContactName,lbl_contactnumber;
- (void)viewDidLoad {
    [super viewDidLoad];
    if (![self connected])
    {
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
        
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; //usedetails instance
        
        
        ReasonLostOptyArr=[[NSMutableArray alloc] init];
        MakeLostOptyArr=[[NSMutableArray alloc] init];
        ModeofLostArr=[[NSMutableArray alloc] init];
        MakeLostSalesStageArr=[[NSMutableArray alloc] initWithObjects:@"Closed Lost at C0",@"Closed Lost at C1",@"Closed Lost at C1A",@"Closed Lost at C2", nil];
        
        [self.view_ShowDetails.layer setBorderColor:[UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor];
        [self.view_ShowDetails.layer setBorderWidth:2.0f];
        
        
        //Make View Rounded
        self.view_ShowDetails.layer.cornerRadius=5;
        self.view_ShowDetails.layer.masksToBounds=YES;
        
        [self.view_ShowDetails.layer setBorderColor:[UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor];
        [self.view_ShowDetails.layer setBorderWidth:2.0f];
        self.view_ShowDetails.layer.cornerRadius = 5;

        
        
        // Make Button Corner Rounded
        self.btn_Save.layer.cornerRadius=4;
        self.btn_Clear.layer.cornerRadius=4;
        self.btn_Save.layer.masksToBounds=YES;
        self.btn_Clear.layer.masksToBounds=YES;
        
        // Radious for text Fileds .
        self.txt_ReasonLost.layer.borderWidth=2.0f;
        self.txt_MakeLost.layer.borderWidth=2.0f;
        self.txt_ModeLost.layer.borderWidth=2.0f;
        self.txt_Description.layer.borderWidth=2.0f;
        
        
        self.txt_ReasonLost.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_MakeLost.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        
        self.txt_ModeLost.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_Description.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        
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
        
        
        
    }else{
        
        
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; //usedetails instance
        /*
         Closed Lost at C0
         Closed Lost at C1
         Closed Lost at C1A
         Closed Lost at C2
         */
        [self textFiledText];
        
        ReasonLostOptyArr=[[NSMutableArray alloc] init];
        MakeLostOptyArr=[[NSMutableArray alloc] init];
        ModeofLostArr=[[NSMutableArray alloc] init];
        MakeLostSalesStageArr=[[NSMutableArray alloc] initWithObjects:@"Closed Lost at C0",@"Closed Lost at C1",@"Closed Lost at C1A",@"Closed Lost at C2", nil];
        
        [self.view_ShowDetails.layer setBorderColor:[UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor];
        [self.view_ShowDetails.layer setBorderWidth:2.0f];
        
        
        //Make View Rounded
        self.view_ShowDetails.layer.cornerRadius=3;
        self.view_ShowDetails.layer.masksToBounds=YES;
        
        
        
        
        // Make Button Corner Rounded
        self.btn_Save.layer.cornerRadius=4;
        self.btn_Clear.layer.cornerRadius=4;
        self.btn_Save.layer.masksToBounds=YES;
        self.btn_Clear.layer.masksToBounds=YES;
        
        // Radious for text Fileds .
        self.txt_ReasonLost.layer.borderWidth=2.0f;
        self.txt_MakeLost.layer.borderWidth=2.0f;
        self.txt_ModeLost.layer.borderWidth=2.0f;
        self.txt_Description.layer.borderWidth=2.0f;
        
        
        self.txt_ReasonLost.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_MakeLost.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        
        self.txt_ModeLost.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_Description.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        
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
        
        [self callReasonLost];
        [self callMakeLost];
        
        lbl_ContactName.text=opportunity_list.CONTACT_NAME;
        lbl_contactnumber.text=opportunity_list.CONTACT_CELL_NUMBER;
        salesStages=opportunity_list.SALE_STAGE_NAME;
        
        
        NSLog(@"Sales Stages :%@",salesStages);
        if ([salesStages containsString:@"C0"])
        {
            NSLog(@"C0");
            salesStages=[MakeLostSalesStageArr objectAtIndex:0];
            NSLog(@"Sales Stages After :%@",salesStages);
            
        }else if([salesStages containsString:@"C1"])
        {
            NSLog(@"C1");
            salesStages=[MakeLostSalesStageArr objectAtIndex:1];
            NSLog(@"Sales Stages  After :%@",salesStages);
        }else if([salesStages containsString:@"C1A"])
        {
            NSLog(@"C1A");
            salesStages=[MakeLostSalesStageArr objectAtIndex:2];
            NSLog(@"Sales Stages  After :%@",salesStages);
        }else if([salesStages containsString:@"C2"])
        {
            NSLog(@"C2");
            salesStages=[MakeLostSalesStageArr objectAtIndex:3];
            NSLog(@"Sales Stages  After :%@",salesStages);
        }else if([salesStages containsString:@"C3"])
        {
            NSLog(@"C2");
            salesStages=[MakeLostSalesStageArr objectAtIndex:4];
            NSLog(@"Sales Stages  After :%@",salesStages);
        }
        else
        {
            NSLog(@"Wrong");
        }
    }
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LostReasonOpty_Found:) name:@"LostReasonOpty_Found" object:nil]; //For Sale Satge PPL Dropdown Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ModeLostOpty_Found:) name:@"ModeLostOpty_Found" object:nil];//For sale SatgeFailed DropDown fail
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MakeLostOpty_Found:) name:@"MakeLostOpty_Found" object:nil];//For Sale Satge PPL Dropdown Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MakeLostTheOpty_Found:) name:@"MakeLostTheOpty_Found" object:nil];//For sale SatgeFailed DropDown fail
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SaleStageFound:) name:@"SaleStageFound" object:nil];//For Sale Satge PPL Dropdown Count
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"LostReasonOpty_Found" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ModeLostOpty_Found" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"MakeLostOpty_Found" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"MakeLostTheOpty_Found" object:nil];
    
    
    
}


-(void)info_btn
{
    //  NSLog(@"Home biscuit from Sanfrancisco");
    [self performSegueWithIdentifier:@"infoView" sender:self];
    
}
-(void)logOut_btn
{
    // flag=true;
    alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                       message:@"Are you sure you want to Logout ?"
                                      delegate:self
                             cancelButtonTitle:@"No"
                             otherButtonTitles:@"Yes",nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
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

- (IBAction)btn_Save:(id)sender {
    
    if (![self connected])
    {
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
    }else{
        if([txt_Description.text isEqualToString:@"Description"])
        {
            txt_Description.text=@"";
        }
        if(![txt_ReasonLost.text isEqualToString:@""] && ![txt_MakeLost.text isEqualToString:@""] && ![txt_ModeLost.text isEqualToString:@""] &&![txt_Description.text isEqualToString:@""])
        {
            [self showAlert];
            [self callLostOpty];
            
        }else{
            
            if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
                alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Please enter all mandatory fields " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            }else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
                alert=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"Please enter all mandatory fields " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
                alert=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"Please enter all mandatory fields " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }

}
- (IBAction)btn_ReasonLost:(id)sender {
    if (![self connected])
    {
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
        
        
    }else{
        //  [self callReasonLost];
        NSLog(@"Activity...Data %@",ReasonLostOptyArr);
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        // ObjC Fast Enumeration
        for (NSString *title in ReasonLostOptyArr) {
            [actionSheet addButtonWithTitle:title];
        }
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            
            [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.view_Main animated:YES];
            actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;

            //[actionSheet showFromRect:[(UITextField *)sender frame] inView:txt_ReasonLost animated:YES];
            //actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
        }
        else{
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 1;
    }

}

- (IBAction)btn_MakeLost:(id)sender {
    
    if (![self connected])
    {
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
        
        
    }else{
        
        NSLog(@"Activity...Data %@",MakeLostOptyArr);
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        // ObjC Fast Enumeration
        for (NSString *title in MakeLostOptyArr) {
            [actionSheet addButtonWithTitle:title];
        }
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.view_Main animated:YES];
            actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
        }
        else{
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 2;
    }

}

- (IBAction)btn_ModeLost:(id)sender {
    
    NSLog(@"Postion details namr %@",userDetailsVal_.POSTN);
    if (![self connected])
    {
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
    }else{
        [self showAlert];
        if([txt_MakeLost.text isEqual:@""])
        {
            if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message:@"Please select make lost " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            }
           else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
                [self hideAlert];
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Please select make lost " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
           else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
                [self hideAlert];
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"Please select make lost " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }else{
            
            if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            envelopeText = [NSString stringWithFormat:
                                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetTMCVModelLostTypeNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<maketype>%@</maketype>"
                                       @"</GetTMCVModelLostTypeNeev>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",txt_MakeLost.text] ;
            }else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
                
                envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<GetTMCVModelLostType xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<maketype>%@</maketype>"
                                @"</GetTMCVModelLostType>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",txt_MakeLost.text];

            }
            else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
                
                envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetTMCVModelLostTypeNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<maketype>%@</maketype>"
                                           @"</GetTMCVModelLostTypeNeev>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",txt_MakeLost.text] ;

            }
            NSLog(@"\n envlopeString Of user details Mode ....!!!!%@",envelopeText);
            
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
            
            [[RequestDelegate alloc]initiateRequest:request name:@"getLostModeOpportunityConnection"];
        }
    }
}

-(void)ModeLostOpty_Found:(NSNotification*)notification
{
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ",response);
    
    if([response isEqual:@""]){
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }

    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else{
        
       if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
        if (ModeofLostArr)
        {
            [ModeofLostArr removeAllObjects];
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        NSLog(@"Which..");
        TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVModelLostTypeNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            [self hideAlert];
            do
            {
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                NSString *str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_NSE : %@",str_NAME);
                [ModeofLostArr addObject:str_NAME];
                
            }while ((tuple = tuple->nextSibling));
            
            NSLog(@"Sales Stages : %@",ModeofLostArr);
            
            if ((ModeofLostArr.count) > 0)
            {
                [self hideAlert];
                actionSheet = [[UIActionSheet alloc]
                               initWithTitle:nil
                               delegate:self
                               cancelButtonTitle:nil
                               destructiveButtonTitle:nil
                               otherButtonTitles:nil];
                
                // Add buttons one by one (e.g. in a loop from array etc...)
                for (int i=0; i<[self.ModeofLostArr count]; i++)
                {
                    [actionSheet addButtonWithTitle:[self.ModeofLostArr objectAtIndex:i]];
                    
                }
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    
                    [actionSheet showFromRect:[self.txt_ModeLost frame] inView:view_Main animated:YES];
                    actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
                }
                else
                {
                    [actionSheet showInView:self.view];
                }
                
                actionSheet.tag = 3;
            }
        }else
        {
            [self hideAlert];
            alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
      }
       else if([userDetailsVal_.POSTN isEqual:@"DSE"]){

           if (ModeofLostArr)
           {
               [ModeofLostArr removeAllObjects];
           }
          TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
          TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVModelLostTypeResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
          TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
          if (tuple)
          {
              do {
                  
                  TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                  
                  TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                  
                  NSString *nameString=[TBXML textForElement:NAME];
                  [ModeofLostArr addObject:nameString];
                  NSLog(@"%@", [TBXML textForElement:NAME]);
                  
                  
                  
              } while ((tuple = tuple->nextSibling));
              NSLog(@"\nmodelLostDisplayArr......%d",[ModeofLostArr count]);
              //            //[appdelegate hideAlert];
              [self hideAlert];

              NSLog(@"Activity...Data %@",ModeofLostArr);
              actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
              // ObjC Fast Enumeration
              for (NSString *title in ModeofLostArr) {
                  [actionSheet addButtonWithTitle:title];
              }
              //  self.actionSheet.cancelButtonIndex = [self.actionSheet addButtonWithTitle:@"Cancel"];
              actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
              
              
              if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                  
                  [actionSheet showFromRect:[self.txt_ModeLost frame] inView:view_Main animated:YES];
                  actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
              }
              else{
                  [actionSheet showInView:self.view];
              }
              actionSheet.tag = 3;
          }
          else
          {
               alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"No values found. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
              [alert show];
          }
      }
        else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            
            if (ModeofLostArr)
            {
                [ModeofLostArr removeAllObjects];
            }
            
            TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            
            NSLog(@"Which..");
            TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVModelLostTypeNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
                do
                {
                    TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                    NSString *str_NAME = [TBXML textForElement:NAME];
                    NSLog(@"\n str_NSE : %@",str_NAME);
                    [ModeofLostArr addObject:str_NAME];
                    
                }while ((tuple = tuple->nextSibling));
                
                NSLog(@"Sales Stages : %@",ModeofLostArr);
            }
            if ((ModeofLostArr.count) > 0)
            {
                [self hideAlert];
                actionSheet = [[UIActionSheet alloc]
                               initWithTitle:@""
                               delegate:self
                               cancelButtonTitle:nil
                               destructiveButtonTitle:nil
                               otherButtonTitles:nil];
                
                // Add buttons one by one (e.g. in a loop from array etc...)
                for (int i=0; i<[self.ModeofLostArr count]; i++)
                {
                    [actionSheet addButtonWithTitle:[self.ModeofLostArr objectAtIndex:i]];
                    
                }
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    [actionSheet showFromRect:[self.txt_ModeLost frame] inView:view_Main animated:YES];
                    actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
                    
                }
                else
                {
                    [actionSheet showInView:self.view];
                }
                
                actionSheet.tag = 3;
            }
            
        }
    }
}


- (IBAction)btn_Clear:(id)sender {
    
    txt_ReasonLost.text=@"";
    txt_MakeLost.text=@"";
    txt_ModeLost.text=@"";
    txt_Description.text=@"";
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


-(void)textFiledText
{
    UIColor *color=[UIColor colorWithRed:(131/255.0) green:(131/255.0) blue:(131/255.0) alpha:1];
    
    
    self.txt_MakeLost.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Make Lost" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_ModeLost.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Mode To lost" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_ReasonLost.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Reason For Lost" attributes:@{NSForegroundColorAttributeName:color}];
    
   // self.txt_Description.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Description" attributes:@{NSForegroundColorAttributeName:color}];
    
   // txt_Description.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;

    
    
    //  self.txtDescription.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type" attributes:@{NSForegroundColorAttributeName:color}];
    
}
-(void)callReasonLost
{
    
    if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
        
        envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetTMCVReasonLostTypeNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"] ;
    }
   else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
    
    envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetTMCVReasonLostType xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"];
   }
  else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
    
       envelopeText = [NSString stringWithFormat:
                                  @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                  @"<SOAP:Body>"
                                  @"<GetTMCVReasonLostTypeNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                                  @"</SOAP:Body>"
                                  @"</SOAP:Envelope>"] ;
   }
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getLostReasonOpportunityConnection"];
    
}
-(void)LostReasonOpty_Found:(NSNotification*)notification
{
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ",response);
    
    if([response isEqual:@""]){
        
        [self hideAlert];

        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{

    if([userDetailsVal_.POSTN isEqual:@"NDRM"]){

        if (ReasonLostOptyArr)
        {
            [ReasonLostOptyArr removeAllObjects];
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVReasonLostTypeNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            
            do
            {
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                NSString *str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_NSE : %@",str_NAME);
                [ReasonLostOptyArr addObject:str_NAME];
                
                
            }while ((tuple = tuple->nextSibling));
            
            NSLog(@"Sales Stages :%@",ReasonLostOptyArr);
            // }
            if ((ReasonLostOptyArr.count) > 0)
            {
                [self hideAlert];
            }
        }
        else
        {
            [self hideAlert];
            alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
      }
     else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
         
         if (ReasonLostOptyArr)
         {
             [ReasonLostOptyArr removeAllObjects];
         }
         
         TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
         
         TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVReasonLostTypeNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
         TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
         if (tuple)
         {
             do
             {
                 TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                 TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                 NSString *str_NAME = [TBXML textForElement:NAME];
                 NSLog(@"\n str_NSE : %@",str_NAME);
                 [ReasonLostOptyArr addObject:str_NAME];
                 
             }while ((tuple = tuple->nextSibling));
             
             NSLog(@"Sales Stages : %@",ReasonLostOptyArr);
             if ((ReasonLostOptyArr.count) > 0)
             {
                 [self hideAlert];
             }
         }else
         {
             [self hideAlert];
             alert=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert show];
         }
         
     }
     if([userDetailsVal_.POSTN isEqual:@"DSE"]){
         
             if (ReasonLostOptyArr)
             {
                 [ReasonLostOptyArr removeAllObjects];
             }
             
             TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
             TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVReasonLostTypeResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
             TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
             if (tuple)
             {
                 do {
                     
                     TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                     TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                     
                     NSString *nameString=[TBXML textForElement:NAME];
                     [ReasonLostOptyArr addObject:nameString];
                     NSLog(@"%@", [TBXML textForElement:NAME]);
                 } while ((tuple = tuple->nextSibling));
                 NSLog(@"\nOpportunityListDisplayArr......%d",[ReasonLostOptyArr count]);
             }
             else
             {
                 [self hideAlert];
                 alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
             }
         }
         
        
    }
    //[self hideAlert];
    
}

-(void)callMakeLost
{
 if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
     
    envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetTMCVMakeLostTypeNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"] ;
    }
    else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
        
        envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                   @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e7ab-229211ac173b</DC>"
                                   @"</Logger>"
                                   @"</header>"
                                   @"</SOAP:Header>"
                                   @"<SOAP:Body>"
                                   @"<GetTMCVMakeLostTypeNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>"];
    }
    else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
        
        envelopeText = [NSString stringWithFormat:
                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Body>"
                                   @"<GetTMCVMakeLostTypeNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>"] ;    }

    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getLostMakeOpportunityConnection"];
}
-(void)MakeLostOpty_Found:(NSNotification*)notification
{
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ",response);
    
    if([userDetailsVal_.POSTN isEqual:@"NDRM"])
    {
    
        if([response isEqual:@""]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
        {
            [self hideAlert];
            alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            if (MakeLostOptyArr)
            {
                [MakeLostOptyArr removeAllObjects];
            }
            TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            NSLog(@"Which..");
            TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVMakeLostTypeNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
                [self hideAlert];
                do
                {
                    TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                    NSString *str_NAME = [TBXML textForElement:NAME];
                    NSLog(@"\n str_NSE : %@",str_NAME);
                    [MakeLostOptyArr addObject:str_NAME];
                }while ((tuple = tuple->nextSibling));
                    NSLog(@"Sales Stages : %@",MakeLostOptyArr);
                    if ((MakeLostOptyArr.count) > 0)
                    {
                        [self hideAlert];
                    //  [appdelegate hideAlert];
                    // [self callModeLost];
                    }
            }else
            {
                [self hideAlert];
                alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        [self hideAlert];
    }
    else if([userDetailsVal_.POSTN isEqual:@"DSE"])
    {
      
        if ([response isEqual:@""])
        {
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
        {
            [self hideAlert];
            alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"omething went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVMakeLostTypeNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            if (MakeLostOptyArr)
            {
                [MakeLostOptyArr removeAllObjects];
            }
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
                do {
                    TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    
                    TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                    
                    NSString *nameString=[TBXML textForElement:NAME];
                    [MakeLostOptyArr addObject:nameString];
                    NSLog(@"%@", [TBXML textForElement:NAME]);
                } while ((tuple = tuple->nextSibling));
                NSLog(@"\nOpportunityListDisplayArr......%d",[MakeLostOptyArr count]);
            }
            else
            {
                alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    else if([userDetailsVal_.POSTN isEqual:@"DSM"])
    {
        
        if (MakeLostOptyArr)
        {
            [MakeLostOptyArr removeAllObjects];
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        NSLog(@"Which..");
        TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVMakeLostTypeNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            do
            {
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                NSString *str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_NSE : %@",str_NAME);
                [MakeLostOptyArr addObject:str_NAME];
                
            }while ((tuple = tuple->nextSibling));
            NSLog(@"Sales Stages : %@",MakeLostOptyArr);
            if ((MakeLostOptyArr.count) > 0)
            {
            
            }
        } else
        {
            alert=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    [self hideAlert];
}

-(void)callLostOpty
{
    
    //NSLog(@"... Opty Id L %@",opportunity_list.OPTY_ID);
    envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                               @"<Opportunity>"
                               @"<Id>%@</Id>"
                               @"<ClosureSummary>%@</ClosureSummary>"
                               @"<IntegrationId>%ld</IntegrationId>"
                               @"<Make>%@</Make>"
                               @"<Model>%@</Model>"
                               @"<ReasonWonLost>%@</ReasonWonLost>"
                               @"<SalesStage>%@</SalesStage>"
                               @"</Opportunity>"
                               @"</ListOfTMOpportunityInterface>"
                               @"</SFATMCVOPTYInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",opportunity_list.OPTY_ID,txt_Description.text,(long)[[NSDate date]timeIntervalSince1970],txt_MakeLost.text,txt_ModeLost.text,txt_ReasonLost.text,salesStages] ;
    
    
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getLostOpportunityConnection"];
    
}
-(void)MakeLostTheOpty_Found:(NSNotification*)notification
{
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n Make the Lost opty  %@ ",response);
    
    
    if([response isEqual:@""]){
        [self hideAlert];
        
        if([userDetailsVal_.POSTN isEqual:@"NDRM"])
        {
        
            alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
       else if([userDetailsVal_.POSTN isEqual:@"DSE"])
        {
            
            alert=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
       else if([userDetailsVal_.POSTN isEqual:@"DSM"])
        {
            
            alert=[[UIAlertView alloc]initWithTitle:@"DSN" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        
        TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:container];
        
        TBXMLElement *Opportunity = [TBXML childElementNamed:@"Opportunity" parentElement:ListOfContactInterface];
        TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
        if (Id)
        {
            //createLostOpportunity.Id_ = [TBXML textForElement:Id];
            //NSLog(@"\nListOfContactInterface.....!!!!!%@",createLostOpportunity.Id_);
            
            [self hideAlert];
            flag=1;
            if([userDetailsVal_.POSTN isEqual:@"NDRM"])
            {
                alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message:@"Opportunity lost successfully " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else if([userDetailsVal_.POSTN isEqual:@"DSE"])
            {
                alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Opportunity lost successfully " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else if([userDetailsVal_.POSTN isEqual:@"DSM"])
            {
                alert=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"Opportunity lost successfully " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else
        {
            [self hideAlert];
            if([userDetailsVal_.POSTN isEqual:@"NDRM"])
            {
                alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
           else if([userDetailsVal_.POSTN isEqual:@"DSE"])
            {
                alert=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
           else if([userDetailsVal_.POSTN isEqual:@"DSM"])
            {
                alert=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    //[self hideAlert];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"button click ....%ld",(long)buttonIndex);
    if(txt_ReasonLost){
        NSLog(@"... in");
        switch (popup.tag) {
            case 1:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    NSLog(@"ek..");
                    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    self.txt_ReasonLost.text = NSLocalizedString([ReasonLostOptyArr objectAtIndex:buttonIndex],@"");
                    
                }
                
        }
    }
    if(txt_MakeLost){
        NSLog(@"... in");
        switch (popup.tag) {
            case 2:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    NSLog(@"ek..");
                    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    self.txt_MakeLost.text = NSLocalizedString([MakeLostOptyArr objectAtIndex:buttonIndex],@"");
                    
                }
                
        }
    }
    if(txt_ModeLost){
        NSLog(@"... in");
        switch (popup.tag) {
            case 3:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    NSLog(@"ek..");
                    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    self.txt_ModeLost.text = NSLocalizedString([ModeofLostArr objectAtIndex:buttonIndex],@"");
                    
                }
        }
    }
}
-(void) textViewDidChange:(UITextView *)textView
{
    NSLog(@"Inside uitext");
    if(txt_Description.text.length == 0){
        txt_Description.textColor = [UIColor lightGrayColor];
        txt_Description.text = @"Description";
        [txt_Description resignFirstResponder];
    }
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"Inside uitext1");

    txt_Description.text = @"";
    txt_Description.textColor = [UIColor blackColor];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        
        NSLog(@"David Miller");
        if(flag==1)
        {
            if(appdelegate.flagget==1){
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
-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
    
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


@end
