//
//  ActivityUpdateViewController.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/15/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "ActivityUpdateViewController.h"
#import "PendingActivityList.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "MBProgressHUD.h"
#import "UserDetails_Var.h"
#import "Reachability.h"
#import "Activity_List.h"
#import "Opportunity_List.h"
#import "LoginViewController.h"

@interface ActivityUpdateViewController ()
{
    
    UIActionSheet *actionSheet;
    UIDatePicker *datePicker;
    NSString *stringFromDate;
    NSString *stringDate;
    NSString *dateTime;
    NSArray *splitTime;
    UIAlertView *alert;
    int flag,flagdate,flagtime;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive,hostActive;
    
    NSString *integrationValue;
    NSString *firecount;
    NSString* envelopeText;
    
    
}
@end

@implementation ActivityUpdateViewController

@synthesize activityTypeArr,textfieldType;
@synthesize flagset;
@synthesize lblAccountType,lblAddress,lblCustomerName,lblMobileNo,lblOptyId,lblTGMTKM_Name,lblTGMTKMNumber;
@synthesize txtfldTym,txtfldDate,txDescription;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [super viewDidLoad];
    
    if (![self connected])
    {
        // not connected
        NSLog(@"Newtwork not Available...");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"The Internet connection appears to be offline." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self textFiledText];
        
        
    }else{
        
        [self showAlert];
        [self textFiledText];
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
        userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
        // NSLog(@"%d",flagset);
        activityTypeArr = [[NSMutableArray alloc]init];// for Activty TYPE
        
        /*
         <S_OPTY>
         <ACTIVITY_PLAN_START_DT>28-FEB-2015 17:14:05</ACTIVITY_PLAN_START_DT>
         <ACTIVITY_TYPE>Test Drive</ACTIVITY_TYPE>
         <ACTIVITY_ID>1-7BN1O73</ACTIVITY_ID>
         <ACTIVITY_STATUS>Open</ACTIVITY_STATUS>
         <ACTIVITY_DESC>FFF</ACTIVITY_DESC>
         <TGM_TKM_NAME xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
         <TGM_TKM_PHONE_NUMBER xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
         <ACCOUNT_ID xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
         <CONTACT_NAME>ANAND KUMAR</CONTACT_NAME>
         <CONTACT_ID>1-788U783</CONTACT_ID>
         <CONTACT_ADDRESS>FINANCE ONE INDIA BULLS, 20TH FLR,</CONTACT_ADDRESS>
         <CONTACT_CELL_NUMBER>2266586333</CONTACT_CELL_NUMBER>
         <OPTY_NAME>1-788U78A</OPTY_NAME>
         <OPTY_ID>1-788U78A</OPTY_ID>
         <OPTY_CREATED>19-SEP-2014</OPTY_CREATED>
         <SALES_STAGE_NAME>Closed Lost at C1A</SALES_STAGE_NAME>
         <SALE_STAGE_UPDATED_DATE>27-JAN-2015</SALE_STAGE_UPDATED_DATE>
         <LEAD_ASSIGNED_NAME>AJAY PARAB</LEAD_ASSIGNED_NAME>
         <LEAD_ASSIGNED_CELL_NUMBER>9999999999</LEAD_ASSIGNED_CELL_NUMBER>
         <LEAD_POSITION>TMCV-Sal-W-MUM-1001680-Jogeshwari-Pickup-DSE-33</LEAD_POSITION>
         <LEAD_POSITION_ID>1-7F0Y20</LEAD_POSITION_ID>
         <X_PROSPECT_SRC>TGM</X_PROSPECT_SRC>
         </S_OPTY>
         
         */
        
        
        NSLog(@"Activity List... %@",activity_list.CONTACT_NAME);
        NSLog(@"Activity List... %@",activity_list.OPPTY_ROWID);
        NSLog(@"Activity List... %@",activity_list.CONTACT_CELL_NUM);
        NSLog(@"Activity List... %@",activity_list.CONTACT_ADDRESS);
        NSLog(@"Activity List... %@",activity_list.TGM_TKM_NAME);
        NSLog(@"Activity List... %@",activity_list.TGM_TKM_PHONE_NUMBER);
        NSLog(@"Activity List... %@",activity_list.ACCOUNT_TYPE);
        
        self.btn_cancel.layer.cornerRadius=3;
        self.btn_cancel.layer.masksToBounds = YES;
        
        self.btn_update.layer.cornerRadius=3;
        self.btn_update.layer.masksToBounds = YES;
        
        
        self.textfieldType.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.textfieldType.layer.borderWidth = 2;
        
        self.txtfldDate.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txtfldDate.layer.borderWidth = 2;
        
        self.txtfldTym.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txtfldTym.layer.borderWidth = 2;
        
        self.txDescription.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txDescription.layer.borderWidth = 2;
        
        self.txDescription.delegate=self;
        
        // Do any additional setup after loading the view.
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
        // Do any additional setup after loading the view.}
        
        
        NSLog(@"Status : %@", activityPending_list.ACTIVITY_STATUS);
        if([activityPending_list.ACTIVITY_STATUS isEqual:@"Done"])
        {
            alert = [[UIAlertView alloc] initWithTitle:nil
                                               message:@"This activity is already marked as done! You cannot update it."
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil,nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];
            
            //[self dismissViewControllerAnimated:YES completion:nil];
            //[self presentViewController:secondViewController animated:YES completion:nil ];
            
        }
        
        if(flagset==1)
        {
            NSLog(@"From ...Opty");
            self.lblCustomerName.text=opportunity_list.CONTACT_NAME;
            self.lblMobileNo.text=opportunity_list.CONTACT_CELL_NUMBER;
            self.lblAddress.text=opportunity_list.CONTACT_ADDRESS;
            self.lblTGMTKM_Name.text=opportunity_list.TGM_TKM_NAME;
            self.lblTGMTKMNumber.text=opportunity_list.TGM_TKM_PHONE_NUMBER;
            self.lblAccountType.text=opportunity_list.ACCOUNT_TYPE;
            self.lblOptyId.text=opportunity_list.OPTY_ID;
            
            self.textfieldType.text=activityPending_list.ACTIVITY_TYPE;
            self.txDescription.text=activityPending_list.ACTIVITY_DESC;
            NSLog(@"From ...Opty1 %@",activityPending_list.ACTIVITY_PLAN_START_DT);
            
            if ([userDetailsVal_.POSTN isEqual:@"DSE"]) {
                splitTime=[activityPending_list.ACTIVITY_PLAN_START_DT componentsSeparatedByString:@" "];
                self.txtfldDate.text=activityPending_list.ACTIVITY_PLAN_START_DT;
              //  self.txtfldTym.text=activityPending_list.ACTIVITY_PLAN_START_TM;
            }
            else if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
                
                
                self.txtfldDate.text=activityPending_list.ACTIVITY_PLAN_START_DT;
                //self.txtfldTym.text=activityPending_list.ACTIVITY_PLAN_START_TM;
            }
            /*splitTime=[activityPending_list.ACTIVITY_PLAN_START_DT componentsSeparatedByString:@" "];
             self.txtfldDate.text=[splitTime objectAtIndex:0];
             self.txtfldTym.text=[splitTime objectAtIndex:1];*/
            NSLog(@"From ...Opty2");
            
            
        }
        else{
            NSLog(@"From ...Activty");
            self.lblCustomerName.text=activity_list.CONTACT_NAME;
            self.lblMobileNo.text=activity_list.CONTACT_CELL_NUM;
            self.lblAddress.text=activity_list.CONTACT_ADDRESS;
            self.lblTGMTKM_Name.text=activity_list.TGM_TKM_NAME;
            self.lblTGMTKMNumber.text=activity_list.TGM_TKM_PHONE_NUMBER;
            self.lblAccountType.text=activity_list.ACCOUNT_TYPE;
            self.lblOptyId.text=activity_list.OPPTY_ROWID;
            
            self.textfieldType.text=activityPending_list.ACTIVITY_TYPE;
            // self.txtSelectDate.text=activityPending_list.ACTIVITY_PLAN_START_DT;
            self.txDescription.text=activityPending_list.ACTIVITY_DESC;
            
            self.txtfldDate.text=activityPending_list.ACTIVITY_PLAN_START_DT;
            //self.txtfldTym.text=activityPending_list.ACTIVITY_PLAN_START_TM;
            
            
            /*splitTime=[activityPending_list.ACTIVITY_PLAN_START_DT componentsSeparatedByString:@" "];
             NSLog(@"Array :Print :%@",splitTime);
             self.txtfldDate.text=[splitTime objectAtIndex:0];
             self.txtfldTym.text=[splitTime objectAtIndex:1];*/
            
            
        }
        
        if([lblCustomerName.text isEqual:@""])
        {
            lblCustomerName.text=@"Not Available";
        }
        if([self.lblMobileNo.text isEqual:@""])
        {
            self.lblMobileNo.text=@"Not Available";
        }
        if([self.lblAddress.text isEqual:@""])
        {
            self.lblAddress.text=@"Not Available";
        }
        if([self.lblTGMTKM_Name.text isEqual:@""])
        {
            self.lblTGMTKM_Name.text=@"Not Available";
        }
        if([self.lblTGMTKMNumber.text isEqual:@""])
        {
            self.lblTGMTKMNumber.text=@"Not Available";
        }
        if([self.lblAccountType.text isEqual:@""])
        {
            NSLog(@"ekssss");
            lblAccountType.text=@"Not Available";
        }
        if([self.lblOptyId.text isEqual:@""])
        {
            lblOptyId.text=@"Not Available";
        }
        [self CallActivity_Type];
    }
}

-(void)textFiledText
{
    UIColor *color=[UIColor colorWithRed:(131/255.0) green:(131/255.0) blue:(131/255.0) alpha:1];
    //self.txtCustomerName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Customer name" attributes:@{NSForegroundColorAttributeName:color}];
    
    //self.txtCustomerMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Customer Mobile Number" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txtfldDate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Date" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txtfldTym.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Time" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.textfieldType.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Select Activity Type" attributes:@{NSForegroundColorAttributeName:color}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityType_Found:) name:@"ActivityType_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityUpdates_Found:) name:@"ActivityUpdates_Found" object:nil];//Gautam //For activity type
}
-(void)viewDidDisappear:(BOOL)animated{
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityType_Found" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityUpdates_Found" object:nil];
    
    
}
-(void)CallActivity_Type
{       NSString * envelopeText = [NSString stringWithFormat:
                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Body>"
                                   @"<getListOfActivityJavaCall xmlns=\"http://schemas.cordys.com/NeevJavaCall\" />"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>"];
    
    NSLog(@"\n envlopeString Of Activity Type Create....!!!!%@",envelopeText);
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
                [activityTypeArr addObject:str_NAME];
                
            }while ((tuple2 = tuple2->nextSibling));
            NSLog(@"Activty Type: %@",activityTypeArr);
            [self hideAlert];
        }
    }
    [self hideAlert];
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"button click ....%ld",(long)buttonIndex);
    if(textfieldType){
        NSLog(@"... in");
        switch (popup.tag) {
                //NSLog(@"... in");
            case 1:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    NSLog(@"ek..");
                    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    self.textfieldType.text = NSLocalizedString([activityTypeArr objectAtIndex:buttonIndex],@"");
                    
                }
        }
    }
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        
        NSLog(@"David Miller");
        if(flag==1)
        {
            [self dismissViewControllerAnimated:YES completion:NULL];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            /*
             ActivityListViewController *activitiesResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"activityList_controller"];
             [self.navigationController pushViewController:activitiesResult_VC animated:YES];*/
        }
        else
        {
            NSLog(@"Ethech...");
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



- (IBAction)btn_Activitytype:(id)sender {
    
    
    if (![self connected])
    {
        [self hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
        
        NSLog(@"Network not Available...");
        
    }
    else{
        
        
        
        NSLog(@"Activity...Data %@",activityTypeArr);
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        // ObjC Fast Enumeration
        for (NSString *title in activityTypeArr) {
            [actionSheet addButtonWithTitle:title];
        }
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.view animated:YES];
            actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
        }
        else{
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 1;
        
        
    }
    
    
}
//- (void)changeDate:(UIDatePicker *)sender {
//    NSLog(@"New Date: %@", sender.date);
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MM/dd/yyyy"];
//    stringDate = [formatter stringFromDate:sender.date];
//    _txtfldDate.text=stringDate;
//
//
//}

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



//- (void)changeDate_:(UIDatePicker *)sender {
//    NSLog(@"New Date: %@", sender.date);
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH:mm:ss"];
//    stringFromDate = [formatter stringFromDate:sender.date];
//    //[dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
//    NSLog(@"Date..Set  To: : %@",stringFromDate);
//    _txtfldTym.text=stringFromDate;
//}
- (IBAction)btnDate:(id)sender {
    
    
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height-500-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height-500, 320, 216);
    flagdate=1;
    
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
    
    // NSLog(@"New Date: %@", sender.date);
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"dd-MMMM-YYYY"];
    
    [formatter setDateFormat:@"MM/dd/yyyy"];
    // [formatter setDateFormat:@"dd-MMM-yyyy"];
    
    stringDate = [formatter stringFromDate:date];
    NSLog(@"Date..Set  From : : %@",stringDate);
    self.txtfldDate.text=stringDate;
    
    [datePicker setMinimumDate: [NSDate date]];
    
    
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
    //[formatter setDateFormat:@"dd-MMMM-YYYY"];
    
    [formatter setDateFormat:@"MM/dd/yyyy"];
    // [formatter setDateFormat:@"dd-MMM-yyyy"];
    
    stringDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  From : : %@",stringDate);
    self.txtfldDate.text=stringDate;
}
- (IBAction)btnTime:(id)sender {
    
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
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //[formatter setDateFormat:@"MM/dd/yyyy"];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    // [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dateStringExtra = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateStringExtra);
    
    if([dateStringExtra isEqual:stringDate])
    {
        [datePicker setMinimumDate: [NSDate date]];
        
    }
    
    
    //[datePicker setMinimumDate: [NSDate date]];
    [datePicker setLocale:[NSLocale systemLocale]];
    // NSLog(@"New Date: %@", sender.date);
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    stringFromDate = [formatter stringFromDate:date];
    //[dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
    NSLog(@"Date..Set  To: : %@",stringFromDate);
    self.txtfldTym.text=stringFromDate;
    flagtime=1;
    
    // [datePicker setMinimumDate: [NSDate date]];
    
    
    [datePicker addTarget:self action:@selector(changeDate_:) forControlEvents:UIControlEventValueChanged];
    //datePicker.backgroundColor=[UIColor colorWithRed:(2/255.0) green:(18/255.0) blue:(40/255.0) alpha:1];
    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    datePicker.layer.borderWidth = 2;
    [[UILabel appearanceWhenContainedIn:[UIDatePicker class], nil]
     setTextColor:[UIColor whiteColor]];
    datePicker.datePickerMode=UIDatePickerModeTime;
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
    [formatter setDateFormat:@" HH:mm:ss"];
    stringFromDate = [formatter stringFromDate:sender.date];
    //[dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
    NSLog(@"Date..Set  To: : %@",stringFromDate);
    self.txtfldTym.text=stringFromDate;
    
    /*stringDate = [stringDate stringByAppendingString:@""];
     stringDate = [stringDate stringByAppendingString:stringFromDate];
     //[string capitalizedString]
     NSLog(@"Log Date Vakues: %@",[stringDate capitalizedString]);*/
}

- (IBAction)btnUpdate:(id)sender
{
    
    if (![self connected]) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"Network not Available...");
    }
    else {
        
        //stringDate = [NSString stringWithFormat:stringDate,stringFromDate];
        if(stringFromDate.length==0)
        {
            stringDate = [[stringDate stringByAppendingString:@" "] stringByAppendingString:self.txtfldTym.text];
            NSLog(@"Date and Time :%@",stringDate);
        }else{
            NSLog(@"Date ::::: %@",stringDate);
            NSLog(@"Date ::::: %@",stringFromDate);
            stringDate = [stringDate stringByAppendingString:stringFromDate];
            NSLog(@"Date and Time :%@",stringDate);
        }
        //  Code for chnage date formamte while date set as it is
        if(flagdate==1)
        {
            NSLog(@"Clicked on Date button");
        }else{
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MMM-yyyy"];
            NSDate* aDate = [formatter dateFromString:txtfldDate.text];
            [formatter setDateFormat:@"MM/dd/yyyy"];
            NSLog(@"%@", [formatter stringFromDate:aDate]);
            stringDate=[formatter stringFromDate:aDate];
            NSLog(@"New Date : %@",stringDate);
            if(flagtime==1)
            {
                stringDate = [[stringDate stringByAppendingString:@""]stringByAppendingString:txtfldTym.text];
                
            }else{
                stringDate = [[stringDate stringByAppendingString:@" "]stringByAppendingString:txtfldTym.text];
            }
            NSLog(@"New Date :::: %@",stringDate);
        }
        if (textfieldType.text.length == 0 || txtfldDate.text.length == 0 || txtfldTym.text.length == 0) {
            
            alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Select mandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            [self showAlert];
            [self CallActivityUpdate];
        }
    }
}
- (IBAction)btnCancel:(id)sender {
    
}


-(void)CallActivityUpdate
{
    NSLog(@"Login name..%@",userDetailsVal_.Login_Name);
    
    NSLog(@"date string %@",stringDate);
    
    
    
    
    //   stringDate=[stringDate stringByAppendingString:@":00"];
    //    NSLog(@"%@",stringDate);
    
    
    
    
    integrationValue= [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
    
    NSLog(@"date string %@",stringDate);
    
    
    firecount =@"first";
    
    
    
    
    
    
    if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
        
        
        
        
        envelopeText = [NSString stringWithFormat:
                        @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:con=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                        @"<soapenv:Header/>"
                        @"<soapenv:Body>"
                        @"<asi:SFATMCVContactInsertOrUpdate_Input>"
                        @"<con:ListOfContactInterface>"
                        @"<Contact>"
                        @"<Id>%@</Id>"
                        @"<ListOfOpportunity>"
                        @"<Opportunity>"
                        @"<Id>%@</Id>"
                        @"<ListOfOpportunityRelatedActivities>"
                        @"<OpportunityRelatedActivities>"
                        @"<ActivityUID>%@</ActivityUID>"
                        @"<TMIntegrationId>%@</TMIntegrationId>"
                        @"<OpportunityId>%@</OpportunityId>"
                        @"<ActivityStatus>Open</ActivityStatus>"
                        @"<NextPlannedDate/>"
                        @"<Mode>Visit</Mode>"
                        @"<ActivityType>Test Drive</ActivityType>"
                        @"<PlannedStart>%@</PlannedStart>"
                        @"<Comments>test activity</Comments>"
                        @"<PlannedEnd/>"
                        @"<ListOfActivitiesRelatedSalesRep>"
                        @"<ActivitiesRelatedSalesRep IsPrimaryMVG=\"N\">"
                        @"<Id>1-1S7NSUJ</Id>"
                        @"<Login>SARITAK_1001680</Login>"
                        @"</ActivitiesRelatedSalesRep>"
                        @"</ListOfActivitiesRelatedSalesRep>"
                        @"<Description2>1-1S7NSUJ</Description2>"
                        @"</OpportunityRelatedActivities>"
                        @"</ListOfOpportunityRelatedActivities>"
                        @"</Opportunity>"
                        @"</ListOfOpportunity>"
                        @"</Contact>"
                        @"</con:ListOfContactInterface>"
                        @"<!--Optional:-->"
                        @"<asi:StatusObject>?</asi:StatusObject>"
                        @"</asi:SFATMCVContactInsertOrUpdate_Input>"
                        @"</soapenv:Body>"
                        @"</soapenv:Envelope>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,activityPending_list.ACTIVITY_ID,activityPending_list.ACTIVITY_ID,opportunity_list.OPTY_ID,stringDate];
    }
    else{
        
        
        envelopeText = [NSString stringWithFormat:
                        @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:con=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                        @"<soapenv:Header/>"
                        @"<soapenv:Body>"
                        @"<asi:SFATMCVContactInsertOrUpdate_Input>"
                        @"<con:ListOfContactInterface>"
                        @"<Contact>"
                        @"<Id>%@</Id>"
                        @"<ListOfOpportunity>"
                        @"<Opportunity>"
                        @"<Id>%@</Id>"
                        @"<ListOfOpportunityRelatedActivities>"
                        @"<OpportunityRelatedActivities>"
                        @"<ActivityUID>%@</ActivityUID>"
                        @"<TMIntegrationId>%@</TMIntegrationId>"
                        @"<OpportunityId>%@</OpportunityId>"
                        @"<ActivityStatus>Open</ActivityStatus>"
                        @"<NextPlannedDate/>"
                        @"<Mode>Visit</Mode>"
                        @"<ActivityType>Test Drive</ActivityType>"
                        @"<PlannedStart>%@</PlannedStart>"
                        @"<Comments>test activity</Comments>"
                        @"<PlannedEnd/>"
                        @"<ListOfActivitiesRelatedSalesRep>"
                        @"<ActivitiesRelatedSalesRep IsPrimaryMVG=\"N\">"
                        @"<Id>1-5DVL4B</Id>"
                        @"<Login>JJOSHI1001680</Login>"
                        @"</ActivitiesRelatedSalesRep>"
                        @"</ListOfActivitiesRelatedSalesRep>"
                        @"<Description2>1-5DVL4B</Description2>"
                        @"</OpportunityRelatedActivities>"
                        @"</ListOfOpportunityRelatedActivities>"
                        @"</Opportunity>"
                        @"</ListOfOpportunity>"
                        @"</Contact>"
                        @"</con:ListOfContactInterface>"
                        @"<!--Optional:-->"
                        @"<asi:StatusObject>?</asi:StatusObject>"
                        @"</asi:SFATMCVContactInsertOrUpdate_Input>"
                        @"</soapenv:Body>"
                        @"</soapenv:Envelope>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,activityPending_list.ACTIVITY_ID,activityPending_list.ACTIVITY_ID,opportunity_list.OPTY_ID,stringDate];
        
        
        
        
        
        
        
        
    }
    
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityUpdateConnection"];
    
}
-(void)ActivityUpdates_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityType_Found response... %@ ",response);
    
    if ([response rangeOfString:@"soapenv:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message :@"Update activity failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        //      TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        //
        //        TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];
        
        TBXMLElement *container = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"soapenv:Body" parentElement:tbxml.rootXMLElement]]];
        
        
        
        TBXMLElement *Opportunity = [TBXML childElementNamed:@"Contact" parentElement:container];
        if (Opportunity)
        {
            TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
            
            NSString   *newactivity = [TBXML textForElement:Id];
            NSLog(@"\nListOfContactInterface.....!!!!!%@",newactivity);
            
            if ([firecount isEqual:@"first"]) {
                
                [self updateagain];
                
            }
            else{
                
                
                
                if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
                    
                    alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message:@"Activity updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                    [self hideAlert];
                }else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
                    
                    alert=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"Activity updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [self hideAlert];
                }else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
                    
                    alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Activity updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [self hideAlert];
                }
            }
            
        }
        
        else
        {
            
            [self hideAlert];
            
            alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Server Error while Updating Activity, please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}


-(void)updateagain
{
    
    
    firecount=@"second";
    
    if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
        
        
        
        
        
        
        envelopeText = [NSString stringWithFormat:
                        @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:con=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                        @"<soapenv:Header/>"
                        @"<soapenv:Body>"
                        @"<asi:SFATMCVContactInsertOrUpdate_Input>"
                        @"<con:ListOfContactInterface>"
                        @"<Contact>"
                        @"<Id>%@</Id>"
                        @"<ListOfOpportunity>"
                        @"<Opportunity>"
                        @"<Id>%@</Id>"
                        @"<ListOfOpportunityRelatedActivities>"
                        @"<OpportunityRelatedActivities>"
                        @"<ActivityUID>%@</ActivityUID>"
                        @"<TMIntegrationId>%@</TMIntegrationId>"
                        @"<OpportunityId>%@</OpportunityId>"
                        @"<ActivityStatus>Open</ActivityStatus>"
                        @"<NextPlannedDate/>"
                        @"<Mode>Visit</Mode>"
                        @"<ActivityType>Test Drive</ActivityType>"
                        @"<PlannedStart>%@</PlannedStart>"
                        @"<Comments>test activity</Comments>"
                        @"<PlannedEnd/>"
                        @"<ListOfActivitiesRelatedSalesRep>"
                        @"<ActivitiesRelatedSalesRep IsPrimaryMVG=\"N\">"
                        @"<Id>1-1S7NSUJ</Id>"
                        @"<Login>SARITAK_1001680</Login>"
                        @"</ActivitiesRelatedSalesRep>"
                        @"</ListOfActivitiesRelatedSalesRep>"
                        @"<Description2>1-1S7NSUJ</Description2>"
                        @"</OpportunityRelatedActivities>"
                        @"</ListOfOpportunityRelatedActivities>"
                        @"</Opportunity>"
                        @"</ListOfOpportunity>"
                        @"</Contact>"
                        @"</con:ListOfContactInterface>"
                        @"<!--Optional:-->"
                        @"<asi:StatusObject>?</asi:StatusObject>"
                        @"</asi:SFATMCVContactInsertOrUpdate_Input>"
                        @"</soapenv:Body>"
                        @"</soapenv:Envelope>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,activityPending_list.ACTIVITY_ID,activityPending_list.ACTIVITY_ID,opportunity_list.OPTY_ID,stringDate];
        
        
    }
    else{
        
        
        envelopeText = [NSString stringWithFormat:
                        @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:con=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                        @"<soapenv:Header/>"
                        @"<soapenv:Body>"
                        @"<asi:SFATMCVContactInsertOrUpdate_Input>"
                        @"<con:ListOfContactInterface>"
                        @"<Contact>"
                        @"<Id>%@</Id>"
                        @"<ListOfOpportunity>"
                        @"<Opportunity>"
                        @"<Id>%@</Id>"
                        @"<ListOfOpportunityRelatedActivities>"
                        @"<OpportunityRelatedActivities>"
                        @"<ActivityUID>%@</ActivityUID>"
                        @"<TMIntegrationId>%@</TMIntegrationId>"
                        @"<OpportunityId>%@</OpportunityId>"
                        @"<ActivityStatus>Open</ActivityStatus>"
                        @"<NextPlannedDate/>"
                        @"<Mode>Visit</Mode>"
                        @"<ActivityType>Test Drive</ActivityType>"
                        @"<PlannedStart>%@</PlannedStart>"
                        @"<Comments>test activity</Comments>"
                        @"<PlannedEnd/>"
                        @"<ListOfActivitiesRelatedSalesRep>"
                        @"<ActivitiesRelatedSalesRep IsPrimaryMVG=\"N\">"
                        @"<Id>1-5DVL4B</Id>"
                        @"<Login>JJOSHI1001680</Login>"
                        @"</ActivitiesRelatedSalesRep>"
                        @"</ListOfActivitiesRelatedSalesRep>"
                        @"<Description2>1-5DVL4B</Description2>"
                        @"</OpportunityRelatedActivities>"
                        @"</ListOfOpportunityRelatedActivities>"
                        @"</Opportunity>"
                        @"</ListOfOpportunity>"
                        @"</Contact>"
                        @"</con:ListOfContactInterface>"
                        @"<!--Optional:-->"
                        @"<asi:StatusObject>?</asi:StatusObject>"
                        @"</asi:SFATMCVContactInsertOrUpdate_Input>"
                        @"</soapenv:Body>"
                        @"</soapenv:Envelope>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,activityPending_list.ACTIVITY_ID,activityPending_list.ACTIVITY_ID,opportunity_list.OPTY_ID,stringDate];
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityUpdateConnection"];
    
    
    
}
@end











