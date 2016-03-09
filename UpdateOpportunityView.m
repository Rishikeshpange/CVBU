//
//  UpdateOpportunityView.m
//  DSE
//
//  Created by Rishikesh on 13/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "UpdateOpportunityView.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "Search_OpportunityList_Var.h"
#import "MBProgressHUD.h"




@interface UpdateOpportunityView ()

@end

@implementation UpdateOpportunityView

- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
     self.opp_Contact_LOB_PickerArr=[[NSMutableArray alloc] init];
     self.PPL_List_PickerArr=[[NSMutableArray alloc] init];
     self.PL_List_PickerArr=[[NSMutableArray alloc] init];
    self.Application_List_PickerArr=[[NSMutableArray alloc] init];
    
    self.PPLTextField.enabled=NO;
    self.PLTextField.enabled=NO;
    self.ApplicationTextField.enabled=NO;
    
     self.PPLTextField.delegate=self;
    self.PLTextField.delegate=self;
    self.ApplicationTextField.delegate=self;
    self.LOBTextFiled.delegate=self;
    
   
    self.LOBTextFiled.layer.borderWidth= 2.0f;
    
    self.SAVEBTN.layer.cornerRadius=4;
    self.CANCELBTN.layer.cornerRadius=4;
    
//  self.PLTextField.text= [[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.optyrow] valueForKey:@"PRODUCT_NAME1"];
//    self.PPLTextField.text= [[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.optyrow] valueForKey:@"PPL"];
    
    
    _btnSave.enabled = NO;//Abhishek
    _btnSave.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1]; //Abhishek

    [self hideAlert];//Abhishek
    
    
    if ([appdelegate.fromManageOptyview isEqualToString:@"fromManageOptyview"])
    {
        NSLog(@"formmanageoptyview");
        if ([self.PLTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor darkGrayColor];
            self.PLTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"PRODUCT_NAME1"]] attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
            // TODO: Add fall-back code to set placeholder color.
        }
        if ([self.PPLTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor darkGrayColor];
            self.PPLTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"PRODUCT_NAME"]] attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
            // TODO: Add fall-back code to set placeholder color.
        }
        if ([self.LOBTextFiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor darkGrayColor];
            self.LOBTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  Select LOB" attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
            // TODO: Add fall-back code to set placeholder color.
        }
        if ([self.ApplicationTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor darkGrayColor];
            self.ApplicationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  Select Application Type" attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
            // TODO: Add fall-back code to set placeholder color.
        }

        
    }
    else if ([appdelegate.fromSearchOptyview isEqualToString:@"fromSearchOptyview"])
    {
        NSLog(@"fromSearchOptyview");
        if ([self.PLTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor darkGrayColor];
            self.PLTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME1"]] attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
            // TODO: Add fall-back code to set placeholder color.
        }
        if ([self.PPLTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor darkGrayColor];
            self.PPLTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME"]] attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
            // TODO: Add fall-back code to set placeholder color.
        }
        if ([self.LOBTextFiled respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor darkGrayColor];
            self.LOBTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  Select LOB" attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
            // TODO: Add fall-back code to set placeholder color.
        }
        if ([self.ApplicationTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor darkGrayColor];
            self.ApplicationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  Select Application Type" attributes:@{NSForegroundColorAttributeName: color}];
        } else {
            NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
            // TODO: Add fall-back code to set placeholder color.
        }

       
    }
       
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(210,3, 35, 35)];
    UIImage *btnImage = [UIImage imageNamed:@"dropdown1.png"];
    [searchButton setImage:btnImage forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(LOBListDropDown) forControlEvents:UIControlEventTouchUpInside];
    //searchButton.backgroundColor=[UIColor blackColor];
    [self.LOBTextFiled addSubview:searchButton];
    
    UIButton *PPLButton = [[UIButton alloc]initWithFrame:CGRectMake(210,3, 35, 39)];
    //UIImage *btnImage = [UIImage imageNamed:@"2X_textbox_icon_3.png"];
    [PPLButton setImage:btnImage forState:UIControlStateNormal];
    [PPLButton addTarget:self action:@selector(SelectPPLDropDown) forControlEvents:UIControlEventTouchUpInside];
   // PPLButton.backgroundColor=[UIColor blackColor];
    [self.PPLTextField addSubview:PPLButton];
    
    UIButton *PLButton = [[UIButton alloc]initWithFrame:CGRectMake(210,3, 35, 39)];
 //   UIImage *btnImage = [UIImage imageNamed:@"2X_textbox_icon_3.png"];
    [PLButton setImage:btnImage forState:UIControlStateNormal];
    [PLButton addTarget:self action:@selector(SelectPLDropDown) forControlEvents:UIControlEventTouchUpInside];
   // PLButton.backgroundColor=[UIColor blackColor];
    [self.PLTextField addSubview:PLButton];
    
    
    UIButton *ApplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(210,3, 35, 39)];
    //   UIImage *btnImage = [UIImage imageNamed:@"2X_textbox_icon_3.png"];
    [ApplicationButton setImage:btnImage forState:UIControlStateNormal];
    [ApplicationButton addTarget:self action:@selector(SelectApplicationDropDown) forControlEvents:UIControlEventTouchUpInside];
    //ApplicationButton.backgroundColor=[UIColor blackColor];
    [self.ApplicationTextField addSubview:ApplicationButton];

    
    [self LOBDropDownClicked];
    // Do any additional setup after loading the view.
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.LOBTextFiled)
    {
        // [textField resignFirstResponder];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, 5, 20)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        return NO;
    }
    if (textField == self.PPLTextField)
    {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, 5, 20)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        // [textField resignFirstResponder];
        return NO;
    }
    if (textField == self.PLTextField)
    {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, 5, 20)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        // [textField resignFirstResponder];
        return NO;
    }
    if (textField == self.ApplicationTextField)
    {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, 5, 20)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        // [textField resignFirstResponder];
        return NO;
    }
    return NO;
}

- (void)LOBListDropDown
{
    self.LOBTextFiled.text = @""; //abhishek
    self.PPLTextField.text = @""; //abhishek
    self.PLTextField.text = @""; //abhishek
    self.ApplicationTextField.text = @""; //abhishek

    self.LOBTextFiled.placeholder = nil; //Abhishek
    self.PPLTextField.placeholder = nil; //Abhishek
    self.PLTextField.placeholder = nil; //Abhishek
    self.ApplicationTextField.placeholder = nil; //Abhishek
    
    
    [self.LOBTextFiled resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    for (int i=0; i<[self.opp_Contact_LOB_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.opp_Contact_LOB_PickerArr objectAtIndex:i]];
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.LOBTextFiled frame] inView:self.view animated:YES];
    }
    
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 1000;
    
   // [self.appdelegate hideAlert];
    
  
}
- (void)SelectPPLDropDown
{
    self.PPLTextField.text = @""; //abhishek
    self.PLTextField.text = @""; //abhishek
    self.ApplicationTextField.text = @""; //abhishek
    
    
    self.PPLTextField.placeholder = nil; //Abhishek
    self.PLTextField.placeholder = nil; //Abhishek
    self.ApplicationTextField.placeholder = nil; //Abhishek
    
    
    
    [self.PPLTextField resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    for (int i=0; i<[self.PPL_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.PPL_List_PickerArr objectAtIndex:i]];
        
    }
    
    
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.PPLTextField frame] inView:self.view animated:YES];
    }
    
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 2000;
    
    
    
}
- (void)SelectPLDropDown
{
    //self.PPLTextField.text = @""; //abhishek
    self.PLTextField.text = @""; //abhishek
    self.ApplicationTextField.text = @""; //abhishek
    
    self.PLTextField.placeholder = nil; //Abhishek
    self.ApplicationTextField.placeholder = nil; //Abhishek
    

    
    
    [self.PLTextField resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    for (int i=0; i<[self.PL_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.PL_List_PickerArr objectAtIndex:i]];
        
    }
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.PLTextField frame] inView:self.view animated:YES];
    }
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 3000;
    
}
- (void)SelectApplicationDropDown
{
    
   // self.PPLTextField.text = @""; //abhishek
    //self.PLTextField.text = @""; //abhishek
    
    
    self.ApplicationTextField.text = @""; //abhishek
     self.ApplicationTextField.placeholder = nil; //Abhishek
    
    [self.ApplicationTextField resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    for (int i=0; i<[self.Application_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.Application_List_PickerArr objectAtIndex:i]];
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [actionSheet showFromRect:[self.ApplicationTextField frame] inView:self.view animated:YES];
    }
    else
    {
        [actionSheet showInView:self.view];
    }
    
    actionSheet.tag = 4000;
    
//    _btnSave.enabled = YES; //Abhishek
//    _btnSave.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1]; //Abhishek
    
    
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    return NO; //hide keyboard
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestLOBListFound:) name:@"LobListFound" object:nil];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestPPL_ListFound:) name:@"PPL_ListFound" object:nil];
//    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestPL_ListFound:) name:@"PL_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestApplication_ListFound:) name:@"Application_ListFound" object:nil];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetProductFound:) name:@"GetProduct_Notification_Found" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateOptyNotificationFound:) name:@"UpdateOpty_Notification_Found" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_District_ListFound:) name:@"District_ListFound" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_City_ListFound:) name:@"City_ListFound" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_PostalCode_ListFound:) name:@"Postal_code_ListFound" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_Taluka_ListFound:) name:@"Taluka_ListFound" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(contactlistfetchedAlert:) name:@"Contact_ListPopulated" object:nil];
//    [super viewWillAppear:animated];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"\nView Did Dissapears...!!!!");
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"LobListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PPL_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PL_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Application_ListFound" object:nil];
   [[NSNotificationCenter defaultCenter]removeObserver:self name:@"GetProduct_Notification_Found" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UpdateOpty_Notification_Found" object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"District_ListFound" object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"City_ListFound" object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Postal_code_ListFound" object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Taluka_ListFound" object:nil];
}
- (IBAction)SelectPPL:(UITextField *)sender
{
    
     [self.PPLTextField resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"PPL LIST"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    for (int i=0; i<[self.PPL_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.PPL_List_PickerArr objectAtIndex:i]];
        
    }
    
    
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.PPLTextField frame] inView:self.view animated:YES];
    }
    
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 2000;
    

    
}

- (IBAction)SelectPL:(UITextField *)sender
{
     [self.PLTextField resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"PL LIST"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    for (int i=0; i<[self.PL_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.PL_List_PickerArr objectAtIndex:i]];
        
    }
    
    
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.PLTextField frame] inView:self.view animated:YES];
    }
    
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 3000;

}
- (IBAction)Application:(UITextField *)sender
{
     [self.ApplicationTextField resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"APPLICATION LIST"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    for (int i=0; i<[self.Application_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.Application_List_PickerArr objectAtIndex:i]];
        
    }
    
    
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.ApplicationTextField frame] inView:self.view animated:YES];
    }
    
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 4000;




}

- (IBAction)SaveButton:(id)sender
{
    
    if ([self.LOBTextFiled.text isEqualToString:@""] ||
        [self.PLTextField.text isEqualToString:@""] ||
        [self.PPLTextField.text isEqualToString:@""]||
        [self.ApplicationTextField.text isEqualToString:@""])
    {
        NSLog(@"\n\n checking");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                                        message:@"Please select mandatory fields"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
        
    }

    else
    {
        [self showAlert];//Abhishek
//        appdelegate.PLUPDATED=self.plstring;
//        NSNotification *UpdatePLNotification=[NSNotification notificationWithName:@"UpdatePLValue" object:nil userInfo:nil];
//        [[NSNotificationQueue defaultQueue]enqueueNotification:UpdatePLNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
//     NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//    @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//    @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
//    @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
//    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
//    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
//    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
//    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
//    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
//    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e719-d95a1a869db9</DC>"
//    @"</Logger>"
//    @"</header>"
//    @"</SOAP:Header>"
//    @"<SOAP:Body>"
//    @"<GetProductfromPLDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//    @"<PLName>%@</PLName>"
//    @"</GetProductfromPLDSM>"
//    @"</SOAP:Body>"
//                                @"</SOAP:Envelope>",self.PLTextField.text];
        
        NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                   @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                                   @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e719-d95a1a869db9</DC>"
                                   @"</Logger>"
                                   @"</header>"
                                   @"</SOAP:Header>"
                                   @"<SOAP:Body>"
                                   @"<GetProductfromPLDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                   @"<PLName>%@</PLName>"
                                   @"</GetProductfromPLDSM>"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>",self.plstring];
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetProduct"];
        
    }
}
- (IBAction)CancelButton:(id)sender
{
    if ([appdelegate.fromCreatequote isEqualToString:@"fromCreatequote"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        NSNotification *ShowAlertViewNotification = [NSNotification notificationWithName:@"showAlert" object:nil userInfo:nil];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ShowAlertViewNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
       
    }
    else
    {
     [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)LOBDropDownClicked
{
    [self.LOBTextFiled resignFirstResponder];
    //[self.LOBTextFiled setText:sender.text];
    
    
    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
   @"<SOAP:Body>"
    @"<GetLOBForNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
    @"</SOAP:Body>"
                               @"</SOAP:Envelope>"];
    
    
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetLOB"];
    
}
-(void)requestLOBListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....DOne %@",response);
    
    if (self.opp_Contact_LOB_PickerArr)
    {
        
        [self.opp_Contact_LOB_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetLOBForNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
            NSString* Name = [TBXML textForElement:NAME];
            NSLog(@"NAME : %@",Name);
            [self.opp_Contact_LOB_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    
  
    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:@"LOB LIST"
//                                  delegate:self
//                                  cancelButtonTitle:nil
//                                  destructiveButtonTitle:nil
//                                  otherButtonTitles:nil];
//    
//    // Add buttons one by one (e.g. in a loop from array etc...)
//    for (int i=0; i<[self.opp_Contact_LOB_PickerArr count]; i++)
//    {
//        [actionSheet addButtonWithTitle:[self.opp_Contact_LOB_PickerArr objectAtIndex:i]];
//        
//    }
//    
//    
//    
//    
//    
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//    {
//        
//        [actionSheet showFromRect:[self.LOBTextFiled frame] inView:self.view animated:YES];
//    }
//    
//    
//    else
//    {
//        
//        [actionSheet showInView:self.view];
//        
//    }
//    
//    actionSheet.tag = 1000;
    
  //  [self.appdelegate hideAlert];
    
}
-(void)GetProductFound:(NSNotification*)notification
{
    [self hideAlert];//Abhishek
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
//    if (self.opp_Contact_LOB_PickerArr)
//    {
//        
//        [self.opp_Contact_LOB_PickerArr removeAllObjects];
//        
//    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetProductfromPLDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *PRODUCT = [TBXML childElementNamed:@"PRODUCT" parentElement:S_PROD_LN];
             TBXMLElement *PRODUCT_ID = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:S_PROD_LN];
            NSString* PRODUCTstring = [TBXML textForElement:PRODUCT];
            NSString* PRODUCT_IDstring = [TBXML textForElement:PRODUCT_ID];
            NSLog(@"PRODUCTstring : %@",PRODUCTstring);
             NSLog(@"PRODUCT_IDstring : %@",PRODUCT_IDstring);
            self.ProductString=PRODUCTstring;
            self.PRODUCT_IDstring=PRODUCT_IDstring;
          // [self.Product_Arr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
//    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                               @"<SOAP:Body>"
//                               @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
//                               @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
//                               @"<Opportunity operation=\"update\">"
//                               @"<Id>%@</Id>"
//                               @"<TMLOB>%@</TMLOB>"
//                               @"<ParentProductLine>%@</ParentProductLine>"
//                               @"<ProductLine>%@</ProductLine>"
//                               @"<IntendedApplication>%@</IntendedApplication>"
//                               @"<ListOfOpportunityRelatedProducts>"
//                               @"<OpportunityRelatedProducts operation=\"update\">"
//                               @"<Product>%@</Product>"
//                               @"<Id>%@</Id>"
//                               @"<ProductQuantity>1</ProductQuantity>"
//                               @"<ParentProductLine>%@</ParentProductLine>"
//                               @"<ProductLine>%@</ProductLine>"
//                               @"<OpptyId>%@</OpptyId>"
//                               @"</OpportunityRelatedProducts>"
//                               @"</ListOfOpportunityRelatedProducts>"
//                               @"</Opportunity>"
//                               @"</ListOfTMOpportunityInterface>"
//                               @"</SFATMCVOPTYInsertOrUpdate_Input>"
//                               @"</SOAP:Body>"
//                               @"</SOAP:Envelope>",self.PRODUCT_IDstring,self.LOBTextFiled.text,self.PPLTextField.text,self.PLTextField.text,self.ApplicationTextField.text,self.ProductString,self.PRODUCT_IDstring,self.PPLTextField.text,self.PLTextField.text,[[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.optyrow] valueForKey:@"OPTY_ID"] ];
   // NSLog(@"%@",appdelegate.opty_idDetailPage);
//    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                               @"<SOAP:Body>"
//                               @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
//                               @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
//                               @"<Opportunity operation=\"update\">"
//                               @"<Id>%@</Id>"
//                               @"<TMLOB>%@</TMLOB>"
//                               @"<ParentProductLine>%@</ParentProductLine>"
//                               @"<ProductLine>%@</ProductLine>"
//                               @"<IntendedApplication>%@</IntendedApplication>"
//                               @"<ListOfOpportunityRelatedProducts>"
//                               @"<OpportunityRelatedProducts operation=\"update\">"
//                               @"<Product>%@</Product>"
//                               @"<Id>%@</Id>"
//                               @"<ProductQuantity>1</ProductQuantity>"
//                               @"<ParentProductLine>%@</ParentProductLine>"
//                               @"<ProductLine>%@</ProductLine>"
//                               @"<OpptyId>%@</OpptyId>"
//                               @"</OpportunityRelatedProducts>"
//                               @"</ListOfOpportunityRelatedProducts>"
//                               @"</Opportunity>"
//                               @"</ListOfTMOpportunityInterface>"
//                               @"</SFATMCVOPTYInsertOrUpdate_Input>"
//                               @"</SOAP:Body>"
//                               @"</SOAP:Envelope>",appdelegate.opty_idDetailPage,self.LOBTextFiled.text,self.PPLTextField.text,self.PLTextField.text,self.ApplicationTextField.text,self.ProductString,self.PRODUCT_IDstring,self.PPLTextField.text,self.PLTextField.text,appdelegate.opty_idDetailPage ];
    
    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                               @"<Opportunity operation=\"update\">"
                               @"<Id>%@</Id>"
                               @"<TMLOB>%@</TMLOB>"
                               @"<ParentProductLine>%@</ParentProductLine>"
                               @"<ProductLine>%@</ProductLine>"
                               @"<IntendedApplication>%@</IntendedApplication>"
                               @"<ListOfOpportunityRelatedProducts>"
                               @"<OpportunityRelatedProducts operation=\"update\">"
                               @"<Product>%@</Product>"
                               @"<Id>%@</Id>"
                               @"<ProductQuantity>1</ProductQuantity>"
                               @"<ParentProductLine>%@</ParentProductLine>"
                               @"<ProductLine>%@</ProductLine>"
                               @"<OpptyId>%@</OpptyId>"
                               @"</OpportunityRelatedProducts>"
                               @"</ListOfOpportunityRelatedProducts>"
                               @"</Opportunity>"
                               @"</ListOfTMOpportunityInterface>"
                               @"</SFATMCVOPTYInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",appdelegate.opty_idDetailPage,self.lobstring,self.pplstring,self.plstring,self.applicationstring,self.ProductString,self.PRODUCT_IDstring,self.pplstring,self.plstring,appdelegate.opty_idDetailPage ];

    
    
    
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"UpdateOpty"];
    
    //    UIActionSheet *actionSheet = [[UIActionSheet alloc]
    //                                  initWithTitle:@"LOB LIST"
    //                                  delegate:self
    //                                  cancelButtonTitle:nil
    //                                  destructiveButtonTitle:nil
    //                                  otherButtonTitles:nil];
    //
    //    // Add buttons one by one (e.g. in a loop from array etc...)
    //    for (int i=0; i<[self.opp_Contact_LOB_PickerArr count]; i++)
    //    {
    //        [actionSheet addButtonWithTitle:[self.opp_Contact_LOB_PickerArr objectAtIndex:i]];
    //
    //    }
    //
    //
    //
    //
    //
    //
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    //    {
    //
    //        [actionSheet showFromRect:[self.LOBTextFiled frame] inView:self.view animated:YES];
    //    }
    //
    //
    //    else
    //    {
    //
    //        [actionSheet showInView:self.view];
    //        
    //    }
    //    
    //    actionSheet.tag = 1000;
    //    
    //    [self.appdelegate hideAlert];
    //    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 if (alertView.tag==20)
 {
     [self dismissViewControllerAnimated:YES completion:nil];
     if ([appdelegate.fromCreatequote isEqualToString:@"fromCreatequote"])
     {
         
         NSNotification *ShowAlertViewNotification = [NSNotification notificationWithName:@"showAlert" object:nil userInfo:nil];
         [[NSNotificationQueue defaultQueue]enqueueNotification:ShowAlertViewNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
         
     }
     else
     {
    
     }
 }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1000) {
        if (buttonIndex<0)
        {
            
        }
       else
       {
        NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
           self.lobstring=title;
        self.LOBTextFiled.text=[NSString stringWithFormat:@"  %@",title];
        self.PPLTextField.layer.borderWidth= 2.0f;
        
        self.PPLTextField.enabled=YES;
        
        NSString * envelopeText = [NSString stringWithFormat:
                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Body>"
                                   @"<GetPPLFromLOB xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                   @"<LOB>%@</LOB>"
                                   @"</GetPPLFromLOB>"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>",title];
        
        
        
        
        
        
        NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
        NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
        NSLog(@"URL IS .... %@",theurl);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
        NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
        [[RequestDelegate alloc]initiateRequest:request name:@"GetPPL_List"];
        NSLog(@"%@",title);
       }
    }
    else if (actionSheet.tag==2000)
    {
        
               if (buttonIndex<0)
        {
            
        }
        else
        {
        NSString *ppl = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.pplstring=ppl;
        self.PLTextField.enabled=YES;
        self.PLTextField.layer.borderWidth= 2.0f;
       
        self.PPLTextField.text=[NSString stringWithFormat:@"  %@",ppl];;
       
//        
//        NSString * envelopeText = [NSString stringWithFormat:
//                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                                   @"<SOAP:Body>"
//                                   @"<GetPLFromPPL xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//                                   @"<PPL_Name>%@</PPL_Name>"
//                                   @"<LOB>%@</LOB>"
//                                   @"</GetPLFromPPL>"
//                                   @"</SOAP:Body>"
//                                   @"</SOAP:Envelope>",ppl,self.LOBTextFiled.text];
        
            NSString * envelopeText = [NSString stringWithFormat:
                                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetPLFromPPL xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<PPL_Name>%@</PPL_Name>"
                                       @"<LOB>%@</LOB>"
                                       @"</GetPLFromPPL>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",self.pplstring,self.lobstring];
        
        
        
        NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
        NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
        NSLog(@"URL IS .... %@",theurl);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
        NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
        [[RequestDelegate alloc]initiateRequest:request name:@"GetPL_List"];
        }
        
    }
    else if (actionSheet.tag==3000)
    {
//        
                       if (buttonIndex<0)
        {
            
        }
        else
        {

        NSString *PL = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.plstring=PL;
        self.ApplicationTextField.enabled=YES;
        self.PLTextField.text=[NSString stringWithFormat:@"  %@",PL];;
         self.ApplicationTextField.layer.borderWidth= 2.0f;
//        
//        //
//        NSString * envelopeText = [NSString stringWithFormat:
//                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                                   @"<SOAP:Body>"
//                                   @"<GetTMCVIndentApps xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//                                   @"<lob>%@</lob>"
//                                   @"</GetTMCVIndentApps>"
//                                   @"</SOAP:Body>"
//                                   @"</SOAP:Envelope>",self.LOBTextFiled.text];
            
            NSString * envelopeText = [NSString stringWithFormat:
                                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetTMCVIndentApps xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<lob>%@</lob>"
                                       @"</GetTMCVIndentApps>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",self.lobstring];

        
        NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
        NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
        NSLog(@"URL IS .... %@",theurl);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
        NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
        [[RequestDelegate alloc]initiateRequest:request name:@"GetApplication_List"];
        }
//
//        NSLog(@"%@",PL);
    }
    else if (actionSheet.tag==4000)
    {
//        
        if (buttonIndex<0)
        {
            
        }
        else
        {

        NSString *Application = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.applicationstring=Application;
        self.ApplicationTextField.text=[NSString stringWithFormat:@"  %@",Application];
            _btnSave.enabled = YES; //Abhishek
            _btnSave.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1]; //Abhishek
        }
//
//     //   NSLog(@"%@",self.APPLICATION.text);
//    }
//    else if (actionSheet.tag==5000)
//    {
//        
//        
//        NSString *Application = [actionSheet buttonTitleAtIndex:buttonIndex];
////        self.APPLICATION.text=Application;
//    }
//    else if (actionSheet.tag==6000)
//    {
//        NSString *SOURCEOFCONTACT = [actionSheet buttonTitleAtIndex:buttonIndex];
////        self.SOURCEOFCONTACT.text=SOURCEOFCONTACT;
//        NSLog(@"%@",SOURCEOFCONTACT);
//    }
//    else if (actionSheet.tag==7000)
//    {
//        
    
       // NSString *FINANCIER = [actionSheet buttonTitleAtIndex:buttonIndex];
//        self.FINANCIER.text=FINANCIER;
//        NSLog(@"%@",self.FINANCIER.text);
    }
  }
-(void)requestPPL_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.PPL_List_PickerArr)
    {
        
        [self.PPL_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetPPLFromLOBResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
            NSString* Name = [TBXML textForElement:NAME];
            NSLog(@"PPLIST FOR LOB : %@",Name);
            
            
            [self.PPL_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    NSLog(@"%d",[self.PPL_List_PickerArr count]);
    
    
    
}

-(void)requestPL_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.PL_List_PickerArr)
    {
        
        [self.PL_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetPLFromPPLResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"s_prod_int" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *NAME = [TBXML childElementNamed:@"PL" parentElement:S_PROD_LN];
            NSString* Name = [TBXML textForElement:NAME];
            NSLog(@"PLIST FOR PPL : %@",Name);
            
            
            [self.PL_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    NSLog(@"%d",[self.PL_List_PickerArr count]);
    
    
}
-(void)requestApplication_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.Application_List_PickerArr)
    {
        
        [self.Application_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVIndentAppsResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
            NSString* Name = [TBXML textForElement:NAME];
            NSLog(@"Application_LIST FOR PPL : %@",Name);
            
            
            [self.Application_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    NSLog(@"%d",[self.Application_List_PickerArr count]);
    
    
}

-(void)UpdateOptyNotificationFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }

    else{
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *ListOfTMOpportunityInterface =[TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:container];
     TBXMLElement *Opportunity =[TBXML childElementNamed:@"Opportunity" parentElement:ListOfTMOpportunityInterface];
    
    TBXMLElement *Opportunity_Id =[TBXML childElementNamed:@"Id" parentElement:Opportunity];
    TBXMLElement *IntegrationId =[TBXML childElementNamed:@"IntegrationId" parentElement:Opportunity];
    
    NSString* Opportunity_Id_string = [TBXML textForElement:Opportunity_Id];
    NSString* IntegrationId_string = [TBXML textForElement:IntegrationId];
    
    if (!IntegrationId_string )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Opportunity Failed To Update" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if(IntegrationId_string)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Opportunity Updated Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertView.tag=20;
        [alertView show];
        NSLog(@"%@",self.PPLTextField.text);
       // appdelegate.PPL=self.PPLTextField.text;
        appdelegate.PPL=self.PLTextField.text;
       // appdelegate.accountPhoneNumber= self.Phone_Number_txt_field.text;
        
        appdelegate.PLUPDATED=self.plstring;
        NSNotification *UpdatePLNotification=[NSNotification notificationWithName:@"UpdatePLValue" object:nil userInfo:nil];
        [[NSNotificationQueue defaultQueue]enqueueNotification:UpdatePLNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
        NSNotification *UpdateOppurtunityValues = [NSNotification notificationWithName:@"UpdateOpportunityValues" object:nil userInfo:nil];
        [[NSNotificationQueue defaultQueue]enqueueNotification:UpdateOppurtunityValues postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    
    }
    }
}

- (IBAction)Save:(id)sender
{
     NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Body>"
    @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
    @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
    @"<Opportunity operation=\"update\">"
    @"<Id></Id>"//opty id
    @"<TMLOB></TMLOB>"//lob
    @"<ParentProductLine></ParentProductLine>"//ppl
    @"<ProductLine></ProductLine>"//pl
    @"<IntendedApplication></IntendedApplication>"
    @"<ListOfOpportunityRelatedProducts>"
    @"<OpportunityRelatedProducts operation=\"update\">"
    @"<Product></Product>"//get from request
    @"<Id></Id>"
    @"<ProductQuantity></ProductQuantity>"
    @"<ParentProductLine></ParentProductLine>"
    @"<ProductLine></ProductLine>"
    @"<OpptyId></OpptyId>"
    @"</OpportunityRelatedProducts>"
    @"</ListOfOpportunityRelatedProducts>"
    @"</Opportunity>"
    @"</ListOfTMOpportunityInterface>"
    @"</SFATMCVOPTYInsertOrUpdate_Input>"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>"];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



//Abhishek
-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


@end
