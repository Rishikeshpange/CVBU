//
//  ActvityDetailTableviewcellTableViewCell.m
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/14/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import "ActvityDetailTableviewcellTableViewCell.h"

@implementation ActvityDetailTableviewcellTableViewCell

- (void)awakeFromNib {
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    userDetailsVal_ = [UserDetails_Var sharedmanager];
    
    
    if ([userDetailsVal_.POSTN isEqual:@"NDRM"]) {
        _activittyDonebtn.hidden=NO;
        _activityUpdateBtn.hidden=NO;
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSE"])
    {
        _activittyDonebtn.hidden=NO;
        _activityUpdateBtn.hidden=NO;
    
    
    }
    else if ([userDetailsVal_.POSTN isEqual:@"DSM"]){
    
        _activittyDonebtn.hidden=YES;
        _activityUpdateBtn.hidden=YES;
    
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
