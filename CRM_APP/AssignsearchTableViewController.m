//
//  AssignsearchTableViewController.m
//  NEEV
//
//  Created by Sachin Sharma on 03/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import "AssignsearchTableViewController.h"
#import "RequestDelegate.h"
#import "AppDelegate.h"
#import "TBXML.h"
#import "AssignViewController.h"
#import "SearchAssign_Cell.h"
#import "Recipe.h"
#import "MBProgressHUD.h"
#import "AssignViewModel.h"
@interface AssignsearchTableViewController ()

@end
@implementation AssignsearchTableViewController {
    NSArray *items;
    NSMutableArray *searchResults;
    AssignViewModel *recipe;
    NSString * envelopeText;
    //NSMutableArray *recipe;

}
@synthesize ListofDSE_Arr;
@synthesize ListofDSE_Name_Arr;
- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; //usedetails instance
    appdelegate.tableCounter=nil;
    appdelegate.flagcheck=0;
    NSLog(@"Load..");
    ListofDSE_Arr=[[NSMutableArray alloc] init];
    ListofDSE_Name_Arr=[[NSMutableArray alloc] init];
    searchResults=[[NSMutableArray alloc] init];
    
    //recipe=[[NSMutableArray alloc] init];
    
    //searchResults=[[NSArray alloc] init];

    [self showAlert];
    if (items == nil) {
        items = [NSArray arrayWithObjects:@"ZENON",@"BOLT",@"ZEST",@"ACE",@"INDICA",@"NANO",@"BOLT",@"VISTA",@"ARIA",@"SUMO",@"BOLT",nil];
        
    }
    
    [self callDSEName];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ListOfDSE_Found:) name:@"ListOfDSE_Found" object:nil]; //For Sale Satge PPL Dropdown Count
    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ModeLostOpty_Found:) name:@"ModeLostOpty_Found" object:nil];//For sale SatgeFailed DropDown fail
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ListOfDSE_Found" object:nil];//Gomzy // For opportunity Count
    //  [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ModeLostOpty_Found" object:nil];//Gomzy // For opportunity Count
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [ListofDSE_Name_Arr count];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Row Selected ... %ld",(long)indexPath.row);
    appdelegate.flagcheck=1;
    appdelegate.tableCounter=(long)indexPath.row;
    SearchAssign_Cell *cell =(SearchAssign_Cell*) [tableView cellForRowAtIndexPath:indexPath];
    cell.imgTik.image=[UIImage imageNamed:@"checkbox_12.png"];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        //recipe = [searchResults objectAtIndex:indexPath.row];
        assign_list = [searchResults objectAtIndex:indexPath.row];
    } else {
        assign_list = [ListofDSE_Arr objectAtIndex:indexPath.row];
        //recipe = [recipes objectAtIndex:indexPath.row];
    }
    //assign_list = [ListofDSE_Arr objectAtIndex:indexPath.row];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Enter..");
    assign_list = nil;
    assign_list = [[AssignViewModel alloc]init];
    assign_list = [ListofDSE_Arr objectAtIndex:indexPath.row];
    //assign_list = [ListofDSE_Arr objectAtIndex:indexPath.row];
    
    //Postion Id 1-7F0Y2G
    //Opty Id 1-7566C1P
    
    NSLog(@"Assing List : %@",assign_list.EMP_ID);
    static NSString *CellIdentifier1 = @"Analyticsdentifier";
    SearchAssign_Cell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil)
    {
        cell = [[SearchAssign_Cell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier1];
    }
    cell.backgroundColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
    cell.layer.borderColor=[UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor;

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
     
     // cell.dse_Name.text=recipe.name;
     //cell.dse_mob_no.text=recipe.mob;
     //cell.dse_position_name.text=recipe.postion_name;
     
     /*cell.dse_Name.text=assign_list.NSE_LOBDSE_NAME;
     cell.dse_mob_no.text=assign_list.POSITION_PH_NUM;
     cell.dse_position_name.text=assign_list.POSITION_NAME;*/
    
    // Display recipe in the table cell
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        recipe = [searchResults objectAtIndex:indexPath.row];
        NSLog(@"out in ..");
        NSLog(@"Recipes... %@",recipe);
        //cell.dse_Name.text=recipe;
    } else {
        recipe = [ListofDSE_Arr objectAtIndex:indexPath.row];
        //recipe = [recipes objectAtIndex:indexPath.row];
    }
 
    cell.dse_Name.text=recipe.NSE_LOBDSE_NAME;
    cell.dse_mob_no.text=recipe.POSITION_PH_NUM;
    cell.dse_position_name.text=recipe.POSITION_NAME;
    
    cell.imgTik.image=[UIImage imageNamed:@"checkbox.png"];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
}
- (void)tableView:(UITableView *)tableView
didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"... Diselect %ld",(long)indexPath.row);
    SearchAssign_Cell *cell =(SearchAssign_Cell*) [tableView cellForRowAtIndexPath:indexPath];
    assign_list = [ListofDSE_Arr objectAtIndex:indexPath.row ];
    cell.imgTik.image=[UIImage imageNamed:@"checkbox.png"];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0 || indexPath.row == ([indexPath length]-1))
    {
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
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:(1/255.0) green:(29/255.0) blue:(115/255.0) alpha:1]];
    bgColorView.layer.cornerRadius = 10;
    // [cell setSelectedBackgroundView:bgColorView];
    // [bgColorView release];
    
    cell.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] ;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor=[UIColor colorWithRed:(216/255.0) green:(218/255.0) blue:(221/255.0) alpha:1];
    cell.layer.borderColor=[UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor;
    //  cell.textLabel.highlightedTextColor = [UIColor colorWithRed:(0/255.0) green:(13/255.0) blue:(65/255.0) alpha:1];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(244/255.0) blue:(244/255.0) alpha:1];
    
    //cell.selectedBackgroundView=bgColorView;
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSLog(@"In");
    //   NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.shipBuilder LIKE[cd] %@",searchText];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"NSE_LOBDSE_NAME CONTAINS[c] %@", searchText];
    //NSLog(@"search String : %@",[ListofDSE_Name_Arr filteredArrayUsingPredicate:resultPredicate]);
    searchResults = [[ListofDSE_Arr filteredArrayUsingPredicate:resultPredicate] mutableCopy];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
-(void)callDSEName
{
     if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
    
    
    
    
   envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body><GetListOfNSEOrLOBDSEForNDRM xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<positionname></positionname>"
                               @"<buname></buname>"
                               @"<searchpostitionname1></searchpostitionname1>"
                               @"<searchpostitionname2></searchpostitionname2>"
                               @"</GetListOfNSEOrLOBDSEForNDRM></SOAP:Body></SOAP:Envelope>",userDetailsVal_.ROW_ID] ;
         
     }
    
    
     else{
     
         
         envelopeText = [NSString stringWithFormat:
                                    @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                    @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                    @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                    @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                                    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                                    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                                    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                                    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                                    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e875-98c59ce1dde9</DC>"
                                    @"</Logger>"
                                    @"</header>"
                                    @"</SOAP:Header>"
                                    @"<SOAP:Body>"
                                    @"<GetListOfNseOrDseForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                    @"<positionid>%@</positionid>"
                                    @"</GetListOfNseOrDseForDSM>"
                                    @"</SOAP:Body>"
                                    @"</SOAP:Envelope> ",userDetailsVal_.ROW_ID];
     
     
     
     
     
     }
    
    
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getListOfDSETypeConnection"];
    
}
-(void)ListOfDSE_Found:(NSNotification*)notification
{
    ListofDSE_Arr=[[NSMutableArray alloc] init];
    ListofDSE_Name_Arr=[[NSMutableArray alloc] init];
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n assign DSE response  %@ ",response);
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
    
    
    if([response isEqual:@""]){
        [self hideAlert];
        NSLog(@"Data....nhi ahe ");
    }
    else{
        
         if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
        
        if (ListofDSE_Arr)
        {
            [ListofDSE_Arr removeAllObjects];
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        NSLog(@"Which..");
        TBXMLElement *container = [TBXML childElementNamed:@"GetListOfNSEOrLOBDSEForNDRMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            [self hideAlert];
            do
            {
                assign_list = nil;
                assign_list = [[AssignViewModel alloc]init];
                
                
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"NSE_LOBDSE_NAME" parentElement:S_Lst_Of_Val];
                //NSString *str_NAME = [TBXML textForElement:NAME];
                //NSLog(@"\n str_NSE : %@",str_NAME);
                // activity_list.OPPTY_NAME =[TBXML textForElement:X_OPTY_NAME];
                assign_list.NSE_LOBDSE_NAME =[TBXML textForElement:NAME];
                
                TBXMLElement *X_POSITION_PH_NUM = [TBXML childElementNamed:@"POSITION_PH_NUM" parentElement:S_Lst_Of_Val];
                assign_list.POSITION_PH_NUM =[TBXML textForElement:X_POSITION_PH_NUM];
                
                TBXMLElement *X_PRODUCT_NAME1 = [TBXML childElementNamed:@"POSITION_NAME" parentElement:S_Lst_Of_Val];
                assign_list.POSITION_NAME =[TBXML textForElement:X_PRODUCT_NAME1];
                
                TBXMLElement *X_POSITION_ID = [TBXML childElementNamed:@"POSITION_ID" parentElement:S_Lst_Of_Val];
                assign_list.POSITION_ID =[TBXML textForElement:X_POSITION_ID];
                
                TBXMLElement *X_LOB_NAME = [TBXML childElementNamed:@"LOB_NAME" parentElement:S_Lst_Of_Val];
                assign_list.LOB_NAME =[TBXML textForElement:X_LOB_NAME];
                
                TBXMLElement *X_POSTN_TYPE_CD = [TBXML childElementNamed:@"POSTN_TYPE_CD" parentElement:S_Lst_Of_Val];
                assign_list.POSTN_TYPE_CD =[TBXML textForElement:X_POSTN_TYPE_CD];
                
                TBXMLElement *X_EMP_ID = [TBXML childElementNamed:@"EMP_ID" parentElement:S_Lst_Of_Val];
                assign_list.EMP_ID =[TBXML textForElement:X_EMP_ID];
                
                TBXMLElement *X_NSEORDSEUSERNAME = [TBXML childElementNamed:@"NSEORDSEUSERNAME" parentElement:S_Lst_Of_Val];
                assign_list.NSEORDSEUSERNAME =[TBXML textForElement:X_NSEORDSEUSERNAME];
                
                [ListofDSE_Name_Arr addObject:assign_list.NSE_LOBDSE_NAME];
                
                [ListofDSE_Arr addObject:assign_list];
                
            }while ((tuple = tuple->nextSibling));
            
            NSLog(@"Sales Stages : %@",ListofDSE_Arr);
            NSLog(@"Sales Stages : %@",ListofDSE_Name_Arr);
            
            [self._searchtableView reloadData];
            
        }
        if ((ListofDSE_Arr.count) > 0)
        {
             [self hideAlert];
        }
           
         }
        
         else{
         
             
             
             if (ListofDSE_Arr)
             {
                 [ListofDSE_Arr removeAllObjects];
             }
             
             TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
             
             NSLog(@"Which..");
             TBXMLElement *container = [TBXML childElementNamed:@"GetListOfNseOrDseForDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
             TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
             if (tuple)
             {
                 [self hideAlert];
                 do
                 {
                     assign_list = nil;
                     assign_list = [[AssignViewModel alloc]init];
                     
                     
                     TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_PARTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                     TBXMLElement *NAME = [TBXML childElementNamed:@"NSE_LOBDSE_NAME" parentElement:S_Lst_Of_Val];
                    
                     assign_list.NSE_LOBDSE_NAME =[TBXML textForElement:NAME];
                     
                     TBXMLElement *X_POSITION_PH_NUM = [TBXML childElementNamed:@"POSITION_PH_NUM" parentElement:S_Lst_Of_Val];
                     assign_list.POSITION_PH_NUM =[TBXML textForElement:X_POSITION_PH_NUM];
                     
                     TBXMLElement *X_PRODUCT_NAME1 = [TBXML childElementNamed:@"POSTION_NAME" parentElement:S_Lst_Of_Val];
                     assign_list.POSITION_NAME =[TBXML textForElement:X_PRODUCT_NAME1];
                     
                     TBXMLElement *X_POSITION_ID = [TBXML childElementNamed:@"POSTION_ID" parentElement:S_Lst_Of_Val];
                     assign_list.POSITION_ID =[TBXML textForElement:X_POSITION_ID];
                     
                     TBXMLElement *X_LOB_NAME = [TBXML childElementNamed:@"LOBNAME" parentElement:S_Lst_Of_Val];
                     assign_list.LOB_NAME =[TBXML textForElement:X_LOB_NAME];
                     
                     TBXMLElement *X_POSTN_TYPE_CD = [TBXML childElementNamed:@"POSITION_TYPE" parentElement:S_Lst_Of_Val];
                     assign_list.POSTN_TYPE_CD =[TBXML textForElement:X_POSTN_TYPE_CD];
                     
                  
                     [ListofDSE_Name_Arr addObject:assign_list.NSE_LOBDSE_NAME];
                     
                     [ListofDSE_Arr addObject:assign_list];
                     
                 }while ((tuple = tuple->nextSibling));
                 
                 NSLog(@"Sales Stages : %@",ListofDSE_Arr);
                 NSLog(@"Sales Stages : %@",ListofDSE_Name_Arr);
                 
                 [self._searchtableView reloadData];
                 
             }
             if ((ListofDSE_Arr.count) > 0)
             {
                 [self hideAlert];
             }
             
         
        
         }
        
        
        
        
        
    }
    //  [self hideAlert];
    
}

-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
    
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}



@end
