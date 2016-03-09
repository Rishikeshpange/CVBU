//
//  searchAccount_Cell.h
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 02/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchAccount_Cell : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet UIView *search_view;

@property (weak, nonatomic) IBOutlet UILabel *lbl_CustName;

@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *lblAccountId;

@property (weak, nonatomic) IBOutlet UILabel *lblNAme;

@property (weak, nonatomic) IBOutlet UILabel *lblAccountStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgTik;



@end
