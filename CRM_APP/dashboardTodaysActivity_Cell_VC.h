//
//  dashboardTodaysActivity_Cell_VC.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/19/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dashboardTodaysActivity_Cell_VC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl_customer;
@property (weak, nonatomic) IBOutlet UILabel *lbl_CustomerName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_opty;
@property (weak, nonatomic) IBOutlet UILabel *lbl_OptyId;


@property (strong, nonatomic) IBOutlet UILabel *lbl_SaleStage;
@property (strong, nonatomic) IBOutlet UILabel *lbl_DSEName;

@property (strong, nonatomic) IBOutlet UILabel *lbl_ActivityPending;

@property (strong, nonatomic) IBOutlet UILabel *lbl_ActivityType;


@end
