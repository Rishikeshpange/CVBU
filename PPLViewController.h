//
//  PPLViewController.h
//  CRM_APP
//
//  Created by Nihal Shaikh on 10/12/15.
//  Copyright (c) 2015 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"

@interface PPLViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;

}

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (weak, nonatomic) IBOutlet UILabel *pplvalue;


@end
