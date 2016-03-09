//
//  ContactsList.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 11/18/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsList : NSObject


@property (strong, nonatomic) IBOutlet NSString *Name;
@property (strong, nonatomic) IBOutlet NSString *Address;
@property (strong, nonatomic) IBOutlet NSString *Contact;
@property (strong, nonatomic) IBOutlet NSString *email;
@property (strong, nonatomic) IBOutlet NSString *lastName;
@property (strong, nonatomic) IBOutlet NSString *Id;

@end
extern ContactsList *selectedcontact;