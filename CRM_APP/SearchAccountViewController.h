//
//  SearchAccountViewController.h
//  NEEV
//
//  Created by Gautam Panpatil  Panpatil  on 02/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"
@interface SearchAccountViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UISplitViewControllerDelegate,UIPopoverControllerDelegate> {
    UserDetails_Var* userDetailsVal_;
    AppDelegate* appdelegate;
}
@property (weak, nonatomic) IBOutlet UIView* viewFirst;
@property (weak, nonatomic) IBOutlet UIButton* btnSearch;
@property (weak, nonatomic) IBOutlet UIButton* btnUpdate;
// Search Button :
- (IBAction)btnSearch:(id)sender;
// Active InACtive Actions :
- (IBAction)btnActive:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton* btnInActive;
- (IBAction)btnInActive:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton* btnActive;
// Arrays :
@property (strong, nonatomic) NSMutableArray* AccountSearch_ListArr;
@property (weak, nonatomic) IBOutlet UITableView* _tableView;

- (IBAction)btnUpdate:(id)sender;

@property (retain) NSIndexPath* lastIndexPath;
@end
