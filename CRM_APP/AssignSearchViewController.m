//
//  AssignSearchViewController.m
//  CRM_APP
//
//  Created by admin on 19/10/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import "AssignSearchViewController.h"
#import "SearchAssign_Cell.h"
#import "RequestDelegate.h"
#import "AppDelegate.h"
#import "TBXML.h"
#import "AssignViewController.h"
#import "SearchAssign_Cell.h"
#import "Recipe.h"
#import "MBProgressHUD.h"
#import "AssignViewModel.h"
@interface AssignSearchViewController ()

@end

@implementation AssignSearchViewController {
    NSArray* items;
    NSMutableArray* searchResults;
    AssignViewModel* recipe;
    //NSMutableArray *recipe;
}
@synthesize ListofDSE_Arr;
@synthesize ListofDSE_Name_Arr;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; //AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; //usedetails instance
    appdelegate.tableCounter = nil;
    appdelegate.flagcheck = 0;
    
   
    NSLog(@"Load..");
    ListofDSE_Arr = [[NSMutableArray alloc] init];
    ListofDSE_Name_Arr = [[NSMutableArray alloc] init];
    searchResults = [[NSMutableArray alloc] init];
    
    //recipe=[[NSMutableArray alloc] init];
    
    //searchResults=[[NSArray alloc] init];
    
    [self showAlert];
    if (items == nil) {
        items = [NSArray arrayWithObjects:@"ZENON", @"BOLT", @"ZEST", @"ACE", @"INDICA", @"NANO", @"BOLT", @"VISTA", @"ARIA", @"SUMO", @"BOLT", nil];
    }
    
    [self callDSEName];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ListOfDSE_Found:) name:@"ListOfDSE_Found" object:nil]; //For Sale Satge PPL Dropdown Count
    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ModeLostOpty_Found:) name:@"ModeLostOpty_Found" object:nil];//For sale SatgeFailed DropDown fail
    if (self.searchDisplayController.active) {
        self.searchDisplayController.searchBar.text = self.searchDisplayController.searchBar.text;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ListOfDSE_Found" object:nil]; //Gomzy // For opportunity Count
    //  [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ModeLostOpty_Found" object:nil];//Gomzy // For opportunity Count
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    }
    else {
        return [ListofDSE_Name_Arr count];
    } /*
       // Return the number of rows in the section.
       if (tableView == self.searchDisplayController.searchResultsTableView) {
       return [searchResults count];
       
       } else {
       return [items count];
       
       }
       //return 0;
       */
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    NSLog(@"Row Selected ...Assign %ld", (long)indexPath.row);
    appdelegate.flagcheck = 1;
    appdelegate.tableCounter = (long)indexPath.row;
    SearchAssign_Cell* cell = (SearchAssign_Cell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.imgTik.image = [UIImage imageNamed:@"checkbox_12.png"];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        assign_list = [searchResults objectAtIndex:indexPath.row];
    }
    else {
        assign_list = [ListofDSE_Arr objectAtIndex:indexPath.row];
    }
    //assign_list = [ListofDSE_Arr objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"Assign... Diselect %ld", (long)indexPath.row);
    appdelegate.flagcheck = 1;
    SearchAssign_Cell* cell = (SearchAssign_Cell*)[tableView cellForRowAtIndexPath:indexPath];
    assign_list = [ListofDSE_Arr objectAtIndex:indexPath.row];
    cell.imgTik.image = [UIImage imageNamed:@"checkbox.png"];
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    NSLog(@"Enter..");
    assign_list = nil;
    assign_list = [[AssignViewModel alloc] init];
    assign_list = [ListofDSE_Arr objectAtIndex:indexPath.row];
    //assign_list = [ListofDSE_Arr objectAtIndex:indexPath.row];
    
    //Postion Id 1-7F0Y2G
    //Opty Id 1-7566C1P
    
    NSLog(@"Assing List : %@", assign_list.EMP_ID);
    static NSString* CellIdentifier1 = @"Analyticsdentifier";
    SearchAssign_Cell* cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[SearchAssign_Cell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier1];
    }
    cell.backgroundColor = [UIColor colorWithRed:(255 / 255.0)green:(255 / 255.0)blue:(255 / 255.0)alpha:1];
    cell.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;
    
    // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // cell.dse_Name.text=recipe.name;
    //cell.dse_mob_no.text=recipe.mob;
    //cell.dse_position_name.text=recipe.postion_name;
    
    cell.dse_Name.text = assign_list.NSE_LOBDSE_NAME;
    cell.dse_mob_no.text = assign_list.POSITION_PH_NUM;
    cell.dse_position_name.text = assign_list.POSITION_NAME;
    
    // Display recipe in the table cell
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        recipe = [searchResults objectAtIndex:indexPath.row];
        NSLog(@"out in ..");
        NSLog(@"Recipes... %@", recipe);
        //cell.dse_Name.text=recipe;
        NSLog(@"recipe...QQQ%@", recipe.POSITION_NAME);
        cell.dse_position_name.text = recipe.POSITION_NAME;


    }
    else {
        recipe = [ListofDSE_Arr objectAtIndex:indexPath.row];
        //recipe = [recipes objectAtIndex:indexPath.row];
    }
    NSLog(@"recipe...%@", recipe.POSITION_NAME);
    cell.dse_Name.text = recipe.NSE_LOBDSE_NAME;
    cell.dse_mob_no.text = recipe.POSITION_PH_NUM;
    cell.dse_position_name.text = recipe.POSITION_NAME;
    cell.imgTik.image = [UIImage imageNamed:@"checkbox.png"];
    return cell;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 91;
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0 || indexPath.row == ([indexPath length] - 1)) {
        cell.layer.cornerRadius = 10;
    }
    cell.layer.cornerRadius = 10;
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    // self.Activity.layer.borderColor =  [UIColor colorWithRed:(1/255.0) green:(43/255.0) blue:(98/255.0) alpha:1].CGColor;
    // self.Activity.layer.borderWidth = 2.0f;
    
    UIView* bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:(1 / 255.0)green:(29 / 255.0)blue:(115 / 255.0)alpha:1]];
    bgColorView.layer.cornerRadius = 10;
    // [cell setSelectedBackgroundView:bgColorView];
    // [bgColorView release];
    
    cell.backgroundColor = [UIColor colorWithRed:(255 / 255.0)green:(255 / 255.0)blue:(255 / 255.0)alpha:1];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithRed:(216 / 255.0)green:(218 / 255.0)blue:(221 / 255.0)alpha:1];
    cell.layer.borderColor = [UIColor colorWithRed:(229 / 255.0)green:(229 / 255.0)blue:(229 / 255.0)alpha:1].CGColor;
    //  cell.textLabel.highlightedTextColor = [UIColor colorWithRed:(0/255.0) green:(13/255.0) blue:(65/255.0) alpha:1];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(245 / 255.0)green:(244 / 255.0)blue:(244 / 255.0)alpha:1];
    
    //cell.selectedBackgroundView=bgColorView;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSLog(@"Innnnn");
    //   NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.shipBuilder LIKE[cd] %@",searchText];
    NSPredicate* resultPredicate = [NSPredicate predicateWithFormat:@"NSE_LOBDSE_NAME CONTAINS[c] %@", searchText];
    //NSLog(@"search String : %@",[ListofDSE_Name_Arr filteredArrayUsingPredicate:resultPredicate]);
    searchResults = [[ListofDSE_Arr filteredArrayUsingPredicate:resultPredicate] mutableCopy];
    [self._searchtableView reloadData];
}

- (BOOL)searchDisplayController:(UISearchDisplayController*)controller shouldReloadTableForSearchString:(NSString*)searchString
{
    NSLog(@"Innnnn11");

    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
#pragma mark - UISearchResultsUpdating


//- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
//{
//    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
//        [self._searchtableView insertSubview:self.searchDisplayController.searchBar aboveSubview:self._searchtableView];
//    }
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)callDSEName
{
    /*
     <SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body><GetListOfNSEOrLOBDSEForNDRM xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\"><positionid>"
     + UserDetails.ROW_ID
     + "</positionid><positionname></positionname><buname></buname><searchpostitionname1></searchpostitionname1>"
     + "<searchpostitionname2></searchpostitionname2></GetListOfNSEOrLOBDSEForNDRM></SOAP:Body></SOAP:Envelope>
     */
    NSString* envelopeText = [NSString stringWithFormat:
                              @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              @"<SOAP:Body><GetListOfNSEOrLOBDSEForNDRM xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                              @"<positionid>%@</positionid>"
                              @"<positionname></positionname>"
                              @"<buname></buname>"
                              @"<searchpostitionname1></searchpostitionname1>"
                              @"<searchpostitionname2></searchpostitionname2>"
                              @"</GetListOfNSEOrLOBDSEForNDRM></SOAP:Body></SOAP:Envelope>",
                              userDetailsVal_.ROW_ID];
    
    NSLog(@"\n envlopeString Of user details....CSR!!!!%@", envelopeText);
    
    NSData* envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL* theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@", appdelegate.URL, appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@", theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString* msglength = [NSString stringWithFormat:@"%lu", (unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc] initiateRequest:request name:@"getListOfDSETypeConnection"];
}
- (void)ListOfDSE_Found:(NSNotification*)notification
{
    ListofDSE_Arr = [[NSMutableArray alloc] init];
    ListofDSE_Name_Arr = [[NSMutableArray alloc] init];
    
    NSError* err;
    NSString* response = [[notification userInfo] objectForKey:@"response"];
    NSLog(@"\n Reason Lost  %@ ", response);
    /*
     <S_POSTN>
     <NSE_LOBDSE_NAME>ABHAY GOGATE</NSE_LOBDSE_NAME>
     <POSITION_PH_NUM>9223354582</POSITION_PH_NUM>
     <POSITION_NAME>TMCV-Sal-W-MUM-1001680-Thane-LCV-DSE-15</POSITION_NAME>
     <POSITION_ID>1-14XINH4</POSITION_ID>
     <LOB_NAME>LCV</LOB_NAME>
     <POSTN_TYPE_CD>DSE</POSTN_TYPE_CD>
     <EMP_ID>1-5AR6Q57</EMP_ID>
     <NSEORDSEUSERNAME>AGOGATE_1001680</NSEORDSEUSERNAME>
     </S_POSTN>
     
     */
    
    if ([response isEqual:@""]) {
        [self hideAlert];
        NSLog(@"Data....nhi ahe ");
    }
    else {
        if (ListofDSE_Arr) {
            [ListofDSE_Arr removeAllObjects];
        }
        
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        NSLog(@"Which..");
        TBXMLElement* container = [TBXML childElementNamed:@"GetListOfNSEOrLOBDSEForNDRMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement* tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple) {
            [self hideAlert];
            do {
                assign_list = nil;
                assign_list = [[AssignViewModel alloc] init];
                
                TBXMLElement* S_Lst_Of_Val = [TBXML childElementNamed:@"S_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement* NAME = [TBXML childElementNamed:@"NSE_LOBDSE_NAME" parentElement:S_Lst_Of_Val];
                //NSString *str_NAME = [TBXML textForElement:NAME];
                //NSLog(@"\n str_NSE : %@",str_NAME);
                // activity_list.OPPTY_NAME =[TBXML textForElement:X_OPTY_NAME];
                assign_list.NSE_LOBDSE_NAME = [TBXML textForElement:NAME];
                
                TBXMLElement* X_POSITION_PH_NUM = [TBXML childElementNamed:@"POSITION_PH_NUM" parentElement:S_Lst_Of_Val];
                assign_list.POSITION_PH_NUM = [TBXML textForElement:X_POSITION_PH_NUM];
                
                TBXMLElement* X_PRODUCT_NAME1 = [TBXML childElementNamed:@"POSITION_NAME" parentElement:S_Lst_Of_Val];
                assign_list.POSITION_NAME = [TBXML textForElement:X_PRODUCT_NAME1];
                
                TBXMLElement* X_POSITION_ID = [TBXML childElementNamed:@"POSITION_ID" parentElement:S_Lst_Of_Val];
                assign_list.POSITION_ID = [TBXML textForElement:X_POSITION_ID];
                
                TBXMLElement* X_LOB_NAME = [TBXML childElementNamed:@"LOB_NAME" parentElement:S_Lst_Of_Val];
                assign_list.LOB_NAME = [TBXML textForElement:X_LOB_NAME];
                
                TBXMLElement* X_POSTN_TYPE_CD = [TBXML childElementNamed:@"POSTN_TYPE_CD" parentElement:S_Lst_Of_Val];
                assign_list.POSTN_TYPE_CD = [TBXML textForElement:X_POSTN_TYPE_CD];
                
                TBXMLElement* X_EMP_ID = [TBXML childElementNamed:@"EMP_ID" parentElement:S_Lst_Of_Val];
                assign_list.EMP_ID = [TBXML textForElement:X_EMP_ID];
                
                TBXMLElement* X_NSEORDSEUSERNAME = [TBXML childElementNamed:@"NSEORDSEUSERNAME" parentElement:S_Lst_Of_Val];
                assign_list.NSEORDSEUSERNAME = [TBXML textForElement:X_NSEORDSEUSERNAME];
                
                [ListofDSE_Name_Arr addObject:assign_list.NSE_LOBDSE_NAME];
                
                [ListofDSE_Arr addObject:assign_list];
                
            } while ((tuple = tuple->nextSibling));
            
            NSLog(@"Sales Stages : %@", ListofDSE_Arr);
            NSLog(@"Sales Stages : %@", ListofDSE_Name_Arr);
            [self hideAlert];
            [self._searchtableView reloadData];
        }
        if ((ListofDSE_Arr.count) > 0) {
            [self hideAlert];
        }
    }
    //  [self hideAlert];
}

- (void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
- (void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
