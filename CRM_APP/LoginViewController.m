//
//  LoginViewController.m
//  test
//
//  Created by admin on 02/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "DetailViewController.h"
#import "LoginViewController.h"
#import "MasterViewController.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "AppDelegate.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#import "MBProgressHUD.h"
#import "DSE.h"
#import "DSM.h"
@interface LoginViewController () {
    NSString *userName, *passWord, *user, *pass;
    NSString *password, *usernamme;
    NSArray* logingetUD;
    int* imageflag;
}
@end
@implementation LoginViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    NSLog(@"login..");

    imageflag = 0;
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager];
    userDetailsVal_.Login_Name = @"";
    appdelegate.flagappname = @"";
    userDetailsVal_.ROW_ID = @"";
    NSLog(@"row id cleared%@", userDetailsVal_.ROW_ID);
    user = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    pass = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];

    NSString* number = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];

    NSLog(@".... Detials : %@ %@--> %@", user, pass, number);

    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance

    [self.username setBackgroundColor:[UIColor clearColor]];
    [self.username.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.username setTextColor:[UIColor colorWithRed:(0 / 255.0)green:(0 / 255.0)blue:(0 / 255.0)alpha:1]];
    [self.username.layer setBorderWidth:1.0];
    ;
    [self.username.layer setCornerRadius:16.0f];
    self.username.textAlignment = NSTextAlignmentCenter;
    if ([self.username respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor* color = [UIColor blackColor];
        self.username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"USER ID" attributes:@{ NSForegroundColorAttributeName : color }];
    }
    else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    // self.username.placeholder = @"Username";

    [self.password setBackgroundColor:[UIColor clearColor]];
    [self.password.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.password setTextColor:[UIColor colorWithRed:(0 / 255.0)green:(0 / 255.0)blue:(0 / 255.0)alpha:1]];
    [self.password.layer setBorderWidth:1.0];
    [self.password.layer setCornerRadius:16.0f];
    self.password.placeholder = @"Password";
    self.password.textAlignment = NSTextAlignmentCenter;
    if ([self.password respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor* color = [UIColor blackColor];
        self.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PASSWORD" attributes:@{ NSForegroundColorAttributeName : color }];
    }
    else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    self.LoginButton.layer.cornerRadius = 16; // this value vary as per your desire
    self.LoginButton.clipsToBounds = YES;
    globalVariables_ = [[GlobalVariables alloc] init];
    userDetailsVal_ = [UserDetails_Var sharedmanager];
    if (!GlobalVariablesArray_) {
        GlobalVariablesArray_ = [[NSMutableArray alloc] init];
    }
    else {
        
        [GlobalVariablesArray_ removeAllObjects];
        
    }
    
    password = [SSKeychain passwordForService:@"AnyService" account:@"AnyUser"];
    usernamme = [SSKeychain passwordForService:@"AnyService" account:@"AnyUser1"];
    self.username.text = usernamme;
    self.password.text = password;

   //self.username.text=@"SARITAK_1001680";    // For NEEv
  //self.password.text=@"TATA2015";

//   self.username.text=@"SAMSONJ1001680";   // For DSM
//     self.password.text=@"CVBU2016";

   self.username.text = @"JJOSHI1001680";  // For DSE
   self.password.text = @"NANO2016";
    
    _transitionImageView = [[LTransitionImageView alloc] initWithFrame:CGRectMake(20, 50, 600, 600)];
    
    _transitionImageView.animationDuration = 3;
    
    [self.view addSubview:_transitionImageView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSLog(@"\n View Will Appear.....");

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(artifactFound:) name:@"artifactFound" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(artifactFailed:) name:@"artifactFailed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authenticateOIDFound:) name:@"authenticateOIDFound" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestDateFound:) name:@"requestDateFound" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDetailsFound:) name:@"userDetailsFound" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDetailsFailed:) name:@"userDetailsFailed" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    NSLog(@"\nView Did Dissapears...!!!!");

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"artifactFound" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"artifactFailed" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"authenticateOIDFound" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"requestDateFound" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userDetailsFound" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userDetailsFailed" object:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        [self startAnimations];
    });
}

- (void)didReceiveMemoryWarning
{
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
- (IBAction)loginScreeb:(id)sender
{
    // [self callArtifactRequest];

    userName = self.username.text;
    passWord = self.password.text;
    
    NSLog(@"Username : - %@", self.username.text);
    NSLog(@"Password : - %@", self.password.text);

    NSLog(@"app status %@", appdelegate.flagappname);

    [self showAlert];

    if (self.username.text.length == 0 || self.password.text.length == 0) {
        
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Please enter USER ID and PASSWORD" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else {
        if (imageflag == 0) {
            
            [SSKeychain setPassword:@"" forService:@"AnyService" account:@"AnyUser"];
            [SSKeychain setPassword:@"" forService:@"AnyService" account:@"AnyUser1"];
            
        }
        else {

            [SSKeychain setPassword:self.password.text forService:@"AnyService" account:@"AnyUser"];
            [SSKeychain setPassword:self.username.text forService:@"AnyService" account:@"AnyUser1"];
        }
        [self callArtifactRequest];
    }

    /*  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
     MasterViewController *masterViewController = [storyboard instantiateViewControllerWithIdentifier:@"masterViewController"];
     
     self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
     self.window.rootViewController = self.navigationController;
     } else {
     MasterViewController *masterViewController = [storyboard instantiateViewControllerWithIdentifier:@"masterViewController"];
     UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
     
     DetailViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
     
     
     UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
     
     masterViewController.detailViewController = detailViewController;
     
     self.splitViewController = [[UISplitViewController alloc] init];
     self.splitViewController.delegate = detailViewController;
     self.splitViewController.viewControllers = @[masterNavigationController, detailNavigationController];
     
     self.window.rootViewController = self.splitViewController;
     }
     [self.window makeKeyAndVisible];*/
    //return YES;

    /*
    AppDelegate* app_delegate=[[UIApplication sharedApplication] delegate];
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         UISplitViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SplitView"];
         //self.window = [[UIApplication sharedApplication] keyWindow];
         app_delegate.window.rootViewController= vc;*/

    NSLog(@"SamlArt Not found's.....");
    // UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"The internet connection seems to be offline!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    // [alertView show];
    // [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:NO];
    
    
    
}

- (void)callArtifactRequest
{

    NSLog(@"appname %@", appdelegate.flagappname);

    NSString* envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Header>"
                                       @"<wsse:Security xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\">"
                                       @"<wsse:UsernameToken xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\">"
                                       @"<wsse:Username>%@</wsse:Username>"
                                       @"<wsse:Password>%@</wsse:Password>"
                                       @"</wsse:UsernameToken>"
                                       @"</wsse:Security>"
                                       @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                       @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\"/>"
                                       @"</header>"
                                       @"</SOAP:Header>"
                                       @"<SOAP:Body>"
                                       @"<samlp:Request xmlns:samlp=\"urn:oasis:names:tc:SAML:1.0:protocol\" MajorVersion=\"1\" MinorVersion=\"1\" IssueInstant=\"2010-05-03T06:53:51Z\" RequestID=\"aa23159489-0126-1853-28ca-d7024556c36\">"
                                       @"<samlp:AuthenticationQuery>"
                                       @"<saml:Subject xmlns:saml=\"urn:oasis:names:tc:SAML:1.0:assertion\">"
                                       @"<saml:NameIdentifier Format=\"urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified\">%@</saml:NameIdentifier>"
                                       @"</saml:Subject>"
                                       @"</samlp:AuthenticationQuery>"
                                       @"</samlp:Request>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",
                                       self.username.text, self.password.text, self.username.text];

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    //<string name="URL">https://tmcrmappsqa.inservices.tatamotors.com/cordys/com.eibus.web.soap.Gateway.wcp?organization=o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com</string>
    NSURL* theurl = [NSURL URLWithString:@"http://tmcrmappsqa.inservices.tatamotors.com/cordys/com.eibus.web.soap.Gateway.wcp?organization=o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com"];

    //NSURL * theurl = [NSURL URLWithString:@"http://172.24.29.100/cordys/WSDLGateway.wcp?service=http%3A%2F%2Fschemas.cordys.com%2Fcom.cordys.tatamotors.tmwebauthwsapps/GetWebAuthByKey&organization=o%3DMobileApps%2Ccn%3Dcordys%2Ccn%3Dcbop%2Co%3Dtatamotors.com&version=isv"];

    //NSURL * theurl = [NSURL URLWithString:@"http://tmcrmappsqa.inservices.tatamotors.com/cordys/com.eibus.web.soap.Gateway.wcp?organization=o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com"];
    NSLog(@"URL IS %@", theurl);
    NSLog(@"REQUEST IS %@", envelopeText);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50];
    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc] initiateRequest:request name:@"artifactRequest"];
}
- (void)artifactFound:(NSNotification*)notification
{

    NSLog(@"APP NAME %@", appdelegate.flagappname);

    NSLog(@"World Cup");
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    if ([response rangeOfString:@"samlp:Response"].location == NSNotFound) {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid USER ID/PASSWORD" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        @try {
            TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            TBXMLElement* body = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
            // TBXMLElement *keyResponse = [TBXML childElementNamed:@"GetWebAuthByKeyResponse" parentElement:body];
            // TBXMLElement *envelope = [TBXML childElementNamed:@"SOAP:Envelope" parentElement:keyResponse];
            //TBXMLElement *innerBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:envelope];
            TBXMLElement* samlResponse = [TBXML childElementNamed:@"samlp:Response" parentElement:body];
            if (samlResponse) {
                TBXMLElement* art = [TBXML childElementNamed:@"samlp:AssertionArtifact" parentElement:samlResponse];
                appdelegate.artifact = [TBXML textForElement:art];
                NSLog(@"Samlp Art: %@", appdelegate.artifact);
                // NSLog(@"%@",appdelegate.artifact);
                //   globalVariables_.g_Artifact = appdelegate.artifact;
                //   [GlobalVariablesArray_ addObject:globalVariables_.g_Artifact];
                //[appdelegate hideAlert];
                //  [self callauthenticateOIDRequest];
                [self callDateRequest];
                [self CallUserDetails];
            }
            else {
                [self hideAlert];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Error in connecting to server. Please try later!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
        @catch (NSException* exception) {
            [self hideAlert];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Error in connecting to server. Please try later!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}
- (void)artifactFailed:(NSNotification*)notification
{
    NSString* errorString = [[notification userInfo] objectForKey:@"error"];
    NSLog(@"%@", errorString);
    if ([errorString isEqualToString:@"offline"]) {
        [self hideAlert];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"The internet connection seems to be offline!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:NO];
    }
}
- (void)callDateRequest
{

    NSString* envelopeText = [NSString stringWithFormat:

                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body><getCurrentDate xmlns=\"http://schemas.cordys.com/DateUtils\" />"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>"];

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    NSLog(@"URL IS .... %@", theurl);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc] initiateRequest:request name:@"dateRequest"];
}

- (void)requestDateFound:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement* body = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];

    TBXMLElement* currentDate = [TBXML childElementNamed:@"getCurrentDate" parentElement:[TBXML childElementNamed:@"getCurrentDate" parentElement:[TBXML childElementNamed:@"old" parentElement:[TBXML childElementNamed:@"tuple" parentElement:[TBXML childElementNamed:@"getCurrentDateResponse" parentElement:body]]]]];

    NSString* _ParseCurrentDate = [TBXML textForElement:currentDate];

    NSLog(@"\nCurrent date...!!!! %@", _ParseCurrentDate);
    // Convert string to date object
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    NSDate* date = [dateFormat dateFromString:_ParseCurrentDate];

    NSLog(@"\nCurrent dateaa...!!!! %@", date);
}

- (void)callauthenticateOIDRequest
{
    NSLog(@"inside ...CallAunthrnticate");

    NSString* envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<authenticateAgainstOID xmlns=\"http://schemas.cordys.com/OIDAuthentication\">"
                                       @"<stringParam>%@</stringParam>"
                                       @"<stringParam1>%@</stringParam1>"
                                       @"</authenticateAgainstOID>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",
                                       _username.text, _password.text];

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Envelop..%@", envelope);
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    NSLog(@"URL..%@", theurl);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc] initiateRequest:request name:@"authenticateOIDRequest"];
}
- (void)authenticateOIDFound:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"The username or password you entered is incorrect.\n*The user account will be locked after 3 unsucessfull attempts." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self hideAlert];
    }
    else {
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        NSLog(@"Error TBXML...%@", tbxml);
        NSLog(@"Error ...%@", err);
        TBXMLElement* body = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
        TBXMLElement* auth1 = [TBXML childElementNamed:@"authenticateAgainstOID" parentElement:[TBXML childElementNamed:@"old" parentElement:[TBXML childElementNamed:@"tuple" parentElement:[TBXML childElementNamed:@"authenticateAgainstOIDResponse" parentElement:body]]]];

        TBXMLElement* auth = [TBXML childElementNamed:@"authenticateAgainstOID" parentElement:auth1];
        NSLog(@"Authentication....%@", auth);
        if (auth) {
            NSLog(@"\nLogin Authentications ... is true....");
            [self callDateRequest];
            [self CallUserDetails];
        }
        else {
            NSLog(@"\n Login Autntications .... are fail.... ");
        }
    }
}

- (void)CallUserDetails
{

    NSLog(@"test user %@", self.username.text);

    NSString* envelopeText = [NSString stringWithFormat:
                                           @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetPositionDetailsFromLogin xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<LOGIN>%@</LOGIN>"
                                       @"</GetPositionDetailsFromLogin>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",
                                       self.username.text];

    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];

    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    NSLog(@"URL IS %@", theurl);
    NSLog(@"REQUEST IS %@", envelopeText);

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];

    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];

    [[RequestDelegate alloc] initiateRequest:request name:@"userDetailsRequest"];
}
- (void)userDetailsFound:(NSNotification*)notification
{
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    
    NSLog(@"response %@",response);
 
    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];

    //clear userdetails
    /*
     Login_Name,
     POSITION_NAME,
     LOB_NAME,
     REGION_NAME,
     AREA,
     STATE,
     ROW_ID,
     POSTN,
     ORGNAME
     */
    [userDetailsArray removeAllObjects];

    userDetailsVal_.Login_Name = @"";
    userDetailsVal_.POSITION_NAME = @"";
    userDetailsVal_.LOB_NAME = @"";
    userDetailsVal_.REGION_NAME = @"";
    userDetailsVal_.AREA = @"";
    userDetailsVal_.STATE = @"";
    userDetailsVal_.ROW_ID = @"";
    userDetailsVal_.POSTN = @"";
    userDetailsVal_.ORGNAME = @"";
    //  userDetailsVal_.POSITION_NAME=@"";
    appdelegate.flagappname = @"";

    NSLog(@"appname %@", appdelegate.flagappname);
    
    
    NSLog(@" user values %@,%@,%@,%@,%@,%@,%@,%@,%@", userDetailsVal_.Login_Name, userDetailsVal_.POSITION_NAME, userDetailsVal_.LOB_NAME, userDetailsVal_.REGION_NAME, userDetailsVal_.AREA, userDetailsVal_.STATE, userDetailsVal_.ROW_ID, userDetailsVal_.POSTN, userDetailsVal_.ORGNAME);
    TBXMLElement* soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement* container = [TBXML childElementNamed:@"GetPositionDetailsFromLoginResponse" parentElement:soapBody];
    
    if (container) {
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            container = [TBXML childElementNamed:@"S_USER" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            TBXMLElement* POSITION_NAME = [TBXML childElementNamed:@"POSITION_NAME" parentElement:container];
            NSString* _POSITION_NAME = [TBXML textForElement:POSITION_NAME];
            userDetailsVal_.POSITION_NAME = _POSITION_NAME;
            NSLog(@"\n POSITION_NAME %@", _POSITION_NAME);
            NSLog(@"\n POSITION_NAME %@", _POSITION_NAME);
            logingetUD = [_POSITION_NAME componentsSeparatedByString:@"-"];
            NSLog(@"Elents...on   %@", [logingetUD objectAtIndex:[logingetUD count] - 1]);
            appdelegate.loginUD = [logingetUD objectAtIndex:[logingetUD count] - 3];
            TBXMLElement* LOB_NAME = [TBXML childElementNamed:@"LOB_NAME" parentElement:container];
            NSString* _LOB_NAME = [TBXML textForElement:LOB_NAME];
            userDetailsVal_.LOB_NAME = _LOB_NAME;
            NSLog(@"\n LOB_NAME %@", _LOB_NAME);
            TBXMLElement* REGION_NAME = [TBXML childElementNamed:@"REGION_NAME" parentElement:container];
            NSString* _REGION_NAME = [TBXML textForElement:REGION_NAME];
            userDetailsVal_.REGION_NAME = _REGION_NAME;
            NSLog(@"\n REGION_NAME %@", _REGION_NAME);

            TBXMLElement* AREA = [TBXML childElementNamed:@"AREA" parentElement:container];
            NSString* _AREA = [TBXML textForElement:AREA];
            userDetailsVal_.AREA = _AREA;
            NSLog(@"\n _AREA %@", _AREA);

            TBXMLElement* STATE = [TBXML childElementNamed:@"STATE" parentElement:container];
            NSString* _STATE = [TBXML textForElement:STATE];
            userDetailsVal_.STATE = _STATE;
            NSLog(@"\n _AREA %@", _STATE);

            TBXMLElement* ROW_ID = [TBXML childElementNamed:@"ROW_ID" parentElement:container];
            NSString* _ROW_ID = [TBXML textForElement:ROW_ID];
            userDetailsVal_.ROW_ID = _ROW_ID;
            NSLog(@"\n _ROW_ID %@", _ROW_ID);

            TBXMLElement* POSTN = [TBXML childElementNamed:@"POSTN" parentElement:container];
            NSString* _POSTN = [TBXML textForElement:POSTN];
            userDetailsVal_.POSTN = _POSTN;
            NSLog(@"\nuser application type  %@", _POSTN);

            TBXMLElement* ORGNAME = [TBXML childElementNamed:@"ORGNAME" parentElement:container];
            NSString* _ORGNAME = [TBXML textForElement:ORGNAME];
            userDetailsVal_.ORGNAME = _ORGNAME;
            NSLog(@"\n _ORGNAME %@", userDetailsVal_.ORGNAME);

            userDetailsVal_.Login_Name = self.username.text;
            NSManagedObjectContext* context;

            userDetailsVal_.PassWord = self.password.text;
            NSLog(@"\n Password %@", userDetailsVal_.PassWord); //JUST TEST

            if ([userDetailsVal_.Login_Name isEqualToString:@"SAMSONJ1001680"]) {

                appdelegate.flagappname = @"DSM";

                context = [appdelegate managedObjectContext];
                DSM* opty = [NSEntityDescription
                    insertNewObjectForEntityForName:@"DSM"
                             inManagedObjectContext:context];
                opty.firstname = @"NIHAL";
                opty.lastname = @"SHEIKH";
                opty.cellnumber = @"8899007788";
                opty.email = @"nihal.sheikh@gmail.com";

                opty.area = @"Rahimatpur";
                opty.state = @"Maharashtra";
                opty.district = @"Satara";
                opty.city = @"Rahimatpur";
                opty.taluka = @"Koregaon";
                opty.panchayat = @"Rahimatpur";
                opty.pincode = @"415511";
                opty.accountname = @"Nihal";

                opty.lob = @"LCV";
                opty.ppl = @"7TONNNETRUCKS";
                opty.pl = @"LPT613";
                opty.application = @"BOTTLECARRIER";
                opty.sourceofcontact = @"SHOWROOM WALKIN";
                opty.financier = @"SELF";

                NSError* error;

                if (![context save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
            }
            else if ([userDetailsVal_.Login_Name isEqualToString:@"SARITAK_1001680"]) {
                appdelegate.flagappname = @"NEEV";
            }
            else if ([userDetailsVal_.Login_Name isEqualToString:@"JJOSHI1001680"]) {

                appdelegate.flagappname = @"DSE";

                context = [appdelegate managedObjectContext];
                DSE* opty = [NSEntityDescription
                    insertNewObjectForEntityForName:@"DSE"
                             inManagedObjectContext:context];
                opty.firstname = @"RISHIKESH";
                opty.lastname = @"PANGE";
                opty.cellnumber = @"8899007788";
                opty.email = @"rishikesh.pange@gmail.com";

                opty.area = @"mumbai";
                opty.state = @"mumbai";
                opty.district = @"mumbai";
                opty.city = @"mumbai";
                opty.taluka = @"mumbai";
                opty.panchayat = @"mumbai";
                opty.pincode = @"mumbai";
                opty.accountname = @"amol";

                opty.lob = @"LCV";
                opty.ppl = @"7TONNNETRUCKS";
                opty.pl = @"LPT613";
                opty.application = @"BOTTLECARRIER";
                opty.sourceofcontact = @"SHOWROOM WALKIN";
                opty.financier = @"SELF";

                NSError* error;

                if (![context save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
            }

            NSLog(@"\n _ORGNAME %@", userDetailsVal_.Login_Name); //JUST TEST

            [self hideAlert];

            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                MasterViewController* masterViewController = [storyboard instantiateViewControllerWithIdentifier:@"masterViewController"];

                self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
                self.window.rootViewController = self.navigationController;
            }
            else {
                MasterViewController* masterViewController = [storyboard instantiateViewControllerWithIdentifier:@"masterViewController"];
                UINavigationController* masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];

                DetailViewController* detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];

                UINavigationController* detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];

                masterViewController.detailViewController = detailViewController;

                self.splitViewController = [[UISplitViewController alloc] init];
                self.splitViewController.delegate = detailViewController;
                self.splitViewController.viewControllers = @[ masterNavigationController, detailNavigationController ];

                self.window.rootViewController = self.splitViewController;
            }
            [self.window makeKeyAndVisible];
        }
        else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)userDetailsFailed:(NSNotification*)notification
{
    NSString* errorString = [[notification userInfo] objectForKey:@"error"];
    NSLog(@"\n artifactFailed%@", errorString);

    if ([errorString isEqualToString:@"offline"]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"The internet connection seems to be offline!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:NO];
    }
    else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"DSM" message:@"Request time out Please Try Later!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:NO];
    }
}

- (void)showAlert
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)startAnimations
{
    CGFloat delay = _transitionImageView.animationDuration + 1;

    _transitionImageView.animationDirection = AnimationDirectionLeftToRight;
    _transitionImageView.image = [UIImage imageNamed:@"sti01.jpg"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        _transitionImageView.animationDirection = AnimationDirectionTopToBottom;
        _transitionImageView.image = [UIImage imageNamed:@"sti02.jpg"];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
            _transitionImageView.animationDirection = AnimationDirectionRightToLeft;
            _transitionImageView.image = [UIImage imageNamed:@"sti03.jpg"];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                _transitionImageView.animationDirection = AnimationDirectionBottomToTop;
                _transitionImageView.image = [UIImage imageNamed:@"sti04.jpg"];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                    _transitionImageView.animationDirection = AnimationDirectionTopToBottom;
                    _transitionImageView.image = [UIImage imageNamed:@"sti05.jpg"];

                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
                        [self startAnimations];
                    });
                });
            });
        });
    });
}
@end
