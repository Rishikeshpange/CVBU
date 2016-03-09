//
//  DSE.h
//  
//
//  Created by Preeti Sakhare on 9/21/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DSE : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * cellnumber;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * district;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * taluka;
@property (nonatomic, retain) NSString * pincode;
@property (nonatomic, retain) NSString * panchayat;
@property (nonatomic, retain) NSString * accountname;
@property (nonatomic, retain) NSString * lob;
@property (nonatomic, retain) NSString * ppl;
@property (nonatomic, retain) NSString * pl;
@property (nonatomic, retain) NSString * application;
@property (nonatomic, retain) NSString * sourceofcontact;
@property (nonatomic, retain) NSString * financier;

@end
