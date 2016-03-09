//
//  DetailViewController.m
//  test
//
//  Created by Gautam Panpatil on 07.03.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "ActivityAdhCustomCell.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "EventActive_NEEV.h"
#import "EventExecutiveDashboard_NEEV.h"
#import "ExpandableCustomCell.h"
#import "GetMMPipeLineView_DSE.h"
#import "GetSalesPipeLineDashboardAllPL_DSM.h"
#import "GetSalesPipeLineDashboardExecutive_NEEV.h"
#import "GetSalesPipeLineDashboardNEEVPL.h"
#import "GetSalesPipeLineDashboardNEEVPPL.h"
#import "GetSalesPipeLineDashboard_DSM.h"
#import "GetSalesPipeLineDashboard_NEEV.h"
#import "LeadGeneratorwisePipelineView.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "MMPipeLineView_DSM.h"
#import "Reachability.h"
#import "RequestDelegate.h"
#import "SalesPipelineDashboardNSE_NEEV.h"
#import "SingletonClass.h"
#import "TBXML.h"
#import "mmPipelineCustomCell.h"

#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface DetailViewController () {
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
    NSString *envelopeText, *str_NAME;
    UIAlertView* alert;
    NSString *values, *valuesDSMPPL, *valuesDSMPPLActive;
}
@end

@implementation DetailViewController {
}

@synthesize percentageLabel = _percentageLabel;
@synthesize Opty_Arr;
@synthesize GetSalesPipelineDashboard_Arr, GetLeadGeneratorwisePipelineView_Arr, GetSalesPipeLineDashboard_DSM_Arr;
@synthesize GetLOB_Arr, GetPPL_LOB_Arr, EventExecutiveDashboard_NEEV_Arr, EventActive_NEEV_Arr, GetSalesPipeLineDashboardNEEVPPL_Arr, GetSalesPipeLineDashboardNEEVPL_Arr, GetSalesPipeLineDashboard_NEEV_Arr, GetSalesPipelineDashboardDSM_Arr, GetSalesPipeLineDashboard_DSMPLAll_Arr, GetMMPipeLineView_DSM_Arr, GetMMPipeLineView_DSE_Arr, GetMMPipeLineView_DSEApp_Arr;
@synthesize GetPL_LOBPPL_Arr, GetPL_PPLDSM_Arr, GetPL_LOBPPLSEC_Arr;
@synthesize masterPopoverController;
@synthesize GetSalesPipeLineDashboard_DSEPLAll_Arr, GetSalesPipeLineDashboard_DSEPLArr;
;
#pragma mark - Life Cycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.originalCenter = self.view.center;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
    NSLog(@"called Detailed ");
    self.splitViewController.delegate = self;
    [self.masterPopoverController setDelegate:self];
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; //usedetails instance

    GetSalesPipelineDashboard_Arr = [[NSMutableArray alloc] init];
    GetLeadGeneratorwisePipelineView_Arr = [[NSMutableArray alloc] init];
    GetSalesPipeLineDashboard_DSM_Arr = [[NSMutableArray alloc] init];
    GetLOB_Arr = [[NSMutableArray alloc] init];
    GetPPL_LOB_Arr = [[NSMutableArray alloc] init];
    EventExecutiveDashboard_NEEV_Arr = [[NSMutableArray alloc] init];
    EventActive_NEEV_Arr = [[NSMutableArray alloc] init];
    GetSalesPipeLineDashboardNEEVPPL_Arr = [[NSMutableArray alloc] init];
    GetPL_LOBPPL_Arr = [[NSMutableArray alloc] init];
    GetSalesPipeLineDashboardNEEVPL_Arr = [[NSMutableArray alloc] init];
    GetSalesPipeLineDashboard_NEEV_Arr = [[NSMutableArray alloc] init];
    GetSalesPipelineDashboardDSM_Arr = [[NSMutableArray alloc] init];
    GetSalesPipeLineDashboard_DSMPLAll_Arr = [[NSMutableArray alloc] init];
    GetPL_LOBPPLSEC_Arr = [[NSMutableArray alloc] init];
    GetPL_PPLDSM_Arr = [[NSMutableArray alloc] init];
    GetMMPipeLineView_DSM_Arr = [[NSMutableArray alloc] init];
    GetMMPipeLineView_DSE_Arr = [[NSMutableArray alloc] init];
    GetMMPipeLineView_DSEApp_Arr = [[NSMutableArray alloc] init];
    GetSalesPipeLineDashboard_DSEPLAll_Arr = [[NSMutableArray alloc] init];
    GetSalesPipeLineDashboard_DSEPLArr = [[NSMutableArray alloc] init];
    //singleton array
    [SingletonClass sharedobject].GetSalesPipeLineDashboard_DSMPLAll_singleTonArr = [[NSMutableArray alloc] init];
    [SingletonClass sharedobject].GetPL_PPLDSM_SingletonArr = [[NSMutableArray alloc] init];
    [SingletonClass sharedobject].GetSalesPipeLineDashboard_DSEPLArrSingleton
        = [[NSMutableArray alloc] init];

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

        NSLog(@"user Details :%@", userDetailsVal_.POSTN);
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            NSLog(@"NDRM call");

            //Sales Pipeline

              [self GetAllLOB];

            //Activity Adherence WS: GetEventDashboard_NEEV  : Executive event

            //[self GetEventExecutiveDashboard_NEEV];

            //[self GetEventActive_NEEV];

            // Sales Executive Pipeline

            //[self GetSalesPipelineDashboard];

            //LeadGeneratorwisePipelineView

            //[self GetLeadGeneratorwisePipelineView_NEEV];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

            [self GetAllPPLDSM];
            //GetMMPipelineView_DSM
            [self GetMMPipeLineView_DSM];
            //[self GetSalesPipeLineDashboard_DSM];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

            [self GetAllPPLDSM];

            //[self GetSalesPipeLineDashboard_DSE];

            //[self GetMMPipeLineView_DSE];

            [self GetMMGeoDashboard_DSE];
        }
        //shraddha
        selectedIndex = -1;
        self.subTitleArray = [[NSMutableArray alloc] init];

        self.textArray = [[NSArray alloc] initWithObjects:@"apple", @"orange", @"banana", nil];
        //to fill data in tree view- shraddha
        //[self createArrayForTable];
        // [self showSalesPipeLineInLabel];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.splitViewController.delegate = self;

    if ((self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay)) {
        UIBarButtonItem* barButtonItem = self.splitViewController.displayModeButtonItem;
        barButtonItem.title = @"Show master";
        self.navigationItem.leftBarButtonItem = barButtonItem;
        [masterPopoverController dismissPopoverAnimated:YES];

        DetailViewController* detailViewManager = (DetailViewController*)self.splitViewController.delegate;
        [[detailViewManager masterPopoverController] dismissPopoverAnimated:YES];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SalesPipelineDashboard_Found:) name:@"SalesPipelineDashboard_Found" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LeadGeneratorwisePipelineView_Found:) name:@"LeadGeneratorwisePipelineView_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MMPipeLineView_DSM_Found:) name:@"MMPipeLineView_DSM_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SalesPipeLineDashboard_DSM_Found:) name:@"SalesPipeLineDashboard_DSM_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SalesPipeLineDashboard_DSE_Found:) name:@"SalesPipeLineDashboard_DSE_Found" object:nil];

    // NEEV

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SalesPipelineDashboard_NEEV_Found:) name:@"SalesPipelineDashboard_NEEV_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SalesPipelineDashboard_NEEVPPL_Found:) name:@"SalesPipelineDashboard_NEEVPPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SalesPipelineDashboard_NEEVPL_Found:) name:@"SalesPipelineDashboard_NEEVPL_Found" object:nil];

    //SalesPipelineDashboard_NEEVPPL_Found

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EventExecutiveDashboard_NEEV_Found:) name:@"EventExecutiveDashboard_NEEV_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EventActive_NEEV_Found:) name:@"EventActive_NEEV_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LobListFound:) name:@"LobListFound" object:nil]; //For LOB

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Activity_PPL_Found:) name:@"Activity_PPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PLUpdateOpty_Found:) name:@"PLUpdateOpty_Found" object:nil];

    // DSM

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActivityPPLConnectionDSMPPL_Found:) name:@"ActivityPPLConnectionDSMPPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActivityPLDSMConnection_Found:) name:@"ActivityPLDSMConnection_Found" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SalesPipelineDashboard_DSMPLAll_Found:) name:@"SalesPipelineDashboard_DSMPLAll_Found" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EventDashboard_DSM_Found:) name:@"EventDashboard_DSM_Found" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EventActiveDashboard_DSMM_Found:) name:@"EventActiveDashboard_DSMM_Found" object:nil];

    //DSE
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dsepipelinefound:) name:@"dsepipelinefound" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MMGeoDashboard_DSE_Found:) name:@"MMGeoDashboard_DSE_Found" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EventActiveDashboardDSM_DSM_FOund:) name:@"EventActiveDashboardDSM_DSM_FOund" object:nil];

    //EventActiveDashboardDSM_DSM_FOund

    //   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MMPipeLineView_DSE1_Found:) name:@"MMPipeLineView_DSE1_Found" object:nil];

    //SalesStageDSEDashboardPL_FOUND

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SalesStageDSEDashboardPL_FOUND:) name:@"SalesStageDSEDashboardPL_FOUND" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EventActiveDashboardDSM_DSM_FOund" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SalesPipelineDashboard_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LeadGeneratorwisePipelineView_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MMPipeLineView_DSM_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SalesPipeLineDashboard_DSM_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SalesPipeLineDashboard_DSE_Found" object:nil];

    //For NEEV

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SalesPipelineDashboard_NEEV_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SalesPipelineDashboard_NEEVPPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SalesPipelineDashboard_NEEVPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EventExecutiveDashboard_NEEV_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EventActive_NEEV_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LobListFound" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Activity_PPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PLUpdateOpty_Found" object:nil];

    // DSM

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ActivityPPLConnectionDSMPPL_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ActivityPLDSMConnection_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SalesPipelineDashboard_DSMPLAll_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EventDashboard_DSM_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EventActiveDashboard_DSMM_Found" object:nil];

    //DSe
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dsepipelinefound" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MMGeoDashboard_DSE_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SalesStageDSEDashboardPL_FOUND" object:nil];

    // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MMPipeLineView_DSE1_Found" object:nil];

    //SalesStageDSEDashboardPL_FOUND

    NSLog(@" Will DIsAppear");
}

- (void)viewDidAppear:(BOOL)animated
{

    NSLog(@"did appear");

    [super viewDidAppear:animated];
    //self.splitViewController.delegate = self;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"Null");
    // self.splitViewController.delegate = self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - user define Methods
//method to create dictionary for tree table -shraddha

- (void)createArrayForTable
{
    NSLog(@"LOB Array Data :%lu", (unsigned long)[GetLOB_Arr count]);

    NSDictionary* dTmp = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];

    NSMutableDictionary* Item0DicFourthlbl1 = [[NSMutableDictionary alloc] init];
    [Item0DicFourthlbl1 setObject:@"computer" forKey:@"name"];
    [Item0DicFourthlbl1 setObject:@"0-4" forKey:@"level"];

    //[Item0DicFourthlbl setValue:"Item0DicfourthArr11" forKey:@"Objects"];

    NSMutableDictionary* Item1DicFourthlbl1 = [[NSMutableDictionary alloc] init];
    [Item1DicFourthlbl1 setObject:@"computer" forKey:@"name"];
    [Item1DicFourthlbl1 setObject:@"0-4" forKey:@"level"];

    //[Item1DicFourthlbl setValue:Item0DicfourthArr11   forKey:@"Objects"];
    //
    NSArray* Item0DicfourthArr1 = [[NSArray alloc] initWithObjects:Item0DicFourthlbl1, Item1DicFourthlbl1, nil];

    NSMutableDictionary* Item0DicFourthlbl = [[NSMutableDictionary alloc] init];
    [Item0DicFourthlbl setObject:@"computer" forKey:@"name"];
    [Item0DicFourthlbl setObject:@"0-4" forKey:@"level"];

    [Item0DicFourthlbl setValue:Item0DicfourthArr1 forKey:@"Objects"];

    NSMutableDictionary* Item1DicFourthlbl = [[NSMutableDictionary alloc] init];
    [Item1DicFourthlbl setObject:@"computer" forKey:@"name"];
    [Item1DicFourthlbl setObject:@"0-4" forKey:@"level"];

    [Item1DicFourthlbl setValue:Item0DicfourthArr1 forKey:@"Objects"];
    NSArray* Item0DicfourthArr = [[NSArray alloc] initWithObjects:Item0DicFourthlbl, Item1DicFourthlbl, nil];

    NSMutableDictionary* Item0DicThirdlbl = [[NSMutableDictionary alloc] init];
    [Item0DicThirdlbl setObject:@"computer" forKey:@"name"];
    [Item0DicThirdlbl setObject:@"0-3" forKey:@"level"];

    [Item0DicThirdlbl setValue:Item0DicfourthArr forKey:@"Objects"];

    //NSArray *Item1DicSecondArr = [[NSArray alloc]initWithObjects:Item0DicSecondlbl,Item1DicSecondlbl, nil];

    NSMutableDictionary* Item1DicThirdlbl = [[NSMutableDictionary alloc] init];
    [Item1DicThirdlbl setObject:@"phone" forKey:@"name"];
    [Item1DicThirdlbl setObject:@"0-3" forKey:@"level"];

    [Item1DicThirdlbl setValue:Item0DicfourthArr forKey:@"Objects"];

    NSArray* Item0DicSecondArr = [[NSArray alloc] initWithObjects:Item0DicThirdlbl, Item1DicThirdlbl, nil];

    NSArray* Item1DicSecondArr = [[NSArray alloc] initWithObjects:Item0DicThirdlbl, Item1DicThirdlbl, nil];

    NSMutableDictionary* Item0DicSecondlbl = [[NSMutableDictionary alloc] init];
    [Item0DicSecondlbl setObject:@"Ramlal" forKey:@"name"];
    [Item0DicSecondlbl setObject:@"0-2" forKey:@"level"];

    [Item0DicSecondlbl setValue:Item0DicSecondArr forKey:@"Objects"];

    NSMutableDictionary* Item1DicSecondlbl = [[NSMutableDictionary alloc] init];
    [Item0DicSecondlbl setObject:@"hemall" forKey:@"name"];
    [Item0DicSecondlbl setObject:@"0-2" forKey:@"level"];

    [Item0DicSecondlbl setValue:Item1DicSecondArr forKey:@"Objects"];

    NSArray* Item0Array = [[NSArray alloc] initWithObjects:Item0DicSecondlbl, Item1DicSecondlbl, nil];

    NSMutableDictionary* Item0Dic = [[NSMutableDictionary alloc] init];
    [Item0Dic setObject:@"Ramlal" forKey:@"name"];
    [Item0Dic setObject:@"0" forKey:@"level"];

    [Item0Dic setValue:Item0Array forKey:@"Objects"];

    NSMutableDictionary* Item1Dic = [[NSMutableDictionary alloc] init];
    [Item1Dic setObject:@"Rohan" forKey:@"name"];
    [Item1Dic setObject:@"1" forKey:@"level"];

    [Item1Dic setValue:Item0Array forKey:@"Objects"];

    NSMutableDictionary* RootDic = [[NSMutableDictionary alloc] init];
    NSArray* Objects0 = [[NSArray alloc] initWithObjects:Item0Dic, Item1Dic, nil];
    [RootDic setObject:Objects0 forKey:@"Objects"];

    //RootDic writeToFile:path atomically:YES];

    //
    self.arrayOriginal = [RootDic valueForKey:@"Objects"];

    self.arForTable = [[NSMutableArray alloc] init];
    [self.arForTable addObjectsFromArray:self.arrayOriginal];
}
- (void)showSalesPipeLineInLabel
{
    NSLog(@"call after WS GetSalesPipeLineDashboard_NEEV_Arr %lu", (unsigned long)[GetSalesPipeLineDashboard_NEEV_Arr count]);
    int GetSalesPipeLineDashboard_NEEV = [GetSalesPipeLineDashboard_NEEV_Arr count];
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

- (void)info_btn
{
    //  NSLog(@"Home biscuit from Sanfrancisco");
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController*)splitController
     willHideViewController:(UIViewController*)viewController
          withBarButtonItem:(UIBarButtonItem*)barButtonItem
       forPopoverController:(UIPopoverController*)popoverController
{
    NSLog(@"Will hide");
    barButtonItem.title = NSLocalizedString(@"File list", @"File list");
    [self.navigationItem setLeftBarButtonItem:barButtonItem
                                     animated:YES];

    self.masterPopoverController = popoverController;
    [self.masterPopoverController setDelegate:self];
}

- (void)splitViewController:(UISplitViewController*)splitController
     willShowViewController:(UIViewController*)viewController
  invalidatingBarButtonItem:(UIBarButtonItem*)barButtonItem
{
    NSLog(@"Will show");
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
//
- (BOOL)splitViewController:(UISplitViewController*)svc shouldHideViewController:(UIViewController*)vc inOrientation:(UIInterfaceOrientation)orientation
{
    NSLog(@"Will ..");
    return YES;
}
- (void)splitViewController:(UISplitViewController*)svc popoverController:(UIPopoverController*)pc willPresentViewController:(UIViewController*)aViewController
{

    [masterPopoverController dismissPopoverAnimated:YES];
    if ([pc isPopoverVisible]) {
        NSLog(@"over");
    }
    else {
        NSLog(@"Over1");
    }
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController*)popoverController
{
    NSLog(@"HIDING POPOVER");
}
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController*)popoverController
{
    NSLog(@"!!!111");
    return YES;
}

//  Common SW
// LOB

- (void)GetAllLOB
{
    /*
     
     <SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body><GetLOBForNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" /></SOAP:Body></SOAP:Envelope>
     */

    envelopeText = [NSString stringWithFormat:
                                 @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 @"<SOAP:Body>"
                                 @"<GetAllLOB xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                                 @" </SOAP:Body>"
                                 @"</SOAP:Envelope>"];

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
    [[RequestDelegate alloc] initiateRequest:request name:@"GetLOB"];
}
- (void)LobListFound:(NSNotification*)notification
{
    GetLOB_Arr = [[NSMutableArray alloc] init];
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ", response);

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
        if (GetLOB_Arr) {
            [GetLOB_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        NSLog(@"Which..");
        TBXMLElement* container = [TBXML childElementNamed:@"GetAllLOBResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            do {
                TBXMLElement* S_Lst_Of_Val = [TBXML childElementNamed:@"S_LST_OF_VAL" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* NAME = [TBXML childElementNamed:@"VAL" parentElement:S_Lst_Of_Val];
                str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_NSE : %@", str_NAME);
                //str_NAME=[str_NAME stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                //NSLog(@"\n str_NSE change  : %@", str_NAME);

                // activity_list.OPPTY_NAME =[TBXML textForElement:X_OPTY_NAME];
                //assign_list.NSE_LOBDSE_NAME =[TBXML textForElement:NAME];
                [GetLOB_Arr addObject:str_NAME];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages : %@", GetLOB_Arr);

            if ((GetLOB_Arr.count) > 0) {

              //  [self createArrayForTable];
                        //[self showSalesPipeLineInLabel];
              //  [self GetSalesPipelineDashboard_NEEV];
            }
        }
        else {
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        //  [self hideAlert];
    }
}
- (void)GetAllPPL
{
    envelopeText = [NSString stringWithFormat:
                                 @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 @"<SOAP:Body>"
                                 @"<GetPPLFromLOB xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                 @"<LOB>Pickups</LOB>"
                                 @"</GetPPLFromLOB>"
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

    [[RequestDelegate alloc] initiateRequest:request name:@"getActivityPPLConnection"];
}
- (void)Activity_PPL_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PPL_Found response....... %@ ", response);

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

        if (GetPPL_LOB_Arr) {
            [GetPPL_LOB_Arr removeAllObjects];
            // [activityPPLNamePickerArr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetPPLFromLOBResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetPPL_LOB_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetPPL_LOB_Arr);

            if ((GetPPL_LOB_Arr.count) > 0) {
                NSLog(@"In..");
                [self hideAlert];
                [self GetSalesPipelineDashboard_NEEVPPL];
            }
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
} //GetAllPL
- (void)GetAllPL
{
    envelopeText = [NSString stringWithFormat:
                                 @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 @"<SOAP:Body>"
                                 @"<GetPLFromPPL xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                 @"<PPL_Name>Xenon Pickups</PPL_Name>"
                                 @"<LOB>Pickups</LOB>"
                                 @"</GetPLFromPPL>"
                                 @"</SOAP:Body>"
                                 @"</SOAP:Envelope>"];

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getActivityPLConnection"];
}
- (void)PLUpdateOpty_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response ....... %@ ", response);
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

        if (GetPL_LOBPPL_Arr) {
            [GetPL_LOBPPL_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetPLFromPPLResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"s_prod_int" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"PL" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetPL_LOBPPL_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetPL_LOBPPL_Arr);

            if ((GetPL_LOBPPL_Arr.count) > 0) {
                [self GetSalesPipelineDashboard_NEEVPL];
            }
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}
// Dashboard Webservices
- (void)GetSalesPipelineDashboard
{
    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id :%@", position_Id);
    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetSalesPipelineDashboardNSE_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<fromdate>01-AUG-2015</fromdate>"
                                     @"<todate>25-OCT-2015</todate>"
                                     @"</GetSalesPipelineDashboardNSE_NEEV>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 position_Id];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
        
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
                        @"</SOAP:Envelope>"] ;    
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getSalesPipelineDashboard"];
}
- (void)SalesPipelineDashboard_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get Executive SalesPipelineDashboard   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetSalesPipelineDashboard_Arr) {
            [GetSalesPipelineDashboard_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetSalesPipelineDashboardNSE_NEEVResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                salesPipelineDashboard = nil;
                salesPipelineDashboard = [[SalesPipelineDashboardNSE_NEEV alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* LOGIN = [TBXML childElementNamed:@"LOGIN" parentElement:table];
                salesPipelineDashboard.LOGIN = [TBXML textForElement:LOGIN];

                TBXMLElement* F_NAME = [TBXML childElementNamed:@"F_NAME" parentElement:table];
                salesPipelineDashboard.F_NAME = [TBXML textForElement:F_NAME];

                TBXMLElement* L_NAME = [TBXML childElementNamed:@"L_NAME" parentElement:table];
                salesPipelineDashboard.L_NAME = [TBXML textForElement:L_NAME];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                salesPipelineDashboard.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                salesPipelineDashboard.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                salesPipelineDashboard.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                salesPipelineDashboard.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                salesPipelineDashboard.alias4 = [TBXML textForElement:alias4];

                NSLog(@"\n str_NSE : %@", salesPipelineDashboard);
                [GetSalesPipelineDashboard_Arr addObject:salesPipelineDashboard];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetSalesPipelineDashboard_Arr);
            // }
            if ((GetSalesPipelineDashboard_Arr.count) > 0) {
                [self hideAlert];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
- (void)GetLeadGeneratorwisePipelineView_NEEV
{
    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id :%@", position_Id);
    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetLeadGeneratorwisePipelineView_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<fromdate>01-JAN-2013</fromdate>"
                                     @"<todate>10-NOV-2015</todate>"
                                     @"</GetLeadGeneratorwisePipelineView_NEEV>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 position_Id];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getLeadGeneratorwisePipelineView"];
}
- (void)LeadGeneratorwisePipelineView_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get LeadGeneratorwisePipelineView_NEEV   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetLeadGeneratorwisePipelineView_Arr) {
            [GetLeadGeneratorwisePipelineView_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetLeadGeneratorwisePipelineView_NEEVResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                leadGeneratorwisePipelineView = nil;
                leadGeneratorwisePipelineView = [[LeadGeneratorwisePipelineView alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* ACC_TYPE = [TBXML childElementNamed:@"ACC_TYPE" parentElement:table];
                leadGeneratorwisePipelineView.ACC_TYPE = [TBXML textForElement:ACC_TYPE];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                leadGeneratorwisePipelineView.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                leadGeneratorwisePipelineView.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                leadGeneratorwisePipelineView.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                leadGeneratorwisePipelineView.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                leadGeneratorwisePipelineView.alias4 = [TBXML textForElement:alias4];

                NSLog(@"\n str_NSE : %@", leadGeneratorwisePipelineView);
                [GetLeadGeneratorwisePipelineView_Arr addObject:leadGeneratorwisePipelineView];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetLeadGeneratorwisePipelineView_Arr);
            // }
            if ((GetLeadGeneratorwisePipelineView_Arr.count) > 0) {
                [self hideAlert];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
// NEEV Dashboard WS : First Table View

- (void)GetSalesPipelineDashboard_NEEV
{
    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id :%@", position_Id);
    NSLog(@"LOB Count  id :%lu", (unsigned long)GetLOB_Arr.count);
    values = @"";
    for (int i = 0; i < GetLOB_Arr.count; i++) {

        NSLog(@"Valu3w %d", i);
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:[GetLOB_Arr objectAtIndex:i]];
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:@"e"];
        // values = [values stringByAppendingString:@","];
        //values=[GetLOB_Arr objectAtIndex:i];
        //values = [values stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
    }
    NSLog(@"Valu3w %@", values);
    if ([values length] > 0) {
        values = [values substringToIndex:[values length] - 1];
    }
    else {
        //no characters to delete... attempting to do so will result in a crash
    }
    NSLog(@"Valu3w Set %@", values);

    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

        /*envelopeText = [NSString stringWithFormat:
                        @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        @"<SOAP:Body>"
                        @"<GetSalesPipelineDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                        @"<positionid>%@</positionid>"
                        @"<PPL>Xenon Pickups</PPL>"
                        @"<PL>Xenon FBV</PL>"
                        @"<LOB>Pickups</LOB>"
                        @"<fromdate>01-JAN-2015</fromdate>"
                        @"<todate>01-NOV-2015</todate>"
                        @"</GetSalesPipelineDashboard_NEEV>"
                        @"</SOAP:Body>"
                        @"</SOAP:Envelope>",position_Id];*/
        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetSalesPipelineDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<PPL></PPL>"
                                     @"<PL></PL>"
                                     @"<LOB>%@</LOB>"
                                     @"<fromdate>01-JAN-2015</fromdate>"
                                     @"<todate>01-NOV-2015</todate>"
                                     @"</GetSalesPipelineDashboard_NEEV>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 position_Id, values];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getSalesPipelineDashboard_NEEV"];
}
- (void)SalesPipelineDashboard_NEEV_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get SalesPipelineDashboard NEEV  %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetSalesPipeLineDashboard_NEEV_Arr) {
            [GetSalesPipeLineDashboard_NEEV_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetSalesPipelineDashboard_NEEVResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                salesPipelineDashboardNEEV = nil;
                salesPipelineDashboardNEEV = [[GetSalesPipeLineDashboard_NEEV alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PL = [TBXML childElementNamed:@"PL" parentElement:table];
                salesPipelineDashboardNEEV.PL = [TBXML textForElement:PL];

                TBXMLElement* PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                salesPipelineDashboardNEEV.PPL = [TBXML textForElement:PPL];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                salesPipelineDashboardNEEV.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                salesPipelineDashboardNEEV.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                salesPipelineDashboardNEEV.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                salesPipelineDashboardNEEV.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                salesPipelineDashboardNEEV.alias4 = [TBXML textForElement:alias4];

                //[urlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];

                NSLog(@"\n str_NSE SalesPipeLineDashboard_DSE : %@", salesPipelineDashboardNEEV);
                [GetSalesPipeLineDashboard_NEEV_Arr addObject:salesPipelineDashboardNEEV];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetSalesPipeLineDashboard_NEEV_Arr);
            // }
            if ((GetSalesPipeLineDashboard_NEEV_Arr.count) > 0) {
                [self hideAlert];
                [self showSalesPipeLineInLabel];

                //[self GetAllPPL]; /// Call when main lob selected for drop drill
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Data not available.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (void)GetSalesPipelineDashboard_NEEVPPL
{
    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id :%@", position_Id);
    NSLog(@"LOB Count  id :%lu", (unsigned long)GetPPL_LOB_Arr.count);
    values = @"";
    for (int i = 0; i < GetPPL_LOB_Arr.count; i++) {

        NSLog(@"Valu3w %d", i);
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:[GetPPL_LOB_Arr objectAtIndex:i]];
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:@","];
        // values = [values stringByAppendingString:@","];
        //values=[GetLOB_Arr objectAtIndex:i];
        //values = [values stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
    }
    NSLog(@"Valu3w %@", values);
    if ([values length] > 0) {
        values = [values substringToIndex:[values length] - 1];
    }
    else {
        //no characters to delete... attempting to do so will result in a crash
    }
    NSLog(@"Valu3w Set %@", values);

    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

        /*envelopeText = [NSString stringWithFormat:
         @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
         @"<SOAP:Body>"
         @"<GetSalesPipelineDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
         @"<positionid>%@</positionid>"
         @"<PPL>Xenon Pickups</PPL>"
         @"<PL>Xenon FBV</PL>"
         @"<LOB>Pickups</LOB>"
         @"<fromdate>01-JAN-2015</fromdate>"
         @"<todate>01-NOV-2015</todate>"
         @"</GetSalesPipelineDashboard_NEEV>"
         @"</SOAP:Body>"
         @"</SOAP:Envelope>",position_Id];*/
        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetSalesPipelineDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<PPL>%@</PPL>"
                                     @"<PL></PL>"
                                     @"<LOB>'Pickups'</LOB>"
                                     @"<fromdate>01-JAN-2015</fromdate>"
                                     @"<todate>01-NOV-2015</todate>"
                                     @"</GetSalesPipelineDashboard_NEEV>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 position_Id, values];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getSalesPipelineDashboard_NEEVPPL"];
}
- (void)SalesPipelineDashboard_NEEVPPL_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get SalesPipelineDashboard NEEVPPL  %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        /*
         <tuple
         xmlns="com.cordys.tatamotors.Neevsiebelwsapp">
         <old>
         <TABLE
         xmlns="com.cordys.tatamotors.Neevsiebelwsapp">
         <PL>Xenon FBV</PL>
         <PPL>Xenon Pickups</PPL>
         <LOB>Pickups</LOB>
         <alias>1</alias>
         <alias1>1</alias1>
         <alias2>0</alias2>
         <alias3>0</alias3>
         <alias4>0</alias4>
         </TABLE>
         </old>
         </tuple>
         */

        if (GetSalesPipeLineDashboardNEEVPPL_Arr) {
            [GetSalesPipeLineDashboardNEEVPPL_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetSalesPipelineDashboard_NEEVResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                salesPipeLineDashboardNEEVPPL = nil;
                salesPipeLineDashboardNEEVPPL = [[GetSalesPipeLineDashboardNEEVPPL alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PL = [TBXML childElementNamed:@"PL" parentElement:table];
                salesPipeLineDashboardNEEVPPL.PL = [TBXML textForElement:PL];

                TBXMLElement* PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                salesPipeLineDashboardNEEVPPL.PPL = [TBXML textForElement:PPL];

                TBXMLElement* LOB = [TBXML childElementNamed:@"LOB" parentElement:table];
                salesPipeLineDashboardNEEVPPL.LOB = [TBXML textForElement:LOB];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                salesPipeLineDashboardNEEVPPL.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                salesPipeLineDashboardNEEVPPL.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                salesPipeLineDashboardNEEVPPL.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                salesPipeLineDashboardNEEVPPL.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                salesPipeLineDashboardNEEVPPL.alias4 = [TBXML textForElement:alias4];

                //[urlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];

                NSLog(@"\n str_NSE salesPipeLineDashboardNEEVPPL : %@", salesPipeLineDashboardNEEVPPL);
                [GetSalesPipeLineDashboardNEEVPPL_Arr addObject:salesPipeLineDashboardNEEVPPL];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetSalesPipeLineDashboardNEEVPPL_Arr);
            // }
            if ((GetSalesPipeLineDashboardNEEVPPL_Arr.count) > 0) {
                [self hideAlert];
                [self GetAllPL]; /// Call when main lob selected for drop drill-- PPL
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Data not available.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
} //
- (void)GetSalesPipelineDashboard_NEEVPL
{
    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id :%@", position_Id);
    NSLog(@"LOB Count  id :%lu", (unsigned long)GetPL_LOBPPL_Arr.count);
    values = @"";
    for (int i = 0; i < GetPL_LOBPPL_Arr.count; i++) {

        NSLog(@"Valu3w %d", i);
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:[GetPL_LOBPPL_Arr objectAtIndex:i]];
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:@","];
        // values = [values stringByAppendingString:@","];
        //values=[GetLOB_Arr objectAtIndex:i];
        //values = [values stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
    }
    NSLog(@"Valu3w %@", values);
    if ([values length] > 0) {
        values = [values substringToIndex:[values length] - 1];
    }
    else {
        //no characters to delete... attempting to do so will result in a crash
    }
    NSLog(@"Valu3w Set %@", values);

    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

        /*envelopeText = [NSString stringWithFormat:
         @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
         @"<SOAP:Body>"
         @"<GetSalesPipelineDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
         @"<positionid>%@</positionid>"
         @"<PPL>Xenon Pickups</PPL>"
         @"<PL>Xenon FBV</PL>"
         @"<LOB>Pickups</LOB>"
         @"<fromdate>01-JAN-2015</fromdate>"
         @"<todate>01-NOV-2015</todate>"
         @"</GetSalesPipelineDashboard_NEEV>"
         @"</SOAP:Body>"
         @"</SOAP:Envelope>",position_Id];*/
        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetSalesPipelineDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<PPL>'Xenon Pickups'</PPL>"
                                     @"<PL>%@</PL>"
                                     @"<LOB>'Pickups'</LOB>"
                                     @"<fromdate>01-JAN-2015</fromdate>"
                                     @"<todate>01-NOV-2015</todate>"
                                     @"</GetSalesPipelineDashboard_NEEV>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 position_Id, values];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getSalesPipelineDashboard_NEEVPL"];
} //

- (void)SalesPipelineDashboard_NEEVPL_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get SalesPipelineDashboard_NEEVPL_Found %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetSalesPipeLineDashboardNEEVPL_Arr) {
            [GetSalesPipeLineDashboardNEEVPL_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetSalesPipelineDashboard_NEEVResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                salesPipeLineDashboardNEEVPL = nil;
                salesPipeLineDashboardNEEVPL = [[GetSalesPipeLineDashboardNEEVPL alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PL = [TBXML childElementNamed:@"PL" parentElement:table];
                salesPipeLineDashboardNEEVPL.PL = [TBXML textForElement:PL];

                TBXMLElement* PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                salesPipeLineDashboardNEEVPL.PPL = [TBXML textForElement:PPL];

                TBXMLElement* LOB = [TBXML childElementNamed:@"LOB" parentElement:table];
                salesPipeLineDashboardNEEVPL.LOB = [TBXML textForElement:LOB];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                salesPipeLineDashboardNEEVPL.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                salesPipeLineDashboardNEEVPL.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                salesPipeLineDashboardNEEVPL.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                salesPipeLineDashboardNEEVPL.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                salesPipeLineDashboardNEEVPL.alias4 = [TBXML textForElement:alias4];

                //[urlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];

                NSLog(@"\n str_NSE salesPipeLineDashboardNEEVPPL : %@", salesPipeLineDashboardNEEVPL);
                [GetSalesPipeLineDashboardNEEVPL_Arr addObject:salesPipeLineDashboardNEEVPL];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetSalesPipeLineDashboardNEEVPL_Arr);
            // }
            if ((GetSalesPipeLineDashboardNEEVPL_Arr.count) > 0) {
                [self hideAlert];
                //[self GetAllPL]; /// Call when main lob selected for drop drill-- PPL
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Data not available.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
// NEEV Avtivity Adherence

- (void)GetEventExecutiveDashboard_NEEV
{

    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

        /*envelopeText = [NSString stringWithFormat:
         @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
         @"<SOAP:Body>"
         @"<GetSalesPipelineDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
         @"<positionid>%@</positionid>"
         @"<PPL>Xenon Pickups</PPL>"
         @"<PL>Xenon FBV</PL>"
         @"<LOB>Pickups</LOB>"
         @"<fromdate>01-JAN-2015</fromdate>"
         @"<todate>01-NOV-2015</todate>"
         @"</GetSalesPipelineDashboard_NEEV>"
         @"</SOAP:Body>"
         @"</SOAP:Envelope>",position_Id];*/
        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetEventDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<buid>1-560</buid>"
                                     @"<PPL>'ICV Buses' AS ICVBuses ,'Indica GLS' AS IndicaGLS ,'Ace_Zip' AS  Ace_Zip ,'Super_Ace' AS Super_Ace,'Xenon Pickups' AS XenonPickups</PPL>"
                                     @"</GetEventDashboard_NEEV>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 userDetailsVal_.ROW_ID];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getEventExecutiveDashboard_NEEV"];
}

- (void)EventExecutiveDashboard_NEEV_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get EventExecutiveDashboard_NEEV NEEV  %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (EventExecutiveDashboard_NEEV_Arr) {
            [EventExecutiveDashboard_NEEV_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetEventDashboard_NEEVResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            /*
             <tuple xmlns="com.cordys.tatamotors.Neevsiebelwsapp">
             <old>
             <S_SRC xmlns="com.cordys.tatamotors.Neevsiebelwsapp">
             <FN>JAYESH KUMAR</FN>
             <LN> C V</LN>
             <DSE_NAME>JKCV3001520</DSE_NAME>
             <ICVBUSES>3</ICVBUSES>
             <INDICAGLS>0</INDICAGLS>
             <ACE_ZIP>0</ACE_ZIP>
             <SUPER_ACE>0</SUPER_ACE>
             <XENONPICKUPS>0</XENONPICKUPS>
             </S_SRC>
             </old>
             </tuple>
             */

            do {

                salesPipeLineDashboardExecutive_NEEV = nil;
                salesPipeLineDashboardExecutive_NEEV = [[GetSalesPipeLineDashboardExecutive_NEEV alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PL = [TBXML childElementNamed:@"PL" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.PL = [TBXML textForElement:PL];

                TBXMLElement* PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.PPL = [TBXML textForElement:PPL];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.alias4 = [TBXML textForElement:alias4];

                //[urlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];

                NSLog(@"\n str_NSE SalesPipeLineDashboard_DSE : %@", salesPipeLineDashboardExecutive_NEEV);
                [EventExecutiveDashboard_NEEV_Arr addObject:salesPipeLineDashboardExecutive_NEEV];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", EventExecutiveDashboard_NEEV_Arr);
            // }
            if ((EventExecutiveDashboard_NEEV_Arr.count) > 0) {
                [self hideAlert];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Data not available.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
} //GetEventActive_NEEV
- (void)GetEventActive_NEEV
{

    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {

        /*envelopeText = [NSString stringWithFormat:
         @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
         @"<SOAP:Body>"
         @"<GetSalesPipelineDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
         @"<positionid>%@</positionid>"
         @"<PPL>Xenon Pickups</PPL>"
         @"<PL>Xenon FBV</PL>"
         @"<LOB>Pickups</LOB>"
         @"<fromdate>01-JAN-2015</fromdate>"
         @"<todate>01-NOV-2015</todate>"
         @"</GetSalesPipelineDashboard_NEEV>"
         @"</SOAP:Body>"
         @"</SOAP:Envelope>",position_Id];*/
        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetEventActive_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<buid>1-560</buid>"
                                     @"<PPL>'ICV Buses' AS ICVBuses ,'Indica GLS' AS IndicaGLS ,'Ace_Zip' AS  Ace_Zip ,'Super_Ace' AS Super_Ace,'Xenon Pickups' AS XenonPickups</PPL>"
                                     @"</GetEventActive_NEEV>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 userDetailsVal_.ROW_ID];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getEventActive_NEEV"];
} //EventActive_NEEV_Found
- (void)EventActive_NEEV_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get EventActive_NEEV   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (EventActive_NEEV_Arr) {
            [EventActive_NEEV_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetEventActive_NEEVResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {
                /*
                 <S_SRC
                 xmlns="com.cordys.tatamotors.Neevsiebelwsapp">
                 <FN>JAYESH KUMAR</FN>
                 <LN> C V</LN>
                 <DSE_NAME>JKCV3001520</DSE_NAME>
                 <ICVBUSES>3</ICVBUSES>
                 <INDICAGLS>0</INDICAGLS>
                 <ACE_ZIP>0</ACE_ZIP>
                 <SUPER_ACE>0</SUPER_ACE>
                 <XENONPICKUPS>0</XENONPICKUPS>
                 </S_SRC>
                 */

                eventActive = nil;
                eventActive = [[EventActive_NEEV alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"S_SRC" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* FN = [TBXML childElementNamed:@"FN" parentElement:table];
                eventActive.FN = [TBXML textForElement:FN];

                TBXMLElement* PPL = [TBXML childElementNamed:@"LN" parentElement:table];
                eventActive.LN = [TBXML textForElement:PPL];

                TBXMLElement* LN = [TBXML childElementNamed:@"DSE_NAME" parentElement:table];
                eventActive.DSE_NAME = [TBXML textForElement:LN];

                TBXMLElement* ICVBUSES = [TBXML childElementNamed:@"ICVBUSES" parentElement:table];
                eventActive.ICVBUSES = [TBXML textForElement:ICVBUSES];

                TBXMLElement* INDICAGLS = [TBXML childElementNamed:@"INDICAGLS" parentElement:table];
                eventActive.INDICAGLS = [TBXML textForElement:INDICAGLS];

                TBXMLElement* ACE_ZIP = [TBXML childElementNamed:@"ACE_ZIP" parentElement:table];
                eventActive.ACE_ZIP = [TBXML textForElement:ACE_ZIP];

                TBXMLElement* SUPER_ACE = [TBXML childElementNamed:@"SUPER_ACE" parentElement:table];
                eventActive.SUPER_ACE = [TBXML textForElement:SUPER_ACE];

                TBXMLElement* XENONPICKUPS = [TBXML childElementNamed:@"XENONPICKUPS" parentElement:table];
                eventActive.XENONPICKUPS = [TBXML textForElement:XENONPICKUPS];

                //[urlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];

                NSLog(@"\n str_NSE SalesPipeLineDashboard_DSE : %@", eventActive);
                [EventActive_NEEV_Arr addObject:eventActive];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", EventActive_NEEV_Arr);
            // }
            if ((EventActive_NEEV_Arr.count) > 0) {
                [self hideAlert];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Data not available.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
// DSM Dashboard WS

- (void)GetAllPPLDSM
{
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

    [[RequestDelegate alloc] initiateRequest:request name:@"getActivityPPLConnectionDSM"];
}
- (void)ActivityPPLConnectionDSMPPL_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found responseDSM ....... %@ ", response);
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

        if (GetPL_LOBPPL_Arr) {
            [GetPL_LOBPPL_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetListOfPPLForNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"PPL_ID" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];

                TBXMLElement* PPL_NAME = [TBXML childElementNamed:@"PPL_NAME" parentElement:S_PROD_LN];
                NSString* PPL_NAME_ = [TBXML textForElement:PPL_NAME];
                NSString* PPL_NAMESEC = PPL_NAME_;
                NSLog(@"\n PPL_ID_DSM  : %@", PPL_ID_);
                NSLog(@"\n PPL_ID_DSM  : %@", PPL_NAMESEC);

                [GetPL_LOBPPL_Arr addObject:PPL_NAME_];

                PPL_NAMESEC = [PPL_NAMESEC stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];

                [GetPL_LOBPPLSEC_Arr addObject:PPL_NAMESEC];

            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetPL_LOBPPL_Arr);
            NSLog(@" PPL %lu", (unsigned long)[GetPL_LOBPPL_Arr count]);
            if ((GetPL_LOBPPL_Arr.count) > 0) {
                //shrad

                [self.ExpandableTableView reloadData];

                if ([userDetailsVal_.POSTN isEqualToString:@"DSM"]) {
                    [self GetSalesPipeLineDashboard_DSM];
                    [self GetEventActiveDashboard_DSM];
                }
                else if ([userDetailsVal_.POSTN isEqualToString:@"DSE"]) {
                    //[self GetSalesPipeLineDashboard_DSM];

                    //call Sales stages values for DSE

                    [self GetSalesPipeLineDashboard_DSE];

                    [self GetEventActiveDashboard_DSM];
                }
                else {
                    // NEEV
                }
                //[self GetEventDashboard_DSM];
                //[self GetEventActiveDashboard_DSM];
            }
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}
- (void)GetSalesPipeLineDashboard_DSM
{
    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id :%@", position_Id);
    NSLog(@"LOB Count  id :%lu", (unsigned long)GetPL_LOBPPL_Arr.count);
    values = @"";
    for (int i = 0; i < GetPL_LOBPPL_Arr.count; i++) {

        NSLog(@"Valu3w %d", i);
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:[GetPL_LOBPPL_Arr objectAtIndex:i]];
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:@","];
        // values = [values stringByAppendingString:@","];
        //values=[GetLOB_Arr objectAtIndex:i];
        //values = [values stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
    }
    NSLog(@"Valu3w %@", values);
    if ([values length] > 0) {
        values = [values substringToIndex:[values length] - 1];
    }
    else {
        //no characters to delete... attempting to do so will result in a crash
    }
    NSLog(@"Valu3w Set %@", values);
    if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetSalesPipeLineDashboard_DSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<PPL>%@</PPL>"
                                     @"<PL></PL>"
                                     @"<fromdate>01-AUG-2015</fromdate>"
                                     @"<todate>25-AUG-2015</todate>"
                                     @"</GetSalesPipeLineDashboard_DSM>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 userDetailsVal_.ROW_ID, values];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getSalesPipeLineDashboard_DSM"];
} //
- (void)SalesPipeLineDashboard_DSM_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get SalesPipelineDashboardDSM/DSE   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetSalesPipeLineDashboard_DSM_Arr) {
            [GetSalesPipeLineDashboard_DSM_Arr removeAllObjects];
        }

        /*
         <SOAP:Body>
         <GetListOfPPLForNeevResponse xmlns="com.cordys.tatamotors.Neevsiebelwsapp" preserveSpace="no" qAccess="0">
         <tuple>
         <old>
         <S_PROD_LN>
         <PPL_ID>1-J0-8</PPL_ID>
         <PPL_NAME>LPT MCV</PPL_NAME>
         </S_PROD_LN>
         </old>
         </tuple>
         */
        TBXML* tbxml;
        TBXMLElement* container;
        TBXMLElement* tuple;
        if ([userDetailsVal_.POSTN isEqualToString:@"DSM"]) {

            tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            container = [TBXML childElementNamed:@"GetSalesPipeLineDashboard_DSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        }
        else if ([userDetailsVal_.POSTN isEqualToString:@"DSE"]) {
            tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            container = [TBXML childElementNamed:@"GetListOfPPLForNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        }
        else {
            // NEEV
        }

        if (tuple) {

            do {

                salesPipelineDashboardDSM = nil;
                salesPipelineDashboardDSM = [[GetSalesPipeLineDashboard_DSM alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PL = [TBXML childElementNamed:@"PL" parentElement:table];
                salesPipelineDashboardDSM.PL = [TBXML textForElement:PL];

                TBXMLElement* PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                salesPipelineDashboardDSM.PPL = [TBXML textForElement:PPL];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                salesPipelineDashboardDSM.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                salesPipelineDashboardDSM.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                salesPipelineDashboardDSM.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                salesPipelineDashboardDSM.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                salesPipelineDashboardDSM.alias4 = [TBXML textForElement:alias4];

                NSLog(@"\n str_NSE SalesPipeLineDashboard_DSM : %@", salesPipelineDashboardDSM);
                [GetSalesPipeLineDashboard_DSM_Arr addObject:salesPipelineDashboardDSM];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetSalesPipeLineDashboard_DSM_Arr);
            // }
            if ((GetSalesPipeLineDashboard_DSM_Arr.count) > 0) {
                //[self createArrayForsingleEpandableTBle];
                [self.ExpandableTableView reloadData];

                [self hideAlert];
                //[self GetAllPLDSM];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (void)GetAllPLDSM
{
    //to send
    // NSString * str = self.selectedData;
    ;
    //@"<PPL_Name>ICV Buses</PPL_Name>"
    envelopeText = [NSString stringWithFormat:
                                 @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 @"<SOAP:Body>"
                                 @"<GetPLFromPPL xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                 @"<PPL_Name>%@</PPL_Name>"
                                 @"<LOB></LOB>"
                                 @"</GetPLFromPPL>"
                                 @"</SOAP:Body>"
                                 @"</SOAP:Envelope>",
                             self.selectedData];

    /* envelopeText = [NSString stringWithFormat:
                    @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                    @"<SOAP:Body>"
                    @"<GetPLFromPPL xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                    @"<PPL_Name>ICV Buses</PPL_Name>"
                    @"<LOB></LOB>"
                    @"</GetPLFromPPL>"
                    @"</SOAP:Body>"
                    @"</SOAP:Envelope>"];*/
    //Xenon Pickups
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

    [[RequestDelegate alloc] initiateRequest:request name:@"getActivityPLDSMConnection"];
}
- (void)ActivityPLDSMConnection_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response for PL Clecked ....... %@ ", response);
    if ([response isEqual:@""]) {
        if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Noooo data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

        if (GetPL_PPLDSM_Arr) {
            [GetPL_PPLDSM_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetPLFromPPLResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"s_prod_ln" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* NAME = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString* NAME_ = [TBXML textForElement:NAME];
                NSLog(@"\n PPL_ID_ : %@", NAME_);
                [GetPL_PPLDSM_Arr addObject:NAME_];
                [[SingletonClass sharedobject].GetPL_PPLDSM_SingletonArr addObject:NAME_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetPL_PPLDSM_Arr);

            if ((GetPL_PPLDSM_Arr.count) > 0) {
                //to get value from GetPL_PPLDSM_Arr
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:self];

                //[self.ExpandableTableView reloadData];

                // DSM
                if ([userDetailsVal_.POSTN isEqualToString:@"DSM"]) {

                    [self GetSalesPipelineDashboard_DSMPLAll];
                }
                else if ([userDetailsVal_.POSTN isEqualToString:@"DSE"]) {
                    //[self GetSalesPipeLineDashboard_DSE];

                    [self GetSalesPipeLineDashboardPL_DSE];
                }
            }
        }
        else {
            [self hideAlert];
            if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                alert = [[UIAlertView alloc] initWithTitle:@"NEEV" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                if ([GetSalesPipeLineDashboard_DSEPLArr count] > 0) {
                    [GetSalesPipeLineDashboard_DSEPLArr removeAllObjects];
                    [self.ExpandableTableView reloadData];
                }
                alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([userDetailsVal_.POSTN isEqual:@"DSM"])
                if ([GetSalesPipeLineDashboard_DSMPLAll_Arr count] > 0) {

                    [GetSalesPipeLineDashboard_DSMPLAll_Arr removeAllObjects];
                    [self.ExpandableTableView reloadData];
                }
            {
                alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
} //GetSalesPipelineDashboard_NEEVPLAll
- (void)GetSalesPipelineDashboard_DSMPLAll
{
    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id for All PL :%@", position_Id);
    NSLog(@"LOB Count  id :%lu", (unsigned long)GetPL_PPLDSM_Arr.count);
    values = @"";
    for (int i = 0; i < GetPL_PPLDSM_Arr.count; i++) {

        NSLog(@"Valu3w %d", i);
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:[GetPL_PPLDSM_Arr objectAtIndex:i]];
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:@","];
        // values = [values stringByAppendingString:@","];
        //values=[GetLOB_Arr objectAtIndex:i];
        //values = [values stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
    }
    NSLog(@"Valu3w %@", values);
    if ([values length] > 0) {
        values = [values substringToIndex:[values length] - 1];
    }
    else {
        //no characters to delete... attempting to do so will result in a crash
    }
    NSLog(@"Valu3w Set %@", values);
    if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetSalesPipeLineDashboard_DSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<PPL></PPL>"
                                     @"<PL>%@</PL>"
                                     @"<fromdate>01-AUG-2015</fromdate>"
                                     @"<todate>25-AUG-2015</todate>"
                                     @"</GetSalesPipeLineDashboard_DSM>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 userDetailsVal_.ROW_ID, values];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getSalesPipelineDashboard_DSMPLAll"];
}
- (void)SalesPipelineDashboard_DSMPLAll_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get SalesPipelineDashboardDSMAll   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetSalesPipeLineDashboard_DSMPLAll_Arr) {
            [GetSalesPipeLineDashboard_DSMPLAll_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetSalesPipeLineDashboard_DSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                salesPipeLineDashboardAllPL_DSM = nil;
                salesPipeLineDashboardAllPL_DSM = [[GetSalesPipeLineDashboardAllPL_DSM alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PL = [TBXML childElementNamed:@"PL" parentElement:table];
                salesPipeLineDashboardAllPL_DSM.PL = [TBXML textForElement:PL];

                TBXMLElement* PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                salesPipeLineDashboardAllPL_DSM.PPL = [TBXML textForElement:PPL];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                salesPipeLineDashboardAllPL_DSM.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                salesPipeLineDashboardAllPL_DSM.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                salesPipeLineDashboardAllPL_DSM.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                salesPipeLineDashboardAllPL_DSM.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                salesPipeLineDashboardAllPL_DSM.alias4 = [TBXML textForElement:alias4];

                [GetSalesPipeLineDashboard_DSMPLAll_Arr addObject:salesPipeLineDashboardAllPL_DSM];
                [[SingletonClass sharedobject].GetSalesPipeLineDashboard_DSMPLAll_singleTonArr addObject:salesPipeLineDashboardAllPL_DSM];
                //               NSMutableArray * str = [[ NSMutableArray alloc]initWithArray:[SingletonClass sharedobject].GetSalesPipeLineDashboard_DSMPLAll_singleTonArr];
                NSLog(@"\n str_NSE SalesPipeLineDashboard_DSM : %@", salesPipeLineDashboardAllPL_DSM);

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetSalesPipeLineDashboard_DSMPLAll_Arr);
            // }
            if ((GetSalesPipeLineDashboard_DSMPLAll_Arr.count && [SingletonClass sharedobject].GetSalesPipeLineDashboard_DSMPLAll_singleTonArr.count) > 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:self];

                //                [self.ExpandableTableView reloadData];

                [self hideAlert];
                //shraddha Change
                //                [self GetAllPLDSM];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

//
- (void)GetEventDashboard_DSM
{
    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id for All PL :%@", position_Id);
    //NSMutableArray *GetPL_LOBPPLSecond_Arr=[[NSMutableArray alloc] init];
    //GetPL_LOBPPLSecond_Arr=GetPL_LOBPPL_Arr;
    NSLog(@"All PPL :%@", GetPL_LOBPPL_Arr);
    valuesDSMPPL = @"";
    for (int i = 0; i < GetPL_LOBPPL_Arr.count; i++) {

        NSLog(@"Values PPL %d", i);
        valuesDSMPPL = [valuesDSMPPL stringByAppendingString:@"'"];
        valuesDSMPPL = [valuesDSMPPL stringByAppendingString:[GetPL_LOBPPL_Arr objectAtIndex:i]];
        valuesDSMPPL = [valuesDSMPPL stringByAppendingString:@"'"];
        //valuesDSMPPL = [valuesDSMPPL stringByAppendingString:@" as "];
        //valuesDSMPPL = [valuesDSMPPL stringByAppendingString:[GetPL_LOBPPLSEC_Arr objectAtIndex:i]];
        valuesDSMPPL = [valuesDSMPPL stringByAppendingString:@","];
        // values = [values stringByAppendingString:@","];
        //values=[GetLOB_Arr objectAtIndex:i];
        //values = [values stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
    }
    NSLog(@"Valu3w %@", valuesDSMPPL);
    if ([valuesDSMPPL length] > 0) {
        valuesDSMPPL = [valuesDSMPPL substringToIndex:[valuesDSMPPL length] - 1];
    }
    else {
        //no characters to delete... attempting to do so will result in a crash
    }

    if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

        /*envelopeText = [NSString stringWithFormat:
         @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
         @"<SOAP:Body>"
         @"<GetSalesPipelineDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
         @"<positionid>%@</positionid>"
         @"<PPL>Xenon Pickups</PPL>"
         @"<PL>Xenon FBV</PL>"
         @"<LOB>Pickups</LOB>"
         @"<fromdate>01-JAN-2015</fromdate>"
         @"<todate>01-NOV-2015</todate>"
         @"</GetSalesPipelineDashboard_NEEV>"
         @"</SOAP:Body>"
         @"</SOAP:Envelope>",position_Id];*/
        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetEventDashboard_DSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<buid>1-560</buid>"
                                     @"<PPL>'Xenon Pickups'</PPL>"
                                     @"</GetEventDashboard_DSM>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 userDetailsVal_.ROW_ID];
    }
    //            <PPL>'LPT MCV' as LPT MCV,'SE MCV' as SE MCV,'8 Tonne Trucks' as 8 Tonne Trucks,'697 Buses' as 697 Buses,'Cummins Buses' as Cummins Buses,'HCV Buses' as HCV Buses,'CNG Buses' as CNG Buses,'Special Purpose Buses' as Special Purpose Buses,'4 Tonne Buses' as 4 Tonne Buses,'7 Tonne Buses' as 7 Tonne Buses,  'M&amp;HCV Buses' as M&HCV Buses,'ICV Buses' as ICV Buses,'Buses1' as Buses1,'SCV Pass-Venture' as SCV Pass-Venture,'207 Pickups' as 207 Pickups,'Xenon Pickups' as Xenon Pickups,'LPT 810 old' as LPT 810 old,'ICVs' as ICVs,'4 Tonne Trucks' as 4 Tonne Trucks,'7 Tonne Trucks' as 7 Tonne Trucks,'ICV Trucks' as ICV Trucks,'4 Tonne Pickup' as 4 Tonne Pickup,'LCV Tippers' as LCV Tippers,'9 Tonne Trucks' as 9 Tonne Trucks,'ICV Tippers' as ICV Tippers,'Engine-4SP' as Engine-4SP,'Engine-497' as Engine-497,'Engine-697' as Engine-697,'Axle' as Axle,'SCV Pass-Winger test' as SCV Pass-Winger test,'SCV Pass-Magic' as SCV Pass-Magic,'SCV Pass-Magic IRIS' as SCV Pass-Magic IRIS,'MCV Tippers' as MCV Tippers,'MAV Tippers' as MAV Tippers,'Tata Ace' as Tata Ace,'Super_Ace' as Super_Ace,'Ace_Zip' as Ace_Zip,'Ace HT' as Ace HT,'Ace HT PPL' as Ace HT PPL,'Tractor Trailers' as Tractor Trailers,'LCV Buses' as LCV Buses,'MAV 25' as MAV 25,'MAV 31' as MAV 31,'MAV 37' as MAV 37</PPL>

    //      <PPL>'ICV Buses' as ICVBuses,'Indica GLS'as IndicaGLS,'Ace_Zip' as Ace_Zip,'Super_Ace' as Super_Ace,'Xenon Pickups' as XenonPickups</PPL>
    //<PPL>'LPT MCV','SE MCV','8 Tonne Trucks','697 Buses','Cummins Buses','HCV Buses','CNG Buses','Special Purpose Buses','4 Tonne Buses','7 Tonne Buses','M&amp;HCV Buses','ICV Buses','Buses1','SCV Pass-Venture','207 Pickups','Xenon Pickups','LPT 810 old','ICVs','4 Tonne Trucks','7 Tonne Trucks','ICV Trucks','4 Tonne Pickup','LCV Tippers','9 Tonne Trucks','ICV Tippers','Engine-4SP','Engine-497','Engine-697','Axle','SCV Pass-Winger test','SCV Pass-Magic','SCV Pass-Magic IRIS','MCV Tippers','MAV Tippers','Tata Ace','Super_Ace','Ace_Zip','Ace HT','Ace HT PPL','Tractor Trailers','LCV Buses','MAV 25','MAV 31','MAV 37'</PPL>
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

    NSLog(@"\n envlopeString Of user details....www!!!!%@", envelopeText);

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getEventDashboard_DSM"];
}
//EventDashboard_DSM_Found

- (void)EventDashboard_DSM_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get EventExecutiveDashboard_DSM  %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        /*
        if (EventExecutiveDashboard_NEEV_Arr)
        {
            [EventExecutiveDashboard_NEEV_Arr removeAllObjects];
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetEventDashboard_NEEVResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
         
            
            do {
                
                salesPipeLineDashboardExecutive_NEEV = nil;
                salesPipeLineDashboardExecutive_NEEV = [[GetSalesPipeLineDashboardExecutive_NEEV alloc]init];
                
                
                TBXMLElement *table  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *PL = [TBXML childElementNamed:@"PL" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.PL = [TBXML textForElement:PL];
                
                
                TBXMLElement *PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.PPL = [TBXML textForElement:PPL];
                
                TBXMLElement *alias = [TBXML childElementNamed:@"alias" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.alias = [TBXML textForElement:alias];
                
                TBXMLElement *alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.alias1 = [TBXML textForElement:alias1];
                
                TBXMLElement *alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.alias2 = [TBXML textForElement:alias2];
                
                TBXMLElement *alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.alias3 = [TBXML textForElement:alias3];
                
                TBXMLElement *alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                salesPipeLineDashboardExecutive_NEEV.alias4 = [TBXML textForElement:alias4];
                
                //[urlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                
                NSLog(@"\n str_NSE SalesPipeLineDashboard_DSE : %@",salesPipeLineDashboardExecutive_NEEV);
                [EventExecutiveDashboard_NEEV_Arr addObject:salesPipeLineDashboardExecutive_NEEV];
                
            }while ((tuple = tuple->nextSibling));
            
            NSLog(@"Sales Stages :%@",EventExecutiveDashboard_NEEV_Arr);
            // }
            if ((EventExecutiveDashboard_NEEV_Arr.count) > 0)
            {
                [self hideAlert];
            }
        }
        else
        {
            [self hideAlert];
            alert=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"Data not available.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }*/
    }
}
- (void)GetEventActiveDashboard_DSM
{
    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id for All PL :%@", position_Id);
    //NSMutableArray *GetPL_LOBPPLSecond_Arr=[[NSMutableArray alloc] init];
    //GetPL_LOBPPLSecond_Arr=GetPL_LOBPPL_Arr;
    NSLog(@"All PPL :%@", GetPL_LOBPPL_Arr);
    valuesDSMPPLActive = @"";
    for (int i = 0; i < GetPL_LOBPPL_Arr.count; i++) {

        NSLog(@"Values PPL %d", i);
        valuesDSMPPLActive = [valuesDSMPPLActive stringByAppendingString:@"'"];
        valuesDSMPPLActive = [valuesDSMPPLActive stringByAppendingString:[GetPL_LOBPPL_Arr objectAtIndex:i]];
        valuesDSMPPLActive = [valuesDSMPPLActive stringByAppendingString:@"'"];
        valuesDSMPPLActive = [valuesDSMPPLActive stringByAppendingString:@" as "];
        valuesDSMPPLActive = [valuesDSMPPLActive stringByAppendingString:@"'"];
        valuesDSMPPLActive = [valuesDSMPPLActive stringByAppendingString:[GetPL_LOBPPLSEC_Arr objectAtIndex:i]];
        valuesDSMPPLActive = [valuesDSMPPLActive stringByAppendingString:@"'"];
        valuesDSMPPLActive = [valuesDSMPPLActive stringByAppendingString:@","];
        // values = [values stringByAppendingString:@","];
        //values=[GetLOB_Arr objectAtIndex:i];
        //values = [values stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
    }
    NSLog(@"Valu3w %@", valuesDSMPPLActive);
    if ([valuesDSMPPLActive length] > 0) {
        valuesDSMPPLActive = [valuesDSMPPLActive substringToIndex:[valuesDSMPPLActive length] - 1];
    }
    else {
        //no characters to delete... attempting to do so will result in a crash
    }

    if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

        /*envelopeText = [NSString stringWithFormat:
         @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
         @"<SOAP:Body>"
         @"<GetSalesPipelineDashboard_NEEV xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
         @"<positionid>%@</positionid>"
         @"<PPL>Xenon Pickups</PPL>"
         @"<PL>Xenon FBV</PL>"
         @"<LOB>Pickups</LOB>"
         @"<fromdate>01-JAN-2015</fromdate>"
         @"<todate>01-NOV-2015</todate>"
         @"</GetSalesPipelineDashboard_NEEV>"
         @"</SOAP:Body>"
         @"</SOAP:Envelope>",position_Id];*/
        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetEventActiveDashboard_DSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>1-70Z</positionid>"
                                     @"<buid>1-560</buid>"
                                     @"<PPL>%@</PPL>"
                                     @"</GetEventActiveDashboard_DSM>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 valuesDSMPPLActive];
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

        NSLog(@"Event activity DSE");

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetEventActiveDashboard_DSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>1-70Z</positionid>"
                                     @"<buid>1-560</buid>"
                                     @"<PPL>%@</PPL>"
                                     @"</GetEventActiveDashboard_DSM>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 valuesDSMPPLActive];
    }
    //      <PPL>'ICV Buses' as ICVBuses,'Indica GLS'as IndicaGLS,'Ace_Zip' as Ace_Zip,'Super_Ace' as Super_Ace,'Xenon Pickups' as XenonPickups</PPL>

    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

    NSLog(@"\n envlopeString Of user details....ACtive!!!!%@", envelopeText);

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

    [[RequestDelegate alloc] initiateRequest:request name:@"get_DSM_EvetnDashboard"];
}

- (void)EventActiveDashboard_DSMM_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get EventActiveExecutiveDashboard_DSM  %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        /*
         if (EventExecutiveDashboard_NEEV_Arr)
         {
         [EventExecutiveDashboard_NEEV_Arr removeAllObjects];
         }
         
         TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
         TBXMLElement *container = [TBXML childElementNamed:@"GetEventDashboard_NEEVResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
         TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
         if (tuple)
         {
         
         
         do {
         
         salesPipeLineDashboardExecutive_NEEV = nil;
         salesPipeLineDashboardExecutive_NEEV = [[GetSalesPipeLineDashboardExecutive_NEEV alloc]init];
         
         
         TBXMLElement *table  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
         TBXMLElement *PL = [TBXML childElementNamed:@"PL" parentElement:table];
         salesPipeLineDashboardExecutive_NEEV.PL = [TBXML textForElement:PL];
         
         
         TBXMLElement *PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
         salesPipeLineDashboardExecutive_NEEV.PPL = [TBXML textForElement:PPL];
         
         TBXMLElement *alias = [TBXML childElementNamed:@"alias" parentElement:table];
         salesPipeLineDashboardExecutive_NEEV.alias = [TBXML textForElement:alias];
         
         TBXMLElement *alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
         salesPipeLineDashboardExecutive_NEEV.alias1 = [TBXML textForElement:alias1];
         
         TBXMLElement *alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
         salesPipeLineDashboardExecutive_NEEV.alias2 = [TBXML textForElement:alias2];
         
         TBXMLElement *alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
         salesPipeLineDashboardExecutive_NEEV.alias3 = [TBXML textForElement:alias3];
         
         TBXMLElement *alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
         salesPipeLineDashboardExecutive_NEEV.alias4 = [TBXML textForElement:alias4];
         
         //[urlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
         
         NSLog(@"\n str_NSE SalesPipeLineDashboard_DSE : %@",salesPipeLineDashboardExecutive_NEEV);
         [EventExecutiveDashboard_NEEV_Arr addObject:salesPipeLineDashboardExecutive_NEEV];
         
         }while ((tuple = tuple->nextSibling));
         
         NSLog(@"Sales Stages :%@",EventExecutiveDashboard_NEEV_Arr);
         // }
         if ((EventExecutiveDashboard_NEEV_Arr.count) > 0)
         {
         [self hideAlert];
         }
         }
         else
         {
         [self hideAlert];
         alert=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"Data not available.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         }*/
    }
}
- (void)GetMMPipeLineView_DSM
{
    if ([userDetailsVal_.POSTN isEqual:@"DSM"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetMMPipeLineView_DSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>%@</positionid>"
                                     @"<fromdate>01-AUG-2015</fromdate>"
                                     @"<todate>20-AUG-2015</todate>"
                                     @"</GetMMPipeLineView_DSM>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 userDetailsVal_.ROW_ID];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getMMPipeLineView_DSM"];
}

- (void)MMPipeLineView_DSM_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get MMPipeLineView_DSM   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetMMPipeLineView_DSEApp_Arr) {
            [GetMMPipeLineView_DSEApp_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetMMPipeLineView_DSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                mmPipeLineView_DSM = nil;
                mmPipeLineView_DSM = [[MMPipeLineView_DSM alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* LOGIN = [TBXML childElementNamed:@"LOGIN" parentElement:table];
                mmPipeLineView_DSM.LOGIN = [TBXML textForElement:LOGIN];

                TBXMLElement* F_NAME = [TBXML childElementNamed:@"F_NAME" parentElement:table];
                mmPipeLineView_DSM.F_NAME = [TBXML textForElement:F_NAME];

                TBXMLElement* L_NAME = [TBXML childElementNamed:@"L_NAME" parentElement:table];
                mmPipeLineView_DSM.L_NAME = [TBXML textForElement:L_NAME];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                mmPipeLineView_DSM.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                mmPipeLineView_DSM.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                mmPipeLineView_DSM.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                mmPipeLineView_DSM.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                mmPipeLineView_DSM.alias4 = [TBXML textForElement:alias4];

                NSLog(@"\n str_NSE  MM : %@", mmPipeLineView_DSM);
                [GetMMPipeLineView_DSEApp_Arr addObject:mmPipeLineView_DSM];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetMMPipeLineView_DSEApp_Arr);
            // }
            if ((GetMMPipeLineView_DSEApp_Arr.count) > 0) {
                [self hideAlert];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
- (void)GetSalesPipeLineDashboard_DSE
{
    //GetPL_PPLDSM_Arr

    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id :%@", position_Id);
    NSLog(@"LOB Count  id :%lu", (unsigned long)GetPL_LOBPPL_Arr.count);
    values = @"";
    for (int i = 0; i < GetPL_LOBPPL_Arr.count; i++) {

        NSLog(@"Valu3w %d", i);
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:[GetPL_LOBPPL_Arr objectAtIndex:i]];
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:@","];
        // values = [values stringByAppendingString:@","];
        //values=[GetLOB_Arr objectAtIndex:i];
        //values = [values stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
    }
    NSLog(@"Valu3w %@", values);
    if ([values length] > 0) {
        values = [values substringToIndex:[values length] - 1];
    }
    else {
        //no characters to delete... attempting to do so will result in a crash
    }
    NSLog(@"Valu3w Set %@", values);

    if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetSalesPipeLineDashboard_DSE xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>1-70Z</positionid>"
                                     @"<PPL>%@</PPL>"
                                     @"<PL></PL>"
                                     @"<LOB></LOB>"
                                     @"<fromdate>01-AUG-2015</fromdate>"
                                     @"<todate>25-AUG-2015</todate>"
                                     @"</GetSalesPipeLineDashboard_DSE>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 values];

        //
        //        envelopeText = [NSString stringWithFormat:
        //                        @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        //                        @"<SOAP:Body>"
        //                        @"<GetSalesPipeLineDashboard_DSE xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
        //                        @"<positionid>%@</positionid>"
        //                        @"<PPL>%@</PPL>"
        //                        @"<PL></PL>"
        //                        @"<LOB></LOB>"
        //                        @"<fromdate>01-AUG-2015</fromdate>"
        //                        @"<todate>25-AUG-2015</todate>"
        //                        @"</GetSalesPipeLineDashboard_DSE>"
        //                        @"</SOAP:Body>"
        //                        @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,values];
    }

    /*if([userDetailsVal_.POSTN isEqual:@"DSE"]){
        
        envelopeText = [NSString stringWithFormat:
                        @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        @"<SOAP:Body>"
                        @"<GetSalesPipeLineDashboard_DSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                        @"<positionid>%@</positionid>"
                        @"<PPL>%@</PPL>"
                        @"<PL></PL>"
                        @"<fromdate>01-AUG-2015</fromdate>"
                        @"<todate>25-AUG-2015</todate>"
                        @"</GetSalesPipeLineDashboard_DSM>"
                        @"</SOAP:Body>"
                        @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,values];
    }
    
    if([userDetailsVal_.POSTN isEqual:@"DSE"]){
        
        envelopeText = [NSString stringWithFormat:
                        @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        @"<SOAP:Body>"
                        @"<GetSalesPipeLineDashboard_DSE xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                        @"<positionid>%@</positionid>"
                        @"<PPL>Xenon Pickups</PPL>"
                        @"<PL>Xenon FBV</PL>"
                        @"<LOB>Pickups</LOB>"
                        @"<fromdate>01-AUG-2015</fromdate>"
                        @"<todate>25-AUG-2015</todate>"
                        @"</GetSalesPipeLineDashboard_DSE>"
                        @"</SOAP:Body>"
                        @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getSalesPipeLineDashboard_DSE"];
} //
- (void)SalesPipeLineDashboard_DSE_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get SalesPipelineDashboard   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetSalesPipeLineDashboard_DSEPLAll_Arr) {
            [GetSalesPipeLineDashboard_DSEPLAll_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetSalesPipeLineDashboard_DSEResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                salesPipelineDashboardDSM = nil;
                salesPipelineDashboardDSM = [[GetSalesPipeLineDashboard_DSM alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PL = [TBXML childElementNamed:@"PL" parentElement:table];
                salesPipelineDashboardDSM.PL = [TBXML textForElement:PL];

                TBXMLElement* PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                salesPipelineDashboardDSM.PPL = [TBXML textForElement:PPL];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                salesPipelineDashboardDSM.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                salesPipelineDashboardDSM.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                salesPipelineDashboardDSM.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                salesPipelineDashboardDSM.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                salesPipelineDashboardDSM.alias4 = [TBXML textForElement:alias4];

                NSLog(@"\n str_NSE SalesPipeLineDashboard_DSE : %@", salesPipelineDashboardDSM);
                [GetSalesPipeLineDashboard_DSEPLAll_Arr addObject:salesPipelineDashboardDSM];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetSalesPipeLineDashboard_DSEPLAll_Arr);
            // }
            if ((GetSalesPipeLineDashboard_DSEPLAll_Arr.count) > 0) {

                [self hideAlert];
                [self.ExpandableTableView reloadData];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wronggggg.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
//
- (void)GetSalesPipeLineDashboardPL_DSE
{
    //GetPL_PPLDSM_Arr

    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id :%@", position_Id);
    NSLog(@"LOB Count  id :%lu", (unsigned long)GetPL_PPLDSM_Arr.count);
    values = @"";
    for (int i = 0; i < GetPL_PPLDSM_Arr.count; i++) {

        NSLog(@"Valu3w %d", i);
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:[GetPL_PPLDSM_Arr objectAtIndex:i]];
        values = [values stringByAppendingString:@"'"];
        values = [values stringByAppendingString:@","];
        // values = [values stringByAppendingString:@","];
        //values=[GetLOB_Arr objectAtIndex:i];
        //values = [values stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
    }
    NSLog(@"Valu3w %@", values);
    if ([values length] > 0) {
        values = [values substringToIndex:[values length] - 1];
    }
    else {
        //no characters to delete... attempting to do so will result in a crash
    }
    NSLog(@"Valu3w Set %@", values);

    if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetSalesPipeLineDashboard_DSE xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>1-70Z</positionid>"
                                     @"<PPL></PPL>"
                                     @"<PL>%@</PL>"
                                     @"<LOB></LOB>"
                                     @"<fromdate>01-AUG-2015</fromdate>"
                                     @"<todate>25-AUG-2015</todate>"
                                     @"</GetSalesPipeLineDashboard_DSE>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 values];
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

    [[RequestDelegate alloc] initiateRequest:request name:@"getSalesPipeLineDashboardPL_DSE"];
}
// Found method :
- (void)SalesStageDSEDashboardPL_FOUND:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get SalesStageDSEDashboardPL_FOUND   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetSalesPipeLineDashboard_DSEPLArr) {
            [GetSalesPipeLineDashboard_DSEPLArr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetSalesPipeLineDashboard_DSEResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                salesPipelineDashboardDSM = nil;
                salesPipelineDashboardDSM = [[GetSalesPipeLineDashboard_DSM alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PL = [TBXML childElementNamed:@"PL" parentElement:table];
                salesPipelineDashboardDSM.PL = [TBXML textForElement:PL];

                TBXMLElement* PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                salesPipelineDashboardDSM.PPL = [TBXML textForElement:PPL];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                salesPipelineDashboardDSM.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                salesPipelineDashboardDSM.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                salesPipelineDashboardDSM.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                salesPipelineDashboardDSM.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                salesPipelineDashboardDSM.alias4 = [TBXML textForElement:alias4];

                NSLog(@"\n str_NSE SalesPipeLineDashboard_DSE : %@", salesPipelineDashboardDSM);
                [GetSalesPipeLineDashboard_DSEPLArr addObject:salesPipelineDashboardDSM];
                [[SingletonClass sharedobject].GetSalesPipeLineDashboard_DSEPLArrSingleton addObject:salesPipelineDashboardDSM];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetSalesPipeLineDashboard_DSEPLArr);
            // }
            if ((GetSalesPipeLineDashboard_DSEPLArr.count) > 0) {

                [self hideAlert];
            }
            if ([SingletonClass sharedobject].GetSalesPipeLineDashboard_DSEPLArrSingleton.count > 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:self];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wronggggg.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (void)GetMMPipeLineView_DSE
{
    //NSString *position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id GetMMPipeLineView_DSE");

    if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetMMApplicationDashboard_DSE xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues="
                                      ">"
                                     @"<positionid>1-70Z</positionid>"
                                     @"<fromdate>01-AUG-2015</fromdate>"
                                     @"<todate>20-AUG-2015</todate>"
                                     @"</GetMMApplicationDashboard_DSE>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>"];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

    NSLog(@"\n envlopeString Of user details....MM!!!!%@", envelopeText);

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getMMPipeLineView_DSE_SH"];
}

- (void)MMPipeLineView_DSE_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get MMPipeLineView_DSE   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetMMPipeLineView_DSEApp_Arr) {
            [GetMMPipeLineView_DSEApp_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetMMPipeLineView_DSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                getMMPipeLineView_DSE = nil;
                getMMPipeLineView_DSE = [[GetMMPipeLineView_DSE alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* LOGIN = [TBXML childElementNamed:@"LOGIN" parentElement:table];
                getMMPipeLineView_DSE.LOGIN = [TBXML textForElement:LOGIN];

                TBXMLElement* F_NAME = [TBXML childElementNamed:@"F_NAME" parentElement:table];
                getMMPipeLineView_DSE.F_NAME = [TBXML textForElement:F_NAME];

                TBXMLElement* L_NAME = [TBXML childElementNamed:@"L_NAME" parentElement:table];
                getMMPipeLineView_DSE.L_NAME = [TBXML textForElement:L_NAME];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                getMMPipeLineView_DSE.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                getMMPipeLineView_DSE.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                getMMPipeLineView_DSE.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                getMMPipeLineView_DSE.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                getMMPipeLineView_DSE.alias4 = [TBXML textForElement:alias4];

                NSLog(@"\n str_NSE  MM : %@", getMMPipeLineView_DSE);
                [GetMMPipeLineView_DSEApp_Arr addObject:getMMPipeLineView_DSE];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetMMPipeLineView_DSEApp_Arr);
            // }
            if ((GetMMPipeLineView_DSEApp_Arr.count) > 0) {
                [self hideAlert];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
- (void)dsepipelinefound:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get MMPipeLineView_DSE   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetMMPipeLineView_DSE_Arr) {
            [GetMMPipeLineView_DSE_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetMMPipeLineView_DSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                getMMPipeLineView_DSE = nil;
                getMMPipeLineView_DSE = [[GetMMPipeLineView_DSE alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* LOGIN = [TBXML childElementNamed:@"LOGIN" parentElement:table];
                getMMPipeLineView_DSE.LOGIN = [TBXML textForElement:LOGIN];

                TBXMLElement* F_NAME = [TBXML childElementNamed:@"F_NAME" parentElement:table];
                getMMPipeLineView_DSE.F_NAME = [TBXML textForElement:F_NAME];

                TBXMLElement* L_NAME = [TBXML childElementNamed:@"L_NAME" parentElement:table];
                getMMPipeLineView_DSE.L_NAME = [TBXML textForElement:L_NAME];

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                getMMPipeLineView_DSE.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                getMMPipeLineView_DSE.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                getMMPipeLineView_DSE.alias2 = [TBXML textForElement:alias2];

                TBXMLElement* alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
                getMMPipeLineView_DSE.alias3 = [TBXML textForElement:alias3];

                TBXMLElement* alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
                getMMPipeLineView_DSE.alias4 = [TBXML textForElement:alias4];

                NSLog(@"\n str_NSE  MM : %@", getMMPipeLineView_DSE);
                [GetMMPipeLineView_DSE_Arr addObject:getMMPipeLineView_DSE];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetMMPipeLineView_DSE_Arr);
            // }
            if ((GetMMPipeLineView_DSE_Arr.count) > 0) {
                [self hideAlert];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
- (void)GetMMGeoDashboard_DSE
{
    NSString* position_Id = [NSString stringWithFormat:@"'%@'", userDetailsVal_.ROW_ID];
    NSLog(@"Position id :%@", position_Id);

    if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<GetMMGeoDashboard_DSE xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                     @"<positionid>1-70Z</positionid>"
                                     @"<PPL></PPL>"
                                     @"<PL></PL>"
                                     @"<LOB></LOB>"
                                     @"<fromdate>01-SEP-2015</fromdate>"
                                     @"<todate>20-SEP-2015</todate>"
                                     @"</GetMMGeoDashboard_DSE>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>"];
    }
    /*else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
     
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
     @"</SOAP:Envelope>"] ;
     }*/

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

    [[RequestDelegate alloc] initiateRequest:request name:@"getMMGeoDashboard_DSE"];
}

- (void)MMGeoDashboard_DSE_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Get MMGeoDashboard_DSE   %@ ", response);

    if ([response isEqual:@""]) {

        [self hideAlert];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {

        if (GetMMPipeLineView_DSE_Arr) {
            [GetMMPipeLineView_DSE_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetMMGeoDashboard_DSEResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {

            do {

                getMMPipeLineView_DSE = nil;
                getMMPipeLineView_DSE = [[GetMMPipeLineView_DSE alloc] init];

                TBXMLElement* table = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* LOGIN = [TBXML childElementNamed:@"MM_MKT" parentElement:table];
                getMMPipeLineView_DSE.LOGIN = [TBXML textForElement:LOGIN];

                /* TBXMLElement *F_NAME = [TBXML childElementNamed:@"F_NAME" parentElement:table];
         getMMPipeLineView_DSE.F_NAME = [TBXML textForElement:F_NAME];
         
         TBXMLElement *L_NAME = [TBXML childElementNamed:@"L_NAME" parentElement:table];
         getMMPipeLineView_DSE.L_NAME = [TBXML textForElement:L_NAME];*/

                TBXMLElement* alias = [TBXML childElementNamed:@"alias" parentElement:table];
                getMMPipeLineView_DSE.alias = [TBXML textForElement:alias];

                TBXMLElement* alias1 = [TBXML childElementNamed:@"alias1" parentElement:table];
                getMMPipeLineView_DSE.alias1 = [TBXML textForElement:alias1];

                TBXMLElement* alias2 = [TBXML childElementNamed:@"alias2" parentElement:table];
                getMMPipeLineView_DSE.alias2 = [TBXML textForElement:alias2];

                /*TBXMLElement *alias3 = [TBXML childElementNamed:@"alias3" parentElement:table];
         getMMPipeLineView_DSE.alias3 = [TBXML textForElement:alias3];
         
         TBXMLElement *alias4 = [TBXML childElementNamed:@"alias4" parentElement:table];
         getMMPipeLineView_DSE.alias4 = [TBXML textForElement:alias4];*/

                NSLog(@"\n str_NSE  MM : %@", getMMPipeLineView_DSE);
                [GetMMPipeLineView_DSE_Arr addObject:getMMPipeLineView_DSE];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"Sales Stages :%@", GetMMPipeLineView_DSE_Arr);
            // }
            if ((GetMMPipeLineView_DSE_Arr.count) > 0) {

                [self hideAlert];
            }
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:@"DSE" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
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
#pragma mark - TableView Delegate and Data source methods- shraddha

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.ActivityAdherenceTableView)

    {
        return 1;
    }
    else if (tableView == self.MMPipeLineTableView) {
        //        return [GetMMPipeLineView_DSE_Arr count];
        return 1;
    }
    else if (tableView == self.ExpandableTableView) {
        //return  [self.titleArray count];

        return [GetPL_LOBPPL_Arr count];
    }
    else
        return [self.arForTable count];
}

// Customize the appearance of table view cells.
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    if (tableView == self.ActivityAdherenceTableView) {

        static NSString* cellIdentifier = @"ActivityAdhCustomCell";

        ActivityAdhCustomCell* activityAdhCustomCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (activityAdhCustomCell == nil) {
            NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"ActivityAdhCustomCell" owner:self options:nil];

            activityAdhCustomCell = [nib objectAtIndex:0];
        }
        return activityAdhCustomCell;
    }
    else if (tableView == self.MMPipeLineTableView) {

        static NSString* cellIdentifier = @"mmPipelineCustomCell";

        mmPipelineCustomCell* mmPipelineCustomCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (mmPipelineCustomCell == nil) {
            NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"mmPipelineCustomCell" owner:self options:nil];

            mmPipelineCustomCell = [nib objectAtIndex:0];
        }
        if (GetMMPipeLineView_DSE_Arr.count > 0 && senderTagFrButton == 1) {

            //            int rowc = indexPath.row;
            mmPipelineCustomCell.C0Lbl.text = [[GetMMPipeLineView_DSE_Arr objectAtIndex:indexPath.row] alias];
            mmPipelineCustomCell.C1ALbl.text = [[GetMMPipeLineView_DSE_Arr objectAtIndex:indexPath.row] alias1];
            mmPipelineCustomCell.C3Lbl.text = [[GetMMPipeLineView_DSE_Arr objectAtIndex:indexPath.row] alias2];
        }
        if (GetMMPipeLineView_DSEApp_Arr.count > 0 && senderTagFrButton == 2)

        {

            //          int rowc = indexPath.row;
            mmPipelineCustomCell.C0Lbl.text = [[GetMMPipeLineView_DSEApp_Arr objectAtIndex:indexPath.row] alias];
            mmPipelineCustomCell.C1ALbl.text = [[GetMMPipeLineView_DSEApp_Arr objectAtIndex:indexPath.row] alias1];
            mmPipelineCustomCell.C3Lbl.text = [[GetMMPipeLineView_DSEApp_Arr objectAtIndex:indexPath.row] alias2];
        }

        return mmPipelineCustomCell;
    }
    else {
        static NSString* cellIdentifier = @"ExpandableCustomCell";

        ExpandableCustomCell* ExpandableCustomCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (ExpandableCustomCell == nil) {
            NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"ExpandableCustomCell" owner:self options:nil];

            ExpandableCustomCell = [nib objectAtIndex:0];
        }
        if (selectedIndex == indexPath.row) {
            //do expandable row work here
        }
        else {
            //do closing stuff here
        }
        //                [GetSalesPipeLineDashboard_DSM_Arr addObject:salesPipelineDashboardDSM];

        //GetLOB_Arr
        
        ExpandableCustomCell.title.text = [GetPL_LOBPPL_Arr objectAtIndex:indexPath.row];
        self.selectedData = [GetPL_LOBPPL_Arr objectAtIndex:indexPath.row];
        ExpandableCustomCell.title.textColor = [UIColor blackColor];
        // NSLog(@"GetSalesPipeLineDashboard_DSMPLAll_Arr count value :%d",[ GetSalesPipeLineDashboard_DSMPLAll_Arr count]);
        //if no data i sthr in array to show nill in other array

        //salesPipeLineDashboardAllPL_DSM.alias3 = [TBXML textForElement:alias3];
        if (GetSalesPipeLineDashboard_DSM_Arr.count > 0) {
            //        int str  = indexPath.row;
            if (GetSalesPipeLineDashboard_DSM_Arr.count > indexPath.row) {
                salesPipelineDashboardDSM = nil;
                salesPipelineDashboardDSM = [[GetSalesPipeLineDashboard_DSM alloc] init];
                salesPipelineDashboardDSM = [GetSalesPipeLineDashboard_DSM_Arr objectAtIndex:indexPath.row];

                ExpandableCustomCell.subtitleAlis.text = salesPipelineDashboardDSM.alias;
                ExpandableCustomCell.subtitleAlis1.text = salesPipelineDashboardDSM.alias1;

                ExpandableCustomCell.subtitleAlis2.text = salesPipelineDashboardDSM.alias2;

                ExpandableCustomCell.subtitleAlis3.text = salesPipelineDashboardDSM.alias3;

                ExpandableCustomCell.subtitleAlis4.text = salesPipelineDashboardDSM.alias4;
            }
        }
        if (GetSalesPipeLineDashboard_DSEPLAll_Arr.count > 0) {

            if (GetSalesPipeLineDashboard_DSEPLAll_Arr.count > indexPath.row) {
                salesPipelineDashboardDSM = nil;
                salesPipelineDashboardDSM = [[GetSalesPipeLineDashboard_DSM alloc] init];
                salesPipelineDashboardDSM = [GetSalesPipeLineDashboard_DSEPLAll_Arr objectAtIndex:indexPath.row];

                ExpandableCustomCell.subtitleAlis.text = salesPipelineDashboardDSM.alias;
                ExpandableCustomCell.subtitleAlis1.text = salesPipelineDashboardDSM.alias1;

                ExpandableCustomCell.subtitleAlis2.text = salesPipelineDashboardDSM.alias2;

                ExpandableCustomCell.subtitleAlis3.text = salesPipelineDashboardDSM.alias3;

                ExpandableCustomCell.subtitleAlis4.text = salesPipelineDashboardDSM.alias4;
            }
        }

        return ExpandableCustomCell;
    }
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    self.selectedData = [GetPL_LOBPPL_Arr objectAtIndex:indexPath.row];
    NSLog(@"Selected index valus :%@", self.selectedData);
    if (tableView == self.ExpandableTableView) {
        //        if(selectedIndex==indexPath.row && (GetSalesPipeLineDashboard_DSM_Arr.count >0))
        if (selectedIndex == indexPath.row)

        {
            selectedIndex = -1;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            return;
        }
        //user tabs diff row
        if (selectedIndex != -1)

        {
            NSIndexPath* prePath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            selectedIndex = (int)indexPath.row;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:prePath, nil] withRowAnimation:UITableViewRowAnimationFade];
        }
        //user select new row with none expandable
        if (selectedIndex == -1) {

            [self GetAllPLDSM];

            selectedIndex = (int)indexPath.row;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    if (selectedIndex == indexPath.row) {
        return 260;
    }
    else {
        return 34;
    }
}
#pragma mark -method to collapse TableView
//To collapse table view -shraddha

#pragma mark -methid to show geo and App detail in  TableView

- (IBAction)ShowMMGeoDetails:(UIButton*)sender
{
    self.MMGeoLbl.text = @"MM Geo";
    senderTagFrButton = [sender tag];
    //tag = 1

    [self.MMPipeLineTableView reloadData];
}

- (IBAction)ShowMMAppDetails:(id)sender
{

    senderTagFrButton = [sender tag];

    self.MMGeoLbl.text = @"MM App";
    [self.MMPipeLineTableView reloadData];
}

@end