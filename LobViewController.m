//
//  LobViewController.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/6/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "LobViewController.h"
#import "createoptydata.h"


@interface LobViewController ()
{
    UIActionSheet *actionsheet;
    NSMutableArray *ppllist;
    UIAlertView *alert;
}


@end

@implementation LobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nback.png"] forBarMetrics:UIBarMetricsDefault];
    self.splitViewController.delegate = self;
    self.masterPopoverController.delegate = self;
    UIBarButtonItem *barButtonItem = self.splitViewController.displayModeButtonItem;
    barButtonItem.title = @"Show master";
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    NSLog(@"Samlp Art Master: %@",appdelegate.artifact);
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"Samlp Art Master: %@",userDetailsVal_.ROW_ID);
    
    appdelegate.LOBPPLIsselected = @"NO";
    
    ppllist = [[NSMutableArray alloc]initWithObjects:@"ICV Buses",@"LCV Buses",@"M&HC V Buses",nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)viewDidAppear:(BOOL)animated{

    NSLog(@"appear");
}



- (IBAction)busesBtn:(id)sender {
    
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.LOB = @"Buses";
    
    NSLog(@"LOB%@",optyData.LOB);
    
    alert = [[UIAlertView alloc] initWithTitle:@"Create Opportunity"
                                           message:@"selected LOB : BUS"
                                          delegate:self
                                 cancelButtonTitle:@"Confirm"
                                 otherButtonTitles:@"Cancel", nil];
    [alert setTag:1];
    [alert show];
    
}

- (IBAction)hcvcargoBtn:(id)sender {
    
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.LOB=@"HCV Cargo";
    
    NSLog(@"LOB%@",optyData.LOB);
    
    alert = [[UIAlertView alloc] initWithTitle:@"Create Opportunity"
                                       message:@"selected LOB : HCV Cargo"
                                      delegate:self
                             cancelButtonTitle:@"Confirm"
                             otherButtonTitles:@"Cancel", nil];
    [alert setTag:1];
    [alert show];
    
    
    
    
    
}

- (IBAction)imcvtrucksBtn:(id)sender {
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.LOB=@"I&MCV Trucks";
    
    NSLog(@"LOB%@",optyData.LOB);
    
    
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"Create Opportunity"
                                       message:@"selected LOB : I&MCV Trucks"
                                      delegate:self
                             cancelButtonTitle:@"Confirm"
                             otherButtonTitles:@"Cancel", nil];
    [alert setTag:1];
    [alert show];
    
}

- (IBAction)lcvBtn:(id)sender {
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.LOB=@"LCV";
    
    NSLog(@"LOB%@",optyData.LOB);
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"Create Opportunity"
                                       message:@"selected LOB : LCV"
                                      delegate:self
                             cancelButtonTitle:@"Confirm"
                             otherButtonTitles:@"Cancel", nil];
    [alert setTag:1];
    [alert show];
    
       // [self performSegueWithIdentifier:@"createOpty" sender:self];}
}
- (IBAction)mhcvBtn:(id)sender {
    
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.LOB=@"M&HCV Const";
    
    NSLog(@"LOB%@",optyData.LOB);
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"Create Opportunity"
                                       message:@"selected LOB : M&HCV Const"
                                      delegate:self
                             cancelButtonTitle:@"Confirm"
                             otherButtonTitles:@"Cancel", nil];
    [alert setTag:1];
    [alert show];
    
    
}


- (IBAction)pickupsBtn:(id)sender {
    
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.LOB=@"Pickups";
    
    NSLog(@"LOB%@",optyData.LOB);
    
    
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"Create Opportunity"
                                       message:@"selected LOB : Pickups"
                                      delegate:self
                             cancelButtonTitle:@"Confirm"
                             otherButtonTitles:@"Cancel", nil];
    [alert setTag:1];
    [alert show];
    
    
    
}

- (IBAction)scvcargoBtn:(id)sender {
    
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.LOB=@"SCV Cargo";
    
    NSLog(@"LOB%@",optyData.LOB);
    
    
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"Create Opportunity"
                                       message:@"selected LOB : SCV Cargo"
                                      delegate:self
                             cancelButtonTitle:@"Confirm"
                             otherButtonTitles:@"Cancel", nil];
    [alert setTag:1];
    [alert show];
}

- (IBAction)scvpassBtn:(id)sender {
    
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.LOB=@"Buses";
    
    NSLog(@"LOB%@",optyData.LOB);
    
    
    
   //     [self performSegueWithIdentifier:@"createOpty" sender:self];
    
}

- (IBAction)scpassBtn:(id)sender {
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.LOB=@"ScPass";
    
    NSLog(@"LOB%@",optyData.LOB);
    
    
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"Create Opportunity"
                                       message:@"selected LOB : ScPass"
                                      delegate:self
                             cancelButtonTitle:@"Confirm"
                             otherButtonTitles:@"Cancel", nil];
    [alert setTag:1];
    [alert show];
    
}

- (IBAction)pcventureBtn:(id)sender {
    
    
    //PCV - Venture
    
    
    
    optyData = nil;
    optyData = [[createoptydata alloc]init];
    
    
    optyData.LOB=@"PCV - Venture";
    
    NSLog(@"LOB%@",optyData.LOB);
    
    
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"Create Opportunity"
                                       message:@"selected LOB : PCV - Venture"
                                      delegate:self
                             cancelButtonTitle:@"Confirm"
                             otherButtonTitles:@"Cancel", nil];
    [alert setTag:1];
    [alert show];
}



- (void)actionSheet:(UIActionSheet*)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (popup.tag) {
        case 5:
            if (buttonIndex == actionsheet.cancelButtonIndex) {
                return;
            }
            else {
                NSLog(@"Button index %ld", (long)buttonIndex);
              
                 optyData.PPL= NSLocalizedString([ppllist objectAtIndex:buttonIndex], @"");
                
                
            }
    }
    
    
      [self performSegueWithIdentifier:@"createOpty" sender:self];
    
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    
    if(alertView.tag == 1) {
        
        if (buttonIndex == 0) {
            
            
            
            
             [self performSegueWithIdentifier:@"createOpty" sender:self];
            
            
            
        }
        if (buttonIndex==1) {
            
            
        
            
        }}
    
    else{
    
    
    }



}























@end
