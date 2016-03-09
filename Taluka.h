//
//  Taluka.h
//  CRM_APP
//
//  Created by Rishikesh Pange on 10/28/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "EditViewController.h"
#import "MLPAutoCompleteTextFieldDataSource.h"
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface Taluka : NSObject<MLPAutoCompleteTextFieldDataSource,UITextFieldDelegate>
{
    AppDelegate *appdelegate;
}


//Set this to true to return an array of autocomplete objects to the autocomplete textfield instead of strings.
//The objects returned respond to the MLPAutoCompletionObject protocol.
@property (assign) BOOL testWithAutoCompleteObjectsInsteadOfStrings;


//Set this to true to prevent auto complete terms from returning instantly.
@property (assign) BOOL simulateLatency;

@end
