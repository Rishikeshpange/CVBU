//
//  ActivityViewController.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/13/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "ActivityViewController.h"
#import "Opportunity_List.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "AppDelegate.h"
#import "UserDetails_Var.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "LoginViewController.h"
#import "ManageOpportunityViewController.h"
#import "OpportunitySearchResultController.h"
@interface ActivityViewController ()
{
    UIActionSheet *actionSheet;
    UIDatePicker *datePicker;
    UIAlertView *alert;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive,hostActive;
    NSString *stringFromDate;
    NSString *stringFromDate1;
    int flag,flagActivity;
    
    NSString *fire;
    NSString *integrationIdvalue;
    NSString * envelopeText4;
    
    
    
}
@end
@implementation ActivityViewController

@synthesize activityType_PickerArr,activityCreate_Arr,optyid;
@synthesize txt_Selectdate,txt_SelectTime,txtDisc,textfieldType;

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
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        userDetailsVal_ = [UserDetails_Var sharedmanager];
        
        // Radious for text Fileds .
        self.txtDisc.layer.borderWidth=2.0f;
        self.txt_Selectdate.layer.borderWidth=2.0f;
        self.txt_SelectTime.layer.borderWidth=2.0f;
        self.textfieldType.layer.borderWidth=2.0f;
        
        
        self.txt_Selectdate.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_SelectTime.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.textfieldType.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txtDisc.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        
        
        activityType_PickerArr=[[NSMutableArray alloc] init];
        activityCreate_Arr=[[NSMutableArray alloc] init];
        
        NSLog(@"opty ID %@",opportunity_list.OPTY_ID);
        [self textFiledText];
        //[self CallActivity_Type];
    }else{
        //[self textFiledText];
        
        
        
        
        appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        userDetailsVal_ = [UserDetails_Var sharedmanager];
        
        
        
        // Radious for text Fileds .
        self.txtDisc.layer.borderWidth=2.0f;
        self.txt_Selectdate.layer.borderWidth=2.0f;
        self.txt_SelectTime.layer.borderWidth=2.0f;
        self.textfieldType.layer.borderWidth=2.0f;
        
        
        self.btn_Save.layer.cornerRadius=4;
        self.btn_Cancel.layer.cornerRadius=4;
        self.btn_Save.layer.masksToBounds=YES;
        self.btn_Cancel.layer.masksToBounds=YES;
        
        
        
        self.txt_Selectdate.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txt_SelectTime.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.textfieldType.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        self.txtDisc.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
        
        activityType_PickerArr=[[NSMutableArray alloc] init];
        activityCreate_Arr=[[NSMutableArray alloc] init];
        
        
        
        if ([appdelegate.optyflow isEqualToString:@"fromcreateopty"])
        {
            
            
            
            
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Mandatory to create activity " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
            
            self.navigationItem.hidesBackButton = YES;
            
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            
            
            
            
            
        }
        else
        {
            
            
            optyid=opportunity_list.OPTY_ID;
            _contactID=opportunity_list.CONTACT_ID;
            
            NSLog(@"%@,%@",optyid,_contactID);
            self.navigationItem.backBarButtonItem = nil;
            
        }
        
        
        
        
        
        
        
        NSLog(@"opty ID %@",opportunity_list.OPTY_ID);
        [self textFiledText];
        [self CallActivity_Type];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityType_Found:) name:@"ActivityType_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityCreate_Found:) name:@"ActivityCreate_Found" object:nil];
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityType_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityCreate_Found" object:nil];
    
    
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
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                [activityType_PickerArr addObject:str_NAME];
                
                
                
            }while ((tuple2 = tuple2->nextSibling));
            NSLog(@"Activty Type: %@",activityType_PickerArr);
            //[self hideAlert];
        }
    }
}
- (IBAction)btnActivityType:(id)sender {
    
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
    }else{
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
            
            [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.activity_typeview animated:YES];
            actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
        }
        else{
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 1;
    }
}
- (IBAction)btnDate:(id)sender {
    
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
    [formatter setDateFormat:@"MM/dd/yyyy"];
    //[formatter setDateFormat:@"MM/dd/yyyy"];
    
    [datePicker setMinimumDate: [NSDate date]];
    
    stringFromDate1 = [formatter stringFromDate:date];
    NSLog(@"Date..Set  From : : %@",stringFromDate1);
    txt_Selectdate.text=stringFromDate1;
    
    
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
    [formatter setDateFormat:@"MM/dd/yyyy"];
    //[formatter setDateFormat:@"MM/dd/yyyy"];
    stringFromDate1 = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  From : : %@",stringFromDate1);
    txt_Selectdate.text=stringFromDate1;
}

- (IBAction)btn_TIme:(id)sender {
    
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
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //[formatter setDateFormat:@"MM/dd/yyyy"];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dateStringExtra = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateStringExtra);
    
    if([dateStringExtra isEqual:stringFromDate1])
    {
        [datePicker setMinimumDate: [NSDate date]];
        
    }
    //[datePicker setMinimumDate: [NSDate date]];
    [datePicker setLocale:[NSLocale systemLocale]];
    //NSLog(@"New Date: %@", sender.date);
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@" HH:mm:ss"];
    stringFromDate = [formatter stringFromDate:date];
    //[dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
    NSLog(@"Date..Set  To: : %@",stringFromDate);
    txt_SelectTime.text=stringFromDate;
    
    
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
                    self.textfieldType.text = NSLocalizedString([activityType_PickerArr objectAtIndex:buttonIndex],@"");
                    
                }
        }
    }
}
- (void)changeDate_:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@" HH:mm:ss"];
    NSString *stringFromDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  To: : %@",stringFromDate);
    txt_SelectTime.text=stringFromDate;
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

- (IBAction)saveactivityBtn:(id)sender {
    
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
        if([txtDisc.text isEqualToString:@"Description"])
        {
            txtDisc.text=@"";
        }
        if(![textfieldType.text isEqualToString:@""] && ![txt_Selectdate.text isEqualToString:@""] && ![txt_SelectTime.text isEqualToString:@""] &&![txtDisc.text isEqualToString:@""])
        {
            [self showAlert];
            [self callCreateActivity];
            
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


-(void)callCreateActivity{
    
    fire =@"first";
    
    
    
    
    
    integrationIdvalue= [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
    
    
    NSLog(@"Login name..%@",userDetailsVal_.Login_Name);
    
    
    stringFromDate1 = [stringFromDate1 stringByAppendingString:@""];
    stringFromDate1 = [stringFromDate1 stringByAppendingString:stringFromDate];
    NSLog(@"Log Date Vakues: %@",stringFromDate1);
    
    if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
        
        NSString * envelopeText2 = [NSString stringWithFormat:
                                    @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                    @"<SOAP:Body>"
                                    @"<SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                    @"<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TM%%20Action%%20Interface\">"
                                    @"<Action>"
                                    @"<Type>%@</Type>"
                                    @"<PlannedStart>%@</PlannedStart>"
                                    @"<OpportunityId>%@</OpportunityId>"
                                    @"<Employees>%@</Employees>"
                                    @"<Owner>%@</Owner>"
                                    @"<IntegrationId>%ld</IntegrationId>"
                                    @"<Description>%@</Description>"
                                    @"</Action>"
                                    @"</ListOfTmActionInterface>"
                                    @"</SFATMCVInsertOrUpdate_Input>"
                                    @"</SOAP:Body>"
                                    @"</SOAP:Envelope>",textfieldType.text,stringFromDate1,optyid,userDetailsVal_.Login_Name,userDetailsVal_.Login_Name,(long)[[NSDate date]timeIntervalSince1970],txtDisc.text];
        
        
        
        NSString * envelopeText = [NSString stringWithFormat:
                                   @"<SiebelContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                   @"<SiebelContactInsertOrUpdate_Input>"
                                   @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                   @"<Contact>"
                                   @"<Id>%@</Id>"   //contact id
                                   @"<ListOfOpportunity>"
                                   @"<Opportunity>"
                                   @"<Id>%@</Id>"   //opportunity id
                                   @"<ListOfOpportunityRelatedActivities>"
                                   @"<OpportunityRelatedActivities>"
                                   @"<ActivityUID>%ld</ActivityUID>" //integration id
                                   @"<OpportunityId>%@</OpportunityId>" //opportunity id
                                   @"<ActivityStatus>Open</ActivityStatus>"
                                   @"<NextPlannedDate />"
                                   @"<Mode>Visit</Mode>"
                                   @"<ActivityType>%@</ActivityType>"
                                   @"<PlannedStart>%@</PlannedStart>"//planned desc tag
                                   @"<Comments>Hi</Comments>"
                                   @"<PlannedEnd />"
                                   @"<ListOfActivitiesRelatedSalesRep>"
                                   @"<ActivitiesRelatedSalesRep IsPrimaryMVG=\"N\">"
                                   @"<Id>%@</Id>"   //employee id
                                   @"<Login>%@</Login>" //sarita k
                                   @"</ActivitiesRelatedSalesRep>"
                                   @"</ListOfActivitiesRelatedSalesRep>"
                                   @"<Description2>%@</Description2>" //employee id
                                   @"</OpportunityRelatedActivities>"
                                   @"</ListOfOpportunityRelatedActivities>"
                                   @"</Opportunity>"
                                   @"</ListOfOpportunity>"
                                   @"</Contact>"
                                   @"</ListOfContactInterface>"
                                   @"</SiebelContactInsertOrUpdate_Input>"
                                   @"</SiebelContactInsertOrUpdate_Input>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,(long)[[NSDate date]timeIntervalSince1970],opportunity_list.OPTY_ID,textfieldType.text,stringFromDate1,userDetailsVal_.ROW_ID,userDetailsVal_.Login_Name,userDetailsVal_.ROW_ID];
        
        
        
        
        envelopeText4 = [NSString stringWithFormat:
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
                         @"</soapenv:Envelope>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,integrationIdvalue,integrationIdvalue,opportunity_list.OPTY_ID,stringFromDate1];
        
    }
    else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
        
        
        NSString * envelopeText2 = [NSString stringWithFormat:
                                    @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                    @"<SOAP:Body>"
                                    @"<SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                    @"<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TM%%20Action%%20Interface\">"
                                    @"<Action>"
                                    @"<Type>%@</Type>"
                                    @"<PlannedStart>%@</PlannedStart>"
                                    @"<OpportunityId>%@</OpportunityId>"
                                    @"<Employees>%@</Employees>"
                                    @"<Owner>%@</Owner>"
                                    @"<IntegrationId>%ld</IntegrationId>"
                                    @"<Description>%@</Description>"
                                    @"</Action>"
                                    @"</ListOfTmActionInterface>"
                                    @"</SFATMCVInsertOrUpdate_Input>"
                                    @"</SOAP:Body>"
                                    @"</SOAP:Envelope>",textfieldType.text,stringFromDate1,optyid,userDetailsVal_.Login_Name,userDetailsVal_.Login_Name,(long)[[NSDate date]timeIntervalSince1970],txtDisc.text];
        
        
        
        NSString * envelopeText = [NSString stringWithFormat:
                                   @"<SiebelContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                   @"<SiebelContactInsertOrUpdate_Input>"
                                   @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                   @"<Contact>"
                                   @"<Id>%@</Id>"   //contact id
                                   @"<ListOfOpportunity>"
                                   @"<Opportunity>"
                                   @"<Id>%@</Id>"   //opportunity id
                                   @"<ListOfOpportunityRelatedActivities>"
                                   @"<OpportunityRelatedActivities>"
                                   @"<ActivityUID>%ld</ActivityUID>" //integration id
                                   @"<OpportunityId>%@</OpportunityId>" //opportunity id
                                   @"<ActivityStatus>Open</ActivityStatus>"
                                   @"<NextPlannedDate />"
                                   @"<Mode>Visit</Mode>"
                                   @"<ActivityType>%@</ActivityType>"
                                   @"<PlannedStart>%@</PlannedStart>"//planned desc tag
                                   @"<Comments>Hi</Comments>"
                                   @"<PlannedEnd />"
                                   @"<ListOfActivitiesRelatedSalesRep>"
                                   @"<ActivitiesRelatedSalesRep IsPrimaryMVG=\"N\">"
                                   @"<Id>%@</Id>"   //employee id
                                   @"<Login>%@</Login>" //sarita k
                                   @"</ActivitiesRelatedSalesRep>"
                                   @"</ListOfActivitiesRelatedSalesRep>"
                                   @"<Description2>%@</Description2>" //employee id
                                   @"</OpportunityRelatedActivities>"
                                   @"</ListOfOpportunityRelatedActivities>"
                                   @"</Opportunity>"
                                   @"</ListOfOpportunity>"
                                   @"</Contact>"
                                   @"</ListOfContactInterface>"
                                   @"</SiebelContactInsertOrUpdate_Input>"
                                   @"</SiebelContactInsertOrUpdate_Input>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,(long)[[NSDate date]timeIntervalSince1970],opportunity_list.OPTY_ID,textfieldType.text,stringFromDate1,userDetailsVal_.ROW_ID,userDetailsVal_.Login_Name,userDetailsVal_.ROW_ID];
        
        
        
        
        envelopeText4 = [NSString stringWithFormat:
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
                         @"<Id>1-50E9AE</Id>"
                         @"<Login>SAMSONJ1001680</Login>"
                         @"</ActivitiesRelatedSalesRep>"
                         @"</ListOfActivitiesRelatedSalesRep>"
                         @"<Description2>1-50E9AE</Description2>"
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
                         @"</soapenv:Envelope>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,integrationIdvalue,integrationIdvalue,opportunity_list.OPTY_ID,stringFromDate1];
        
        
        
        
        
        
        
    }
    
    else{
        
        
        NSString * envelopeText2 = [NSString stringWithFormat:
                                    @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                    @"<SOAP:Body>"
                                    @"<SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                    @"<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TM%%20Action%%20Interface\">"
                                    @"<Action>"
                                    @"<Type>%@</Type>"
                                    @"<PlannedStart>%@</PlannedStart>"
                                    @"<OpportunityId>%@</OpportunityId>"
                                    @"<Employees>%@</Employees>"
                                    @"<Owner>%@</Owner>"
                                    @"<IntegrationId>%ld</IntegrationId>"
                                    @"<Description>%@</Description>"
                                    @"</Action>"
                                    @"</ListOfTmActionInterface>"
                                    @"</SFATMCVInsertOrUpdate_Input>"
                                    @"</SOAP:Body>"
                                    @"</SOAP:Envelope>",textfieldType.text,stringFromDate1,optyid,userDetailsVal_.Login_Name,userDetailsVal_.Login_Name,(long)[[NSDate date]timeIntervalSince1970],txtDisc.text];
        
        
        
        NSString * envelopeText = [NSString stringWithFormat:
                                   @"<SiebelContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                   @"<SiebelContactInsertOrUpdate_Input>"
                                   @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                   @"<Contact>"
                                   @"<Id>%@</Id>"   //contact id
                                   @"<ListOfOpportunity>"
                                   @"<Opportunity>"
                                   @"<Id>%@</Id>"   //opportunity id
                                   @"<ListOfOpportunityRelatedActivities>"
                                   @"<OpportunityRelatedActivities>"
                                   @"<ActivityUID>%ld</ActivityUID>" //integration id
                                   @"<OpportunityId>%@</OpportunityId>" //opportunity id
                                   @"<ActivityStatus>Open</ActivityStatus>"
                                   @"<NextPlannedDate />"
                                   @"<Mode>Visit</Mode>"
                                   @"<ActivityType>%@</ActivityType>"
                                   @"<PlannedStart>%@</PlannedStart>"//planned desc tag
                                   @"<Comments>Hi</Comments>"
                                   @"<PlannedEnd />"
                                   @"<ListOfActivitiesRelatedSalesRep>"
                                   @"<ActivitiesRelatedSalesRep IsPrimaryMVG=\"N\">"
                                   @"<Id>%@</Id>"   //employee id
                                   @"<Login>%@</Login>" //sarita k
                                   @"</ActivitiesRelatedSalesRep>"
                                   @"</ListOfActivitiesRelatedSalesRep>"
                                   @"<Description2>%@</Description2>" //employee id
                                   @"</OpportunityRelatedActivities>"
                                   @"</ListOfOpportunityRelatedActivities>"
                                   @"</Opportunity>"
                                   @"</ListOfOpportunity>"
                                   @"</Contact>"
                                   @"</ListOfContactInterface>"
                                   @"</SiebelContactInsertOrUpdate_Input>"
                                   @"</SiebelContactInsertOrUpdate_Input>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,(long)[[NSDate date]timeIntervalSince1970],opportunity_list.OPTY_ID,textfieldType.text,stringFromDate1,userDetailsVal_.ROW_ID,userDetailsVal_.Login_Name,userDetailsVal_.ROW_ID];
        
        
        
        
        envelopeText4 = [NSString stringWithFormat:
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
                         @"</soapenv:Envelope>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,integrationIdvalue,integrationIdvalue,opportunity_list.OPTY_ID,stringFromDate1];
        
        
        
    }
    
    
    NSLog(@"\n create Activity request!!!!%@",envelopeText4);
    NSData *envelope = [envelopeText4 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText4 length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"ActivityCreateConnection"];
}


//ActivityCreate_Found

-(void)ActivityCreate_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityCREATE_Found response... %@ ",response);
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if([response isEqual:@""]){
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"NEEV" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
            [self hideAlert];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message :@"Activity creation failed.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else{
        
        
        
        
        
        
        
        
        
        
        
        
        TBXMLElement *container = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:[TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"soapenv:Body" parentElement:tbxml.rootXMLElement]]];
        
        TBXMLElement *Opportunity = [TBXML childElementNamed:@"Contact" parentElement:container];
        
        if (Opportunity)
        {
            [self hideAlert];
            flag=1;
            
            TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
            
            NSString   *newactivity = [TBXML textForElement:Id];
            NSLog(@"\nListOfContactInterface.....!!!!!%@",newactivity);
            
            if ([fire isEqual:@"first"]) {
                
                [self callactivityagain];
                
            }
            else{
                
                
                
                if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
                    
                    alert=[[UIAlertView alloc]initWithTitle:@"NEEV" message:@"Activity created successfully! Do you want to create more activities?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
                    [alert show];
                }else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
                    
                    alert=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"Activity created successfully! Do you want to create more activities?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
                    [alert show];
                }else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
                    
                    alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Activity created successfully! Do you want to create more activities?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
                    [alert show];
                }
                
                
                
                
            }
            
            
            
            
        }else
        {
            [self hideAlert];
            if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
                alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Activity creation failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
                alert=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"Activity creation failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else if([userDetailsVal_.POSTN isEqual:@"DSE"]){
                alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Activity creation failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
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
    
    
    self.textfieldType.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Activity Type" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_Selectdate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Date" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txt_SelectTime.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Time" attributes:@{NSForegroundColorAttributeName:color}];
    
    // self.txt_Description.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Description" attributes:@{NSForegroundColorAttributeName:color}];
    
    // txt_Description.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    
    
    //  self.txtDescription.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type" attributes:@{NSForegroundColorAttributeName:color}];
    
}

-(void) textViewDidChange:(UITextView *)textView
{
    NSLog(@"Inside uitext");
    if(txtDisc.text.length == 0){
        txtDisc.textColor = [UIColor lightGrayColor];
        txtDisc.text = @"Description";
        [txtDisc resignFirstResponder];
    }
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"Inside uitext1");
    
    txtDisc.text = @"";
    txtDisc.textColor = [UIColor blackColor];
    return YES;
}

-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
    
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        
        NSLog(@"David Miller");
        NSLog(@"Activity created ..");
        if(flag==1)
        {
            NSLog(@"Appdeledate Values:%d",appdelegate.flagget);
            if (appdelegate.flagget==1) {
                for (UIViewController *controller in self.navigationController.viewControllers)
                {
                    if ([controller isKindOfClass:[OpportunitySearchResultController class]])
                    {
                        NSLog(@"Final");
                        
                        [self.navigationController popToViewController:controller
                                                              animated:YES];
                        break;
                    }
                }
            }else
            {
                NSLog(@"MAnage Opty Activity");
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
        else
        {
            NSLog(@"Not Created..");
            
        }
    }
    if (buttonIndex==1) {
        NSLog(@"Glen Maxwell");
        
        if(flag==1)
        {
            txt_Selectdate.text=@"";
            txt_SelectTime.text=@"";
            textfieldType.text=@"";
            txtDisc.text=@"";
        }else
        {
            LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            //[self.navigationController pushViewController:secondViewController animated:YES];
            [self presentViewController:secondViewController animated:YES completion:nil ];
            //  [self.navigationController popToRootViewControllerAnimated:TRUE];
            // [self dismissViewControllerAnimated:YES completion:nil];
            //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
            //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}



-(void)callactivityagain{
    
    
    
    
    
    
    
    fire =@"second";
    
    if([userDetailsVal_.POSTN isEqual:@"NDRM"]){
        
        
        
        envelopeText4 = [NSString stringWithFormat:
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
                         @"</soapenv:Envelope>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,integrationIdvalue,integrationIdvalue,opportunity_list.OPTY_ID,stringFromDate1];
        
    }
    
    else if([userDetailsVal_.POSTN isEqual:@"DSM"]){
        
        
        
        envelopeText4 = [NSString stringWithFormat:
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
                         @"<Id>1-50E9AE</Id>"
                         @"<Login>SAMSONJ1001680</Login>"
                         @"</ActivitiesRelatedSalesRep>"
                         @"</ListOfActivitiesRelatedSalesRep>"
                         @"<Description2>1-50E9AE</Description2>"
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
                         @"</soapenv:Envelope>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,integrationIdvalue,integrationIdvalue,opportunity_list.OPTY_ID,stringFromDate1];
        
        
        
    }
    else{
        
        
        
        envelopeText4 = [NSString stringWithFormat:
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
                         @"</soapenv:Envelope>",opportunity_list.CONTACT_ID,opportunity_list.OPTY_ID,integrationIdvalue,integrationIdvalue,opportunity_list.OPTY_ID,stringFromDate1];
        
        
        
        
    }
    
    
    
    
    
    
    NSLog(@"\n create Activity request!!!!%@",envelopeText4);
    NSData *envelope = [envelopeText4 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText4 length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"ActivityCreateConnection"];
    
    
    
    
    
}
@end
