//
//  ExpandableCustomCell.h
//  dashboard
//
//  Created by administrator on 1/17/16.
//  Copyright © 2016 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandableCustomCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{
     int selectedIndex ;
}
@property(nonatomic,weak)IBOutlet UILabel *title,*subtitleAlis,*subtitleAlis1,*subtitleAlis2,*subtitleAlis3,*subtitleAlis4,*textLable;

@property(nonatomic,weak)IBOutlet UITableView *InnerExpandableTblView;
;



@end
