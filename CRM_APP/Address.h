//
//  Address.h
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 04/05/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <Foundation/Foundation.h>
//@property(strong,nonatomic)NSMutableArray *GetAddressData_Arr;
extern NSMutableArray *GetAddressData_Arr;

@interface Address : NSObject
/*
 <PersonalAddress IsPrimaryMVG="N">
 <Id>1-74ZPM1B</Id>
 <IntegrationId />
 <PersonalAddressName>1404708483826</PersonalAddressName>
 <PersonalCity>THANE</PersonalCity>
 <PersonalCountry>India</PersonalCountry>
 <PersonalPostalCode>400604</PersonalPostalCode>
 <PersonalState>Maharashtra</PersonalState>
 <PersonalStreetAddress>D8,HIRANANDANI,THANE</PersonalStreetAddress>
 <PersonalStreetAddress2 />
 <AddressId>1-74ZPM1B</AddressId>
 <TMPanchayat />
 <TMTaluka>THANE</TMTaluka>
 <TMDistrict>THANE</TMDistrict>
 */
@property(nonatomic,strong)NSString* PersonalAddressName;
@property(nonatomic,strong)NSString* PersonalCity;
@property(nonatomic,strong)NSString* PersonalCountry;
@property(nonatomic,strong)NSString* PersonalPostalCode;
@property(nonatomic,strong)NSString* PersonalState;
@property(nonatomic,strong)NSString* PersonalStreetAddress;
@property(nonatomic,strong)NSString* PersonalStreetAddress2;
@property(nonatomic,strong)NSString* AddressId;
@property(nonatomic,strong)NSString* TMTaluka;
@property(nonatomic,strong)NSString* TMDistrict;
@property(nonatomic,strong)NSString* TMPanchayat;
@property(nonatomic,strong)NSString* TMArea;
@end
extern Address *address;


