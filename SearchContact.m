//
//  SearchContact.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 11/18/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//
//
//  SearchContact.m
//  CRM_APP
//
//  Created by Rishikesh Pange on 11/4/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "SearchContact.h"
#import "RequestDelegate.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface SearchContact ()

@end

@implementation SearchContact

- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(contactlistfetchedAlert:) name:@"Contact_ListPopulated" object:nil];
}
-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

-(void)contactlistfetchedAlert:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    [self hideAlert];
    
}

- (IBAction)SearchContacts:(id)sender
{
    NSUInteger testLen = [self length:self.SearchContact.text];
    
    if ([self.SearchContact.text isEqual:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil  message:@"Please enter valid Cell number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
    {
        if (testLen ==10)
        {
            //                NSNotification *Taluka_Notification = [NSNotification notificationWithName:@"Contact_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
            //                [[NSNotificationQueue defaultQueue]enqueueNotification:Taluka_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
            [self showAlert];
            NSString * envelopeText = [NSString stringWithFormat:
                                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @" <SOAP:Body>"
                                       @" <SFATMCVContactQueryByExample_Input xmlns=\"http://siebel.com/asi/\">"
                                       @" <ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                       @" <Contact>"
                                       @" <CellularPhone>%@</CellularPhone>"
                                       @" </Contact>"
                                       @" </ListOfContactInterface>"
                                       @" </SFATMCVContactQueryByExample_Input>"
                                       @" </SOAP:Body>"
                                       @"</SOAP:Envelope>",self.SearchContact.text];
            
            
            
            NSString *newString = [envelopeText stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSData *envelope = [newString dataUsingEncoding:NSUTF8StringEncoding];
            NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
            
            NSLog(@"URL IS .... %@",theurl);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
            NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
            [[RequestDelegate alloc]initiateRequest:request name:@"GetContact"];
            
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"DSE" message:@"Please enter 10 digit Cell number that doesn't start with '0'" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            // self.Phone_Number_txt_field.text = @"";
            
            
        }
    }
    
    
}
-(NSUInteger)length :(NSString *)inputString
{
    NSUInteger length = [inputString length];
    return length;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismissView:(id)sender
{
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
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