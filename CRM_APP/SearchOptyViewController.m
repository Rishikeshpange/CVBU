//
//  SearchOptyViewController.m
//  CRM_APP
//
//  Created by Admin on 24/01/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import "SearchOptyViewController.h"
#import "Reachability.h"
#import "RequestDelegate.h"
#import "MBProgressHUD.h"
#import "TBXML.h"
#import "OpportunitySearchResultController.h"
@interface SearchOptyViewController () {
    UIAlertView* alert;
    NSArray* sale_Stage_array;
    NSString *ActiveInActive, *dateString, *MonthDate;
    NSDateFormatter* df;
    NSPredicate* mobileNumberPred;
    NSString *mobileNumberPattern, *envelopeText;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
    NSString *idLOb;
    NSMutableArray *assignIdArray;
    
    NSString *enablestring;
    
    
    
}
@end

@implementation SearchOptyViewController
@synthesize saleStagePickerArr, pplNamePickerArr, ppl_ID_PickerArr, SearchOpportunityListArray, SalesTaluka_PickerArr, SalesAssignTo_PickerArr, SalesAssignTo_PickerArr_Static,SalesAssignToID;
@synthesize txtFromDate, txtAssignTO, txtSalesStage, txtTaluka, txtToDate, txtPPL, txtCustomerMobile, txtCustomerName, txtFinancier;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![self connected]) {
        // not connected
        NSLog(@"Newtwork not Available...");
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
        [self textFiledText];
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; //usedetails instance
        saleStagePickerArr = [[NSMutableArray alloc] init];
        mobileNumberPattern = @"[789][0-9]{9}";
        mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
        /*
         1.       C0 (Prospecting)
         2.       C1 (Quote Tendered)
         3.       C1A (Papers submitted)
         4.       C2 (Adv. Received)
         5.       C3 (Vehicle Delivered)
         6.       Closed Lost at C0
         7.       Closed Lost at C1
         8.       Closed Lost at C1A
         9.       Closed Lost at C2
         10.   Closed Lost at C3
         */
        
        saleStagePickerArr = [NSMutableArray arrayWithObjects:@"C0 (Prospecting)", @"C1 (Quote Tendered)", @"C1A (Papers submitted)", @"C2 (Adv. Received)", @"C3 (Vehicle Delivered)", @"Closed Lost at C0", @"Closed Lost at C1", @"Closed Lost at C1A", @"Closed Lost at C2", nil];
        NSLog(@"Sales stage : %@", saleStagePickerArr);
        ActiveInActive = @"TGM";
        
        // [self showAlert];
        self.btnSearch.layer.cornerRadius = 3;
        self.btnSearch.layer.masksToBounds = YES;
        
        self.btnClear.layer.cornerRadius = 3;
        self.btnClear.layer.masksToBounds = YES;
        
        // Rounded border for View's
        self.viewFirst.layer.cornerRadius = 5;
        self.viewSecond.layer.masksToBounds = YES;
        self.viewFirst.layer.cornerRadius = 5;
        self.viewSecond.layer.masksToBounds = YES;
        
        // Button Border Color
        self.btnTGM.layer.borderColor = [UIColor colorWithRed:(54 / 255.0)green:(180 / 255.0)blue:(220 / 255.0)alpha:1].CGColor;
        self.btnTGM.layer.borderWidth = 2;
        
        self.btnTKM.layer.borderColor = [UIColor colorWithRed:(143 / 255.0)green:(145 / 255.0)blue:(152 / 255.0)alpha:1].CGColor;
        self.btnTKM.layer.borderWidth = 2;
        
        // Text Fileds Border Color
        self.txtCustomerName.layer.borderWidth = 2.0f;
        self.txtCustomerMobile.layer.borderWidth = 2.0f;
        
        self.txtFromDate.layer.borderWidth = 2.0f;
        self.txtSalesStage.layer.borderWidth = 2.0f;
        
        self.txtTaluka.layer.borderWidth = 2.0f;
        self.txtToDate.layer.borderWidth = 2.0f;
        
        self.txtPPL.layer.borderWidth = 2.0f;
        self.txtAssignTO.layer.borderWidth = 2.0f;
        
        self.txtCustomerName.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtCustomerMobile.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        
        self.txtFromDate.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtSalesStage.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        
        self.txtTaluka.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtToDate.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        
        self.txtPPL.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtAssignTO.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        // Do any additional setup after loading the view.
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
        
        //saleStagePickerArr=[[NSMutableArray alloc] init];
        pplNamePickerArr = [[NSMutableArray alloc] init];
        SalesTaluka_PickerArr = [[NSMutableArray alloc] init];
        SalesAssignTo_PickerArr = [[NSMutableArray alloc] init];
                SalesAssignToID = [[NSMutableArray alloc] init];
        
        assignIdArray =[[NSMutableArray alloc] init];
        
        
        SalesAssignTo_PickerArr_Static = [[NSMutableArray alloc] initWithObjects:@"NSE & DSE", @"NSE", @"DSE", @"NDRM", nil];
        
        // Date Calculation for Opty Search
        NSDate* date = [NSDate date]; //I'm using this just to show the this is how you convert a date
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd-MMM-yyyy"];
        //[df setDateFormat:@"MMM"];
        dateString = [df stringFromDate:date];
        NSLog(@"Date Final Month :%@", dateString);
        txtToDate.text = dateString;
        
        NSDate* sevenDaysAgo = [date dateByAddingTimeInterval:-180 * 24 * 60 * 60];
        NSLog(@"30 days ago: %@", sevenDaysAgo);
        MonthDate = [df stringFromDate:sevenDaysAgo];
        NSLog(@"Month Date : %@", MonthDate);
        txtFromDate.text = MonthDate;
    }
    else {
        [self textFiledText];
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; //usedetails instance
        saleStagePickerArr = [[NSMutableArray alloc] init];
        mobileNumberPattern = @"[789][0-9]{9}";
        mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
     
        
        saleStagePickerArr = [NSMutableArray arrayWithObjects:@"C0 (Prospecting)", @"C1 (Quote Tendered)", @"C1A (Papers submitted)", @"C2 (Adv. Received)", @"C3 (Vehicle Delivered)", @"Closed Lost at C0", @"Closed Lost at C1", @"Closed Lost at C1A", @"Closed Lost at C2", nil];
        NSLog(@"Sales stage : %@", saleStagePickerArr);
        ActiveInActive = @"TGM";
        
        //[self showAlert];
        self.btnSearch.layer.cornerRadius = 3;
        self.btnSearch.layer.masksToBounds = YES;
        
        self.btnClear.layer.cornerRadius = 3;
        self.btnClear.layer.masksToBounds = YES;
        
        // Rounded border for View's
        self.viewFirst.layer.cornerRadius = 5;
        self.viewSecond.layer.masksToBounds = YES;
        self.viewFirst.layer.cornerRadius = 5;
        self.viewSecond.layer.masksToBounds = YES;
        
        // Button Border Color
        self.btnTGM.layer.borderColor = [UIColor colorWithRed:(54 / 255.0)green:(180 / 255.0)blue:(220 / 255.0)alpha:1].CGColor;
        self.btnTGM.layer.borderWidth = 2;
        
        self.btnTKM.layer.borderColor = [UIColor colorWithRed:(143 / 255.0)green:(145 / 255.0)blue:(152 / 255.0)alpha:1].CGColor;
        self.btnTKM.layer.borderWidth = 2;
        
        // Text Fileds Border Color
        self.txtCustomerName.layer.borderWidth = 2.0f;
        self.txtCustomerMobile.layer.borderWidth = 2.0f;
        
        self.txtFromDate.layer.borderWidth = 2.0f;
        self.txtSalesStage.layer.borderWidth = 2.0f;
        
        self.txtTaluka.layer.borderWidth = 2.0f;
        self.txtToDate.layer.borderWidth = 2.0f;
        
        self.txtPPL.layer.borderWidth = 2.0f;
        self.txtAssignTO.layer.borderWidth = 2.0f;
        
        self.txtCustomerName.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtCustomerMobile.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        
        self.txtFromDate.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtSalesStage.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        
        self.txtTaluka.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtToDate.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        
        self.txtPPL.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        self.txtAssignTO.layer.borderColor = [UIColor colorWithRed:(206 / 255.0)green:(205 / 255.0)blue:(205 / 255.0)alpha:1].CGColor;
        // Do any additional setup after loading the view.
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
        
        //saleStagePickerArr=[[NSMutableArray alloc] init];
        pplNamePickerArr = [[NSMutableArray alloc] init];
        SalesTaluka_PickerArr = [[NSMutableArray alloc] init];
        SalesAssignTo_PickerArr = [[NSMutableArray alloc] init];
          _Financier_List_PickerArr = [[NSMutableArray alloc] init];
         _Assignlobid_PickerArr = [[NSMutableArray alloc] init];
       
        SalesAssignTo_PickerArr_Static = [[NSMutableArray alloc] initWithObjects:@"NSE & DSE", @"NSE", @"DSE", @"NDRM", nil];
        
        // Date Calculation for Opty Search
        NSDate* date = [NSDate date]; //I'm using this just to show the this is how you convert a date
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd-MMM-yyyy"];
        //[df setDateFormat:@"MMM"];
        dateString = [df stringFromDate:date];
        NSLog(@"Date Final Month :%@", dateString);
        txtToDate.text = dateString;
        
        NSDate* sevenDaysAgo = [date dateByAddingTimeInterval:-180 * 24 * 60 * 60];
        NSLog(@"30 days ago: %@", sevenDaysAgo);
        MonthDate = [df stringFromDate:sevenDaysAgo];
        NSLog(@"Month Date : %@", MonthDate);
        txtFromDate.text = MonthDate;
        /*
         NSCalendar *calendar = [NSCalendar currentCalendar];
         NSDateComponents *comps = [NSDateComponents new];
         comps.month = -6;
         comps.day   = -1;
         NSDate *date1 = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
         NSDateComponents *components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date1]; // Get necessary date components
         NSLog(@"Previous month: %d",[components month]);
         NSLog(@"Previous day  : %d",[components day]);
         
         NSDate *currentDate = [NSDate date];
         NSLog(@"Current Date = %@", currentDate);
         NSDateComponents *dateComponents = [NSDateComponents new];
         dateComponents.month = 6;
         
         NSDate *currentDatePlus1Month = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
         NSLog(@"Date = %@", currentDatePlus1Month);
         MonthDate=[df stringFromDate:currentDatePlus1Month];
         NSLog(@"Month Date : %@",MonthDate);*/
        
                 if ([userDetailsVal_.POSTN isEqual:@"NDRM"])
                     {
                     
                         self.viewFirst.hidden=NO;
                         self.txtCustomerMobile.hidden=NO;
                         self.customermobilelabel.hidden=NO;
                     
                     }
                    else if ([userDetailsVal_.POSTN isEqual:@"DSM"])
                    {
                    
                    
                        self.viewFirst.hidden=YES;
                        self.txtCustomerMobile.hidden=NO;
                        self.customermobilelabel.hidden=NO;                    }
        
                else{
                
                    self.viewFirst.hidden=YES;
                    self.txtCustomerMobile.hidden=YES;
                    self.customermobilelabel.hidden=YES;
                    
                    
                    
                }
        
        
        enablestring=@"TGM";
        
        
   //    [self callsaleStage];
     [self callSaleStagePPL];
       [self callTahshil];
        [self  callAssignTo];
        [self call_List_Of_Fianacer];
        

        
        
      
    }
} //

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pplfound:) name:@"pplfound" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActivityTaluka_Found:) name:@"ActivityTaluka_Found" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SaleAssign_To_Found:) name:@"SaleAssign_To_Found" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Finance_Data_Found:) name:@"Finance_Data_Found" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pplfound" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ActivityTaluka_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SaleAssign_To_Found" object:nil];
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Finance_Data_Found" object:nil];
    
}
- (void)textFiledText
{
    UIColor* color = [UIColor colorWithRed:(131 / 255.0)green:(131 / 255.0)blue:(131 / 255.0)alpha:1];
    //self.txtCustomerName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Customer name" attributes:@{NSForegroundColorAttributeName:color}];
    
    //self.txtCustomerMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Customer Mobile Number" attributes:@{NSForegroundColorAttributeName:color}];
    
    
    self.txtFromDate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" From Date" attributes:@{ NSForegroundColorAttributeName : color }];
    
    self.txtToDate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" To Date" attributes:@{ NSForegroundColorAttributeName : color }];
    
    self.txtSalesStage.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Sales Stage" attributes:@{ NSForegroundColorAttributeName : color }];
    
    self.txtPPL.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" PPL" attributes:@{ NSForegroundColorAttributeName : color }];
    
    self.txtTaluka.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Taluka" attributes:@{ NSForegroundColorAttributeName : color }];
    
    self.txtAssignTO.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Assign To" attributes:@{ NSForegroundColorAttributeName : color }];
    
    
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)callSaleStagePPL
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
                    @"</SOAP:Envelope>"];
    
    NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc] initiateRequest:request name:@"ppl"];
}
- (void)pplfound:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found responseDSM ....... %@ ", response);
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
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
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
        
        if (ppl_ID_PickerArr || pplNamePickerArr) {
            [ppl_ID_PickerArr removeAllObjects];
            [pplNamePickerArr removeAllObjects];
        }
        
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        TBXMLElement* container = [TBXML childElementNamed:@"GetListOfPPLForNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        
        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"PPL_ID" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [ppl_ID_PickerArr addObject:PPL_ID_];
                
                TBXMLElement* PPL_NAME = [TBXML childElementNamed:@"PPL_NAME" parentElement:S_PROD_LN];
                NSString* PPL_NAME_ = [TBXML textForElement:PPL_NAME];
                NSLog(@"\n SALE_STAGE_NAME : %@", PPL_NAME_);
                [pplNamePickerArr addObject:PPL_NAME_];
                
            } while ((tuple = tuple->nextSibling));
        }
        if ((pplNamePickerArr.count) > 0) {
            //  [appdelegate hideAlert];
        }
        else {
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                               message:@"No PPL found.Please try agin "
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (void)callTahshil
{
    NSLog(@"Distict..and . %@ %@", appdelegate.loginUD, userDetailsVal_.ROW_ID);
    
  
    
    envelopeText = [NSString stringWithFormat:
                    @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                    @"<SOAP:Body>"
                    @"<GetListOfTehsil xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                    @"<poistionid>%@</poistionid>"
                    @"<districtname>Thane</districtname>"
                    @"<attr1></attr1>"
                    @"</GetListOfTehsil>"
                    @"</SOAP:Body>"
                    @"</SOAP:Envelope>",
                    userDetailsVal_.ROW_ID];
    
    NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc] initiateRequest:request name:@"getActivityTaluka"];
}
- (void)ActivityTaluka_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n _ActivityTaluka_Found response... %@ ", response);
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
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            
            alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        if (SalesTaluka_PickerArr) {
            [SalesTaluka_PickerArr removeAllObjects];
        }
        
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        NSLog(@"Which..");
        TBXMLElement* container = [TBXML childElementNamed:@"GetListOfTehsilResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        // TBXMLElement *old = [TBXML childElementNamed:@"old" parentElement:tuple];
        // TBXMLElement *getListSaleStageJavaCall = [TBXML childElementNamed:@"GetListOfTehsil" parentElement:old];
        // TBXMLElement *getListSaleStageJavaCall2 = [TBXML childElementNamed:@"GetListOfTehsil" parentElement:getListSaleStageJavaCall];
        //  TBXMLElement *getListSaleStageJavaCall3 = [TBXML childElementNamed:@"GetListOfTehsil" parentElement:getListSaleStageJavaCall2];
        
        //  TBXMLElement *tuple2 =[TBXML childElementNamed:@"tuple" parentElement:getListSaleStageJavaCall3];
        
        if (tuple) {
            [self hideAlert];
            do {
                TBXMLElement* S_Lst_Of_Val = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* NAME = [TBXML childElementNamed:@"X_TALUKA" parentElement:S_Lst_Of_Val];
                NSString* str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_S_Lst_Of_Val : %@", str_NAME);
                [SalesTaluka_PickerArr addObject:str_NAME];
                
            } while ((tuple = tuple->nextSibling));
            /* do
             {
             TBXMLElement *SALES_STAGE_NAME  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple2]];
             NSString *SALE_STAGE_NAME = [TBXML textForElement:SALES_STAGE_NAME];
             NSLog(@"\n SALE_STAGE_NAME : %@",SALE_STAGE_NAME);
             [SalesTaluka_PickerArr addObject:SALE_STAGE_NAME];
             
             }while ((tuple2 = tuple2->nextSibling));*/
            NSLog(@"Sales Stages : %@", SalesTaluka_PickerArr);
            
            if ((SalesTaluka_PickerArr.count) > 0) {
                //  [appdelegate hideAlert];
            }
            else {
                alert = [[UIAlertView alloc] initWithTitle:nil
                                                   message:@"No result found for tahshil "
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil
                                               message:@"No result found for tahshil "
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
//- (void)callAssignTo
//{
//    NSLog(@"Distict %@ %@", appdelegate.loginUD, userDetailsVal_.ROW_ID);
//    
//    NSString* envelopeText = [NSString stringWithFormat:
//                              @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                              @"<SOAP:Body>"
//                              @"<GetListOfNSEOrLOBDSEForNDRM> xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//                              @"<positionid>%@</positionid>"
//                              @"<positionname></positionname>"
//                              @"<buname></buname>"
//                              @"<searchpostitionname1></searchpostitionname1>"
//                              @"<searchpostitionname2></searchpostitionname2>"
//                              @"</GetListOfNSEOrLOBDSEForNDRM>"
//                              @"</SOAP:Body>"
//                              @"</SOAP:Envelope>",
//                              userDetailsVal_.ROW_ID];
//    
//    NSLog(@"\n envlopeString Of Assign TO....!!!!%@", envelopeText);
//    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
//    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
//    NSLog(@"URL IS %@", theurl);
//    // NSLog(@"REQUEST IS %@",envelopeText);
//    
//    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
//    
//    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:envelope];
//    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
//    
//    [[RequestDelegate alloc] initiateRequest:request name:@"getActivityAssignTo"];
//}
//- (void)ActivityAssignTo_Found:(NSNotification*)notification
//{
//    
//    NSError* err;
//    NSString* response = [[notification userInfo] objectForKey:@"response"];
//    NSLog(@"\n Activity Assign TO response... %@ ", response);
//    
//    if ([response isEqual:@""]) {
//        alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
//                                           message:@"No data found.Please try agaain "
//                                          delegate:self
//                                 cancelButtonTitle:@"OK"
//                                 otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    else {
//        if (SalesAssignTo_PickerArr) {
//            [SalesAssignTo_PickerArr removeAllObjects];
//        }
//        
//        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
//        
//        TBXMLElement* container = [TBXML childElementNamed:@"GetListOfNSEOrLOBDSEForNDRMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
//        
//        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
//        
//        if (tuple) {
//            do {
//                TBXMLElement* S_Lst_Of_Val = [TBXML childElementNamed:@"S_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
//                TBXMLElement* NAME = [TBXML childElementNamed:@"NSE_LOBDSE_NAME" parentElement:S_Lst_Of_Val];
//                
//                NSString* str_NAME = [TBXML textForElement:NAME];
//                
//                NSLog(@"\n str_NSE : %@", str_NAME);
//                
//                [SalesAssignTo_PickerArr addObject:str_NAME];
//                
//                TBXMLElement* POSITION_ID = [TBXML childElementNamed:@"POSITION_ID" parentElement:S_Lst_Of_Val];
//                
//                NSString* str_Position = [TBXML textForElement:POSITION_ID];
//                
//                NSLog(@"\n str_NSE : %@", str_Position);
//                
//            } while ((tuple = tuple->nextSibling));
//            
//            NSLog(@"Sales Stages : %@", SalesAssignTo_PickerArr);
//        }
//        if ((SalesAssignTo_PickerArr.count) > 0) {
//            //  [appdelegate hideAlert];
//        }
//        else {
//            alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
//                                               message:@"No data found.Please try agin "
//                                              delegate:self
//                                     cancelButtonTitle:@"OK"
//                                     otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    }
//    [self hideAlert];
//}

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
            
            if (SalesAssignTo_PickerArr)
            {
                [SalesAssignTo_PickerArr removeAllObjects];
            }
            //SalesAssignTo_PickerArr_ID
            
           
            
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
                    [SalesAssignTo_PickerArr addObject:str_NAME];
                    
                    TBXMLElement *POSITION_ID = [TBXML childElementNamed:@"POSITION_ID" parentElement:S_Lst_Of_Val];
                    NSString *str_Position = [TBXML textForElement:POSITION_ID];
                    NSLog(@"\n str_NSE : %@",str_Position);
                    [_Assignlobid_PickerArr addObject:str_Position];
                    
                }while ((tuple = tuple->nextSibling));
                NSLog(@"Assign To .... [0] %@",SalesAssignTo_PickerArr);
                
            }
            
            NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[SalesAssignTo_PickerArr count]);
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            
            if (SalesAssignTo_PickerArr)
            {
                [SalesAssignTo_PickerArr removeAllObjects];
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
                    [SalesAssignTo_PickerArr addObject:str_Name];
                    
                    TBXMLElement *POSITION_ID = [TBXML childElementNamed:@"POSTION_ID" parentElement:S_Lst_Of_Val];
                    NSString *str_Position = [TBXML textForElement:POSITION_ID];
                    //   NSLog(@"\n str_NSE : %@",str_Position);
                    [_Assignlobid_PickerArr addObject:str_Position];
                    
                    NSLog(@"id %@",_Assignlobid_PickerArr);
                    
                    
//                    
//                    TBXMLElement *POSITION_NAME = [TBXML childElementNamed:@"POSTION_NAME" parentElement:S_Lst_Of_Val];
//                    NSString *str_PositionName = [TBXML textForElement:POSITION_NAME];
//                    NSLog(@"\n str_NSE : %@",str_PositionName);
//                    [activityAssignLOB addObject:str_PositionName];
//                    
//                    
//                    TBXMLElement *POSITION_PHN = [TBXML childElementNamed:@"POSITION_PH_NUM" parentElement:S_Lst_Of_Val];
//                    NSString *str_PositionPhn = [TBXML textForElement:POSITION_PHN];
//                    NSLog(@"\n str_NSE : %@",str_PositionPhn);
//                    [activityAssignLOB addObject:str_PositionPhn];
//                    
//                    
//                    TBXMLElement *LOB_NAME = [TBXML childElementNamed:@"LOBNAME" parentElement:S_Lst_Of_Val];
//                    NSString *str_LobName = [TBXML textForElement:LOB_NAME];
//                    NSLog(@"\n str_NSE : %@",str_LobName);
//                    [activityAssignLOB addObject:str_LobName];
//                    
//                    TBXMLElement *POSITION_TYPE = [TBXML childElementNamed:@"POSITION_TYPE" parentElement:S_Lst_Of_Val];
//                    NSString *str_PositionType = [TBXML textForElement:POSITION_TYPE];
//                    NSLog(@"\n str_NSE : %@",str_PositionType);
//                    [activityAssignLOB addObject:str_PositionType];
                    
                }while ((tuple = tuple->nextSibling));
            }
            NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[SalesAssignTo_PickerArr count]);
            
            
        }else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            
            if (SalesAssignTo_PickerArr)
            {
                [SalesAssignTo_PickerArr removeAllObjects];
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
                    [SalesAssignTo_PickerArr addObject:str_Name];
                    
                    TBXMLElement *POSITION_ID = [TBXML childElementNamed:@"POSTION_ID" parentElement:S_Lst_Of_Val];
                    NSString *str_Position = [TBXML textForElement:POSITION_ID];
                    NSLog(@"id : %@",str_Position);
                    [_Assignlobid_PickerArr addObject:str_Position];
                    
                    NSLog(@"id %@",_Assignlobid_PickerArr);
                    
                }while ((tuple = tuple->nextSibling));
            }
            NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[SalesAssignTo_PickerArr count]);
        }
        [self hideAlert];
        
      
        
    }
}




- (IBAction)btnSearch:(id)sender
{
    
    if (![self connected]) {
        // not connected
        NSLog(@"Newtwork not Available...");
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        
        NSLog(@"Test....Btn Search ..");
        
        NSLog(@" TGM / TKM name  %@", ActiveInActive);
        NSLog(@" Cust Name %@", txtCustomerName.text);
        NSLog(@" Cust Mob %@", txtCustomerMobile.text);
        NSLog(@" From Date  %@", txtFromDate.text);
        NSLog(@" To date %@", txtToDate.text);
        NSLog(@" Sales Stages %@", txtSalesStage.text);
        NSLog(@" PPL%@", txtPPL.text);
        NSLog(@" Taluka %@", txtTaluka.text);
        NSLog(@" Assing TO  %@", txtAssignTO.text);
        NSLog(@"assign to id %@", idLOb);
        NSLog(@"financier %@",txtFinancier);
        
        
        //NSString *strLastname=[[txtCustomerName.text] ]
        
        if (txtCustomerName.text.length > 0) {
            txtCustomerName.text = [txtCustomerName.text uppercaseString];
        }
        NSLog(@" Cust Name After %@", txtCustomerName.text);
        
        if ([txtFromDate.text isEqual:@""]) {
            alert = [[UIAlertView alloc] initWithTitle:nil
                                               message:@"Please select From date "
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([txtToDate.text isEqual:@""]) {
            alert = [[UIAlertView alloc] initWithTitle:nil
                                               message:@"Please select To date "
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([txtCustomerMobile.text isEqual:@""]) {
            
            if (![txtCustomerName.text isEqual:@""]) {
                NSString* str = txtCustomerName.text;
                NSCharacterSet* strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"]; //1234567890_"];
                
                strCharSet = [strCharSet invertedSet];
                //And you can then use a string method to find if your string contains anything in the inverted set:
                
                NSRange r = [str rangeOfCharacterFromSet:strCharSet];
                if (r.location != NSNotFound) {
                    NSLog(@"the string contains illegal characters");
                    //return NO;
                    NSLog(@"YYY");
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Customer name contains some special characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }
                else {
                    NSLog(@"the string not contains illegal characters");
                      OpportunitySearchResultController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Search_Opportunity_Result_VCViewController"];
                     searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
                     searchOpportunityResult_VC.txtPassFromDate=txtFromDate.text;
                     searchOpportunityResult_VC.txtPassToDate=txtToDate.text;
                     searchOpportunityResult_VC.txtTaluka=txtTaluka.text;
                     searchOpportunityResult_VC.txtTGMTKM=ActiveInActive;
                     searchOpportunityResult_VC.txtCustomerName=txtCustomerName.text;
                     searchOpportunityResult_VC.txtCustomerMobile=txtCustomerMobile.text;
                     searchOpportunityResult_VC.txtPPL=txtPPL.text;
                     searchOpportunityResult_VC.txtPassSalesStages=txtSalesStage.text;
                     searchOpportunityResult_VC.txtAssign=txtAssignTO.text;
                      searchOpportunityResult_VC.txtpassid=idLOb;
                    searchOpportunityResult_VC.txtpassfinancier=txtFinancier.text;
                    
                    
                    
                     [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
                }
                //return YES;
            }
            else {
                // flag = 1;
                NSLog(@"Test....Btn Search ..");
                 OpportunitySearchResultController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Search_Opportunity_Result_VCViewController"];
                 searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
                 searchOpportunityResult_VC.txtPassFromDate=txtFromDate.text;
                 searchOpportunityResult_VC.txtPassToDate=txtToDate.text;
                 searchOpportunityResult_VC.txtTaluka=txtTaluka.text;
                 searchOpportunityResult_VC.txtTGMTKM=ActiveInActive;
                 searchOpportunityResult_VC.txtCustomerName=txtCustomerName.text;
                 searchOpportunityResult_VC.txtCustomerMobile=txtCustomerMobile.text;
                 searchOpportunityResult_VC.txtPPL=txtPPL.text;
                 searchOpportunityResult_VC.txtPassSalesStages=txtSalesStage.text;
                 searchOpportunityResult_VC.txtAssign=txtAssignTO.text;
                searchOpportunityResult_VC.txtpassid=idLOb;
                searchOpportunityResult_VC.txtpassfinancier=txtFinancier.text;
                
                
                 [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
            }
        }
        else {
            
            if (txtCustomerMobile.text && txtCustomerMobile.text.length < 10) {
                [self hideAlert];
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"contact number must be of 10 digits" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                
                self.txtCustomerMobile.text = @"";
            }
            
            else if ([mobileNumberPred evaluateWithObject:txtCustomerMobile.text] != YES && [txtCustomerMobile.text length] == 0) {
                [self hideAlert];
                UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Please enter valid phone number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertview show];
                
                self.txtCustomerMobile.text = @"";
            }
            /*else if (txtCustomerName.text && txtCustomerName.text.length < 1)
             {
             NSString *alphaNum = @"[a-zA-Z0-9]+";
             NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alphaNum];
             }*/
            
            else {
                if (![txtCustomerName.text isEqual:@""]) {
                    NSString* str = txtCustomerName.text;
                    NSCharacterSet* strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"]; //1234567890_"];
                    
                    strCharSet = [strCharSet invertedSet];
                    //And you can then use a string method to find if your string contains anything in the inverted set:
                    
                    NSRange r = [str rangeOfCharacterFromSet:strCharSet];
                    if (r.location != NSNotFound) {
                        NSLog(@"the string contains illegal characters");
                        //return NO;
                        NSLog(@"YYY");
                    }
                    else {
                        NSLog(@"XXXX");
                        NSLog(@"the string not contains illegal characters");
                        
                        
                         OpportunitySearchResultController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Search_Opportunity_Result_VCViewController"];
                         searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
                         searchOpportunityResult_VC.txtPassFromDate=txtFromDate.text;
                         searchOpportunityResult_VC.txtPassToDate=txtToDate.text;
                         searchOpportunityResult_VC.txtTaluka=txtTaluka.text;
                         searchOpportunityResult_VC.txtTGMTKM=ActiveInActive;
                         searchOpportunityResult_VC.txtCustomerName=txtCustomerName.text;
                         searchOpportunityResult_VC.txtCustomerMobile=txtCustomerMobile.text;
                         searchOpportunityResult_VC.txtPPL=txtPPL.text;
                         searchOpportunityResult_VC.txtPassSalesStages=txtSalesStage.text;
                         searchOpportunityResult_VC.txtAssign=txtAssignTO.text;
                        searchOpportunityResult_VC.txtpassid=idLOb;
                        searchOpportunityResult_VC.txtpassfinancier=txtFinancier.text;
                         
                         [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
                    }
                    //return YES;
                }
                
                else {
                    NSLog(@"Inside Search opty ");
                    OpportunitySearchResultController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Search_Opportunity_Result_VCViewController"];
                     searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
                     searchOpportunityResult_VC.txtPassFromDate=txtFromDate.text;
                     searchOpportunityResult_VC.txtPassToDate=txtToDate.text;
                     searchOpportunityResult_VC.txtTaluka=txtTaluka.text;
                     searchOpportunityResult_VC.txtTGMTKM=ActiveInActive;
                     searchOpportunityResult_VC.txtCustomerName=txtCustomerName.text;
                     searchOpportunityResult_VC.txtCustomerMobile=txtCustomerMobile.text;
                     searchOpportunityResult_VC.txtPPL=txtPPL.text;
                     searchOpportunityResult_VC.txtPassSalesStages=txtSalesStage.text;
                     searchOpportunityResult_VC.txtAssign=txtAssignTO.text;
                    searchOpportunityResult_VC.txtpassid=idLOb;
                    searchOpportunityResult_VC.txtpassfinancier=txtFinancier.text;
                    
                    
                     [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
                }
            }
        }
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)btnSalesStage:(id)sender
{
    
    NSLog(@"Activity...Data %@", saleStagePickerArr);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString* title in saleStagePickerArr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.FirstView animated:YES];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    }
    else {
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 1;
}

- (IBAction)btnPPL:(id)sender
{
    
    NSLog(@"Activity...Data %@", pplNamePickerArr);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString* title in pplNamePickerArr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.SecondView animated:YES];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    }
    else {
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 2;
}

- (IBAction)btnTaluka:(id)sender
{
    
    if ([SalesTaluka_PickerArr count]>0) {
       
    
    
    
    NSLog(@"Activity...Data %@", SalesTaluka_PickerArr);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString* title in SalesTaluka_PickerArr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.FirstView animated:YES];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    }
    else {
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 3;
        
    }
    
    else{
    
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    
    }
    
        
        
        
}

- (IBAction)btnAssignTo:(id)sender
{
    
    if ([SalesAssignTo_PickerArr count]>0) {
    
        NSLog(@"Activity...Data %@", SalesAssignTo_PickerArr);
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
     
        for (NSString* title in SalesAssignTo_PickerArr) {
            [actionSheet addButtonWithTitle:title];
        }
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.SecondView animated:YES];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        }
        else {
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 4;
        
        
    }
    else {
    
    
    
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    
    
    
    }
    
    
    
}

- (IBAction)btn_Financier:(id)sender
{
    
    
    
    if ([_Financier_List_PickerArr count]>0) {
        
        NSLog(@"Activity...Data %@", _Financier_List_PickerArr);
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        
        for (NSString* title in _Financier_List_PickerArr) {
            [actionSheet addButtonWithTitle:title];
        }
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.FirstView animated:YES];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        }
        else {
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 5;
        
        
    }
    else {
        
        
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message :@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
        
        
    }
  
}

- (void)actionSheet:(UIActionSheet*)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"button click ....%ld", (long)buttonIndex);
    if (txtSalesStage) {
        NSLog(@"... in");
        switch (popup.tag) {
                NSLog(@"... in");
            case 1:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    NSLog(@"ek..");
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    self.txtSalesStage.text = NSLocalizedString([saleStagePickerArr objectAtIndex:buttonIndex], @"");
                }
        }
    }
    if (txtPPL) {
        switch (popup.tag) {
            case 2:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    txtPPL.text = NSLocalizedString([pplNamePickerArr objectAtIndex:buttonIndex], @"");
                }
        }
    } //if
    if (txtTaluka) {
        switch (popup.tag) {
            case 3:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    txtTaluka.text = NSLocalizedString([SalesTaluka_PickerArr objectAtIndex:buttonIndex], @"");
                }
        }
    } //if
    if (txtAssignTO) {
        switch (popup.tag) {
            case 4:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    txtAssignTO.text = NSLocalizedString([SalesAssignTo_PickerArr objectAtIndex:buttonIndex], @"");
                    
                    idLOb = NSLocalizedString([_Assignlobid_PickerArr objectAtIndex:buttonIndex], @"");
                    
                    NSLog(@"assign to id %@",idLOb);
                }
        }
    }
    if (txtFinancier) {
        switch (popup.tag) {
            case 5:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    txtFinancier.text = NSLocalizedString([_Financier_List_PickerArr objectAtIndex:buttonIndex], @"");
                    
                  // assigntoid = NSLocalizedString([_Assignlobid_PickerArr objectAtIndex:buttonIndex], @"");
                }
        }
    }
    
    
    //if
}
- (IBAction)btnFromDate:(id)sender
{
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height - 500 - 44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height - 500, 320, 216);
    
    UIView* darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height + 44, 320, 216)];
    datePicker.tag = 10;
    datePicker.datePickerMode = UIDatePickerModeDate;
   
    
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    //datePicker.backgroundColor=[UIColor colorWithRed:(2/255.0) green:(18/255.0) blue:(40/255.0) alpha:1];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.layer.borderColor = [UIColor colorWithRed:(49 / 255.0)green:(110 / 255.0)blue:(191 / 255.0)alpha:1].CGColor;
    datePicker.layer.borderWidth = 2;
    [[UILabel appearanceWhenContainedIn:[UIDatePicker class], nil]
     setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:datePicker];
    
    UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem* spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    toolBar.layer.borderColor = [UIColor colorWithRed:(49 / 255.0)green:(110 / 255.0)blue:(191 / 255.0)alpha:1].CGColor;
    toolBar.layer.borderWidth = 2;
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.8;
    [UIView commitAnimations];
}
- (void)changeDate:(UIDatePicker*)sender
{
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    NSString* stringFromDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  From : : %@", stringFromDate);
    txtFromDate.text = stringFromDate;
}

- (void)removeViews:(id)object
{
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
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

- (IBAction)btnToDate:(id)sender
{
    
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height - 500 - 44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height - 500, 320, 216);
    
    UIView* darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height + 44, 320, 216)];
    datePicker.tag = 10;
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(changeDate_:) forControlEvents:UIControlEventValueChanged];
    //datePicker.backgroundColor=[UIColor colorWithRed:(2/255.0) green:(18/255.0) blue:(40/255.0) alpha:1];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.layer.borderColor = [UIColor colorWithRed:(49 / 255.0)green:(110 / 255.0)blue:(191 / 255.0)alpha:1].CGColor;
    datePicker.layer.borderWidth = 2;
    [[UILabel appearanceWhenContainedIn:[UIDatePicker class], nil]
     setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:datePicker];
    
    UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem* spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    toolBar.layer.borderColor = [UIColor colorWithRed:(49 / 255.0)green:(110 / 255.0)blue:(191 / 255.0)alpha:1].CGColor;
    toolBar.layer.borderWidth = 2;
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.8;
    [UIView commitAnimations];
}
- (void)changeDate_:(UIDatePicker*)sender
{
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    NSString* stringFromDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  To: : %@", stringFromDate);
    txtToDate.text = stringFromDate;
}
- (IBAction)btnClear:(id)sender {
    
    self.txtCustomerMobile.text=@"";
    self.txtCustomerName.text=@"";
    self.txtFromDate.text=@"";
    self.txtToDate.text=@"";
    self.txtPPL.text=@"";
    self.txtAssignTO.text=@"";
    self.txtSalesStage.text=@"";
    self.txtTaluka.text=@"";
}

- (void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
- (void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


-(void)call_List_Of_Fianacer
{
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
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-ea08-6508601457ef</DC>"
                               @"</Logger>"
                               @"</header>"
                               @"</SOAP:Header>"
                               @"<SOAP:Body>"
                               @"<GetFinancierDetailsForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"];
    
    
    
    NSLog(@"\n en%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityFinanceConnection"];
    
}


-(void)Finance_Data_Found:(NSNotification*)notification
{
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nfinance  %@",response);
    
    if (self.Financier_List_PickerArr)
    {
        
        [self.Financier_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetFinancierDetailsForDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_ORG_EXT  = [TBXML childElementNamed:@"S_ORG_EXT" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *ACC_NAME = [TBXML childElementNamed:@"ACC_NAME" parentElement:S_ORG_EXT];
            NSString*strACC_NAME = [TBXML textForElement:ACC_NAME];
            NSLog(@"S_Lst_Of_Val FOR  : %@",strACC_NAME);
            
            
            [self.Financier_List_PickerArr addObject:strACC_NAME];
          
        }while ((tuple = tuple->nextSibling));
    }
    if([self.Financier_List_PickerArr count]>0)
    {
        // [self hideAlert];
    }
    
}


- (IBAction)TGMbtnAction:(id)sender {
    if ([enablestring isEqual:@"TGM"]) {
        
        
        
    }
    else{
    
     [self.btnTGM setBackgroundImage: [UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
        
       [self.btnTKM setBackgroundImage: [UIImage imageNamed:@"icon_check.png"] forState:UIControlStateNormal];
        
        self.btnTGM.layer.borderColor = [UIColor colorWithRed:(54 / 255.0)green:(180 / 255.0)blue:(220 / 255.0)alpha:1].CGColor;
        self.btnTGM.layer.borderWidth = 2;
        
        self.btnTKM.layer.borderColor = [UIColor colorWithRed:(143 / 255.0)green:(145 / 255.0)blue:(152 / 255.0)alpha:1].CGColor;
        self.btnTKM.layer.borderWidth = 2;
        
        
        
        
        
        enablestring=@"TGM";
        
        
        
    
        NSLog(@"enable string %@",enablestring);
        
        
    }
    
    
    
    
}

- (IBAction)TKMbtnaction:(id)sender {
    
    
    if ([enablestring isEqual:@"TKM"]) {

        
    }
    else{
        
        [self.btnTKM setBackgroundImage: [UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
        
        [self.btnTGM setBackgroundImage: [UIImage imageNamed:@"icon_check.png"] forState:UIControlStateNormal];
        
        
        self.btnTKM.layer.borderColor = [UIColor colorWithRed:(54 / 255.0)green:(180 / 255.0)blue:(220 / 255.0)alpha:1].CGColor;
        self.btnTKM.layer.borderWidth = 2;
        
        self.btnTGM.layer.borderColor = [UIColor colorWithRed:(143 / 255.0)green:(145 / 255.0)blue:(152 / 255.0)alpha:1].CGColor;
        self.btnTGM.layer.borderWidth = 2;
        
        
        
        enablestring=@"TKM";
        
        NSLog(@"enable string %@",enablestring);
        
    }
    

    
}
@end

