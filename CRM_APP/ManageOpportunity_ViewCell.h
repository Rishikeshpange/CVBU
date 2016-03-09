//
//  ManageOpportunity_ViewCell.h
//  CRM_APP
//
//  Created by admin on 23/09/15.
//  Copyright © 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageOpportunity_ViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *manage_main_view;



@property (strong, nonatomic) IBOutlet UILabel *lbl_customername;

@property (strong, nonatomic) IBOutlet UILabel *lbl_productname;

@property (strong, nonatomic) IBOutlet UILabel *lbl_customercellno;

@property (strong, nonatomic) IBOutlet UILabel *lbl_optycreationdate;

@property (strong, nonatomic) IBOutlet UILabel *lbl_salesstage;

@property (strong, nonatomic) IBOutlet UILabel *lbl_lastpendingactivity;


@end
