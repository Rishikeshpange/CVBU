//
//  DraftsDetailViewController.m
//  CRM_APP
//
//  Created by Preeti Sakhare on 10/5/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "DraftsDetailViewController.h"
#import "EditViewController.h"

@interface DraftsDetailViewController ()

@end

@implementation DraftsDetailViewController
@synthesize PersonalinfoView,AddressDetailsView,OppurtunityDetailView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    PersonalinfoView.layer.borderColor = [UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor;
    
    PersonalinfoView.layer.borderWidth = 2.0f;
    
    AddressDetailsView.layer.borderColor = [UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor;
    
    AddressDetailsView.layer.borderWidth = 2.0f;
    
    OppurtunityDetailView.layer.borderColor = [UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1].CGColor;
    
    OppurtunityDetailView.layer.borderWidth = 2.0f;
    self.Firstname.text=[self.draftsdetail valueForKey:@"firstname"];
    self.Lastname.text=[self.draftsdetail valueForKey:@"lastname"];
    self.Emailid.text=[self.draftsdetail valueForKey:@"email"];
    self.Cellnumber.text=[self.draftsdetail valueForKey:@"cellnumber"];
    self.Area.text=[self.draftsdetail valueForKey:@"area"];
    self.State.text=[self.draftsdetail valueForKey:@"state"];
    self.District.text=[self.draftsdetail valueForKey:@"district"];
    self.City.text=[self.draftsdetail valueForKey:@"city"];
    self.LOB.text=[self.draftsdetail valueForKey:@"lob"];
    
    self.PPL.text=[self.draftsdetail valueForKey:@"ppl"];
    self.PL.text=[self.draftsdetail valueForKey:@"pl"];
    self.Application.text=[self.draftsdetail valueForKey:@"application"];
    self.Financier.text=[self.draftsdetail valueForKey:@"financier"];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditDetail"]) {
        NSManagedObject *selectedDevice = self.draftsdetail;
        EditViewController *destViewController = segue.destinationViewController;
        destViewController.Editdetail = selectedDevice;
    }
}


- (void)didReceiveMemoryWarning {
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

@end
