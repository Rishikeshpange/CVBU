//
//  SearchActivityViewController.m
//  CRM_APP
//
//  Created by admin on 23/10/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import "SearchActivityViewController.h"
#import "TBXML.h"
#import "RequestDelegate.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "SearchActivity_List.h"
#import "LoginViewController.h"
#import "ActivitySearchResultViewController.h"
@interface SearchActivityViewController ()
{
    UIAlertView *alert;
    NSString *selectActivityType,*TgmTkm;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive,hostActive;
    NSString * envelopeText;
    NSString *checkstringfortkmtgm;
    NSString *accountString;
    

}
@end

@implementation SearchActivityViewController
@synthesize btn_Search,btn_Clear;
@synthesize activitypplIDPickerArr,activityPPLNamePickerArr,activityType_PickerArr,activityStatus,activityAssignTo,view_show,activityTaluka,_activityAssingTo,activityAssignLOB;

@synthesize txt_FromDate,txt_ActivityType,txt_AssignTo,txt_PPL,txt_Status,txt_Taluka,txt_ToDate;
- (void)viewDidLoad {
    [super viewDidLoad];
    if (![self connected])
    {
        // not connected
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
        TgmTkm=@"TKM";
        [self textFiledText];
        [self showAlert];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
        self.btn_Search.layer.cornerRadius=3;
        self.btn_Search.layer.masksToBounds = YES;
        
        self.btn_Clear.layer.cornerRadius=3;
        self.btn_Clear.layer.masksToBounds = YES;
        
        self.img_TKM.layer.borderColor = [UIColor colorWithRed:(54/255.0) green:(180/255.0) blue:(220/255.0) alpha:1].CGColor;
        self.img_TGM.layer.borderWidth = 2;
        
        self.img_TKM.layer.borderColor =  [UIColor colorWithRed:(143/255.0) green:(145/255.0) blue:(152/255.0) alpha:1].CGColor;
        self.img_TGM.layer.borderWidth = 2;
        // 206-205-205
        [self.txt_FromDate.layer setCornerRadius:1.0];
        self.txt_FromDate.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_FromDate.layer.borderWidth = 2;
        
        self.txt_ToDate.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_ToDate.layer.borderWidth = 2;
        
        self.txt_AssignTo.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_AssignTo.layer.borderWidth = 2;
        
        self.txt_Status.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_Status.layer.borderWidth = 2;
        
        self.txt_Taluka.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_Taluka.layer.borderWidth = 2;
        
        self.txt_ActivityType.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_ActivityType.layer.borderWidth = 2;
        
        
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
        
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
        activitypplIDPickerArr = [[NSMutableArray alloc]init]; // For Activity PPL_ID
        activityPPLNamePickerArr = [[NSMutableArray alloc]init];// For Activity PPL Name
        activityType_PickerArr = [[NSMutableArray alloc]init];// for Activty TYPE
        activityStatus = [[NSMutableArray alloc]initWithObjects:@"Open",@"Done", nil];
        activityTaluka=[[NSMutableArray alloc]init];
        activityAssignTo=[[NSMutableArray alloc] init];
        _activityAssingTo=[[NSMutableArray alloc] init];
        
        search_activitiesresultpage_variables = [Search_Activitiesresultpage_variables sharedmanager]; //create singleton instance pf search activities class
        
        
        
        
        isActivitystatusClicked = false; // for checking  click on activitystatus textview
        isPPLNameclicked = false;// for checking  click on isPPLName textview
        isActivityTypeClicked = false;// for checking  click on ActivityType textview
        
    
        
        
    }
    
    else{
        
        
        
        
      if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
         
            _img_TGM.hidden=NO;
            _img_TKM.hidden=NO;
            
            _lbl_TGM.hidden=NO;
            _lbl_TKM.hidden=NO;
            
            
            
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
           
            _img_TGM.hidden=YES;
            _img_TKM.hidden=YES;
            
            _lbl_TGM.hidden=YES;
            _lbl_TKM.hidden=YES;
            
            
            
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
          
            _img_TGM.hidden=YES;
            _img_TKM.hidden=YES;
            
            _lbl_TGM.hidden=YES;
            _lbl_TKM.hidden=YES;
            
            
        }
       
        
        
        
        NSLog(@"Welcome Search ...");
        TgmTkm=@"TKM";
        [self textFiledText];
        [self showAlert];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
        self.btn_Search.layer.cornerRadius=3;
        self.btn_Search.layer.masksToBounds = YES;
        
        self.btn_Clear.layer.cornerRadius=3;
        self.btn_Clear.layer.masksToBounds = YES;
        
        self.img_TKM.layer.borderColor = [UIColor colorWithRed:(54/255.0) green:(180/255.0) blue:(220/255.0) alpha:1].CGColor;
        self.img_TGM.layer.borderWidth = 2;
        
        self.img_TKM.layer.borderColor =  [UIColor colorWithRed:(143/255.0) green:(145/255.0) blue:(152/255.0) alpha:1].CGColor;
        self.img_TGM.layer.borderWidth = 2;
        // 206-205-205
        [self.txt_FromDate.layer setCornerRadius:1.0];
        self.txt_FromDate.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_FromDate.layer.borderWidth = 2;
        
        self.txt_ToDate.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_ToDate.layer.borderWidth = 2;
        
        self.txt_AssignTo.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_AssignTo.layer.borderWidth = 2;
        
        self.txt_Status.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_Status.layer.borderWidth = 2;
        
        self.txt_Taluka.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_Taluka.layer.borderWidth = 2;
        
        self.txt_ActivityType.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_ActivityType.layer.borderWidth = 2;

        
        
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
        
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
        activitypplIDPickerArr = [[NSMutableArray alloc]init]; // For Activity PPL_ID
        activityPPLNamePickerArr = [[NSMutableArray alloc]init];// For Activity PPL Name
        activityType_PickerArr = [[NSMutableArray alloc]init];// for Activty TYPE
        activityStatus = [[NSMutableArray alloc]initWithObjects:@"Open",@"Done", nil];
        activityTaluka=[[NSMutableArray alloc]init];
        activityAssignTo=[[NSMutableArray alloc] init];
        _activityAssingTo=[[NSMutableArray alloc] init];
        
        search_activitiesresultpage_variables = [Search_Activitiesresultpage_variables sharedmanager]; //create singleton instance pf search activities class
        
        
        
        
        isActivitystatusClicked = false; // for checking  click on activitystatus textview
        isPPLNameclicked = false;// for checking  click on isPPLName textview
        isActivityTypeClicked = false;// for checking  click on ActivityType textview
        
        accountString=@"TGM";
        
    // [self callActivity_PPL]; // function for parsing PPL activity
  [self CallActivity_Type]; // fuction for parsing activty type
    [self callActivity_TALUKA];
[self callAssignTo];
        
        //  [appdelegate createAlertWithTitle:@"Please Wait" message:@"Loading Data."];
        
        txt_ToDate.delegate = self;
        txt_FromDate.delegate = self;
        txt_ActivityType.delegate = self;
        txt_AssignTo.delegate = self;
        txt_Taluka.delegate = self;
        
        
        
        DisplaySearchActivitiesDetailsArray = [[NSMutableArray alloc]init];
        
        
        checkstringfortkmtgm=@"TGM";
        
    }
    
    if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
        NSLog(@"---111");
        self.view_show.frame=CGRectMake(50, 50, 500, 400);
      
        
        _img_TGM.hidden=NO;
        _img_TKM.hidden=NO;
        
        _lbl_TGM.hidden=NO;
        _lbl_TKM.hidden=NO;

    }
    else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
        
        self.splitViewController.delegate = self;
        UIBarButtonItem *barButtonItem = self.splitViewController.displayModeButtonItem;
        barButtonItem.title = @"Show master";
        self.navigationItem.leftBarButtonItem = barButtonItem;

        
        _img_TGM.hidden=YES;
        _img_TKM.hidden=YES;
        
        _lbl_TGM.hidden=YES;
        _lbl_TKM.hidden=YES;
        
        
    }
    else if([userDetailsVal_.POSTN isEqual:@"DSM"]){

        view_show.frame = CGRectMake( 100,200,view_show.frame.size.width, view_show.frame.size.height ); // set new position exactly
        
        _img_TGM.hidden=YES;
        _img_TKM.hidden=YES;
        
        _lbl_TGM.hidden=YES;
        _lbl_TKM.hidden=YES;
        

    }
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Activity_PPL_Found" object:nil];//abhishek // For Activity_PPL Count
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityType_Found" object:nil];//abhishek // For ActivityType Count
    // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityType_Found" object:nil];//abhishek // For opportunity Count
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"searchActivities_Found" object:nil];//abhishek // For searchActivities_Found Count
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityTaluka_Found" object:nil];//abhishek // For searchActivities_Found Count
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SaleAssign_To_Found" object:nil];//abhishek // For searchActivities_Found Count
    
    //SaleAssign_To_Found
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Activity_PPL_Found:) name:@"Activity_PPL_Found" object:nil];//Abhishek //For Activity Type Dropdown Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityType_Found:) name:@"ActivityType_Found" object:nil];//Abhishek //For activity type
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchActivities_Found:) name:@"searchActivities_Found" object:nil];//Abhishek //for search activites after pressing search button
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityTaluka_Found:) name:@"ActivityTaluka_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SaleAssign_To_Found:) name:@"SaleAssign_To_Found" object:nil];
}

-(void)textFiledText
{
    UIColor *color=[UIColor colorWithRed:(131/255.0) green:(131/255.0) blue:(131/255.0) alpha:1];
    //self.txtCustomerName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Customer name" attributes:@{NSForegroundColorAttributeName:color}];
    
    //self.txtCustomerMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Customer Mobile Number" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_FromDate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"From Date" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_ToDate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"To Date" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_AssignTo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"DSE Name" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_Status.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Status" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_Taluka.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Taluka" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_ActivityType.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Activity Type" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_PPL.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" PL" attributes:@{NSForegroundColorAttributeName:color}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"Home biscuit from Sanfrancisco");
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

// delegate mehod for uialertView

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        
        NSLog(@"David Miller");
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


// For PPL calling Activity....!!!!!

-(void)callActivity_PPL
{
    /*NSString * envelopeText = [NSString stringWithFormat:
     @"<SOAP:Envelope xmlns¸ :SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     @"<SOAP:Body>"
     @"<GetListOfPPLForNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
     @"<buname>TMCV</buname>"
     @"<attr1></attr1>"
     @"<attr2></attr2>"
     @"</GetListOfPPLForNeev>"
     @"</SOAP:Body>"
     @"</SOAP:Envelope>"] ;*/
    
    
    envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetListOfPPLForNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<buname>TMCV</buname>"
                               @"<attr1></attr1>"
                               @"<attr2></attr2>"
                               @"</GetListOfPPLForNeev>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"] ;
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityPPLConnection"];
}
-(void)Activity_PPL_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n Activity_PPL_Found response... %@ ",response);
    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No PPL found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No PPL found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No PPL found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            
            alert=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else{
        
        if (activitypplIDPickerArr)
        {
            [activitypplIDPickerArr removeAllObjects];
            [activityPPLNamePickerArr removeAllObjects];
        }
        
        
        
        
        
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        TBXMLElement *container = [TBXML childElementNamed:@"GetListOfPPLForNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        
        if (tuple)
        {
            [self hideAlert];
            do
            {
                TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *PPL_ID = [TBXML childElementNamed:@"PPL_ID" parentElement:S_PROD_LN];
                NSString *PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@",PPL_ID_);
                [activitypplIDPickerArr addObject:PPL_ID_];
                
                TBXMLElement *PPL_NAME = [TBXML childElementNamed:@"PPL_NAME" parentElement:S_PROD_LN];
                NSString *PPL_NAME_ = [TBXML textForElement:PPL_NAME];
                NSLog(@"\n SALE_STAGE_NAME : %@",PPL_NAME_);
                [activityPPLNamePickerArr addObject:PPL_NAME_];
                
            }while ((tuple = tuple->nextSibling));
            
            
            
            if ((activityType_PickerArr.count) > 0){
                //[appdelegate hideAlert];
            }
            
            NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activityPPLNamePickerArr count]);
            NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activitypplIDPickerArr count]);
        }else
        {
            
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No PPL found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No PPL found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No PPL found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
        
    }
}

// For calling ACTIVITY TYPE


-(void)CallActivity_Type
{
    
    
    envelopeText = [NSString stringWithFormat:
                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Body>"
                                   @"<getListOfActivityJavaCall xmlns=\"http://schemas.cordys.com/NeevJavaCall\" />"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>"];
    
    /*NSString * envelopeText1 = [NSString stringWithFormat:
     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     @"<SOAP:Body>"
     @"<GetTMCVActivityType xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
     @"</SOAP:Body>"
     @"</SOAP:Envelope>"] ;*/
    
    NSLog(@"\n envlopeString Of Activity Type....!!!!%@",envelopeText);
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"ActivityTypeConnection"];
    
}

-(void)ActivityType_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityType_Found response... %@ ",response);
    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No Activity Type found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No Activity Type found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No Activity Type found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            
            alert=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else{
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        
        TBXMLElement *container = [TBXML childElementNamed:@"getListOfActivityJavaCallResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        TBXMLElement *old = [TBXML childElementNamed:@"old" parentElement:tuple];
        TBXMLElement *getListSaleStageJavaCall = [TBXML childElementNamed:@"getListOfActivityJavaCall" parentElement:old];
        TBXMLElement *getListSaleStageJavaCall2 = [TBXML childElementNamed:@"getListOfActivityJavaCall" parentElement:getListSaleStageJavaCall];
        TBXMLElement *getListSaleStageJavaCall3 = [TBXML childElementNamed:@"getListOfActivityJavaCall" parentElement:getListSaleStageJavaCall2];
        
        TBXMLElement *tuple2 =[TBXML childElementNamed:@"tuple" parentElement:getListSaleStageJavaCall3];
        
        if (tuple2)
        {
            do
            {
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple2]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                NSString *str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n SALE_STAGE_NAME : %@",str_NAME);
                [activityType_PickerArr addObject:str_NAME];
                
            }while ((tuple2 = tuple2->nextSibling));
            NSLog(@"Activty Type: %@",activityType_PickerArr);
        }
        else
        {
            
            
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No Activity Type found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No Activity Type found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No Activity Type found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
    }    /*
          if ((pplNamePickerArr.count) > 0)
          {
          //  [appdelegate hideAlert];
          }*/
    
    /*
     if (activityType_PickerArr)
     {
     [activityType_PickerArr removeAllObjects];
     }
     TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
     TBXMLElement *container = [TBXML childElementNamed:@"getListOfActivityJavaCall" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
     TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
     
     if (tuple)
     {
     do
     {
     TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
     TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
     NSString *str_NAME = [TBXML textForElement:NAME];
     NSLog(@"\n str_S_Lst_Of_Val : %@",str_NAME);
     [activityType_PickerArr addObject:str_NAME];
     
     }while ((tuple = tuple->nextSibling));
     }
     
     if (((activitypplIDPickerArr.count)|| (activityPPLNamePickerArr.count)) > 0){
     //  [appdelegate hideAlert];
     }
     NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activityType_PickerArr count]);
     */
}
// Call Taluka..
-(void)callActivity_TALUKA
{
    /*NSString * envelopeText = [NSString stringWithFormat:
     @"<SOAP:Envelope xmlns¸ :SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     @"<SOAP:Body>"
     @"<GetListOfPPLForNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
     @"<buname>TMCV</buname>"
     @"<attr1></attr1>"
     @"<attr2></attr2>"
     @"</GetListOfPPLForNeev>"
     @"</SOAP:Body>"
     @"</SOAP:Envelope>"] ;*/
    
    
    envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetListOfTehsil xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<poistionid>%@</poistionid>"
                               @"<districtname>Thane</districtname>"
                               @"<attr1></attr1>"
                               @"</GetListOfTehsil>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityTaluka"];
}
-(void)ActivityTaluka_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityTaluka_Found response... %@ ",response);
    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No Taluka found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No Taluka found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            
            alert=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else{
        if (activityTaluka)
        {
            [activityTaluka removeAllObjects];
        }
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetListOfTehsilResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        
        if (tuple)
        {
            do
            {
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"X_TALUKA" parentElement:S_Lst_Of_Val];
                NSString *str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_S_Lst_Of_Val : %@",str_NAME);
                [activityTaluka addObject:str_NAME];
                
            }while ((tuple = tuple->nextSibling));
        }
        /*
         if (((activitypplIDPickerArr.count)|| (activityPPLNamePickerArr.count)) > 0){
         //  [appdelegate hideAlert];
         }*/
        NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activityTaluka count]);
    }
}
-(void)callAssignTo
{
    NSLog(@"Distict %@ %@",appdelegate.loginUD,userDetailsVal_.ROW_ID);
    
   if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
     envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetListOfNSEOrLOBDSEForNDRM xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<positionname></positionname>"
                               @"<buname></buname>"
                               @"<searchpostitionname1></searchpostitionname1>"
                               @"<searchpostitionname2></searchpostitionname2>"
                               @"</GetListOfNSEOrLOBDSEForNDRM>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
   }else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
       envelopeText = [NSString stringWithFormat:
                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                       @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                       @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                       @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e875-98c59ce1dde9</DC>"
                       @"</Logger>"
                       @"</header>"
                       @"</SOAP:Header>"
                       @"<SOAP:Body>"
                       @"<GetListOfNseOrDseForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                       @"<positionid>%@</positionid>"
                       @"</GetListOfNseOrDseForDSM>"
                       @"</SOAP:Body>"
                       @"</SOAP:Envelope> ",userDetailsVal_.ROW_ID];
   
   }else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
       
       envelopeText = [NSString stringWithFormat:
                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                       @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                       @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                       @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                       @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e875-98c59ce1dde9</DC>"
                       @"</Logger>"
                       @"</header>"
                       @"</SOAP:Header>"
                       @"<SOAP:Body>"
                       @"<GetListOfNseOrDseForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                       @"<positionid>%@</positionid>"
                       @"</GetListOfNseOrDseForDSM>"
                       @"</SOAP:Body>"
                       @"</SOAP:Envelope> ",userDetailsVal_.ROW_ID];
       
   }
    
    NSLog(@"\n envlopeString Of Assign TO....!!!!%@",envelopeText);
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivity_AssignTo"];
    
}

-(void)SaleAssign_To_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _OptyAssign_Found response... %@ ",response);
    if([response isEqual:@""]){
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"No DSE found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"No DSE found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"No DSE found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    }else{
        
      if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
        
        if (activityAssignTo)
        {
            [activityAssignTo removeAllObjects];
        }
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetListOfNSEOrLOBDSEForNDRMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            do
            {
                
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"NSE_LOBDSE_NAME" parentElement:S_Lst_Of_Val];
                NSString *str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_S_Lst_Of_Val : %@",str_NAME);
                [_activityAssingTo addObject:str_NAME];
                
                TBXMLElement *POSITION_ID = [TBXML childElementNamed:@"POSITION_ID" parentElement:S_Lst_Of_Val];
                NSString *str_Position = [TBXML textForElement:POSITION_ID];
                NSLog(@"\n str_NSE : %@",str_Position);
                [activityAssignTo addObject:str_Position];
                
            }while ((tuple = tuple->nextSibling));
            NSLog(@"Assign To .... [0] %@",activityAssignTo);
            
        }
        /*
         if (((activitypplIDPickerArr.count)|| (activityPPLNamePickerArr.count)) > 0){
         //  [appdelegate hideAlert];
         }*/
        NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activityAssignTo count]);
      }
      else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
          
          if (activityAssignTo)
          {
              [activityAssignTo removeAllObjects];
          }
          TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
          TBXMLElement *container = [TBXML childElementNamed:@"GetListOfNseOrDseForDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
          TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
          if (tuple)
          {
              do
              {
                  
                  TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_PARTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                  
                  
                  TBXMLElement *NAME = [TBXML childElementNamed:@"NSE_LOBDSE_NAME" parentElement:S_Lst_Of_Val];
                  NSString *str_Name = [TBXML textForElement:NAME];
                  [_activityAssingTo addObject:str_Name];
                  
                  TBXMLElement *POSITION_ID = [TBXML childElementNamed:@"POSTION_ID" parentElement:S_Lst_Of_Val];
                  NSString *str_Position = [TBXML textForElement:POSITION_ID];
                  //   NSLog(@"\n str_NSE : %@",str_Position);
                  [activityAssignLOB addObject:str_Position];
                  
                  
                  TBXMLElement *POSITION_NAME = [TBXML childElementNamed:@"POSTION_NAME" parentElement:S_Lst_Of_Val];
                  NSString *str_PositionName = [TBXML textForElement:POSITION_NAME];
                  NSLog(@"\n str_NSE : %@",str_PositionName);
                  [activityAssignLOB addObject:str_PositionName];
                  
                  
                  TBXMLElement *POSITION_PHN = [TBXML childElementNamed:@"POSITION_PH_NUM" parentElement:S_Lst_Of_Val];
                  NSString *str_PositionPhn = [TBXML textForElement:POSITION_PHN];
                  NSLog(@"\n str_NSE : %@",str_PositionPhn);
                  [activityAssignLOB addObject:str_PositionPhn];
                  
                  
                  TBXMLElement *LOB_NAME = [TBXML childElementNamed:@"LOBNAME" parentElement:S_Lst_Of_Val];
                  NSString *str_LobName = [TBXML textForElement:LOB_NAME];
                  NSLog(@"\n str_NSE : %@",str_LobName);
                  [activityAssignLOB addObject:str_LobName];
                  
                  TBXMLElement *POSITION_TYPE = [TBXML childElementNamed:@"POSITION_TYPE" parentElement:S_Lst_Of_Val];
                  NSString *str_PositionType = [TBXML textForElement:POSITION_TYPE];
                  NSLog(@"\n str_NSE : %@",str_PositionType);
                  [activityAssignLOB addObject:str_PositionType];
                  
              }while ((tuple = tuple->nextSibling));
          }
          NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activityAssignTo count]);

      
      }else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
          
          if (activityAssignTo)
          {
              [activityAssignTo removeAllObjects];
          }
          TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
          TBXMLElement *container = [TBXML childElementNamed:@"GetListOfNseOrDseForDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
          TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
          if (tuple)
          {
              do
              {
                  
                  TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_PARTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                  
                  
                  TBXMLElement *NAME = [TBXML childElementNamed:@"NSE_LOBDSE_NAME" parentElement:S_Lst_Of_Val];
                  NSString *str_Name = [TBXML textForElement:NAME];
                  [_activityAssingTo addObject:str_Name];
                  
                  TBXMLElement *POSITION_ID = [TBXML childElementNamed:@"POSTION_ID" parentElement:S_Lst_Of_Val];
                  NSString *str_Position = [TBXML textForElement:POSITION_ID];
                  NSLog(@"id : %@",str_Position);
                  [activityAssignTo addObject:str_Position];

              }while ((tuple = tuple->nextSibling));
          }
          NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activityAssignTo count]);
      }
     [self hideAlert];
    }
}

- (IBAction)btn_FromDate:(id)sender {
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height-500-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height-500, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    //NSLog(@"New Date: %@", sender.date);
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yy"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    NSLog(@"Date..Set  To: : %@",stringFromDate);
    txt_FromDate.text=stringFromDate;
    
    [datePicker addTarget:self action:@selector(changeDate_:) forControlEvents:UIControlEventValueChanged];
    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    datePicker.layer.borderWidth = 2;
    [[UILabel appearanceWhenContainedIn:[UIDatePicker class], nil]
     setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] ;
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    toolBar.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    toolBar.layer.borderWidth = 2;
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.8;
    [UIView commitAnimations];
}
- (void)changeDate_:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yy"];
    NSString *stringFromDate = [formatter stringFromDate:sender.date];
    
    NSLog(@"Date..Set  To: : %@",stringFromDate);
    txt_FromDate.text=stringFromDate;
    
    
}



- (IBAction)btn_ActivityType:(id)sender {
    
    NSLog(@"Activity...Data %@",activityType_PickerArr);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in activityType_PickerArr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[self.txt_ActivityType frame] inView:self.view_show animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 1;
}

- (IBAction)btn_AssignTo:(id)sender {
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in _activityAssingTo) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[self.txt_AssignTo frame] inView:self.view_show animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 3;

}

- (IBAction)btn_PPL:(id)sender {
    
    NSLog(@"Assign Array %@",activityPPLNamePickerArr);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in activityPPLNamePickerArr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[self.txt_PPL frame] inView:self.view_show animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 5;
}

- (IBAction)btn_ToDate:(id)sender {
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height-500-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height-500, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    //  NSLog(@"New Date: %@", sender.date);
    NSDate *date  = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yy"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    NSLog(@"Date..Set  From : : %@",stringFromDate);
    txt_ToDate.text=stringFromDate;
    
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    //datePicker.backgroundColor=[UIColor colorWithRed:(2/255.0) green:(18/255.0) blue:(40/255.0) alpha:1];
    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    datePicker.layer.borderWidth = 2;
    [[UILabel appearanceWhenContainedIn:[UIDatePicker class], nil]
     setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] ;
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    toolBar.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    toolBar.layer.borderWidth = 2;
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.8;
    [UIView commitAnimations];
    
}
- (void)changeDate:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yy"];
    NSString *stringFromDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  From : : %@",stringFromDate);
    txt_ToDate.text=stringFromDate;
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
}


- (IBAction)btn_Status:(id)sender {
    NSLog(@"Assign Array %@",activityStatus);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in activityStatus) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[self.txt_Status frame] inView:self.view_show animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;

        
        //[actionSheet showFromRect:[(UITextField *)sender frame] inView:self.txt_Status animated:YES];
        //actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 4;
    

}

- (IBAction)btn_Taluka:(id)sender {
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in activityTaluka) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[self.txt_Taluka frame] inView:self.view_show animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 2;

}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"button click ....%ld",(long)buttonIndex);
    if(txt_ActivityType){
        NSLog(@"... in");
        switch (popup.tag) {
                NSLog(@"... in");
            case 1:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    NSLog(@"ek..");
                    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    self.txt_ActivityType.text = NSLocalizedString([activityType_PickerArr objectAtIndex:buttonIndex],@"");
                }
        }
    }
    if(txt_Taluka){
        switch (popup.tag) {
            case 2:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    txt_Taluka.text = NSLocalizedString([activityTaluka objectAtIndex:buttonIndex],@"");
                }
                
        }
    }//if
    if(txt_AssignTo){
        switch (popup.tag) {
            case 3:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    txt_AssignTo.text = NSLocalizedString([_activityAssingTo objectAtIndex:buttonIndex],@"");
                }
                
        }
    }//if
    if(txt_Status){
        switch (popup.tag) {
            case 4:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    txt_Status.text = NSLocalizedString([activityStatus objectAtIndex:buttonIndex],@"");
                }
                
        }
    }//if
    if(txt_PPL){
        switch (popup.tag) {
            case 5:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    txt_PPL.text = NSLocalizedString([activityPPLNamePickerArr objectAtIndex:buttonIndex],@"");
                }
        }
    }//if
    
}
-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
    
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
- (IBAction)btn_Search:(id)sender {
    
    if([txt_FromDate.text isEqual:@""])
    {
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){

        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                           message:@"Please from date"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];
        }else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            
            alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                               message:@"Please from date"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil,nil];
            [alert show];
        }else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            
            alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                               message:@"Please from date"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil,nil];
            [alert show];
        }
        
    }else if ([txt_ToDate.text isEqual:@""])
    {
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                               message:@"Please To date"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil,nil];
            [alert show];
        }else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            
            alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                               message:@"Please To date"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil,nil];
            [alert show];
        }else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            
            alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                               message:@"Please To date"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil,nil];
            [alert show];
        }
    }else
    {
        ActivitySearchResultViewController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Search_Activity_Result_VCViewController"];
        
        searchOpportunityResult_VC.FromDate=txt_FromDate.text;
        searchOpportunityResult_VC.Todate=txt_ToDate.text;
        searchOpportunityResult_VC.ActivityType=txt_ActivityType.text;
        searchOpportunityResult_VC.Status=txt_Status.text;
        searchOpportunityResult_VC.assignTO=txt_AssignTo.text;
        searchOpportunityResult_VC.taluka=txt_Taluka.text;
        searchOpportunityResult_VC.ppl=txt_PPL.text;
        searchOpportunityResult_VC.ActiveInActive=accountString;
        
        //searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
        [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
    }

}

- (IBAction)btn_Clear:(id)sender {
}
- (IBAction)btnActive:(id)sender {
    
    if ([checkstringfortkmtgm isEqual:@"TGM"]) {
       
        
          accountString=@"TGM";
    }
    else{
    
    

    
    self.img_TGM.layer.borderColor = [UIColor colorWithRed:(54/255.0) green:(180/255.0) blue:(220/255.0) alpha:1].CGColor;
    self.img_TGM.layer.borderWidth = 2;
    
    self.img_TKM.layer.borderColor =  [UIColor colorWithRed:(143/255.0) green:(145/255.0) blue:(152/255.0) alpha:1].CGColor;
    self.img_TKM.layer.borderWidth = 2;
        
        
    [self.img_TGM setBackgroundImage: [UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
    [self.img_TKM setBackgroundImage: [UIImage imageNamed:@"icon_check.png"] forState:UIControlStateNormal];

       checkstringfortkmtgm=@"TGM";
        
          accountString=@"TGM";
    }
    
    
    }

- (IBAction)btnInActive:(id)sender {
    
    
    
    
    if([checkstringfortkmtgm isEqual:@"TKM"]){
    
     accountString=@"TKM";
        
        
    }
    else{
    self.img_TGM.layer.borderColor = [UIColor colorWithRed:(143/255.0) green:(145/255.0) blue:(152/255.0) alpha:1].CGColor;
    self.img_TGM.layer.borderWidth = 2;
    
    self.img_TKM.layer.borderColor = [UIColor colorWithRed:(54/255.0) green:(180/255.0) blue:(220/255.0) alpha:1].CGColor;
    self.img_TKM.layer.borderWidth = 2;
    
    [self.img_TGM setBackgroundImage: [UIImage imageNamed:@"icon_check.png"] forState:UIControlStateNormal];
    
    [self.img_TKM setBackgroundImage: [UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
   
            checkstringfortkmtgm=@"TKM";
        
         accountString=@"TKM";
        
        
    }
}
@end
