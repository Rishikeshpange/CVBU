//
//  ActivityAdhCustomCell.h
//  dashboardDemo
//
//  Created by Admin on 15/01/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityAdhCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *PplLbl;

@property (weak, nonatomic) IBOutlet UILabel *PlannedEvntsLbl;

@property (weak, nonatomic) IBOutlet UILabel *excutedEventsLbl;
@property (weak, nonatomic) IBOutlet UILabel *percentageAdhereLbl;


@end
