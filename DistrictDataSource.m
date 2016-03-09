//
//  StateDataSource.m
//  CRM_APP
//
//  Created by Rishikesh Pange on 3/9/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import "DistrictDataSource.h"
@interface DistrictDataSource ()

@property (strong, nonatomic) NSArray *countryObjects;

@end


@implementation DistrictDataSource


#pragma mark - MLPAutoCompleteTextField DataSource


//example of asynchronous fetch:
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        if(self.simulateLatency){
            CGFloat seconds =arc4random_uniform(4)+arc4random_uniform(4); //normal distribution
            NSLog(@"sleeping fetch of completions for %f", seconds);
            sleep(seconds);
        }
        
        NSArray *completions;
        if(self.testWithAutoCompleteObjectsInsteadOfStrings){
            
            
            completions = [self allCountryObjects];
        } else {
            completions = [self allCountries];
        }
        
        handler(completions);
    });
}

/*
 - (NSArray *)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
 {
 
 if(self.simulateLatency){
 CGFloat seconds = arc4random_uniform(4)+arc4random_uniform(4); //normal distribution
 NSLog(@"sleeping fetch of completions for %f", seconds);
 sleep(seconds);
 }
 
 NSArray *completions;
 if(self.testWithAutoCompleteObjectsInsteadOfStrings){
 completions = [self allCountryObjects];
 } else {
 completions = [self allCountries];
 }
 
 return completions;
 }
 */

- (NSArray *)allCountryObjects
{
    if(!self.countryObjects){
        NSArray *countryNames = [self allCountries];
        
        
        
        NSMutableArray *mutableCountries = [NSMutableArray new];
        
        for(NSString *countryName in countryNames){
            DEMOCustomAutoCompleteObject *country = [[DEMOCustomAutoCompleteObject alloc] initWithCountry:countryName];
            [mutableCountries addObject:country];
        }
        
        [self setCountryObjects:[NSArray arrayWithArray:mutableCountries]];
    }
    
    return self.countryObjects;
}


- (NSArray *)allCountries
{
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"%@",appdelegate.geoArray);
    NSArray *countries =appdelegate.districtArray;
    //    NSArray *countries =
    //    @[ @"Andaman and Nicobar Islands",
    //
    //       @"Andhra Pradesh",
    //
    //       @"Arunachal Pradesh",
    //
    //       @"Assam",
    //
    //       @"Bihar",
    //
    //       @"Chandigarh",
    //
    //       @"Chhattisgarh",
    //
    //       @"Dadra and Nagar Haveli",
    //
    //       @"Daman and Diu",
    //
    //       @"Delhi",
    //
    //       @"Goa",
    //
    //       @"Gujarat",
    //
    //       @"Haryana",
    //
    //       @"Himachal Pradesh",
    //
    //       @"Jammu and Kashmir",
    //
    //       @"Jharkhand",
    //
    //       @"Karnataka",
    //
    //       @"Kerala",
    //
    //       @"Lakshadweep",
    //
    //       @"Madhya Pradesh",
    //
    //       @"Maharashtra",
    //
    //       @"Manipur",
    //
    //       @"Meghalaya",
    //
    //       @"Mizoram",
    //
    //       @"Nagaland",
    //
    //       @"Orissa",
    //
    //       @"Pondicherry",
    //
    //       @"Punjab",
    //
    //       @"Rajasthan",
    //
    //       @"Sikkim",
    //
    //       @"Tamil Nadu",
    //
    //       @"Telangana",
    //
    //       @"Tripura",
    //
    //       @"Uttar Pradesh",
    //
    //       @"West Bengal"];
    
    NSLog(@"country count %lu",(unsigned long)countries.count);
    
    return countries;
    
    
    
    
}

@end
