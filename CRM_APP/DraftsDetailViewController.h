//
//  DraftsDetailViewController.h
//  CRM_APP
//
//  Created by Preeti Sakhare on 10/5/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"


@interface DraftsDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *Firstname;
@property (weak, nonatomic) IBOutlet UILabel *Lastname;
@property (weak, nonatomic) IBOutlet UILabel *Cellnumber;
@property (weak, nonatomic) IBOutlet UILabel *Emailid;
@property (weak, nonatomic) IBOutlet UILabel *Area;
@property (weak, nonatomic) IBOutlet UILabel *State;
@property (weak, nonatomic) IBOutlet UILabel *District;
@property (weak, nonatomic) IBOutlet UILabel *City;
@property (weak, nonatomic) IBOutlet UILabel *Taluka;
@property (weak, nonatomic) IBOutlet UILabel *Pincode;
@property (weak, nonatomic) IBOutlet UILabel *LOB;
@property (weak, nonatomic) IBOutlet UILabel *PPL;
@property (weak, nonatomic) IBOutlet UILabel *PL;
@property (weak, nonatomic) IBOutlet UILabel *Application;
@property (weak, nonatomic) IBOutlet UILabel *Financier;
@property (weak, nonatomic) IBOutlet UIView *PersonalinfoView;
@property (weak, nonatomic) IBOutlet UIView *AddressDetailsView;
@property (weak, nonatomic) IBOutlet UIView *OppurtunityDetailView;

@property (strong) NSManagedObject *draftsdetail;


@end
