//
//  searchAccount_Cell.m
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 02/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import "searchAccount_Cell.h"

@implementation searchAccount_Cell
@synthesize lblNAme,
lbl_CustName,
lblAccountId,
lblAccountStatus,
lblPhoneNumber,search_view,imgTik;


- (void)awakeFromNib {
    
    // NSLog(@"testing label..123");
    [lblNAme sizeToFit];
    [lbl_CustName sizeToFit];
    [lblAccountId sizeToFit];
    [lblAccountStatus sizeToFit];
    [lblPhoneNumber sizeToFit];
    [search_view sizeToFit];
    [imgTik sizeToFit];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
