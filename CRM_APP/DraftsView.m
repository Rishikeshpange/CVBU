//
//  DraftsView.m
//  CRM_APP
//
//  Created by Preeti Sakhare on 9/21/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "DraftsView.h"
#import "DraftsTableViewCell.h"
#import "DSM.h"
#import "DSE.h"
#import "DraftsDetailViewController.h"

@interface DraftsView ()

@end

@implementation DraftsView

@synthesize drafts;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drafts =[[NSArray alloc] init];
    self.appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.draftTableview.delegate=self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback1.png"] forBarMetrics:UIBarMetricsDefault];
    if ([self.appdelegate.flagappname isEqualToString:@"DSM"])
    {
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
        
        
        NSError *error;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DSM"
                                                  inManagedObjectContext:self.appdelegate.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        self.drafts = [self.appdelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        for (DSM *info in self.drafts)
        {
            NSLog(@"firstname: %@", info.firstname);
            NSLog(@"lastname: %@", info.lastname);
            NSLog(@"cellnumber: %@", info.cellnumber);
            NSLog(@"email: %@", info.email);
            
        }
        
    }
    else if ([self.appdelegate.flagappname isEqualToString:@"DSE"])
    {
        
        NSError *error;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DSE"
                                                  inManagedObjectContext:self.appdelegate.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        self.drafts = [self.appdelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        for (DSE *info in self.drafts)
        {
            NSLog(@"firstname: %@", info.firstname);
            NSLog(@"lastname: %@", info.lastname);
            NSLog(@"cellnumber: %@", info.cellnumber);
            NSLog(@"email: %@", info.email);
            
            NSLog(@"area: %@", info.area);
            NSLog(@"state: %@", info.state);
            NSLog(@"district: %@", info.district);
            NSLog(@"city: %@", info.city);
            NSLog(@"taluka: %@", info.taluka);
            NSLog(@"pincode: %@", info.pincode);
            NSLog(@"panchayat: %@", info.panchayat);
            NSLog(@"accountname: %@", info.accountname);
            
            NSLog(@"lob: %@", info.lob);
            NSLog(@"ppl: %@", info.ppl);
            NSLog(@"pl: %@", info.pl);
            NSLog(@"application: %@", info.application);
            NSLog(@"sourceofcontact: %@", info.sourceofcontact);
            NSLog(@"financier: %@", info.financier);
            
            
            
        }
        
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // in your case, there are 3 cells
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0 || indexPath.row == ([indexPath length]-1))
    {
        cell.layer.cornerRadius = 10;
        
        
    }
    cell.layer.cornerRadius = 10;
    cell.layer.borderWidth=2.0f;
    cell.layer.borderColor=[UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor;
    
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
    /*
     UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 320, 3)];/// change size as you need.
     separatorLineView.backgroundColor = [UIColor redColor];// you can also put image here
     [cell.contentView addSubview:separatorLineView];*/
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:(245/255.0) green:(244/255.0) blue:(244/255.0) alpha:1]];
    bgColorView.layer.cornerRadius = 10;
    // [cell setSelectedBackgroundView:bgColorView];
    // [bgColorView release];
    
    cell.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(244/255.0) blue:(244/255.0) alpha:1] ;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor=[UIColor colorWithRed:(65/255.0) green:(68/255.0) blue:(77/255.0) alpha:1];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
    cell.selectedBackgroundView=bgColorView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.drafts count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    if (tableView == self.draftTableview)
    //    {
    static NSString *MyIdentifier = @"draftsIdentifier";
    
    DraftsTableViewCell *cell = [self.draftTableview dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[DraftsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
    }
    cell.layer.borderColor =  [UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;
    cell.layer.borderWidth = 1.0f;
    cell.layer.cornerRadius=10;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor=[UIColor clearColor];
    
    cell.firstname.text =[[self.drafts objectAtIndex:indexPath.row] valueForKey:@"firstname"];
    cell.lastname.text =[[self.drafts objectAtIndex:indexPath.row] valueForKey:@"lastname"];
    cell.Cellnumber.text = [[self.drafts objectAtIndex:indexPath.row] valueForKey:@"cellnumber"];
    cell.email.text = [[self.drafts objectAtIndex:indexPath.row] valueForKey:@"email"];
    
    cell.lob.text =[[self.drafts objectAtIndex:indexPath.row] valueForKey:@"lob"];
    cell.ppl.text =[[self.drafts objectAtIndex:indexPath.row] valueForKey:@"ppl"];
    cell.pl.text = [[self.drafts objectAtIndex:indexPath.row] valueForKey:@"pl"];
    cell.application.text = [[self.drafts objectAtIndex:indexPath.row] valueForKey:@"application"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"UpdateDevice"]) {
        NSManagedObject *selectedDevice = [self.drafts objectAtIndex:[[self.draftTableview indexPathForSelectedRow] row]];
        DraftsDetailViewController *destViewController = segue.destinationViewController;
        destViewController.draftsdetail = selectedDevice;
    }
}


@end
