//
//  MasterViewController.m
//  test
//
//  Created by Sebastian Boldt on 07.03.13.
//  Copyright (c) 2013 LetsIDev. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "LoginViewController.h"

#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@implementation MasterViewController

UITableViewCell *cell;
NSArray *tableDatadsm,*tabledataneev,*tabledatadse,*tableText,*DSMupdatedtabledata,*DSEupdatedtabledata,*NEEVupdatedtabledata;
UILabel *mainLabel;
UIAlertView *alert;


- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}


- (void)viewDidAppear:(BOOL)animated
{
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.layer.backgroundColor = [UIColor colorWithRed:(255/255.0)  green:(255/255.0)  blue:(255/255.0) alpha:1].CGColor;
    // self.tableView.layer.borderColor =  [UIColor colorWithRed:(4/255.0) green:(41/255.0) blue:(82/255.0) alpha:1].CGColor;
    // self.tableView.layer.borderWidth = 3.0f;
    
    
    DSMupdatedtabledata = [NSArray arrayWithObjects:userDetailsVal_.Login_Name,@"Dashboard",@"Create Prospect",@"Create Opportunity",@"Manage Opportunity",@"Activity",@"Drafts",@"Logout",nil];
    
    DSEupdatedtabledata = [NSArray arrayWithObjects:userDetailsVal_.Login_Name,@"Dashboard",@"Create Prospect",@"Create Opportunity",@"Manage Opportunity",@"Activity",@"Drafts",@"Logout",nil];
    
    NEEVupdatedtabledata = [NSArray arrayWithObjects:userDetailsVal_.Login_Name,@"Dashboard",@"Manage Opportunity",@"Activity",@"Account",@"Logout",nil];
    
    
    
    
    
    tableDatadsm = [NSArray arrayWithObjects:userDetailsVal_.Login_Name,@"DASHBOARD", @"CREATE OPPORTUNITY", @"MANAGE OPPORTUNITY", @"ACTIVITY",@"ANALYTICS",@"LOGOUT" ,nil];
    
    
    tabledataneev = [NSArray arrayWithObjects:userDetailsVal_.Login_Name,@"DASHBOARD", @"ACCOUNT", @"MANAGE OPPORTUNITY", @"ACTIVITY",@"ANALYTICS",@"LOGOUT" ,nil];
    
    tabledatadse = [NSArray arrayWithObjects:userDetailsVal_.Login_Name,@"DASHBOARD", @"CREATE OPPORTUNITY",@"LOGOUT" ,nil];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self.tableView reloadData];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionTop];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    UIImage *img = [UIImage imageNamed:@"header_tml_logo.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,18,18)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    
    
    NSLog(@"\n _ORGNAME %@",userDetailsVal_.Login_Name);
    if(IS_OS_8_OR_LATER)
    {
        NSLog(@"ios 8 ");
        _maximumPrimaryColumnWidth = 240;
        
        self.splitViewController.maximumPrimaryColumnWidth = _maximumPrimaryColumnWidth;
    }
    else
    {
        NSLog(@"ios 7");
        
    }
    
    
    NSLog(@"app name%@",appdelegate.flagappname);
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    if ([appdelegate.flagappname isEqualToString:@"DSM"]) {
        
        return [DSMupdatedtabledata count];
        
    }
    else if ([appdelegate.flagappname isEqualToString:@"NEEV"])
    {
        
        return [NEEVupdatedtabledata count];
        
    }
    else{
        return [DSEupdatedtabledata count];
    }
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"DEBUG: Enter..");
    
    
    
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
    cell.selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.textColor=[UIColor grayColor];
    static NSString *CellIdentifier = @"Cell";
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    if ([appdelegate.flagappname isEqualToString:@"DSM"]) {
        
        cell.textLabel.text = [DSMupdatedtabledata objectAtIndex:indexPath.row];
        
    }
    
    else if ([appdelegate.flagappname isEqualToString:@"NEEV"]) {
        
        cell.textLabel.text = [NEEVupdatedtabledata objectAtIndex:indexPath.row];
        
    }
    
    
    else{
        
        
        cell.textLabel.text = [DSEupdatedtabledata objectAtIndex:indexPath.row];
        
        
    }
    
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //  tableView.separatorStyle
    
    tableView.separatorColor =[UIColor lightGrayColor];
    [tableView setContentOffset:tableView.contentOffset animated:NO];
    
    //[tableView setSeparatorInset:UIEdgeInsetsZero];
    
    if([appdelegate.flagappname isEqualToString:@"DSM"])
    {
        if(indexPath.row==0)
        {
            
            cell.userInteractionEnabled=NO;
            
            cell.imageView.clipsToBounds = YES;
            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 100.0,160.0)] ;
            
        }
        //        else if(indexPath.row==1)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==2)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==3)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==4)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;a
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //
        //        }
        //        if(indexPath.row==5)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //
        //        }
        //        if(indexPath.row==6)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==7)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
    }
    
    if([appdelegate.flagappname isEqualToString:@"DSE"])
    {
        
        
        if(indexPath.row==0)
        {
            cell.userInteractionEnabled = NO;
            
            
            cell.imageView.clipsToBounds = YES;
            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 100.0,160.0)] ;
            
        }
        //        else if(indexPath.row==1)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==2)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==3)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==4)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //
        //        }
        //        if(indexPath.row==5)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //
        //        }
        //        if(indexPath.row==6)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==7)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //
        
    }
    
    if([appdelegate.flagappname isEqualToString:@"NEEV"])
    {
        
        if(indexPath.row==0)
        {
            cell.userInteractionEnabled = NO;
            
            
            cell.imageView.clipsToBounds = YES;
            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 100.0,160.0)] ;
            
        }
        //        else if(indexPath.row==1)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==2)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==3)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //        }
        //        if(indexPath.row==4)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //
        //        }
        //        if(indexPath.row==5)
        //        {
        //            cell.userInteractionEnabled = YES;
        //
        //            cell.imageView.clipsToBounds = YES;
        //            cell.imageView.image = [UIImage imageNamed:@"icon_1"];
        //            mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(25.00, -40.00, 10.0,10.0)] ;
        //
        //
        //        }
        //
        
        
    }    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
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
    
    
    
    
    
    if(indexPath.row==0)
    {
        
        
        cell.userInteractionEnabled=NO;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 100, 100);
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        
        cell.backgroundColor = [UIColor blackColor];
        
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] ;
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor=[UIColor blackColor];
        
        cell.textLabel.highlightedTextColor = [UIColor blackColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
        cell.selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if([appdelegate.flagappname isEqualToString:@"DSM"])
    {
        
        static NSString *simpleTableIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        cell.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
        NSLog(@"Row index : %ld",(long)indexPath.row);
        
        
        
        if (indexPath.row == 0) {
            
            cell.userInteractionEnabled = YES;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            NSLog(@"..");
            cell.imageView.image = [UIImage imageNamed:@"Dummy.jpg"];
            DetailViewController * dvc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc1,nil];
            self.splitViewController.delegate = dvc1;
        }
        
        else if(indexPath.row ==1)
        {
            
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
        }
        
        
        else if(indexPath.row == 2)
        {
            
            
            
            
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionView1"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
            
        }
        else if(indexPath.row == 3)
        {
            
            
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"createopty"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
            
            
        }
        else if(indexPath.row == 4)
        {
            DetailViewController * dvc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ManageOpportunity_identifire"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc2,nil];
            self.splitViewController.delegate = dvc2;
            
            
        }
        else if(indexPath.row ==5)
        {
            
            DetailViewController * dvc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"Activity_List"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc2,nil];
            self.splitViewController.delegate = dvc2;
            
            
        }
        
        else if(indexPath.row ==6)
        {
            
            DetailViewController * dvc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"Drafts"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc2,nil];
            self.splitViewController.delegate = dvc2;
            
            
            
            
            
        }
        
        
        
        
        
        else if (indexPath.row ==7)
        {
            
            
            alert = [[UIAlertView alloc] initWithTitle:@"DSM"
                                               message:@"Do you want to log out ? "
                                              delegate:self
                                     cancelButtonTitle:@"No"
                                     otherButtonTitles:@"Yes",nil];
            [alert show];
            
            
            
            
            
        }
        
        
        
        
    }
    
    else  if([appdelegate.flagappname isEqualToString:@"NEEV"]){
        
        
        static NSString *simpleTableIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        cell.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
        NSLog(@"Row index : %ld",(long)indexPath.row);
        
        if (indexPath.row == 0) {
            
            cell.userInteractionEnabled = YES;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            NSLog(@"..");
            cell.imageView.image = [UIImage imageNamed:@"Dummy.jpg"];
            DetailViewController * dvc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc1,nil];
            self.splitViewController.delegate = dvc1;
        }
        
        
        
        else if(indexPath.row ==1)
        {
            
            
            DetailViewController * dvc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc2,nil];
            self.splitViewController.delegate = dvc2;
            
        }
        
        else if(indexPath.row ==2)
        {
            
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"ManageOpportunity_identifire"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
        }
        
        else if(indexPath.row ==3)
        {
            
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"Activity_List"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
        }
        
        else if(indexPath.row ==4)
        {
            
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"Accounts"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
        }
        else if(indexPath.row ==5)
        {
            
            alert = [[UIAlertView alloc] initWithTitle:@"NEEV"
                                               message:@"Do you want to log out ? "
                                              delegate:self
                                     cancelButtonTitle:@"No"
                                     otherButtonTitles:@"Yes",nil];
            [alert show];
            
        }
        
        
        
    }
    
    else  if([appdelegate.flagappname isEqualToString:@"DSE"]){
        
        
        static NSString *simpleTableIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        cell.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
        NSLog(@"Row index : %ld",(long)indexPath.row);
        
        if (indexPath.row == 0) {
            
            cell.userInteractionEnabled = YES;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            NSLog(@"..");
            cell.imageView.image = [UIImage imageNamed:@"Dummy.jpg"];
            DetailViewController * dvc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc1,nil];
            self.splitViewController.delegate = dvc1;
        }
        
        
        
        else if(indexPath.row ==1)
        {
            //dashboard
            
            DetailViewController * dvc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc2,nil];
            self.splitViewController.delegate = dvc2;
            
        }
        
        else if(indexPath.row ==2)
        {
            //create prospect
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionView1"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
        }
        
        else if(indexPath.row ==3)
        {
            //create opty
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"createopty"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
        }
        
        else if(indexPath.row ==4)
        {
            //manage
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"ManageOpportunity_identifire"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
        }
        else if(indexPath.row ==5)
        {
            //activity
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"searchActivityNV"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
        }
        
        
        else if (indexPath.row ==6)
        {
            
            
            
            
            DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"CREATEOPTYNEW"];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
            self.splitViewController.delegate = dvc3;
            
            
            
            
            
            
        }
        else if(indexPath.row ==7)
        {
            
            
            alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                               message:@"Do you want to log out? "
                                              delegate:self
                                     cancelButtonTitle:@"No"
                                     otherButtonTitles:@"Yes",nil];
            [alert show];
            
        }
        
    }
    
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        
        NSLog(@"David Miller");
    }
    if (buttonIndex==1) {
        
        LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:secondViewController animated:YES completion:nil ];
        
    }
}

@end
