//
//  CreateQuoteViewViewController.m
//  DSE
//
//  Created by Rishikesh on 08/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "CreateQuoteViewViewController.h"
#import "UserDetails_Var.h"
#import "AppDelegate.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "Opportunity_List.h"
//#import "UICustomAlertView.h"
#import "MBProgressHUD.h"


@interface CreateQuoteViewViewController ()

@end

@implementation CreateQuoteViewViewController
@synthesize showStates;

- (void)viewDidLoad
{
    [super viewDidLoad];
    userDetailsVal_ = [UserDetails_Var sharedmanager];
    NSLog(@"%@",userDetailsVal_.ROW_ID);
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    UIButton *state = [UIButton buttonWithType:UIButtonTypeCustom];
    state.frame=CGRectMake(266, 2, 37, 37);
    [state setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [state addTarget:self action:@selector(getStates) forControlEvents:UIControlEventTouchUpInside];
    [self.state_txt_field addSubview:state];
    self.state_txt_field.delegate=self;
    self.Account_Name_txt_field.delegate=self;
    self.Location_txt_field.delegate=self;
    self.Phone_Number_txt_field.delegate=self;
    
    [self.Phone_Number_txt_field addTarget:self action:@selector(textFieldDidChange: ) forControlEvents:UIControlEventEditingChanged]; //Abhishek // For phone number validation
    
    self.SAVEBTN.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1];
    
    self.SAVEBTN.enabled=NO;
    self.SAVEBTN.layer.cornerRadius=4;
    self.CANCELBTN.layer.cornerRadius=4;
    //    for (UIWindow* window in [UIApplication sharedApplication].windows){
    //        for (UIView *subView in [window subviews]){
    //            if ([subView isKindOfClass:[UIAlertView class]]) {
    //                NSLog(@"has AlertView");
    //            }else {
    //                NSLog(@"No AlertView");
    //            }
    //        }
    //    }
    showStates=[[NSMutableArray alloc] initWithObjects:@"Andaman & Nicobar",@"Andhra Pradesh",@"Arunachal Pradesh",@"Assam",@"Bihar",@"Chattishgarh",@"Chennai",@"Daman & Diu",@"Delhi",@"Dadra, Nagarhaveli",@"Goa",@"Gujarat",@"Himachal Pradesh",@"Haryana",@"Jharkhand",@"Jammu & Kashmir",@"Karnataka",@"Kerala",@"Lakshwadeep",@"Maharashtra",@"Meghalaya",@"Manipur",@"Madhya Pradesh",@"Mizoram",@"Nagaland",@"Orrisa",@"Punjab",@"Pondicherry",@"Rajasthan",@"Sikkim",@"Telangana",@"Tamil Nadu",@"Tripura",@"Uttarkhand",@"Uttar Pradesh",@"West Bengal",nil];
    
    [self  getAddressID];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"\n View Will Appear.....");
    
    // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"artifactFound" object:nil];
    //  [[NSNotificationCenter defaultCenter]removeObserver:self name:@"artifactFailed" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AddressIDFound:) name:@"adressID_Found" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ContactSavedFound:) name:@"ContactSave_Found" object:nil];
    
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"\nView Did Dissapears...!!!!");
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"adressID_Found" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ContactSave_Found" object:nil];
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.Phone_Number_txt_field)
    {
       // [textField resignFirstResponder];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, 5, 20)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        return YES;
    }
    if (textField == self.Account_Name_txt_field)
    {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, 5, 20)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        // [textField resignFirstResponder];
        return YES;
    }
    if (textField == self.Location_txt_field)
    {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, 5, 20)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        // [textField resignFirstResponder];
        return YES;
    }
    return 0;
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", self.Phone_Number_txt_field.text);
    
    NSUInteger testLen = [self length:self.Phone_Number_txt_field.text];
    NSLog(@"\n\n testLen .... %d",testLen);
    
    if (theTextField == self.Phone_Number_txt_field)
    {
        NSUInteger testLen = [self length:self.Phone_Number_txt_field.text];
        if (testLen ==10)
        {
            self.SAVEBTN.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1];
            self.SAVEBTN.enabled=YES;
        }
    
    
    }
    
//    if (testLen >10) {
//        
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid Cell Number " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alertView show];
//        self.Phone_Number_txt_field.text = @"";
//    }
}


//Checking String Length

-(NSUInteger)length :(NSString *)inputString
{
    NSUInteger length = [inputString length];
    return length;
}


-(void)getStates
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"STATE LIST"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    for (int i=0; i<[showStates count]; i++)
    {
        [actionSheet addButtonWithTitle:[showStates objectAtIndex:i]];
        
    }
    
    
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.state_txt_field frame] inView:self.view animated:YES];
    }
    
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 1000;
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1000)
    {
        if (buttonIndex<0)
        {
            
        }
        else
        {
            
            NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
            
            self.state_txt_field.text=title;
            
        }
        
    }
}
-(void)getAddressID
{
    
    /*  NSString * envelopeText1 = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\">"
     @"<soapenv:Header/>"
     @"<soapenv:Body>"
     @"<asi:SFATMCVContactQueryById_Input>"
     @"<asi:PrimaryRowId>%@</asi:PrimaryRowId>"
     @"</asi:SFATMCVContactQueryById_Input>"
     @"</soapenv:Body>"
     @"</soapenv:Envelope>",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_ID"]];*/
    
    NSString * envelopeText1 = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\">"
                                @"<soapenv:Header/>"
                                @"<soapenv:Body>"
                                @"<asi:SFATMCVContactQueryById_Input>"
                                @"<asi:PrimaryRowId>%@</asi:PrimaryRowId>"
                                @"</asi:SFATMCVContactQueryById_Input>"
                                @"</soapenv:Body>"
                                @"</soapenv:Envelope>",opportunity_list.CONTACT_ID];
    
    
    
    NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    NSLog(@"REQUEST IS %@",envelopeText1);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText1 length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"adressIDRequest"];
    
}
-(void)AddressIDFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response = [[notification userInfo]objectForKey:@"response"];
    NSLog(@"userdetail :%@",response);
    
     TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Something has gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
    
    
    TBXMLElement *soapBody = [TBXML childElementNamed:@"soapenv:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVContactQueryById_Output" parentElement:soapBody];
    if(container)
    {
        TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];
        TBXMLElement *Contact =[TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];
        if(Contact)
        {
            //container = [TBXML childElementNamed:@"S_USER" parentElement:[TBXML childElementNamed:@"old" parentElement:Contact]];
            TBXMLElement *ListOfPersonalAddress = [TBXML childElementNamed:@"ListOfPersonalAddress" parentElement:Contact];
            TBXMLElement *PersonalAddress = [TBXML childElementNamed:@"PersonalAddress" parentElement:ListOfPersonalAddress];
            NSString * IsPrimaryMVG=[TBXML valueOfAttributeNamed:@"IsPrimaryMVG" forElement:PersonalAddress];
            if ([IsPrimaryMVG isEqualToString:@"Y"])
            {
                TBXMLElement *AddressId = [TBXML childElementNamed:@"AddressId" parentElement:PersonalAddress];
                NSString * PersonalAddressSTRING = [TBXML textForElement:AddressId];
                self.Address_Id=PersonalAddressSTRING;
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"No address Id found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            
        }
        else
        {
            // [appdelegate hideAlert];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
    else
    {
        // [appdelegate hideAlert];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SaveButton:(id)sender
{
    NSUInteger testLen = [self length:self.Phone_Number_txt_field.text];
   
    
    
    
    if ([self.Account_Name_txt_field.text isEqualToString:@""]   ||
        [self.Location_txt_field.text isEqualToString:@""] ||
        [self.Phone_Number_txt_field.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"DSE" message:@"Please Enter Mandatory Fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (testLen != 10)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"DSE" message:@"Please enter 10 digit cell number that doesn't start with '0'" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        self.Phone_Number_txt_field.text = @"";
    }
    else
    {
        
        //    NSString * envelopeText1 = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:acc=\"http://www.siebel.com/xml/Account%%20Interface\">"
        //    @"<soapenv:Header/>"
        //    @"<soapenv:Body><asi:SFATMCVAccountInsertOrUpdate_Input><ListOfAccountInterface><Account operation=\"?\">"
        //    @"<IntegrationId>%ld</IntegrationId>"
        //    @"<Location>%@</Location>"
        //    @"<MainPhoneNumber>%@</MainPhoneNumber>"
        //    @"<Name>%@</Name>"
        //    @"<ListOfBusinessAddress>"
        //    @"<BusinessAddress IsPrimaryMVG=\"Y\" operation=\"?\">"
        //    @"<AddressId>%@</AddressId>"
        //    @"</BusinessAddress></ListOfBusinessAddress><ListOfRelatedContact>"
        //    @"<RelatedContact IsPrimaryMVG=\"Y\" operation =\"?\">"
        //    @"<ContactId>%@</ContactId>"
        //    @"</RelatedContact>"
        //    @"</ListOfRelatedContact>"
        //    @"<ListOfRelatedSalesRep>"
        //    @"<RelatedSalesRep IsPrimaryMVG=\"Y\">"
        //    @"<Position>%%@</Position>"
        //    @"<PositionId>%@</PositionId>"
        //    @"</RelatedSalesRep>"
        //    @"</ListOfRelatedSalesRep>"
        //    @"<ListOfRelatedOrganization>"
        //    @"<RelatedOrganization IsPrimaryMVG=\"Y\">"
        //    @"<Organization>%@</Organization>"
        //    @"</RelatedOrganization>"
        //    @"</ListOfRelatedOrganization>"
        //    @"</Account>"
        //    @"</ListOfAccountInterface>"
        //    @"<asi:StatusObject>?</asi:StatusObject>"
        //    @"</asi:SFATMCVAccountInsertOrUpdate_Input>"
        //    @"</soapenv:Body>"
        //    @"</soapenv:Envelope>",(long)[[NSDate date]timeIntervalSince1970],
        //                                self.Location_txt_field.text,
        //                                self.Phone_Number_txt_field.text,
        //                                self.Account_Name_txt_field.text,
        //                                self.Address_Id,
        //                                [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_ID"],
        //                                userDetailsVal_.POSTN,
        //                                userDetailsVal_.ROW_ID,
        //                                userDetailsVal_.ORGNAME,nil];
        
        
        
        
        
        [self showAlert];//Abhishek
        
        NSLog(@"%@",opportunity_list.CUSTOMER_ACCOUNT_ID);
        //    NSString * envelopeText1 = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:acc=\"http://www.siebel.com/xml/Account%%20Interface\">"
        //                                @"<soapenv:Header/>"
        //                                @"<soapenv:Body><asi:SFATMCVAccountInsertOrUpdate_Input><ListOfAccountInterface><Account operation=\"?\">"
        //                                @"<Id>%@</Id>"
        //                                @"<IntegrationId>%ld</IntegrationId>"
        //                                @"<Location>%@</Location>"
        //                                @"<MainPhoneNumber>%@</MainPhoneNumber>"
        //                                @"<Name>%@</Name>"
        //                                @"<ListOfBusinessAddress>"
        //                                @"<BusinessAddress IsPrimaryMVG=\"Y\" operation=\"?\">"
        //                                @"<AddressId>%@</AddressId>"
        //                                @"</BusinessAddress></ListOfBusinessAddress><ListOfRelatedContact>"
        //                                @"<RelatedContact IsPrimaryMVG=\"Y\" operation =\"?\">"
        //                                @"<ContactId>%@</ContactId>"
        //                                @"</RelatedContact>"
        //                                @"</ListOfRelatedContact>"
        //                                @"<ListOfRelatedSalesRep>"
        //                                @"<RelatedSalesRep IsPrimaryMVG=\"Y\">"
        //                                @"<Position>%@</Position>"
        //                                @"<PositionId>%@</PositionId>"
        //                                @"</RelatedSalesRep>"
        //                                @"</ListOfRelatedSalesRep>"
        //                                @"<ListOfRelatedOrganization>"
        //                                @"<RelatedOrganization IsPrimaryMVG=\"Y\">"
        //                                @"<Organization>%@</Organization>"
        //                                @"</RelatedOrganization>"
        //                                @"</ListOfRelatedOrganization>"
        //                                @"</Account>"
        //                                @"</ListOfAccountInterface>"
        //                                @"<asi:StatusObject>?</asi:StatusObject>"
        //                                @"</asi:SFATMCVAccountInsertOrUpdate_Input>"
        //                                @"</soapenv:Body>"
        //                                @"</soapenv:Envelope>",appdelegate.CUSTOMER_ACCOUNT_ID,
        //                                (long)[[NSDate date]timeIntervalSince1970],
        //                                self.Location_txt_field.text,
        //                                self.Phone_Number_txt_field.text,
        //                                self.Account_Name_txt_field.text,
        //                                self.Address_Id,
        //                                appdelegate.CONTACT_ID,userDetailsVal_.POSITION_NAME,userDetailsVal_.ROW_ID,
        //                                userDetailsVal_.ORGNAME,nil];
        //    NSLog(@"%@",appdelegate.CUSTOMER_ACCOUNT_ID);
        NSString * envelopeText1 = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:acc=\"http://www.siebel.com/xml/Account%%20Interface\">"
                                    @"<soapenv:Header/>"
                                    @"<soapenv:Body><asi:SFATMCVAccountInsertOrUpdate_Input><ListOfAccountInterface><Account operation=\"?\">"
                                    @"<AccountId>%@</AccountId>"
                                    @"<IntegrationId></IntegrationId>"
                                    @"<Location>%@</Location>"
                                    @"<MainPhoneNumber>%@</MainPhoneNumber>"
                                    @"<Name>%@</Name>"
                                    @"<ListOfBusinessAddress>"
                                    @"<BusinessAddress IsPrimaryMVG=\"Y\" operation=\"?\">"
                                    @"<AddressId>%@</AddressId>"
                                    @"</BusinessAddress></ListOfBusinessAddress><ListOfRelatedContact>"
                                    @"<RelatedContact IsPrimaryMVG=\"Y\" operation =\"?\">"
                                    @"<ContactId>%@</ContactId>"
                                    @"</RelatedContact>"
                                    @"</ListOfRelatedContact>"
                                    @"<ListOfRelatedSalesRep>"
                                    @"<RelatedSalesRep IsPrimaryMVG=\"Y\">"
                                    @"<Position>%@</Position>"
                                    @"<PositionId>%@</PositionId>"
                                    @"</RelatedSalesRep>"
                                    @"</ListOfRelatedSalesRep>"
                                    @"<ListOfRelatedOrganization>"
                                    @"<RelatedOrganization IsPrimaryMVG=\"Y\">"
                                    @"<Organization>%@</Organization>"
                                    @"</RelatedOrganization>"
                                    @"</ListOfRelatedOrganization>"
                                    @"</Account>"
                                    @"</ListOfAccountInterface>"
                                    @"<asi:StatusObject>?</asi:StatusObject>"
                                    @"</asi:SFATMCVAccountInsertOrUpdate_Input>"
                                    @"</soapenv:Body>"
                                    @"</soapenv:Envelope>",opportunity_list.CUSTOMER_ACCOUNT_ID,
                                    self.Location_txt_field.text,
                                    self.Phone_Number_txt_field.text,
                                    self.Account_Name_txt_field.text,
                                    self.Address_Id,
                                    opportunity_list.CONTACT_ID,userDetailsVal_.POSITION_NAME,userDetailsVal_.ROW_ID,
                                    userDetailsVal_.ORGNAME,nil];
        //
        
        NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
        // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
        NSLog(@"URL IS %@",theurl);
        NSLog(@"REQUEST IS %@",envelopeText1);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
        
        NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText1 length]];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
        
        [[RequestDelegate alloc]initiateRequest:request name:@"ContactSaveRequest"];
    }
}
-(void)ContactSavedFound:(NSNotification*)notification
{
    [self hideAlert];//Abhishek
    NSError *err;
    NSString *response = [[notification userInfo]objectForKey:@"response"];
    NSLog(@"userdetail :%@",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        
        TBXMLElement *soapBody = [TBXML childElementNamed:@"soapenv:Body" parentElement:tbxml.rootXMLElement];
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVAccountInsertOrUpdate_Output" parentElement:soapBody];
        if(container)
        {
            TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfAccountInterface" parentElement:container];
            TBXMLElement *Account =[TBXML childElementNamed:@"Account" parentElement:ListOfContactInterface];
            if(Account)
            {
                
                TBXMLElement *Account = [TBXML childElementNamed:@"Account" parentElement:ListOfContactInterface];
                NSString * IsPrimaryMVG=[TBXML valueOfAttributeNamed:@"operation" forElement:Account];
                if ([IsPrimaryMVG isEqualToString:@"update"] || [IsPrimaryMVG isEqualToString:@"insert"])
                {
                    TBXMLElement *AccountId = [TBXML childElementNamed:@"AccountId" parentElement:Account];
                    NSString * AccountIdstring = [TBXML textForElement:AccountId];
                    if (AccountIdstring)
                    {
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Account Updated Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        alert.tag=20;
                        [alert show];
                        [self hideAlert];
                        //appdelegate.accountName=self.Account_Name_txt_field.text;
                        //appdelegate.accountPhoneNumber= self.Phone_Number_txt_field.text;
                        NSNotification *UpdateValuesNotification = [NSNotification notificationWithName:@"UpdateAccountValues" object:nil userInfo:nil];
                        [[NSNotificationQueue defaultQueue]enqueueNotification:UpdateValuesNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
                        
                    }
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Account not updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
                
            }
            else
            {
                // [appdelegate hideAlert];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }
        else
        {
            // [appdelegate hideAlert];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    
    if (alertView.tag==20)
    {
        if (buttonIndex == 0)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (alertView.tag==20)
    {
        if (buttonIndex == 0)
        {
            NSNotification *ShowAlertViewNotification = [NSNotification notificationWithName:@"showAlert" object:nil userInfo:nil];
            [[NSNotificationQueue defaultQueue]enqueueNotification:ShowAlertViewNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
            
        }
    }
    
    
    
}

- (IBAction)CancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSNotification *ShowAlertViewNotification = [NSNotification notificationWithName:@"showAlert" object:nil userInfo:nil];
    [[NSNotificationQueue defaultQueue]enqueueNotification:ShowAlertViewNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    
    
    
}



//Abhishek
-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
    
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
