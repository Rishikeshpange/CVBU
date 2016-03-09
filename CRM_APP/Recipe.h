//
//  Recipe.h
//  RecipeApp
//
//  Created by Simon on 25/12/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, strong) NSString *name; // name of recipe
@property (nonatomic, strong) NSString *mob; // preparation time
@property (nonatomic, strong) NSString *postion_name; // image filename of recipe
@property (nonatomic, strong) NSArray *ingredients; // ingredients of recipe

@end
