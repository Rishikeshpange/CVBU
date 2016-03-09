//
//  EditViewController.m
//  CRM_APP
//
//  Created by Preeti Sakhare on 10/7/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "EditViewController.h"
#import "MLPAutoCompleteTextField.h"
#import "DEMOCustomAutoCompleteCell.h"
#import "DEMOCustomAutoCompleteObject.h"
#import "DEMODataSource.h"
#import "Distrcit.h"
#import <QuartzCore/QuartzCore.h>
#import "RequestDelegate.h"
#import "TBXML.h"

@interface EditViewController ()

@end


@implementation EditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    
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
    
    
   self.dict = [[NSMutableDictionary alloc]initWithCapacity:[countries  count]];
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

    
    self.District_List_PickerArr = [[NSMutableArray alloc] init];
    self.City_List_PickerArr = [[NSMutableArray alloc] init];
    self.Taluka_List_PickerArr = [[NSMutableArray alloc] init];
    
    self.firstname.text=[self.Editdetail valueForKey:@"firstname"];
    self.lastname.text=[self.Editdetail valueForKey:@"lastname"];
    self.emailid.text=[self.Editdetail valueForKey:@"email"];
    self.cellnumber.text=[self.Editdetail valueForKey:@"cellnumber"];
    self.Area.text=[self.Editdetail valueForKey:@"area"];
  
    self.Lob.text=[self.Editdetail valueForKey:@"lob"];
    
    self.PPL.text =[self.Editdetail valueForKey:@"ppl"];
    self.PL.text =[self.Editdetail valueForKey:@"pl"];
    self.Application.text =[self.Editdetail valueForKey:@"application"];
    self.Financier.text =[self.Editdetail valueForKey:@"financier"];
    
    
    [self.autocompleteTextField setAutoCompleteTableAppearsAsKeyboardAccessory:NO];
    
    //[self setSimulateLatency:YES]; //Uncomment to delay the return of autocomplete suggestions.
    //[self setTestWithAutoCompleteObjectsInsteadOfStrings:YES]; //Uncomment to return autocomplete objects instead of strings to the textfield.
    
    //[self.autocompleteDataSource setSimulateLatency:YES];
    //[self.autocompleteDataSource setTestWithAutoCompleteObjectsInsteadOfStrings:YES];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowWithNotification:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideWithNotification:) name:UIKeyboardDidHideNotification object:nil];
    
    //Supported Styles:
    //[self.autocompleteTextField setBorderStyle:UITextBorderStyleBezel];
    //[self.autocompleteTextField setBorderStyle:UITextBorderStyleLine];
    //[self.autocompleteTextField setBorderStyle:UITextBorderStyleNone];
    
    [self.autocompleteTextField setBorderStyle:UITextBorderStyleRoundedRect];
    
    //[self.autocompleteTextField setShowAutoCompleteTableWhenEditingBegins:YES];
    //[self.autocompleteTextField setAutoCompleteTableBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    
    //You can use custom TableViewCell classes and nibs in the autocomplete tableview if you wish.
    //This is only supported in iOS 6.0, in iOS 5.0 you can set a custom NIB for the cell
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending) {
        [self.autocompleteTextField registerAutoCompleteCellClass:[DEMOCustomAutoCompleteCell class]
                                           forCellReuseIdentifier:@"CustomCellId"];
    }
    else{
        //Turn off bold effects on iOS 5.0 as they are not supported and will result in an exception
        self.autocompleteTextField.applyBoldEffectToAutoCompleteSuggestions = NO;
    }

    // Do any additional setup after loading the view.
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"\n View Will Appear.....");
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Alldistricts_Found:) name:@"Alldistricts_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AllCities_Found:) name:@"Allcities_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Taluka_ListFound:) name:@"Alltaluka_Found" object:nil];
    
    
       
    
}

- (void)keyboardDidShowWithNotification:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGPoint adjust;
                         switch (self.interfaceOrientation) {
                             case UIInterfaceOrientationLandscapeLeft:
                                 adjust = CGPointMake(-110, 0);
                                 break;
                             case UIInterfaceOrientationLandscapeRight:
                                 adjust = CGPointMake(110, 0);
                                 break;
                             default:
                                 adjust = CGPointMake(0, -60);
                                 break;
                         }
                         CGPoint newCenter = CGPointMake(self.view.center.x+adjust.x, self.view.center.y+adjust.y);
                         [self.view setCenter:newCenter];
                         [self.author setAlpha:0];
                         [self.demoTitle setAlpha:0];
                         [self.typeSwitch setAlpha:0];
                         
                     }
                     completion:nil];
}


- (void)keyboardDidHideWithNotification:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGPoint adjust;
                         switch (self.interfaceOrientation) {
                             case UIInterfaceOrientationLandscapeLeft:
                                 adjust = CGPointMake(110, 0);
                                 break;
                             case UIInterfaceOrientationLandscapeRight:
                                 adjust = CGPointMake(-110, 0);
                                 break;
                             default:
                                 adjust = CGPointMake(0, 60);
                                 break;
                         }
                         CGPoint newCenter = CGPointMake(self.view.center.x+adjust.x, self.view.center.y+adjust.y);
                         [self.view setCenter:newCenter];
                         [self.author setAlpha:1];
                         [self.demoTitle setAlpha:1];
                         [self.typeSwitch setAlpha:1];
                     }
                     completion:nil];
    
    
    [self.autocompleteTextField setAutoCompleteTableViewHidden:NO];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MLPAutoCompleteTextField Delegate


- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
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
        if (textField.tag==1) {
            
        
        NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        @"<SOAP:Body>"
        @"<GetAllIndianDistricts xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
        @"<state>%@</state>"
        @"</GetAllIndianDistricts>"
        @"</SOAP:Body>"
        @"</SOAP:Envelope>",[self.dict valueForKey:selectedString]];
        
        
        NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
        NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
        NSLog(@"URL IS .... %@",theurl);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
        NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
        [[RequestDelegate alloc]initiateRequest:request name:@"AllDistricts"];
        
        }
        
        
        else if (textField.tag ==2)
        {
            
            NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetAllIndianCity xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<state>%@</state>"
                                       @"<dist>%@</dist>"
                                       @"</GetAllIndianCity>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",[self.dict valueForKey:[(UITextField *)[self.view viewWithTag:1] text]] ,[(UITextField *)[self.view viewWithTag:2] text]];
            
            
            NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
            NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
            NSLog(@"URL IS .... %@",theurl);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
            NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
            [[RequestDelegate alloc]initiateRequest:request name:@"Allcities"];
        
        }
        else if (textField.tag ==3)
        {
            
            
            NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetAllIndianTaluka xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<state>%@</state>"
                                       @"<dist>%@</dist>"
                                       @"<city>%@</city>"
                                       @"</GetAllIndianTaluka>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",[self.dict valueForKey:[(UITextField *)[self.view viewWithTag:1] text]] ,[(UITextField *)[self.view viewWithTag:2] text],[(UITextField *)[self.view viewWithTag:3] text]];
            
            
            NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
            NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
            NSLog(@"URL IS .... %@",theurl);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
            NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
            [[RequestDelegate alloc]initiateRequest:request name:@"Alltaluka"];
            
        }

        
        NSLog(@"selected string '%@' from autocomplete menu", [self.dict valueForKey:@"MH"]);
    }
}


-(void)Alldistricts_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.District_List_PickerArr)
    {
        [self.District_List_PickerArr removeAllObjects];
    }
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetAllIndianDistrictsResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *CX_DISTRICT_MAS  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *X_DISTRICT = [TBXML childElementNamed:@"X_DISTRICT" parentElement:CX_DISTRICT_MAS];
            NSString* Name = [TBXML textForElement:X_DISTRICT];
            // NSLog(@"X_DISTRICT: %@",X_DISTRICT);
            
            
            [self.District_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    appdelegate.districtArray=self.District_List_PickerArr;
    NSLog(@"%d",[self.District_List_PickerArr count]);
}

-(void)AllCities_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    
    
    if (self.City_List_PickerArr)
    {
        
        [self.City_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetAllIndianCityResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *CX_DISTRICT_MAS  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *X_CITY = [TBXML childElementNamed:@"X_CITY" parentElement:CX_DISTRICT_MAS];
            NSString* Name = [TBXML textForElement:X_CITY];
            
            
            
            [self.City_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    appdelegate.CitiesArray=self.City_List_PickerArr;
    NSLog(@"%d",[self.City_List_PickerArr count]);
    
}
-(void)Taluka_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.Taluka_List_PickerArr)
    {
        
        [self.Taluka_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetAllIndianTalukaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *CX_DISTRICT_MAS  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *X_TALUKA = [TBXML childElementNamed:@"X_TALUKA" parentElement:CX_DISTRICT_MAS];
            NSString* Name = [TBXML textForElement:X_TALUKA];
            //  NSLog(@"CX_DISTRICT_MAS : %@",Name);
            
            
            [self.Taluka_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    appdelegate.TalukaArray=self.Taluka_List_PickerArr;
    NSLog(@"%d",[self.Taluka_List_PickerArr count]);
   
      
    
    
    
}


-(NSMutableArray *)get
{
    NSLog(@"%d",[self.District_List_PickerArr count]);
    return self.District_List_PickerArr ;
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
