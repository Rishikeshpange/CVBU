//
//  Address.m
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 04/05/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import "Address.h"
Address *address;
extern Address *recipe;

NSMutableArray *GetAddressData_Arr;
@implementation Address
@synthesize PersonalAddressName,PersonalCity,PersonalCountry,PersonalPostalCode,PersonalState,PersonalStreetAddress,PersonalStreetAddress2,AddressId,TMDistrict,TMTaluka,TMPanchayat,TMArea;

@end
