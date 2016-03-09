//
//  CreateProspectViewController.m
//  CRM_APP
//
//  Created by Admin on 29/01/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import "AppDelegate.h"
#import "CreateProspectViewController.h"
#import "MBProgressHUD.h"
#import "ManageOpportunityViewController.h"
#import "ManageOpportunity_ViewCell.h"
#import "Reachability.h"
#import "RequestDelegate.h"
#import "TBXML.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface CreateProspectViewController () {
    
    UIAlertView* alert;
    NSMutableArray *getallstatesarray, *getalldistrictarray, *getallcitiesarray, *getalltalukaarray,*getallpincode;
    NSMutableArray* showStates;
    Reachability* internetReachable;
    Reachability* hostReachable;
    NetworkStatus internetActive, hostActive;
    UIActionSheet* actionSheet;
    NSString* str;
    
    NSPredicate* emailTest;
    NSString* emailRegEx;
    NSPredicate* mobileNumberPred;
    NSString* mobileNumberPattern;
    NSString *ContactID, *_strAccount, *Wintgration, *Waddressid, *Wcontactid, *WpersonalName;
}
@end

@implementation CreateProspectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    NSLog(@"Samlp Art Master: %@", appdelegate.artifact);
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"Samlp Art Master: %@", userDetailsVal_.ROW_ID);
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
    self.splitViewController.delegate = self;
    self.masterPopoverController.delegate = self;
    UIBarButtonItem* barButtonItem = self.splitViewController.displayModeButtonItem;
    barButtonItem.title = @"Show master";
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    mobileNumberPattern = @"[789][0-9]{9}";
    mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
    
    getallstatesarray = [[NSMutableArray alloc] init];
    
    getalldistrictarray = [[NSMutableArray alloc] init];
    getallcitiesarray = [[NSMutableArray alloc] init];
    getalltalukaarray = [[NSMutableArray alloc] init];
    getallpincode = [[NSMutableArray alloc] init];
    
    self.txt_firstname.delegate = self;
    self.txt_lastname.delegate = self;
    self.txt_pannumber.delegate =  self;
    self.txt_phonenumber.delegate= self;
    self.txt_state.delegate = self;
    self.txt_taluka.delegate= self;
    self.txt_emailID.delegate =  self;
    self.txt_city.delegate = self;
    self.txt_Area.delegate =  self;
    self.txt_addressline2.delegate = self;
    self.txt_addressline1.delegate = self;
    self.tx_district.delegate =  self;
    
    
    [self statelist];
    
    NSArray *countries =
    @[ @"AN",
       
       @"AP",
       
       @"AR",
       
       @"AS",
       
       @"BR",
       
       @"CH",
       
       @"CG",
       
       @"DN",
       
       @"DD",
       
       @"DL",
       
       @"GA",
       
       @"GJ",
       
       @"HR",
       
       @"HP",
       
       @"JK",
       
       @"JH",
       
       @"KA",
       
       @"KL",
       
       @"LD",
       
       @"MP",
       
       @"MH",
       
       @"MN",
       
       @"ML",
       
       @"MZ",
       
       @"NL",
       
       @"OR",
       
       @"PY",
       
       @"PB",
       
       @"RJ",
       
       @"SK",
       
       @"TN",
       
       @"TG",
       
       @"TR",
       
       @"UP",
       
       @"WB"];
    
    
    self.dict= [[NSMutableDictionary alloc]initWithCapacity:[countries  count]];
    [ self.dict setObject:[NSString stringWithFormat:@"MH"] forKey:@"Maharashtra"];
    [ self.dict setObject:[NSString stringWithFormat:@"AN"] forKey:@"Andaman and Nicobar Islands"];
    [ self.dict setObject:[NSString stringWithFormat:@"AP"] forKey:@"Andhra Pradesh"];
    [ self.dict setObject:[NSString stringWithFormat:@"AR"] forKey:@"Arunachal Pradesh"];
    [ self.dict setObject:[NSString stringWithFormat:@"AS"] forKey:@"Assam"];
    [ self.dict setObject:[NSString stringWithFormat:@"BR"] forKey:@"Bihar"];
    [ self.dict setObject:[NSString stringWithFormat:@"CG"] forKey:@"Chhattisgarh"];
    [ self.dict setObject:[NSString stringWithFormat:@"CH"] forKey:@"Chandigarh"];
    [ self.dict setObject:[NSString stringWithFormat:@"DD"] forKey:@"Daman and Diu"];
    [ self.dict setObject:[NSString stringWithFormat:@"DL"] forKey:@"Delhi"];
    [ self.dict setObject:[NSString stringWithFormat:@"DN"] forKey:@"Dadra and Nagar Haveli"];
    [ self.dict setObject:[NSString stringWithFormat:@"GA"] forKey:@"Goa"];
    [ self.dict setObject:[NSString stringWithFormat:@"GJ"] forKey:@"Gujarat"];
    [ self.dict setObject:[NSString stringWithFormat:@"HP"] forKey:@"Himachal Pradesh"];
    [ self.dict setObject:[NSString stringWithFormat:@"HR"] forKey:@"Haryana"];
    [ self.dict setObject:[NSString stringWithFormat:@"JH"] forKey:@"Jharkhand"];
    [ self.dict setObject:[NSString stringWithFormat:@"JK"] forKey:@"Jammu and Kashmir"];
    [ self.dict setObject:[NSString stringWithFormat:@"KA"] forKey:@"Karnataka"];
    [ self.dict setObject:[NSString stringWithFormat:@"KL"] forKey:@"Kerala"];
    [ self.dict setObject:[NSString stringWithFormat:@"LD"] forKey:@"Lakshadweep"];
    [ self.dict setObject:[NSString stringWithFormat:@"ML"] forKey:@"Meghalaya"];
    [ self.dict setObject:[NSString stringWithFormat:@"MN"] forKey:@"Manipur"];
    [ self.dict setObject:[NSString stringWithFormat:@"MP"] forKey:@"Madhya Pradesh"];
    [ self.dict setObject:[NSString stringWithFormat:@"MZ"] forKey:@"Mizoram"];
    [ self.dict setObject:[NSString stringWithFormat:@"NL"] forKey:@"Nagaland"];
    [ self.dict setObject:[NSString stringWithFormat:@"OR"] forKey:@"Odisha"];
    [ self.dict setObject:[NSString stringWithFormat:@"PB"] forKey:@"Punjab"];
    [ self.dict setObject:[NSString stringWithFormat:@"PY"] forKey:@"Puducherry"];
    [ self.dict setObject:[NSString stringWithFormat:@"RJ"] forKey:@"Puducherry"];
    [ self.dict setObject:[NSString stringWithFormat:@"SK"] forKey:@"Sikkim"];
    [ self.dict setObject:[NSString stringWithFormat:@"TG"] forKey:@"Telangana"];
    [ self.dict setObject:[NSString stringWithFormat:@"TN"] forKey:@"Tamil Nadu"];
    [ self.dict setObject:[NSString stringWithFormat:@"TR"] forKey:@"Tripura"];
    [ self.dict setObject:[NSString stringWithFormat:@"UA"] forKey:@"Uttarnchal"];
    [ self.dict setObject:[NSString stringWithFormat:@"UP"] forKey:@"Uttar Pradesh"];
    [ self.dict setObject:[NSString stringWithFormat:@"WB"] forKey:@"West Bengal"];
    NSLog(@"%@",[ self.dict description]);
    
    
    
    showStates = [[NSMutableArray alloc] initWithObjects:@"Andaman & Nicobar", @"Andhra Pradesh", @"Arunachal Pradesh", @"Assam", @"Bihar", @"Chattishgarh", @"Chennai", @"Daman & Diu", @"Delhi", @"Dadra, Nagarhaveli", @"Goa", @"Gujarat", @"Himachal Pradesh", @"Haryana", @"Jharkhand", @"Jammu & Kashmir", @"Karnataka", @"Kerala", @"Lakshwadeep", @"Maharashtra", @"Meghalaya", @"Manipur", @"Madhya Pradesh", @"Mizoram", @"Nagaland", @"Orrisa", @"Punjab", @"Pondicherry", @"Rajasthan", @"Sikkim", @"Telangana", @"Tamil Nadu", @"Tripura", @"Uttarkhand", @"Uttar Pradesh", @"West Bengal", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Allstates_Found:) name:@"Allstates_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllDistrict_Found:) name:@"AllDistrict_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Allcities_Found:) name:@"Allcities_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Alltaluka_Found:) name:@"Alltaluka_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pincode_Found:) name:@"AllPincode_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createcontact_found:) name:@"createcontact_found" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contactqueryfound:) name:@"contactqueryfound" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prospectupdatefound:) name:@"prospectupdatefound" object:nil];
    
    //contactqueryfound
    //createcontact_found
    //prospectupdatefound
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Allstates_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AllDistrict_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Allcities_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Alltaluka_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"createcontact_found" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"contactqueryfound" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"prospectupdatefound" object:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btnState:(id)sender
{
    
    if (![self connected]) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:0];
        [alert show];
    }
    else {
        
        NSLog(@"Activity...Data %@", getallstatesarray);
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
            
            [actionSheet showFromRect:[(UITextField*)sender frame] inView:self.view animated:YES];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        }
        else {
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 5;
    }
}

- (IBAction)BtnDistrict:(id)sender
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
            
            [[RequestDelegate alloc] initiateRequest:request name:@"getAllDistrictConnection"];
        }
    }
}

- (IBAction)Btn_city:(id)sender
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
        if (str.length == 0 || self.tx_district.text.length == 0) {
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
                                          str, self.tx_district.text];
                
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

- (IBAction)Btn_Taluka:(id)sender
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
        if (str.length == 0 || self.tx_district.text.length == 0 || self.txt_city.text.length == 0) {
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
                                          str, self.tx_district.text, self.txt_city.text];
                
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
- (IBAction)pincodeFetch:(id)sender
{
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
                              @"</SOAP:Envelope>",str, _tx_district.text, _txt_city.text, _txt_taluka.text];
    
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
    
    [[RequestDelegate alloc] initiateRequest:request name:@"getAllPincodeConnection"];
    
    
}
- (void)pincode_Found:(NSNotification*)notification

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
        if (getallpincode) {
            [getallpincode removeAllObjects];
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
                
                [getallpincode addObject:state];
                
            } while ((tuple = tuple->nextSibling));
            
            NSLog(@"\nOpportunityListDisplayArr......%d", [getallstatesarray count]);
            if (getallpincode >= 0) {
                
                NSLog(@"all pincode%@", getallpincode);
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
        if ((getallpincode) > 0) {
            NSLog(@"In..");
            [self hideAlert];
            
            actionSheet = [[UIActionSheet alloc]
                           initWithTitle:nil
                           delegate:self
                           cancelButtonTitle:nil
                           destructiveButtonTitle:nil
                           otherButtonTitles:nil];
            
            for (int i = 0; i < [getallpincode count]; i++) {
                [actionSheet addButtonWithTitle:[getallpincode objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_pincode frame] inView:self.view animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 9;
            
            //[appdelegate hideAlert];
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
        if (getallstatesarray) {
            [getallstatesarray removeAllObjects];
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
                
                [getallstatesarray addObject:state];
                
            } while ((tuple = tuple->nextSibling));
            
            NSLog(@"\nOpportunityListDisplayArr......%d", [getallstatesarray count]);
            if (getallstatesarray >= 0) {
                
                NSLog(@"all states%@", getallstatesarray);
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
        if (getalldistrictarray) {
            [getalldistrictarray removeAllObjects];
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
                
                [getalldistrictarray addObject:district];
                
            } while ((tuple = tuple->nextSibling));
            
            NSLog(@"\all districts list......%d", [getalldistrictarray count]);
            if ((getalldistrictarray) > 0) {
                NSLog(@"In..");
                [self hideAlert];
                
                actionSheet = [[UIActionSheet alloc]
                               initWithTitle:nil
                               delegate:self
                               cancelButtonTitle:nil
                               destructiveButtonTitle:nil
                               otherButtonTitles:nil];
                
                for (int i = 0; i < [getalldistrictarray count]; i++) {
                    [actionSheet addButtonWithTitle:[getalldistrictarray objectAtIndex:i]];
                }
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    [actionSheet showFromRect:[self.tx_district frame] inView:self.view animated:YES];
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
        
        if (getallcitiesarray) {
            [getallcitiesarray removeAllObjects];
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
                [getallcitiesarray addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", getallcitiesarray);
        }
        else {
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data not availbale" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:0];
            [alert show];
        }
        
        if ((getallcitiesarray) > 0) {
            NSLog(@"In..");
            [self hideAlert];
            
            actionSheet = [[UIActionSheet alloc]
                           initWithTitle:nil
                           delegate:self
                           cancelButtonTitle:nil
                           destructiveButtonTitle:nil
                           otherButtonTitles:nil];
            
            for (int i = 0; i < [getallcitiesarray count]; i++) {
                [actionSheet addButtonWithTitle:[getallcitiesarray objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_city frame] inView:self.view animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 7;
            
            //[appdelegate hideAlert];
        }
    }
}

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
        
        if (getalltalukaarray) {
            [getalltalukaarray removeAllObjects];
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
                [getalltalukaarray addObject:PPL_ID_];
            } while ((tuple = tuple->nextSibling));
            NSLog(@" PPL %@", getalltalukaarray);
        }
        else {
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Data not availbale" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert setTag:0];
            [alert show];
        }
        
        if ((getalltalukaarray) > 0) {
            NSLog(@"In..");
            [self hideAlert];
            
            actionSheet = [[UIActionSheet alloc]
                           initWithTitle:@" "
                           delegate:self
                           cancelButtonTitle:nil
                           destructiveButtonTitle:nil
                           otherButtonTitles:nil];
            
            for (int i = 0; i < [getalltalukaarray count]; i++) {
                [actionSheet addButtonWithTitle:[getalltalukaarray objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [actionSheet showFromRect:[self.txt_taluka frame] inView:self.view animated:YES];
            }
            else {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 8;
            
            //[appdelegate hideAlert];
        }
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

- (void)actionSheet:(UIActionSheet*)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
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
                    str = [getallstatesarray objectAtIndex:buttonIndex];
                    NSLog(@"Sates : %@", str);
                    self.txt_state.text = NSLocalizedString([showStates objectAtIndex:buttonIndex], @"");
                    self.tx_district.text = @"";
                    self.txt_city.text = @"";
                    self.txt_taluka.text = @"";
                    //self.textpostalcode.text=@"";
                    
                    NSLog(@"state code %@", str);
                }
        }
    }
    if (self.tx_district) {
        NSLog(@"... in");
        switch (popup.tag) {
            case 6:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    NSLog(@"ek..");
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    self.tx_district.text = NSLocalizedString([getalldistrictarray objectAtIndex:buttonIndex], @"");
                    self.txt_city.text = @"";
                    self.txt_taluka.text = @"";
                    
                    //self.textpostalcode.text=@"";
                }
        }
    }
    if (self.txt_city) {
        NSLog(@"... in");
        switch (popup.tag) {
                
            case 7:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    NSLog(@"ek..");
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    self.txt_city.text = NSLocalizedString([getallcitiesarray objectAtIndex:buttonIndex], @"");
                    self.txt_taluka.text = @"";
                    //self.textpostalcode.text=@"";
                }
        }
    }
    if (self.txt_taluka) {
        NSLog(@"... in");
        switch (popup.tag) {
            case 8:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    NSLog(@"ek..");
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    self.txt_taluka.text = NSLocalizedString([getalltalukaarray objectAtIndex:buttonIndex], @"");
                }
        }
    }
    if (self.txt_pincode) {
        NSLog(@"... in");
        switch (popup.tag) {
            case 9:
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    NSLog(@"ek..");
                    return;
                }
                else {
                    NSLog(@"Button index %ld", (long)buttonIndex);
                    self.txt_pincode.text = NSLocalizedString([getallpincode objectAtIndex:buttonIndex], @"");
                }
        }
    }
}

- (IBAction)btncreatecontact:(id)sender
{
    
    if (![self connected]) {
        [self hideAlert];
        alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Internet Connection not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        
        [self showAlert];
        if ([_txt_firstname.text isEqual:@""]) {
            [self hideAlert];
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter mandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        else if ([_txt_lastname.text isEqual:@""]) {
            [self hideAlert];
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:@" Please enter LAST NAME" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        else if ([_txt_phonenumber.text isEqual:@""]) {
            [self hideAlert];
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:@" Please enter CELL NUMBER" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_txt_phonenumber.text && _txt_phonenumber.text.length < 10) {
            [self hideAlert];
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid CELL NUMBER" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        else if ([_txt_pannumber.text isEqual:@""]) {
            [self hideAlert];
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:@" Please enter PAN NUMBER" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_txt_pannumber.text && _txt_pannumber.text.length < 10) {
            [self hideAlert];
            
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid PAN NUMBER" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        else if ([mobileNumberPred evaluateWithObject:_txt_phonenumber.text] != YES && [_txt_phonenumber.text length] != 0) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid CELL NUMBER" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
        else if ([emailTest evaluateWithObject:_txt_emailID.text] != YES && [_txt_emailID.text length] != 0) {
            [self hideAlert];
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid EMAIL ADDRESS" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
        else if ([_txt_addressline1.text isEqual:@""]) {
            [self hideAlert];
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@" Please enter Address " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        else if ([_txt_addressline2.text isEqual:@""]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@" Please enter Address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        else if ([_tx_district.text isEqual:@""]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@" Please select District" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        else if ([_txt_city.text isEqual:@""]) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@" Please select City" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        else {
            NSLog(@"\n\n btn create contact....!!!");
            [self createContact];
        }
    }
}

- (void)createContact
{
    
    NSString* envelopeText = [NSString stringWithFormat:
                              @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              @"<SOAP:Body>"
                              @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                              @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                              @"<Contact>"
                              @"<CellularPhone>%@</CellularPhone>"
                              @"<SocialSecurityNumber>%@</SocialSecurityNumber>"
                              @"<EmailAddress>%@</EmailAddress>" // Email Id
                              @"<FirstName>%@</FirstName>" // First Name
                              @"<IntegrationId>%ld</IntegrationId>" // Current System Time in milliSec Time in Milliseconds
                              @"<LastName>%@</LastName>" //Last Name
                              @"<ListOfRelatedSalesRep>"
                              @"<RelatedSalesRep>"
                              @"<Position>%@</Position>" // UserDetails. Getposition name
                              @"<Id>%@</Id>" //UserDetails Row ID
                              @"</RelatedSalesRep>"
                              @"</ListOfRelatedSalesRep>"
                              @"<ListOfRelatedOrganization>"
                              @"<RelatedOrganization>"
                              @"<Organization>%@</Organization>" // User Deatails Get Org name
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
                              @"<TMArea>%@</TMArea>"
                              @"<PersonalPostalCode>%@</PersonalPostalCode>"
                              @"</PersonalAddress>"
                              @"</ListOfPersonalAddress>"
                              @"</Contact>"
                              @"</ListOfContactInterface>"
                              @"</SFATMCVContactInsertOrUpdate_Input>"
                              @"</SOAP:Body>"
                              @"</SOAP:Envelope>",
                              _txt_phonenumber.text, _txt_pannumber.text, _txt_emailID.text, _txt_firstname.text, (long)[[NSDate date] timeIntervalSince1970], _txt_lastname.text, userDetailsVal_.POSITION_NAME, userDetailsVal_.ROW_ID, userDetailsVal_.ORGNAME, (long)[[NSDate date] timeIntervalSince1970], _txt_addressline1.text, _txt_addressline2.text, str, _tx_district.text, _txt_city.text, _txt_taluka.text, _txt_Area.text,_txt_pincode.text];
    
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
    [[RequestDelegate alloc] initiateRequest:request name:@"CreateContactConnetction"];
}

- (void)createcontact_found:(NSNotification*)notification
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
            
            ContactID = [TBXML textForElement:Id];
            
            NSString* irnt = [TBXML textForElement:Integration];
            
            NSLog(@"contact id  %@", ContactID);
            
            NSLog(@"contact id  %@", irnt);
            
            [self callCreateAccountConnection];
            
            //            [self hideAlert];
            //
            //            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Prospect Created successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            //            [alertView show];
        }
        else {
            [self hideAlert];
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Something Went Wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            [alertView show];
        }
    }
}

- (void)callCreateAccountConnection
{
    NSLog(@"\n\n.. create Account Connection ");
    NSLog(@"\n\n.. _strcontact %@", ContactID);
    
    NSString* envelopeText = [NSString stringWithFormat:
                              @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\">"
                              @"<soapenv:Header/>"
                              @"<soapenv:Body>"
                              @"<asi:SFATMCVContactQueryById_Input>"
                              @"<asi:PrimaryRowId>%@</asi:PrimaryRowId>"
                              @"</asi:SFATMCVContactQueryById_Input>"
                              @"</soapenv:Body>"
                              @"</soapenv:Envelope>",
                              ContactID];
    
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
                              Wcontactid, self.txt_firstname.text, self.txt_lastname.text, Waddressid, Wintgration, WpersonalName, self.txt_addressline1.text, self.txt_addressline2.text, self.txt_Area.text, str, self.tx_district.text, self.txt_city.text, self.txt_taluka.text];
    
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
        if ([response rangeOfString:@"Personal Address"].location != NSNotFound) {
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Contact with same personal address already exist " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else {
            
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
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
            
            NSLog(@"contact id  %@", idstring);
            
            NSLog(@"contact id  %@", irnt);
            
            [self hideAlert];
            
            self.txt_firstname.text = @"";
            self.txt_lastname.text = @"";
            self.txt_pannumber.text = @"";
            self.txt_phonenumber.text = @"";
            self.txt_state.text = @"";
            self.txt_taluka.text = @"";
            self.txt_emailID.text = @"";
            self.txt_city.text = @"";
            self.txt_Area.text = @"";
            self.txt_addressline2.text = @"";
            self.txt_addressline1.text = @"";
            self.tx_district.text = @"";
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Prospect created successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else {
            [self hideAlert];
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Something Went Wronge" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            [alertView show];
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
    if ([self.txt_pannumber isFirstResponder])
    {
        CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = -keyboardSize.height;
            self.view.frame = f;
        }];
        //[self.view setFrame:CGRectMake(0,-250,self.view.bounds.size.width,self.view.bounds.size.height)];
    }
    else
    {
        
        [self.view setFrame:CGRectMake(0,-110,self.view.bounds.size.width,self.view.bounds.size.height)];
    }
    
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
