//
//  ContactSearchTableViewController.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 11/18/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "ContactSearchTableViewController.h"
#import "ContactTableViewCell.h"
#import "AppDelegate.h"
#import "RequestDelegate.h"
#import "ContactsList.h"
#import "TBXML.h"
#import "createoptydata.h"

@interface ContactSearchTableViewController ()



@end

@implementation ContactSearchTableViewController

NSArray *items;
NSArray *searchResults;
@synthesize selectedcontact_Arr;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ContactList=[[NSMutableArray alloc] init ];
    
    self.appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    self.searchDisplayController.searchResultsTableView.rowHeight = self.tableView.rowHeight;
    self.searchDisplayController.searchResultsTableView.backgroundColor=[UIColor colorWithRed:(5/255.0)green:(49/255.0) blue:(105/255.0) alpha:1];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0); //values passed are - top, left, bottom, right
    self.tableView.separatorInset=UIEdgeInsetsZero;
    
    selectedcontact=[[ContactsList alloc ]init];
    
    
    // self.tableView.contentInset = UIEdgeInsetsMake(-20.0f, 0.0f, 0.0f, 0.0f);
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_Contact_ListFound:) name:@"Contact_ListFound" object:nil];
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"\nView Did Dissapears...!!!!");
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Contact_ListFound" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    if ([self.ContactList count]!=0) {
        return [self.ContactList count];
        
    } else {
        return 0;
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier1 = @"contact";
    
    ContactTableViewCell *cell = (ContactTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    
    if (cell == nil)
    {
        cell = [[ContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:CellIdentifier1];
        
    }
    
    
    if ([self.ContactList count]==0) {
        cell.textLabel.text=@"No Contacts";
    }
    else
    {
        cell.Label.text=[[self.ContactList objectAtIndex:indexPath.row] valueForKey:@"Name"];
        cell.addressLabel.text=[[self.ContactList objectAtIndex:indexPath.row] valueForKey:@"Contact"];
       // cell.mail = [[self.ContactList objectAtIndex:indexPath.row] valueForKey:@"email"];
        
        
        NSLog(@"text %@",cell.Label.text);
    }
    

    
    
   
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectedcontact = [self.ContactList objectAtIndex:indexPath.row];
    
    
    NSLog(@"%@",selectedcontact.Id);
    
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.ID=selectedcontact.Id;
  NSLog(@"contact ID %@",optyData.ID);
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSNotification *ShowAlertViewNotification = [NSNotification notificationWithName:@"showAlert" object:nil userInfo:nil];
    [[NSNotificationQueue defaultQueue]enqueueNotification:ShowAlertViewNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
   
}








-(void)request_Contact_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    
    
    
    if ([response isEqual:@""])
    {
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"No data found.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message :@"Something gone wrong . Please try agin" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
    
    
    
    
    
    if (self.ContactList)
    {
        
        [self.ContactList removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVContactQueryByExample_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];
    TBXMLElement *Contact  = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];
    
    if (Contact)
    {
        
        do {
            
            TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Contact];
            TBXMLElement *FirstName = [TBXML childElementNamed:@"FirstName" parentElement:Contact];
            TBXMLElement *LastName = [TBXML childElementNamed:@"LastName" parentElement:Contact];
            TBXMLElement *CellularPhone = [TBXML childElementNamed:@"CellularPhone" parentElement:Contact];
            
            TBXMLElement *ListOfPersonalAddress = [TBXML childElementNamed:@"ListOfPersonalAddress" parentElement:Contact];
            TBXMLElement *PersonalAddress = [TBXML childElementNamed:@"PersonalAddress" parentElement:ListOfPersonalAddress];
            ContactsList *contact=[[ContactsList alloc] init];
            if (!PersonalAddress )
            {
                contact.Address=@"No Address";
            }
            else
            {
                TBXMLElement *PersonalAddressName = [TBXML childElementNamed:@"PersonalAddressName" parentElement:PersonalAddress];
                TBXMLElement *PersonalStreetAddress = [TBXML childElementNamed:@"PersonalStreetAddress" parentElement:PersonalAddress];
                TBXMLElement *PersonalCity = [TBXML childElementNamed:@"PersonalCity" parentElement:PersonalAddress];
                TBXMLElement *PersonalPostalCode = [TBXML childElementNamed:@"PersonalPostalCode" parentElement:PersonalAddress];
                TBXMLElement *PersonalCountry = [TBXML childElementNamed:@"PersonalCountry" parentElement:PersonalAddress];
                
                NSString* adress = [TBXML textForElement:PersonalAddressName];
                NSString* prsnlstrtaddressname = [TBXML textForElement:PersonalStreetAddress];
                NSString* prsnlcity = [TBXML textForElement:PersonalCity];
                NSString* prsnlpostalcode = [TBXML textForElement:PersonalPostalCode];
                NSString* prsnlCountry = [TBXML textForElement:PersonalCountry];
                
                NSArray *myStrings = [[NSArray alloc] initWithObjects:adress, prsnlstrtaddressname, prsnlcity, prsnlpostalcode, prsnlCountry, nil];
                NSString *Address = [myStrings componentsJoinedByString:@","];
                contact.Address=Address;
            }
            
            
            
            
            
            // TBXMLElement *PersonalAddress = [TBXML childElementNamed:@"PersonalAddressName" parentElement:[TBXML childElementNamed:@"ListOfPersonalAddress" parentElement:[TBXML childElementNamed:@"PersonalAddress" parentElement:Contact]]];
            TBXMLElement *EmailAddress = [TBXML childElementNamed:@"EmailAddress" parentElement:Contact];
            
            NSString* Id2 = [TBXML textForElement:Id];
            NSString* Name = [TBXML textForElement:FirstName];
         NSString* LastName1 = [TBXML textForElement:LastName];
            
            
        
            Name = [NSString stringWithFormat:@"%@ %@", Name, LastName1];
      
            NSLog(@"%@", Name);
            
            NSString* Cellphone = [TBXML textForElement:CellularPhone];
            
            
            NSString* email = [TBXML textForElement:EmailAddress];
            
            
            contact.Name=Name;
            contact.Id=Id2;
            
            
            contact.email=email;
            contact.Contact=Cellphone;
            
            [self.ContactList addObject:contact];
            
            
            
        }while ((Contact = Contact->nextSibling));
    }
    else
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"No contacts found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    // NSLog(@"%@",[[self.ContactList objectAtIndex:0] valueForKey:@"Name"]);
    [self.tableView reloadData];
    
    NSNotification *Contact_ListPopulated = [NSNotification notificationWithName:@"Contact_ListPopulated" object:nil userInfo:nil];
    [[NSNotificationQueue defaultQueue]enqueueNotification:Contact_ListPopulated postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    
    }
    
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSLog(@"%@",searchText);
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    NSLog(@"%@",[items filteredArrayUsingPredicate:resultPredicate]);
    searchResults = [items filteredArrayUsingPredicate:resultPredicate];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
    //dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3.00 * NSEC_PER_SEC);
    /*dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
     
     dispatch_async(dispatchQueue, ^(void){
     });
     /*
     alertProgress = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
     UIActivityIndicatorView *loadingView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
     [loadingView startAnimating];
     loadingView.frame=CGRectMake(130.0f, 82.0f, 20.0f, 20.0f);
     [alertProgress addSubview:loadingView];
     [alertProgress show];*/
}
-(void)hideAlert
{
    //NSLog(@"Hide...Alert..");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    //   [alertProgress dismissWithClickedButtonIndex:0 animated:YES];
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

