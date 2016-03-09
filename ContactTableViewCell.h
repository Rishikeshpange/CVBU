//
//  ContactTableViewCell.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 11/18/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ContactTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (weak) UIView *parentTableView;



@end