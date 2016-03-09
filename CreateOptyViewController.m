//
//  CreateOptyViewController.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 9/29/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "ActivityViewController.h"
#import "ContactsList.h"
#import "CreateOptyViewController.h"
#import "DetailViewController.h"
#import "LobViewController.h"
#import "MBProgressHUD.h"
#import "PPLViewController.h"
#import "Reachability.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "createoptydata.h"

#import "MLPAutoCompleteTextField.h"
#import "DEMOCustomAutoCompleteCell.h"
#import "DEMOCustomAutoCompleteObject.h"
#import "DEMODataSource.h"
#import "MLPAutoCompleteTextFieldDataSource.h"
#import "MLPAutoCompleteTextFieldDelegate.h"


@interface CreateOptyViewController () {

    UIAlertView *alert, *alert1;
    NSString *optyContactstatus, *str;
    UIActionSheet* actionSheet;
    NSMutableArray *Financier_List_PickerArr, *Source_Contact_List_PickerArr;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
    NSMutableArray* showStates;
    NSString* Opptystatus;
    int flag;
    NSString* OPTY_ID_;
    NSString* PRODUCT_ID_;
    NSString* PRODUCT_;

    NSString* emailRegEx;
    NSPredicate* emailTest;

    NSPredicate* mobileNumberPred;
    NSString* mobileNumberPattern;
    NSString* CONTACT_ID;
    NSString *ContactID, *_strAccount, *Wintgration, *Waddressid, *Wcontactid, *WpersonalName;
    
}
@end

@implementation CreateOptyViewController

@synthesize GetAllstates_Arr, GetAlldistricts_Arr, GetAllcities_Arr, GetAlltaluka_Arr, Getbodytype_Arr, Financier_List_PickerArr, GetPL_LOBPPL_Arr, GetAppType_Arr, pickerData, Getusagecatagory_Arr, Micromarket_Arr;
@synthesize btn_AddressClick, btn_Contactclick, btn_Optyclick;
@synthesize txt_lob, txt_ppl, txt_PL, txt_financier, txt_application, txt_sourceOfcontact;

@synthesize getallpincodeArr;//Abhishek
@synthesize txtProductQuantity; //Product Quantity


- (void)viewDidLoad
{

    [super viewDidLoad];

    //***abhishek
    txt_application.delegate = self; //abhishek
    txt_financier.delegate = self;
    txt_lob.delegate = self;
    txt_PL.delegate = self;
    txt_ppl.delegate = self;
    txt_sourceOfcontact.delegate = self;
    txtProductQuantity.delegate = self;
    _txt_addressLine1.delegate = self;
    _txt_Taluka.delegate = self;
    _txtBodytype.delegate = self;
    _txtCustomerType.delegate = self;
    _txtFleetSize.delegate = self;
    _txtGetUsagedetails.delegate = self;
    _txtMMgeography.delegate = self;
    _txtPanchayat.delegate = self;
    _txtPincode.delegate = self;
    _txt_addressLine2.delegate = self;
    _txt_area.delegate = self;
    _txt_City.delegate = self;
    _txt_District.delegate = self;
    //_txt_state.delegate = self;
    _txt_Taluka.delegate = self;
    _txt_emailId.delegate = self;
    _txt_firstname.delegate = self;
    _txt_lastName.delegate = self;
    _txt_phonenumber.delegate = self;
    
    _txt_state.tag = 1;
    
    _pannooutlet.delegate = self;
  
    
    //*************
    
    
    
    
    
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    NSLog(@"Samlp Art Master: %@", appdelegate.artifact);
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"Samlp Art Master: %@", userDetailsVal_.ROW_ID);

    NSLog(@"%@,%@,%@,%@", userDetailsVal_.POSTN, userDetailsVal_.POSITION_NAME, userDetailsVal_.ROW_ID, userDetailsVal_.ORGNAME);

    emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];

    mobileNumberPattern = @"[789][0-9]{9}";
    mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];

    [_existingoutlet setEnabled:YES];
    [_newcontactoutlet setEnabled:YES];

    self.newcontactoutlet.backgroundColor = [UIColor colorWithRed:(55.0 / 255.0) green:(128.0 / 255.0) blue:(255.0 / 255.0) alpha:1];

    self.existingoutlet.backgroundColor = [UIColor colorWithRed:(170.0 / 255.0) green:(170.0 / 255.0) blue:(170.0 / 255.0) alpha:1];

    Opptystatus = @"Createoptyfornewcontact";

    NSLog(@"contactr ID %@", optyData.ID);

    //[self createoptyexistingContact];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
    self.splitViewController.delegate = self;
    self.masterPopoverController.delegate = self;
    
    UIBarButtonItem* barButtonItem = self.splitViewController.displayModeButtonItem;
    barButtonItem.title = @"Show master";
    self.navigationItem.leftBarButtonItem = barButtonItem;

    GetAppType_Arr = [[NSMutableArray alloc] init];
    GetPL_LOBPPL_Arr = [[NSMutableArray alloc] init];
    GetAllstates_Arr = [[NSMutableArray alloc] init];
    GetAlldistricts_Arr = [[NSMutableArray alloc] init];
    GetAllcities_Arr = [[NSMutableArray alloc] init];
    GetAlltaluka_Arr = [[NSMutableArray alloc] init];
    Financier_List_PickerArr = [[NSMutableArray alloc] init];
    Source_Contact_List_PickerArr = [[NSMutableArray alloc] init];
    Getusagecatagory_Arr = [[NSMutableArray alloc] init];
    Getbodytype_Arr = [[NSMutableArray alloc] init];

    Micromarket_Arr = [[NSMutableArray alloc] init];
    //Micromarket_Arr
    
    getallpincodeArr = [[NSMutableArray alloc]init];

    _createOptyview.hidden = YES;
    _addressView.hidden = YES;
    _Contact_View.hidden = NO;

    optyContactstatus = @"test";

    btn_AddressClick.layer.cornerRadius = 3.0;
    btn_Contactclick.layer.cornerRadius = 3.0;
    btn_Optyclick.layer.cornerRadius = 3.0;

    [self call_List_Of_Fianacer];

    [self statelist];

    pickerData = [[NSMutableArray alloc] initWithObjects:@"SELF", @"Showroom Walk-in", @"Event", @"Referral", @"Others", nil];

    showStates = [[NSMutableArray alloc] initWithObjects:@"Andaman & Nicobar", @"Andhra Pradesh", @"Arunachal Pradesh", @"Assam", @"Bihar", @"Chattishgarh", @"Chennai", @"Daman & Diu", @"Delhi", @"Dadra, Nagarhaveli", @"Goa", @"Gujarat", @"Himachal Pradesh", @"Haryana", @"Jharkhand", @"Jammu & Kashmir", @"Karnataka", @"Kerala", @"Lakshwadeep", @"Maharashtra", @"Meghalaya", @"Manipur", @"Madhya Pradesh", @"Mizoram", @"Nagaland", @"Orrisa", @"Punjab", @"Pondicherry", @"Rajasthan", @"Sikkim", @"Telangana", @"Tamil Nadu", @"Tripura", @"Uttarkhand", @"Uttar Pradesh", @"West Bengal", nil];

    //
    //        alert = [[UIAlertView alloc] initWithTitle:@"Create Opportunity"
    //                                           message:@"Create opportunity for existing contact ?"
    //                                          delegate:self
    //                                 cancelButtonTitle:@"Yes"
    //                                 otherButtonTitles:@"No", nil];
    //        [alert setTag:1];
    //        [alert show];
    //
    
    

   // [self performSegueWithIdentifier:@"pplView" sender:nil]; // Abhishek
    
    [self.autocompleteTextField setAutoCompleteTableAppearsAsKeyboardAccessory:NO]; // For Auto Complete
    
    [self.autocompleteTextField setBorderStyle:UITextBorderStyleRoundedRect];
    
    
    //This is only supported in iOS 6.0, in iOS 5.0 you can set a custom NIB for the cell
    if ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending) {
        [self.autocompleteTextField registerAutoCompleteCellClass:[DEMOCustomAutoCompleteCell class]
                                           forCellReuseIdentifier:@"CustomCellId"];
    }
    else{
        //Turn off bold effects on iOS 5.0 as they are not supported and will result in an exception
        self.autocompleteTextField.applyBoldEffectToAutoCompleteSuggestions = NO;
    }

    [self MMGeography];
}

//Abhishek



#pragma mark - MLPAutoCompleteTextField Delegate


- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
    //{
    //    //This is your chance to customize an autocomplete tableview cell before it appears in the autocomplete tableview
    //    NSString *filename = [autocompleteString stringByAppendingString:@".png"];
    //    filename = [filename stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    //    filename = [filename stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
    //    [cell.imageView setImage:[UIImage imageNamed:filename]];
    //
    //    return YES;
    //}
    
    return YES;
    
}




- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(selectedObject)
    {
        NSLog(@"selected object from autocomplete menu %@ with string %@", selectedObject, [selectedObject autocompleteString]);
    }
    else
    {
        if (textField.tag == 1) {
            
            NSString* envelopeText = [NSString stringWithFormat:
                                  @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                  @"<SOAP:Body>"
                                  @"<GetAllIndianDistricts xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                  @"<state>%@</state>"
                                  @"</GetAllIndianDistricts>"
                                  @"</SOAP:Body>"
                                  @"</SOAP:Envelope>",str];
        
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
        
            [[RequestDelegate alloc] initiateRequest:request name:@"AllDistricts"];
            
        }
        
    }
    
}




// Abhishek // textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



-(BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSRange backspaceEndRange = NSMakeRange(0, 1);
    
    if (NSEqualRanges(range, backspaceEndRange)){
        NSLog(@"finished writing");
    }
    return YES;
}







- (void)viewWillAppear:(BOOL)animated
{

  

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Createoptyfornewcontact_found:) name:@"Createoptyfornewcontact_found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Allstates_Found:) name:@"Allstates_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllDistrict_Found:) name:@"AllDistrict_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Allcities_Found:) name:@"Allcities_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Alltaluka_Found:) name:@"Alltaluka_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Finance_Data_Found:) name:@"Finance_Data_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PLUpdateOpty_Found:) name:@"PLUpdateOpty_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppType_Data_Found:) name:@"AppType_Data_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UsageCategory_Found:) name:@"UsageCategory_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BodyTypeDSMData_Found:) name:@"BodyTypeDSMData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ListofActiveMicroMarketDSMData_Found:) name:@"ListofActiveMicroMarketDSMData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PL_ProductID_RequestData_Found:) name:@"PL_ProductID_RequestData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CreateoptyforexistingContactData_Found:) name:@"CreateoptyforexistingContactData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ContactSelection_found:) name:@"showAlert" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contactqueryfound:) name:@"contactqueryfound" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prospectupdatefound:) name:@"prospectupdatefound" object:nil];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PincodeConnectioninCreateOptyVCFound:) name:@"PincodeConnectioninCreateOptyVCFound" object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Createoptyfornewcontact_found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Allstates_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllDistrict_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Allcities_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Allcities_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Alltaluka_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Finance_Data_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PLUpdateOpty_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AppType_Data_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UsageCategory_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BodyTypeDSMData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ListofActiveMicroMarketDSMData_Found" object:nil];

   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PL_ProductID_RequestData_Found" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CreateoptyforexistingContactData_Found" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"contactqueryfound" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"prospectupdatefound" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PincodeConnectioninCreateOptyVCFound" object:nil];
    
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)contact:(id)sender
{

    _createOptyview.hidden = YES;
    _addressView.hidden = YES;
    _Contact_View.hidden = NO;
}

- (IBAction)address:(id)sender
{

    _createOptyview.hidden = YES;
    _addressView.hidden = NO;
    _Contact_View.hidden = YES;
}

- (IBAction)opportunity:(id)sender
{

    _createOptyview.hidden = NO;
    _addressView.hidden = YES;
    _Contact_View.hidden = YES;
}

- (IBAction)contactArrowBtn:(id)sender
{

    _createOptyview.hidden = YES;
    _addressView.hidden = NO;
    _Contact_View.hidden = YES;
}

- (IBAction)addressarrowBtn:(id)sender
{

    _createOptyview.hidden = NO;
    _addressView.hidden = YES;
    _Contact_View.hidden = YES;
}

- (IBAction)addressarrowBackwordBtn:(id)sender
{

    _createOptyview.hidden = YES;
    _addressView.hidden = YES;
    _Contact_View.hidden = NO;
}

- (IBAction)optyarrowbackwordbtn:(id)sender
{

    _createOptyview.hidden = NO;
    _addressView.hidden = NO;
    _Contact_View.hidden = YES;
}

- (IBAction)existingcontact:(id)sender
{

    [self performSegueWithIdentifier:@"searchContact" sender:nil];

    [_existingoutlet setEnabled:NO];
    [_newcontactoutlet setEnabled:NO];

    self.existingoutlet.backgroundColor = [UIColor colorWithRed:(55.0 / 255.0) green:(128.0 / 255.0) blue:(255.0 / 255.0) alpha:1];

    self.newcontactoutlet.backgroundColor = [UIColor colorWithRed:(170.0 / 255.0) green:(170.0 / 255.0) blue:(170.0 / 255.0) alpha:1];
}

- (IBAction)NewContact:(id)sender
{

    optyContactstatus = @"ExistingContact";

    [_existingoutlet setEnabled:NO];
    [_newcontactoutlet setEnabled:NO];

    self.newcontactoutlet.backgroundColor = [UIColor colorWithRed:(55.0 / 255.0) green:(128.0 / 255.0) blue:(255.0 / 255.0) alpha:1];

    self.existingoutlet.backgroundColor = [UIColor colorWithRed:(170.0 / 255.0) green:(170.0 / 255.0) blue:(170.0 / 255.0) alpha:1];
    NSLog(@"status %@", optyContactstatus);
}
- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld", (long)buttonIndex);

    if (alertView.tag == 1) {

        if (buttonIndex == 0) {
        }
        if (buttonIndex == 1) {
        }
    }

    else if (alertView.tag == 100) {

        appdelegate.optyflow = @"fromcreateopty";

        //            ActivityViewController * searchOpportunityResult_VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateActivity"];
        //            [self.navigationController pushViewController:searchOpportunityResult_VC1 animated:YES];
        //            searchOpportunityResult_VC1.optyid=OPTY_ID_;
        //          searchOpportunityResult_VC1.contactID=CONTACT_ID;
    }

    else if (alertView.tag == 0) {
    }

    else {
    }
}

- (IBAction)btnactionCreateOpty:(id)sender
{

    [self showAlert];

    if ([Opptystatus isEqualToString:@"Createoptyforexistingcontact"]) {

        [self createoptyexistingContact];
    }
    else {

        [self optyCreationforNewcontact];
    }
}


- (void)optyCreationforNewcontact
{
    
    if([self isNumeric:_txtFleetSize.text])
    {
        // b"date is valid;
        [_txtFleetSize resignFirstResponder];
        
    }
    else
    {
        // b"date is not valid;
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Alert" message :@"Fleet Size Should Be Nuemeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
        _txtFleetSize.text = @"";
        [_txtFleetSize resignFirstResponder];
        [self hideAlert];
        return;
    }
    
    
    
    if([self isNumeric:txtProductQuantity.text])
    {
        // b"date is valid;
        [txtProductQuantity resignFirstResponder];
        
    }
    else
    {
        // b"date is not valid;
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Alert" message :@"Product Quantity Should Be Nuemeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
        txtProductQuantity.text = @"";
        [txtProductQuantity resignFirstResponder];
        [self hideAlert];
        return;
    }
    
    
    
    
    
    if ([_txt_firstname.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter first name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    
    
    else if ([_txt_lastName.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter last name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([_txt_phonenumber.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter phone number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if (_txt_phonenumber.text && _txt_phonenumber.text.length < 10) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid CELL NUMBER" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([mobileNumberPred evaluateWithObject:_txt_phonenumber.text] != YES && [_txt_phonenumber.text length] != 0) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid CELL NUMBER" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    else if ([emailTest evaluateWithObject:_txt_emailId.text] != YES && [_txt_emailId.text length] != 0) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid EMAIL ADDRESS" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    else if ([_pannooutlet.text isEqual:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@" Please enter PAN NUMBER" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_pannooutlet.text && _pannooutlet.text.length < 10) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid PAN NUMBER" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    else if ([_txt_addressLine1.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([_txt_area.text isEqualToString:@""]) {

        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter area" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([_txt_state.text isEqualToString:@""]) {

        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select state" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([_txt_District.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select district" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([_txt_City.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([_txt_area.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter area" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([txt_PL.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select PL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([txt_application.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select application" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }

    else if ([txt_financier.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select financier" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([txt_sourceOfcontact.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([_txtGetUsagedetails.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select usage details " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }

    else if ([_txtBodytype.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select body type" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    
    else if ([_txtMMgeography.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select mmgeography" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    

    
    
    else {

        NSString* envelopeText;

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                     @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                     @"<Contact>"
                                     @"<CellularPhone>%@</CellularPhone>"
                                     @"<EmailAddress>%@</EmailAddress>"
                                     @"<FirstName>%@</FirstName>"
                                     @"<IntegrationId>%ld</IntegrationId>"
                                     @"<LastName>%@</LastName>"
                                     @"<SocialSecurityNumber>FIOPS9223P</SocialSecurityNumber>" //pan card no
                                     @"<ListOfRelatedSalesRep>"
                                     @"<RelatedSalesRep>"
                                     @"<Position>%@</Position>"
                                     @"<Id>%@</Id>"
                                     @"</RelatedSalesRep>"
                                     @"</ListOfRelatedSalesRep>"
                                     @"<ListOfRelatedOrganization>"
                                     @"<RelatedOrganization>"
                                     @"<Organization>%@</Organization>"
                                     @"</RelatedOrganization>"
                                     @"</ListOfRelatedOrganization>"
                                     @"<ListOfPersonalAddress>"
                                     @"<PersonalAddress>"
                                     @"<IntegrationId>%ld</IntegrationId>"
                                     @"<PersonalStreetAddress>%@</PersonalStreetAddress>"
                                     @"<PersonalStreetAddress2>%@</PersonalStreetAddress2>"
                                     @"<PersonalCountry>India</PersonalCountry>"
                                     @"<PersonalState>%@</PersonalState>"
                                     @"<TMDistrict>%@</TMDistrict>"
                                     @"<PersonalCity>%@</PersonalCity>"
                                     @"<TMTaluka>%@</TMTaluka>"
                                     @"<TMPanchayat></TMPanchayat>"
                                     @"<TMArea>teen hath naka</TMArea>"
                                     @"<PersonalPostalCode></PersonalPostalCode>"
                                     @"</PersonalAddress>"
                                     @"</ListOfPersonalAddress>"
                                     @"<ListOfOpportunity>"
                                     @"<Opportunity operation=\"\">"
                                     @"<IntegrationId>%ld</IntegrationId>"
                                     @"<OptyFinancier>ABHYUDAYA CO.OP.BANK LTD</OptyFinancier>"
                                     @"<ParentProductLine>Ace HT PPL</ParentProductLine>"
                                     @"<ProductLine>Ace HT_Old</ProductLine>"
                                     @"<SourceOfContact />"
                                     @"<Channel>MOBILE</Channel>"
                                     @"<TMCVCustomerType>First Time</TMCVCustomerType>"
                                     @"<IntendedApplication>Containers</IntendedApplication>"
                                     @"<TMLOB>SCV Cargo</TMLOB>"
                                     @"<ProductId>1-2KRYD-3</ProductId>"
                                     @"<TMBodyType>Containers</TMBodyType>"
                                     @"<TMCustomerSegment>Market Load Operator</TMCustomerSegment>"
                                     @"<TMFleetSize>2</TMFleetSize>"
                                     @"<TMMMGeography>ACHALPUR</TMMMGeography>"
                                     @"<TMNonFleetSize>2</TMNonFleetSize>"
                                     @"<ListOfOpportunityRelatedOrganization>"
                                     @"<OpportunityRelatedOrganization IsPrimaryMVG=\"Y\" operation=\"\">"
                                     @"<Organization>%@</Organization>"
                                     @"</OpportunityRelatedOrganization>"
                                     @"</ListOfOpportunityRelatedOrganization>"
                                     @"<ListOfOpportunityRelatedSalesRep>"
                                     @"<OpportunityRelatedSalesRep IsPrimaryMVG=\"Y\" operation=\"\">"
                                     @"<Position>%@</Position>"
                                     @"<Id>%@</Id>"
                                     @"</OpportunityRelatedSalesRep>"
                                     @"</ListOfOpportunityRelatedSalesRep>"
                                     @"<ListOfOpportunityRelatedProducts>"
                                     @"<OpportunityRelatedProducts operation=\"\">"
                                     @"<Product>55231120ACNR</Product>"
                                     @"<ProductQuantity>1</ProductQuantity>"
                                     @"<ParentProductLine>Ace HT PPL</ParentProductLine>"
                                     @"<ProductLine>Ace HT_Old</ProductLine>"
                                     @"</OpportunityRelatedProducts>"
                                     @"</ListOfOpportunityRelatedProducts>"
                                     @"</Opportunity>"
                                     @"</ListOfOpportunity>"
                                     @"</Contact>"
                                     @"</ListOfContactInterface>"
                                     @"</SFATMCVContactInsertOrUpdate_Input>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 _txt_phonenumber.text, _txt_emailId.text, _txt_firstname.text, (long)[[NSDate date] timeIntervalSince1970], _txt_lastName.text, userDetailsVal_.POSITION_NAME, userDetailsVal_.ROW_ID, userDetailsVal_.ORGNAME, (long)[[NSDate date] timeIntervalSince1970], _txt_addressLine1.text, _txt_addressLine2.text, str, _txt_District.text, _txt_City.text, _txt_Taluka.text, (long)[[NSDate date] timeIntervalSince1970], userDetailsVal_.ORGNAME, userDetailsVal_.POSITION_NAME, userDetailsVal_.ROW_ID];

        NSLog(@"\n envlopeString Of OPP!!!!%@", envelopeText);
        NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
        NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
        NSLog(@"URL IS %@", theurl);
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
        NSLog(@"Request.... %@", request);
        NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
        [[RequestDelegate alloc] initiateRequest:request name:@"Createoptyfornewcontact"];
    }
}

- (void)Createoptyfornewcontact_found:(NSNotification*)notification

{
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n List of Opportunity Response %@ ", response);

    NSError* err;

    if ([response isEqual:@""]) {
        [self hideAlert];
        NSLog(@"Nko re..");
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

        [alert setTag:0];

        [alertView show];
    }

    else {
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];

        TBXMLElement* ListOfContactInterface = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];

        TBXMLElement* Contact = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];

        TBXMLElement* IDC = [TBXML childElementNamed:@"Id" parentElement:Contact];

        TBXMLElement* ListOfOpportunity = [TBXML childElementNamed:@"ListOfOpportunity" parentElement:Contact];

        TBXMLElement* Opportunity = [TBXML childElementNamed:@"Opportunity" parentElement:ListOfOpportunity];

        TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];

        OPTY_ID_ = [TBXML textForElement:Id];

        CONTACT_ID = [TBXML textForElement:IDC];

        NSLog(@"\n\n OPTY_ID_ ...!!! %@ ", CONTACT_ID);

        //NSLog(@"\n\n OPTY_ID_ ...!!! %@ ",createopportunity.Contact_);

        if ([OPTY_ID_ isEqual:@""]) {
            [self hideAlert];

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Opportunity Creation Failed " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];
            [alertView show];
        }
        else {
            [self hideAlert];

            [self contactByID];
        }
    }
}

- (void)createoptyexistingContact
{
    
    if([self isNumeric:txtProductQuantity.text])
    {
        // b"date is valid;
        [txtProductQuantity resignFirstResponder];
        
    }
    else
    {
        // b"date is not valid;
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Alert" message :@"Product Quantity Should Be Nuemeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
        txtProductQuantity.text = @"";
        [txtProductQuantity resignFirstResponder];
        [self hideAlert];
        return;
    }
        
    if ([txt_PL.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select PL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([txt_application.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select application" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }

    else if ([txt_financier.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select financier" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([txt_sourceOfcontact.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([_txtGetUsagedetails.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select usage details " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }

    else if ([_txtBodytype.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select body type" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([_txtMMgeography.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select mmgeography" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }

    else {

        NSString* envelopeText;

        envelopeText = [NSString stringWithFormat:
                                     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     @"<SOAP:Body>"
                                     @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                     @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                     @"<Contact operation=\"update\">"
                                     @"<Id>%@</Id>"
                                     @"<ListOfRelatedSalesRep>"
                                     @"<RelatedSalesRep IsPrimaryMVG=\"Y\" operation=\"update\">"
                                     @"<Position>%@</Position>"
                                     @"<Id>%@</Id>"
                                     @"</RelatedSalesRep>"
                                     @"</ListOfRelatedSalesRep>"
                                     @"<ListOfRelatedOrganization>"
                                     @"<RelatedOrganization IsPrimaryMVG=\"Y\" operation=\"update\">"
                                     @"<Organization>%@</Organization>"
                                     @"</RelatedOrganization>"
                                     @"</ListOfRelatedOrganization>"
                                     @"<ListOfOpportunity>"
                                     @"<Opportunity operation=\"update\" searchspec=\"\">"
                                     @"<IntegrationId>%ld</IntegrationId>"
                                     @"<OptyFinancier>ABHYUDAYA CO.OP.BANK LTD</OptyFinancier>"
                                     @"<ParentProductLine>Ace HT PPL</ParentProductLine>"
                                     @"<ProductLine>Ace HT_Old</ProductLine>"
                                     @"<SourceOfContact />"
                                     @"<Channel>MOBILE</Channel>"
                                     @"<TMCVCustomerType>First Time</TMCVCustomerType>"
                                     @"<IntendedApplication>Containers</IntendedApplication>"
                                     @"<TMLOB>SCV Cargo</TMLOB>"
                                     @"<ProductId>1-P9IW-3</ProductId>"
                                     @"<TMBodyType>Containers</TMBodyType>" //LOV webservice
                                     @"<TMCustomerSegment>Market Load Operator</TMCustomerSegment>" //LOV webservice
                                     @"<TMFleetSize>2</TMFleetSize>" //numeric value
                                     @"<TMMMGeography>ACHALPUR</TMMMGeography>" //LOV webservice
                                     @"<TMNonFleetSize>2</TMNonFleetSize>" //numeric value
                                     @"<ListOfOpportunityRelatedOrganization>"
                                     @"<OpportunityRelatedOrganization IsPrimaryMVG=\"Y\" operation=\"update\">"
                                     @"<Organization>%@</Organization>"
                                     @"</OpportunityRelatedOrganization>"
                                     @"</ListOfOpportunityRelatedOrganization>"
                                     @"<ListOfOpportunityRelatedSalesRep>"
                                     @"<OpportunityRelatedSalesRep IsPrimaryMVG=\"Y\" operation=\"\">"
                                     @"<Position>%@</Position>"
                                     @"<Id>%@</Id>"
                                     @"</OpportunityRelatedSalesRep>"
                                     @"</ListOfOpportunityRelatedSalesRep>"
                                     @"<ListOfOpportunityRelatedProducts>"
                                     @"<OpportunityRelatedProducts operation=\"\">"
                                     @"<Product>55231120ACNR</Product>"
                                     @"<ProductQuantity>1</ProductQuantity>"
                                     @"<ParentProductLine>Ace HT PPL</ParentProductLine>"
                                     @"<ProductLine>Ace HT_Old</ProductLine>"
                                     @"</OpportunityRelatedProducts>"
                                     @"</ListOfOpportunityRelatedProducts>"
                                     @"</Opportunity>"
                                     @"</ListOfOpportunity>"
                                     @"</Contact>"
                                     @"</ListOfContactInterface>"
                                     @"</SFATMCVContactInsertOrUpdate_Input>"
                                     @"</SOAP:Body>"
                                     @"</SOAP:Envelope>",
                                 optyData.ID, userDetailsVal_.POSITION_NAME, userDetailsVal_.ROW_ID, userDetailsVal_.ORGNAME, (long)[[NSDate date] timeIntervalSince1970], userDetailsVal_.ORGNAME, userDetailsVal_.POSITION_NAME, userDetailsVal_.ROW_ID];

        NSLog(@"\n request envelope create opty from existing contact  %@", envelopeText);
        NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
        NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
        NSLog(@"URL IS %@", theurl);
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
        NSLog(@"Request.... %@", request);
        NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
        [[RequestDelegate alloc] initiateRequest:request name:@"CreateoptyforexistingContact"];
    }
}

- (void)CreateoptyforexistingContactData_Found:(NSNotification*)notification
{

    {
        NSString* response = [[notification userInfo] objectForKey:@"response"];
        NSLog(@"\n List of Opportunity Response %@ ", response);

        NSError* err;

        if ([response isEqual:@""]) {
            [self hideAlert];
            NSLog(@"Nko re..");
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];
            [alertView show];
        }
        else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];
            [alertView show];
        }

        else {
            TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

            TBXMLElement* container = [TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];

            TBXMLElement* ListOfContactInterface = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];

            TBXMLElement* Contact = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];

            TBXMLElement* IDC = [TBXML childElementNamed:@"Id" parentElement:Contact];

            TBXMLElement* ListOfOpportunity = [TBXML childElementNamed:@"ListOfOpportunity" parentElement:Contact];

            TBXMLElement* Opportunity = [TBXML childElementNamed:@"Opportunity" parentElement:ListOfOpportunity];

            TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];

            OPTY_ID_ = [TBXML textForElement:Id];

            CONTACT_ID = [TBXML textForElement:IDC];

            NSLog(@"\n\n OPTY_ID_ ...!!! %@ ", OPTY_ID_);

            if ([OPTY_ID_ isEqual:@""]) {
                [self hideAlert];

                alert = [[UIAlertView alloc] initWithTitle:nil message:@"Opportunity Creation Failed " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                [alert setTag:0];
                [alert show];
            }
            else {

                [self hideAlert];

                txt_lob.text = @"";
                txt_ppl.text = @"";
                txt_PL.text = @"";
                txt_application.text = @"";
                txt_financier.text = @"";
                txt_sourceOfcontact.text = @"";
                _txtGetUsagedetails.text = @"";
                _txtBodytype.text = @"";
                _txtMMgeography.text = @"";
                txt_financier.text = @"";

                alert = [[UIAlertView alloc] initWithTitle:nil
                                                   message:@"Opportunity created successfully. "
                                                  delegate:self
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil];


                [alert show];

                [self hideAlert];
            }
        }
    }
}

- (void)statelist
{
    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                           @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                                            "@<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                                           @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-faf1-0ea55009db29</DC>"
                                           @"</Logger>"
                                            "@</header>"
                                           @"</SOAP:Header>"
                                           @"<SOAP:Body>"
                                           @"<GetAllIndianStates xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\"/>"
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

    [[RequestDelegate alloc] initiateRequest:request name:@"AllStates"];
}

- (void)Allstates_Found:(NSNotification*)notification

{

    NSError* err;
    int i = 0;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n List of Opportunity Response %@ ", response);

    if ([response isEqual:@""]) {

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

        [alert setTag:0];
        [alert show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something gone wrong . Please try agin" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else {
        if (GetAllstates_Arr) {
            [GetAllstates_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianStatesResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];

        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {

            do {

                TBXMLElement* table = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];

                TBXMLElement* Statecode = [TBXML childElementNamed:@"X_STATE" parentElement:table];

                NSString* state = [TBXML textForElement:Statecode];

                NSLog(@"\n State codes : %@", state);

                [GetAllstates_Arr addObject:state];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"\nOpportunityListDisplayArr......%d", [GetAllstates_Arr count]);
            if (GetAllstates_Arr >= 0) {

                NSLog(@"all states%@", GetAllstates_Arr);
            }
            else {
                alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert setTag:0];
                [alert show];
            }
        }
        else {

            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];

            [alert show];
        }
    }
}

- (void)ContactSelection_found:(NSNotification*)notification
{
    NSLog(@"test contact search %@", selectedcontact.Name);

    Opptystatus = @"Createoptyforexistingcontact";

    _createOptyview.hidden = NO;
    _addressView.hidden = YES;
    _Contact_View.hidden = YES;

    btn_Optyclick.hidden = YES;
    btn_AddressClick.hidden = YES;
    btn_Contactclick.hidden = YES;
}
- (void)Districtlist
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetAllIndianDistricts xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<state>MH</state>"
                                           @"</GetAllIndianDistricts>"
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

    [[RequestDelegate alloc] initiateRequest:request name:@"AllDistricts"];
}

- (void)AllDistrict_Found:(NSNotification*)notification

{

    NSError* err;
    int i = 0;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n District Response %@ ", response);

    if ([response isEqual:@""]) {

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];

        [alert show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something gone wrong . Please try agin" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

        [alert setTag:0];

        [alert show];
    }
    else {
        if (GetAlldistricts_Arr) {
            [GetAlldistricts_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianDistrictsResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];

        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {

            do {

                TBXMLElement* table = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];

                TBXMLElement* districtcode = [TBXML childElementNamed:@"X_DISTRICT" parentElement:table];

                NSString* district = [TBXML textForElement:districtcode];

                NSLog(@"\n State codes : %@", district);

                [GetAlldistricts_Arr addObject:district];

            } while ((tuple = tuple->nextSibling));

            NSLog(@"\all districts list......%d", [GetAlldistricts_Arr count]);
            if ((GetAlldistricts_Arr) > 0) {
                NSLog(@"In..");
                [self hideAlert];

                actionSheet = [[UIActionSheet alloc]
                             initWithTitle:nil
                                  delegate:self
                         cancelButtonTitle:nil
                    destructiveButtonTitle:nil
                         otherButtonTitles:nil];

                for (int i = 0; i < [GetAlldistricts_Arr count]; i++) {
                    [actionSheet addButtonWithTitle:[self.GetAlldistricts_Arr objectAtIndex:i]];
                }
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    [actionSheet showFromRect:[self.txt_District frame] inView:self.addressView animated:YES];
                }
                else {
                    [actionSheet showInView:self.view];
                }
                actionSheet.tag = 6;

                //[appdelegate hideAlert];
            }

            else {
                alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                [alert setTag:0];

                [alert show];
            }
        }
        else {

            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];

            [alert show];
        }
    }
}

- (void)Citieslist
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetAllIndianCity xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<state>MH</state>"
                                           @"<dist>SATARA</dist>"
                                           @"</GetAllIndianCity>"
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

    [[RequestDelegate alloc] initiateRequest:request name:@"Allcities"];
}

- (void)Allcities_Found:(NSNotification*)notification

{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Select LOB First ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

        [alert setTag:0];
        [alert show];
        //[self hideAlert];
    }
    else {

        if (GetAllcities_Arr) {
            [GetAllcities_Arr removeAllObjects];
            // [activityPPLNamePickerArr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianCityResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"X_CITY" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetAllcities_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetAllcities_Arr);
        }
        else {

            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data not availbale" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:0];
            [alert show];
        }

        if ((GetAllcities_Arr) > 0) {
            NSLog(@"In..");
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:nil
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [GetAllcities_Arr count]; i++) {
                [actionSheet addButtonWithTitle:[GetAllcities_Arr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_City frame] inView:self.addressView animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 7;

            //[appdelegate hideAlert];
        }
    }
}

- (void)Talukalist
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetAllIndianTaluka xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<state>MH</state>"
                                           @"<dist>SATARA</dist>"
                                           @"<city>RAHIMATPUR</city>"
                                           @"</GetAllIndianTaluka>"
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

    [[RequestDelegate alloc] initiateRequest:request name:@"Alltaluka"];
}

//Alltaluka_Found

- (void)Alltaluka_Found:(NSNotification*)notification

{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Select LOB First ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
        //[self hideAlert];
    }
    else {

        if (GetAlltaluka_Arr) {
            [GetAlltaluka_Arr removeAllObjects];
            // [activityPPLNamePickerArr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianTalukaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"X_TALUKA" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetAlltaluka_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetAlltaluka_Arr);
        }
        else {

            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data not availbale" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];
            [alert show];
        }

        if ((GetAlltaluka_Arr) > 0) {
            NSLog(@"In..");
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:@" "
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [GetAlltaluka_Arr count]; i++) {
                [actionSheet addButtonWithTitle:[self.GetAlltaluka_Arr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_Taluka frame] inView:self.addressView animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 8;

            //[appdelegate hideAlert];
        }
    }
}

- (void)call_List_Of_Fianacer
{
    NSString* envelopeText = [NSString stringWithFormat:
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

    NSLog(@"\n en%@", envelopeText);
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    NSLog(@"URL IS .... %@", theurl);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc] initiateRequest:request name:@"getActivityFinanceConnection"];
}

- (void)Finance_Data_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\nfinance  %@", response);

    if (self.Financier_List_PickerArr) {

        [self.Financier_List_PickerArr removeAllObjects];
    }
    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement* container = [TBXML childElementNamed:@"GetFinancierDetailsForDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

    if (tuple) {

        do {

            TBXMLElement* S_ORG_EXT = [TBXML childElementNamed:@"S_ORG_EXT" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];

            TBXMLElement* ACC_NAME = [TBXML childElementNamed:@"ACC_NAME" parentElement:S_ORG_EXT];
            NSString* strACC_NAME = [TBXML textForElement:ACC_NAME];
            NSLog(@"S_Lst_Of_Val FOR  : %@", strACC_NAME);

            [self.Financier_List_PickerArr addObject:strACC_NAME];

        } while ((tuple = tuple->nextSibling));
    }
    if ([self.Financier_List_PickerArr count] > 0) {
        // [self hideAlert];
    }
}
- (IBAction)btn_PL:(id)sender
{

    if (![self connected]) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

        [alert setTag:0];
        [alert show];
    }
    else {

        [self showAlert];
        if ([self.txt_lob.text isEqual:@""]) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select LOB" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:0];
            [alert show];
        }
        else if ([self.txt_ppl.text isEqual:@""]) {

            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select PPL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];

            [alert show];
        }
        else {
           

            NSString* envelopeText = [NSString stringWithFormat:
                                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                                   @"<SOAP:Body>"
                                                   @"<GetPLFromPPL xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                                   @"<PPL_Name>%@</PPL_Name>"
                                                   @"<LOB>%@</LOB>"
                                                   @"</GetPLFromPPL>"
                                                   @"</SOAP:Body>"
                                                   @"</SOAP:Envelope>",
                                               txt_ppl.text, txt_lob.text];

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

            [[RequestDelegate alloc] initiateRequest:request name:@"getActivityPLConnection"];
        }
    }
}
- (void)PLUpdateOpty_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);
    // [self Call_Product_Name];
    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
        //[self hideAlert];
    }
    else {

        if (GetPL_LOBPPL_Arr) {
            [GetPL_LOBPPL_Arr removeAllObjects];
            // [activityPPLNamePickerArr removeAllObjects];
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
                //[self Call_Product_Name];

                [GetPL_LOBPPL_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetPL_LOBPPL_Arr);
            // [self Call_Product_Name];
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];
            [alert show];
        }

        if ((GetPL_LOBPPL_Arr.count) > 0) {
            NSLog(@"In..");
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:@" "
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [self.GetPL_LOBPPL_Arr count]; i++) {
                [actionSheet addButtonWithTitle:[self.GetPL_LOBPPL_Arr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_PL frame] inView:self.createOptyview animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 3;

           
        }
    }
}

- (IBAction)btn_Source_Contact:(id)sender
{

    if (![self connected]) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else if ([txt_PL.text isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select pl value" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }

    else {
        if (![self connected]) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:0];
            [alert show];
        }
        else {

            [self call_PL_ProductLine];

            if ((pickerData) > 0) {
                NSLog(@"In..");
                [self hideAlert];

                actionSheet = [[UIActionSheet alloc]
                             initWithTitle:@" "
                                  delegate:self
                         cancelButtonTitle:nil
                    destructiveButtonTitle:nil
                         otherButtonTitles:nil];

                for (int i = 0; i < [pickerData count]; i++) {
                    [actionSheet addButtonWithTitle:[self.pickerData objectAtIndex:i]];
                }
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    [actionSheet showFromRect:[self.txt_sourceOfcontact frame] inView:self.createOptyview animated:YES];
                }
                else {
                    [actionSheet showInView:self.view];
                }
                actionSheet.tag = 9;
            }
            else {
                alert = [[UIAlertView alloc] initWithTitle:nil message:@"Not data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert setTag:0];
                [alert show];
            }
        }
    }
}

- (IBAction)btn_Finaincer:(id)sender
{

    if (![self connected]) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else {
        if (![self connected]) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:0];
            [alert show];
        }
        else {

            [self showAlert];
            if ([txt_lob.text isEqual:@""] && [txt_ppl.text isEqual:@""]) {
                [self hideAlert];
                alert = [[UIAlertView alloc] initWithTitle:nil message:@"Select above fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert setTag:0];
                [alert show];
            }
            else {

                if ((Financier_List_PickerArr) > 0) {
                    NSLog(@"In..");
                    [self hideAlert];

                    actionSheet = [[UIActionSheet alloc]
                                 initWithTitle:@" "
                                      delegate:self
                             cancelButtonTitle:nil
                        destructiveButtonTitle:nil
                             otherButtonTitles:nil];

                    for (int i = 0; i < [Financier_List_PickerArr count]; i++) {
                        [actionSheet addButtonWithTitle:[self.Financier_List_PickerArr objectAtIndex:i]];
                    }
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        [actionSheet showFromRect:[self.txt_financier frame] inView:self.createOptyview animated:YES];
                    }
                    else {
                        [actionSheet showInView:self.view];
                    }
                    actionSheet.tag = 10;
                }
                else {
                    alert = [[UIAlertView alloc] initWithTitle:nil message:@"Not data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert setTag:0];
                    [alert show];
                }
            }
        }
    }
}

- (IBAction)btn_Application:(id)sender
{

    if (![self connected]) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else {

        [self showAlert];
        if ([txt_lob.text isEqual:@""]) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Select LOB field ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];
            [alert show];
        }

        else if ([txt_ppl.text isEqual:@""]) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Select PPL field ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];
            [alert show];
        }
        else if ([txt_PL.text isEqual:@""]) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Select PL field ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:0];
            [alert show];
        }

        else {

            NSString* envelopeText = [NSString stringWithFormat:
                                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                                   @"<SOAP:Body>"
                                                   @"<GetTMCVIndentAppsNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                                   @"<lob>%@</lob>"
                                                   @"</GetTMCVIndentAppsNeev>"
                                                   @"</SOAP:Body>"
                                                   @"</SOAP:Envelope>",
                                               txt_lob.text];

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

            [[RequestDelegate alloc] initiateRequest:request name:@"getApplicationTypeConnection"];
        }
    }
}
- (void)AppType_Data_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        //[appdelegate hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Select LOB First ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
        //[self hideAlert];
    }
    else {

        if (GetAppType_Arr) {
            [GetAppType_Arr removeAllObjects];
            // [activityPPLNamePickerArr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetTMCVIndentAppsNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"\n PPL_ID_ : %@", PPL_ID_);
                [GetAppType_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", GetAppType_Arr);
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:0];
            [alert show];
        }

        if ((GetAppType_Arr) > 0) {
            NSLog(@"In..");
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:@" "
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [GetAppType_Arr count]; i++) {
                [actionSheet addButtonWithTitle:[self.GetAppType_Arr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_application frame] inView:self.createOptyview animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 4;

            //[appdelegate hideAlert];
        }
    }
}




- (IBAction)btn_State:(id)sender
{

    if (![self connected]) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else {

        NSLog(@"Activity...Data %@", GetAllstates_Arr);
        actionSheet = [[UIActionSheet alloc] initWithTitle:@" "
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        // ObjC Fast Enumeration
        for (NSString* title in showStates) {
            [actionSheet addButtonWithTitle:title];
        }
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

            [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.addressView animated:YES];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        }
        else {
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 5;
    }
}







- (IBAction)btn_District:(id)sender
{

    if (![self connected]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else {
        [self showAlert];
        //  self.btnSelectPL.userInteractionEnabled=YES;
        if (str.length == 0) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@" Please select state " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:0];
            [alert show];
        }
        else {
            NSLog(@"staes Selected  ");

            NSString* envelopeText = [NSString stringWithFormat:
                                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                                   @"<SOAP:Body>"
                                                   @"<GetAllIndianDistricts xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                                   @"<state>%@</state>"
                                                   @"</GetAllIndianDistricts>"
                                                   @"</SOAP:Body>"
                                                   @"</SOAP:Envelope>",
                                               str];

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

            [[RequestDelegate alloc] initiateRequest:request name:@"getAllDistrictConnection"];
        }
    }
}




- (IBAction)btn_Taluka:(id)sender
{
    if (![self connected]) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else {

        [self showAlert];
        //  self.btnSelectPL.userInteractionEnabled=YES;
        if (str.length == 0 || self.txt_District.text.length == 0 || self.txt_City.text.length == 0) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@" Please select above fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];
            [alert show];
        }

        else {
            NSLog(@"City  Selected  ");
            {

                NSString* envelopeText = [NSString stringWithFormat:
                                                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                                       @"<SOAP:Body>"
                                                       @"<GetAllIndianTaluka xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                                       @"<state>%@</state>"
                                                       @"<dist>%@</dist>"
                                                       @"<city>%@</city>"
                                                       @"</GetAllIndianTaluka>"
                                                       @"</SOAP:Body>"
                                                       @"</SOAP:Envelope>",
                                                   str, self.txt_District.text, self.txt_City.text];

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

                [[RequestDelegate alloc] initiateRequest:request name:@"Alltaluka"];
            }
        }
    }
}

- (IBAction)btn_City:(id)sender
{

    if (![self connected]) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else {

        [self showAlert];
        //  self.btnSelectPL.userInteractionEnabled=YES;
        if (str.length == 0 || self.txt_District.text.length == 0) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@" Please select the  State and  District" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:0];
            [alert show];
        }
        else {
            NSLog(@"District Selected  ");
            {

                NSString* envelopeText = [NSString stringWithFormat:
                                                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                                       @"<SOAP:Body>"
                                                       @"<GetAllIndianCity xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                                       @"<state>%@</state>"
                                                       @"<dist>%@</dist>"
                                                       @"</GetAllIndianCity>"
                                                       @"</SOAP:Body>"
                                                       @"</SOAP:Envelope>",
                                                   str, self.txt_District.text];

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

                [[RequestDelegate alloc] initiateRequest:request name:@"Allcities"];
            }
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

- (void)actionSheet:(UIActionSheet*)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{

    NSLog(@"button click ....%ld", (long)buttonIndex);
    if (txt_lob) {
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
                //self.txt_lob.text = NSLocalizedString([GetLOB_Arr objectAtIndex:buttonIndex],@"");
                self.txt_PL.text = @"";
                self.txt_ppl.text = @"";
                self.txt_application.text = @"";
            }
        }
    }
    if (txt_ppl) {
        NSLog(@"... in");
        switch (popup.tag) {
            NSLog(@"... in");
        case 2:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                // self.txt_ppl.text = NSLocalizedString([GetPPL_LOB_Arr objectAtIndex:buttonIndex],@"");

                self.txt_PL.text = @"";
                self.txt_application.text = @"";
            }
        }
    }
    if (txt_PL) {
        NSLog(@"... in");
        switch (popup.tag) {
            NSLog(@"... in");
        case 3:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_PL.text = NSLocalizedString([GetPL_LOBPPL_Arr objectAtIndex:buttonIndex], @"");

                self.txt_application.text = @"";

                NSLog(@"opty id %@", optyData.ID);
            }
        }
    }
    if (txt_application) {
        NSLog(@"... in");
        switch (popup.tag) {
            NSLog(@"... in");
        case 4:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_application.text = NSLocalizedString([GetAppType_Arr objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (self.txt_state) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 5:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                str = [GetAllstates_Arr objectAtIndex:buttonIndex];
                NSLog(@"Sates : %@", str);
                self.txt_state.text = NSLocalizedString([showStates objectAtIndex:buttonIndex], @"");
                self.txt_District.text = @"";
                self.txt_City.text = @"";
                self.txt_Taluka.text = @"";
                //self.textpostalcode.text=@"";

                NSLog(@"state code %@", str);
            }
        }
    }
    if (self.txt_District) {
        NSLog(@"... in");
        switch (popup.tag) {
            NSLog(@"... in");
        case 6:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_District.text = NSLocalizedString([GetAlldistricts_Arr objectAtIndex:buttonIndex], @"");
                self.txt_City.text = @"";
                self.txt_Taluka.text = @"";
                //self.textpostalcode.text=@"";
            }
        }
    }
    if (self.txt_City) {
        NSLog(@"... in");
        switch (popup.tag) {
            NSLog(@"... in");
        case 7:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_City.text = NSLocalizedString([GetAllcities_Arr objectAtIndex:buttonIndex], @"");
                self.txt_Taluka.text = @"";
                //self.textpostalcode.text=@"";
            }
        }
    }
    if (self.txt_Taluka) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 8:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_Taluka.text = NSLocalizedString([GetAlltaluka_Arr objectAtIndex:buttonIndex], @"");
            }
        }
    }
    if (txt_sourceOfcontact) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 9:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_sourceOfcontact.text = NSLocalizedString([pickerData objectAtIndex:buttonIndex], @"");
                // self.txt_sourceOfcontact.text=@"";
            }
        }
    }
    if (txt_financier) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 10:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txt_financier.text = NSLocalizedString([Financier_List_PickerArr objectAtIndex:buttonIndex], @"");
            }
        }
    }

    if (_txtGetUsagedetails) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 21:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtGetUsagedetails.text = NSLocalizedString([Getusagecatagory_Arr objectAtIndex:buttonIndex], @"");
                // self.txt_sourceOfcontact.text=@"";
            }
        }
    }

    if (_txtBodytype) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 22:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtBodytype.text = NSLocalizedString([Getbodytype_Arr objectAtIndex:buttonIndex], @"");
                // self.txt_sourceOfcontact.text=@"";
            }
        }
    }

    if (_txtMMgeography) {
        NSLog(@"... in");
        switch (popup.tag) {
        case 23:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                NSLog(@"ek..");
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
                self.txtMMgeography.text = NSLocalizedString([Micromarket_Arr objectAtIndex:buttonIndex], @"");
            }
        }
    }
    
    
    if (_txtPincode) {
        NSLog(@"... in");
        switch (popup.tag) {
            case 50:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    NSLog(@"ek..");
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    self.txtPincode.text = NSLocalizedString([getallpincodeArr objectAtIndex:buttonIndex], @"");
                }
        }
    }
    
}



- (void)GetUsageCategoryDSM
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetUsageCategoryDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<subtype>%@</subtype>"
                                           @"</GetUsageCategoryDSM>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",
                                       txt_lob.text];

    NSLog(@"\n en%@", envelopeText);
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    NSLog(@"URL IS .... %@", theurl);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc] initiateRequest:request name:@"GetUsageCategoryDSMconnection"];
}




- (void)UsageCategory_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        //[appdelegate hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
        [self hideAlert];
    }
    else {

        if (Getusagecatagory_Arr) {
            [Getusagecatagory_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetUsageCategoryDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"S_LST_OF_VAL" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"usage name: %@", PPL_ID_);
                [Getusagecatagory_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@"usage array %@", Getusagecatagory_Arr);
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:0];
            [alert show];
        }

        if ((Getusagecatagory_Arr) > 0) {
            NSLog(@"In..");
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:@" "
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [Getusagecatagory_Arr count]; i++) {
                [actionSheet addButtonWithTitle:[self.Getusagecatagory_Arr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txtGetUsagedetails frame] inView:self.createOptyview animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 21;
        }
    }
}

- (void)GetBodyTypeDSM
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetBodyTypeDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<subtype>%@</subtype>"
                                           @"</GetBodyTypeDSM>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",
                                       txt_application.text];

    NSLog(@"\n body type%@", envelopeText);
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    NSLog(@"URL IS .... %@", theurl);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc] initiateRequest:request name:@"GetBodyTypeDSM"];
}

- (void)BodyTypeDSMData_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Activity_PL_Found response....... %@ ", response);

    //NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        //[appdelegate hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
        [self hideAlert];
    }
    else {

        if (Getbodytype_Arr) {
            [Getbodytype_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetBodyTypeDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"S_LST_OF_VAL" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"usage name: %@", PPL_ID_);
                [Getbodytype_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@"body type array %@", Getbodytype_Arr);
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];
            [alert show];
        }

        if ((Getbodytype_Arr) > 0) {
            NSLog(@"In..");
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:@" "
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [Getbodytype_Arr count]; i++) {
                [actionSheet addButtonWithTitle:[self.Getbodytype_Arr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txtBodytype frame] inView:self.createOptyview animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 22;
        }
    }
}

- (void)MMGeography
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<GetListofActiveMicroMarketDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                           @"<type>Micromarket</type>"
                                           @"</GetListofActiveMicroMarketDSM>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>"];

    NSLog(@"\n geography %@", envelopeText);
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    NSLog(@"URL IS .... %@", theurl);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc] initiateRequest:request name:@"GetListofActiveMicroMarketDSM"];
}

- (void)ListofActiveMicroMarketDSMData_Found:(NSNotification*)notification
{

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n micromarket response....... %@ ", response);

    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        //[appdelegate hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
        //[self hideAlert];
    }
    else {

        if (Micromarket_Arr) {
            [Micromarket_Arr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetListofActiveMicroMarketDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        if (tuple) {
            do {
                TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"CX_MMGEOGRAPHY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* PPL_ID = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
                NSString* PPL_ID_ = [TBXML textForElement:PPL_ID];
                NSLog(@"usage name: %@", PPL_ID_);
                [Micromarket_Arr addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@"micro market array %@", Micromarket_Arr);
        }
        else {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [alert setTag:0];
            [alert show];
        }

        if ((Micromarket_Arr) > 0) {
            NSLog(@"In..");
            [self hideAlert];

            actionSheet = [[UIActionSheet alloc]
                         initWithTitle:@" "
                              delegate:self
                     cancelButtonTitle:nil
                destructiveButtonTitle:nil
                     otherButtonTitles:nil];

            for (int i = 0; i < [Micromarket_Arr count]; i++) {
                [actionSheet addButtonWithTitle:[self.Micromarket_Arr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txtMMgeography frame] inView:self.createOptyview animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 23;
        }
    }
}

- (void)call_PL_ProductLine
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
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
                                           @"</SOAP:Envelope>",
                                       txt_PL.text];

    NSLog(@"\n envlopeString Of user pl production  details....!!!!%@", envelopeText);

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];

    NSLog(@"URL IS %@", theurl);

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];

    NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

    [[RequestDelegate alloc] initiateRequest:request name:@"PL_ProductID_Request"];
}

- (void)PL_ProductID_RequestData_Found:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\nResponse....%@", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        NSLog(@"Nko re..");
        alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

        [alert setTag:0];
        [alert show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

        [alert setTag:0];
        [alert show];
    }
    else {

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"GetProductfromPLDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];

        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];

        TBXMLElement* old = [TBXML childElementNamed:@"old" parentElement:tuple];

        TBXMLElement* S_PROD_LN = [TBXML childElementNamed:@"S_PROD_LN" parentElement:old];
        //TBXMLElement *PersonalAddress = [TBXML childElementNamed:@"PersonalAddress" parentElement:ListOfPersonalAddress];
        TBXMLElement* PRODUCT = [TBXML childElementNamed:@"PRODUCT" parentElement:S_PROD_LN];
        TBXMLElement* PRODUCT_ID = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:S_PROD_LN];

        PRODUCT_ = [TBXML textForElement:PRODUCT];

        PRODUCT_ID_ = [TBXML textForElement:PRODUCT_ID];

        NSLog(@"\n\n PRODUCT_...!!! %@ ", PRODUCT_);
        NSLog(@"\n\n PRODUCT_ID_...!!! %@ ", PRODUCT_ID_);
    }
}

- (IBAction)btnBodytype:(id)sender
{

    [self showAlert];

    if ([txt_application.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select application" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else {

        [self GetBodyTypeDSM];
    }
}

- (IBAction)btnCustomeusage:(id)sender
{

    [self showAlert];

    if ([txt_lob.text isEqualToString:@""]) {
        [self hideAlert];

        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select LOB" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else {

        [self GetUsageCategoryDSM];
    }
}


- (IBAction)Btngeography:(id)sender
{

    [self showAlert];

   // [self MMGeography];
}

- (void)contactByID
{
    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\">"
                                           @"<soapenv:Header/>"
                                           @"<soapenv:Body>"
                                           @"<asi:SFATMCVContactQueryById_Input>"
                                           @"<asi:PrimaryRowId>%@</asi:PrimaryRowId>"
                                           @"</asi:SFATMCVContactQueryById_Input>"
                                           @"</soapenv:Body>"
                                           @"</soapenv:Envelope>",
                                       CONTACT_ID];

    NSLog(@"\n envlopeString Of user details....!!!!%@", envelopeText);

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];

    NSLog(@"URL IS %@", theurl);

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];

    NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

    [[RequestDelegate alloc] initiateRequest:request name:@"ContactquerybyID"];
}
- (void)contactqueryfound:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\nResponse....%@", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        NSLog(@"Nko re..");
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"soapenv:Fault"].location != NSNotFound) {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

        TBXMLElement* container = [TBXML childElementNamed:@"ns:SFATMCVContactQueryById_Output" parentElement:[TBXML childElementNamed:@"soapenv:Body" parentElement:tbxml.rootXMLElement]];

        TBXMLElement* ListOfContactInterface = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];
        TBXMLElement* Contact = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];
        TBXMLElement* ListOfPersonalAddress = [TBXML childElementNamed:@"ListOfPersonalAddress" parentElement:Contact];

        TBXMLElement* contactId = [TBXML childElementNamed:@"Id" parentElement:Contact];

        TBXMLElement* PersonalAddress = [TBXML childElementNamed:@"PersonalAddress" parentElement:ListOfPersonalAddress];

        TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:PersonalAddress];

        TBXMLElement* IntegrationId = [TBXML childElementNamed:@"IntegrationId" parentElement:PersonalAddress];

        TBXMLElement* AddressId = [TBXML childElementNamed:@"AddressId" parentElement:PersonalAddress];

        TBXMLElement* PersonalAddressName = [TBXML childElementNamed:@"PersonalAddressName" parentElement:PersonalAddress];

        _strAccount = [TBXML textForElement:Id];
        Wintgration = [TBXML textForElement:IntegrationId];
        Waddressid = [TBXML textForElement:AddressId];
        Wcontactid = [TBXML textForElement:contactId];
        WpersonalName = [TBXML textForElement:PersonalAddressName];

        NSLog(@"\n\n PersonalAddress_Id...!!! %@ ", _strAccount);

        NSLog(@"\n\n PersonalAddress_Id...!!! %@ ", Wintgration);

        NSLog(@"\n\n PersonalAddress_Id...!!! %@ ", Waddressid);

        NSLog(@"\n\n PersonalAddress_Id...!!! %@ ", Wcontactid);

        NSLog(@"\n\n PersonalAddress_Id...!!! %@ ", WpersonalName);

        [self Updatecontact_created];
    }
}

- (void)Updatecontact_created
{

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                           @"<SOAP:Body>"
                                           @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                           @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                           @"<Contact operation=\"update\">"
                                           @"<Id>%@</Id>"
                                           @"<FirstName>%@</FirstName>"
                                           @"<LastName>%@</LastName>"
                                           @"<ListOfPersonalAddress operation=\"update\">"
                                           @"<PersonalAddress IsPrimaryMVG=\"Y\">"
                                           @"<Id>%@</Id>"
                                           @"<IntegrationId>%@</IntegrationId>"
                                           @"<PersonalAddressName>%@</PersonalAddressName>"
                                           @"<PersonalStreetAddress>%@</PersonalStreetAddress>"
                                           @"<PersonalStreetAddress2>%@</PersonalStreetAddress2>"
                                           @"<TMArea>%@</TMArea>"
                                           @"<PersonalCountry>India</PersonalCountry>"
                                           @"<PersonalState>%@</PersonalState>"
                                           @"<TMDistrict>%@</TMDistrict>"
                                           @"<PersonalCity>%@</PersonalCity>"
                                           @"<TMTaluka>%@</TMTaluka>"
                                           @"<PersonalPostalCode></PersonalPostalCode>"
                                           @"<TMPanchayat></TMPanchayat>"
                                           @"</PersonalAddress>"
                                           @"</ListOfPersonalAddress>"
                                           @"</Contact>"
                                           @"</ListOfContactInterface>"
                                           @"</SFATMCVContactInsertOrUpdate_Input>"
                                           @"</SOAP:Body>"
                                           @"</SOAP:Envelope>",
                                       Wcontactid, self.txt_firstname.text, self.txt_lastName.text, Waddressid, Wintgration, WpersonalName, self.txt_addressLine1.text, self.txt_addressLine2.text, self.txt_area.text, str, self.txt_District.text, self.txt_City.text, self.txt_Taluka.text];

    NSLog(@"\n envlopeString CONTACT!!!!%@", envelopeText);

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    NSLog(@"REQUEST IS %@", envelopeText);

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

    NSString* msglength = [NSString stringWithFormat:@"%i", [envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

    NSLog(@"re done");
    [[RequestDelegate alloc] initiateRequest:request name:@"prospectupdateconnection"];
}

- (void)prospectupdatefound:(NSNotification*)notification
{

    NSLog(@"response");

    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\nResUPDATE RESPONSE%@", response);

    if ([response isEqual:@""]) {
        [self hideAlert];
        NSLog(@"Nko re..");
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"No data found.Please try again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }

    else {

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];

        TBXMLElement* ListOfContactInterface = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];

        TBXMLElement* Contact = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];

        TBXMLElement* Id = [TBXML childElementNamed:@"Id" parentElement:Contact];
        TBXMLElement* Integration = [TBXML childElementNamed:@"IntegrationId" parentElement:Contact];

        if (Id) {
            //  createcontactresult.Id_ = [TBXML textForElement:Id];
            // NSLog(@"contact id%@",createcontactresult.Id_);
            NSString* idstring = [TBXML textForElement:Id];

            NSString* irnt = [TBXML textForElement:Integration];

            _txt_firstname.text = @"";
            _txt_lastName.text = @"";
            _txt_phonenumber.text = @"";
            _txt_emailId.text = @"";
            _pannooutlet.text = @"";
            _txt_addressLine1.text = @"";
            _txt_addressLine2.text = @"";
            _txt_area.text = @"";
            _txt_City.text = @"";
            _txt_District.text = @"";
            _txt_Taluka.text = @"";
            txt_lob.text = @"";
            txt_ppl.text = @"";
            txt_PL.text = @"";
            txt_application.text = @"";
            txt_financier.text = @"";
            txt_sourceOfcontact.text = @"";
            _txtGetUsagedetails.text = @"";
            _txtBodytype.text = @"";
            _txtMMgeography.text = @"";
            txt_financier.text = @"";

            NSLog(@"contact id  %@", idstring);

            NSLog(@"contact id  %@", irnt);

            [self hideAlert];

            alert = [[UIAlertView alloc] initWithTitle:nil
                                               message:@"Opportunity created successfully."
                                              delegate:self
                                     cancelButtonTitle:nil
                                     otherButtonTitles:@"OK", nil];

            [alert show];
        }
        else {
            [self hideAlert];

            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Something Went Wronge" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            [alertView show];
        }
    }
}




-(void)testTextNumeric
{
    NSLog(@"");
    
    //Validation
    
    if([self isNumeric:txtProductQuantity.text])
    {
        // b"date is valid;
        [txtProductQuantity resignFirstResponder];
    }
    else
    {
        // b"date is not valid;
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Alert" message :@"Product Quantity Should Be Nuemeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
        txtProductQuantity.text = @"";
        [txtProductQuantity resignFirstResponder];
        [self hideAlert];
        return;
    }

    
}


-(BOOL)isNumeric:(NSString *)s
{
    NSScanner *sc = [NSScanner scannerWithString: s];
    if ( [sc scanFloat:NULL] )
    {
        return [sc isAtEnd];
    }
    return NO;

}



- (IBAction)btnFetchPincodeAction:(id)sender {
    
    
    NSLog(@"Fetch Pincode .... !!!");
    
    [self showAlert];
    [self fetchPincode];
    
    
}


-(void)fetchPincode
{
    NSLog(@"\n Fetch Pincode");
    
    NSLog(@"str.... %@",str);
    
    
    NSString* envelopeText = [NSString stringWithFormat:
                              @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              @"<SOAP:Body>"
                              @"<GetAllIndianPostalCode xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                              @"<state>%@</state>"
                              @"<dist>%@</dist>"
                              @"<city>%@</city>"
                              @"<taluka>%@</taluka>"
                              @"</GetAllIndianPostalCode>"
                              @"</SOAP:Body>"
                              @"</SOAP:Envelope>",str, _txt_District.text, _txt_City.text, _txt_Taluka.text];
    
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
    
    [[RequestDelegate alloc] initiateRequest:request name:@"getAllPincodeConnectioninCreateOptyVC"];

    
    
}

//PincodeConnectioninCreateOptyVCFound

- (void)PincodeConnectioninCreateOptyVCFound:(NSNotification*)notification
{
    
    NSLog(@"response");
    
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\nResUPDATE RESPONSE%@", response);
    
    
    if ([response isEqual:@""]) {
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert setTag:0];
        [alert show];
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something gone wrong . Please try agin" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }

    else
    {
        if (getallpincodeArr) {
            [getallpincodeArr removeAllObjects];
        }

        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement* container = [TBXML childElementNamed:@"GetAllIndianPostalCodeResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        
        if (tuple) {
            
            do {
                
                TBXMLElement* table = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                TBXMLElement* POSTALcode = [TBXML childElementNamed:@"X_POSTAL_CODE" parentElement:table];
                
                NSString* state = [TBXML textForElement:POSTALcode];
                
                NSLog(@"\n State codes : %@", state);
                
                [getallpincodeArr addObject:state];
                
            } while ((tuple = tuple->nextSibling));
            
            NSLog(@"\nOpportunityListDisplayArr......%d", [getallpincodeArr count]);
        
            if (getallpincodeArr >= 0) {
                
                NSLog(@"all pincode%@", getallpincodeArr);
            }
            else {
                alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert setTag:0];
                [alert show];
            }
        }
        
            else {
                
                alert = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert setTag:0];
                
                [alert show];
            }
     
        
        if ((getallpincodeArr) > 0) {
            NSLog(@"In..");
            [self hideAlert];
            
            actionSheet = [[UIActionSheet alloc]
                           initWithTitle:nil
                           delegate:self
                           cancelButtonTitle:nil
                           destructiveButtonTitle:nil
                           otherButtonTitles:nil];
            
            for (int i = 0; i < [getallpincodeArr count]; i++) {
                [actionSheet addButtonWithTitle:[getallpincodeArr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txtPincode frame] inView:_addressView animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 50;
            
            //[appdelegate hideAlert];
        }
    
}
}



//Declare a delegate, assign your textField to the delegate and then include these methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}
- (void)keyboardDidShow:(NSNotification *)notification
{
    //    if ([self.txt_firstname isFirstResponder])
    //    {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = CGRectMake(0,-250,self.view.bounds.size.width,self.view.bounds.size.height);
    }];
    //[self.view setFrame:CGRectMake(0,-250,self.view.bounds.size.width,self.view.bounds.size.height)];
    //    }
    //    else
    //    {
    //
    //        [self.view setFrame:CGRectMake(0,-110,self.view.bounds.size.width,self.view.bounds.size.height)];
    //    }
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
    // [self.view setFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
}








@end
