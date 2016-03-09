//
//  StateDataSource.h
//  CRM_APP
//
//  Created by Rishikesh Pange on 3/9/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import "MLPAutoCompleteTextFieldDataSource.h"
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DEMOCustomAutoCompleteObject.h"


@interface DistrictDataSource : NSObject<MLPAutoCompleteTextFieldDataSource,UITextFieldDelegate>
{
    AppDelegate *appdelegate;
}


//Set this to true to return an array of autocomplete objects to the autocomplete textfield instead of strings.
//The objects returned respond to the MLPAutoCompletionObject protocol.
@property (assign) BOOL testWithAutoCompleteObjectsInsteadOfStrings;


//Set this to true to prevent auto complete terms from returning instantly.
@property (assign) BOOL simulateLatency;


@end
