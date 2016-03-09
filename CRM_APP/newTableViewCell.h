//
//  newTableViewCell.h
//  dashboardDemo
//
//  Created by Admin on 03/02/16.
//  Copyright © 2016 TataTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)IBOutlet UILabel *saleStage1,*saleStage2,*saleStage3,*saleStage4,*saleStage5;
@property(nonatomic,weak)IBOutlet UITableView *InsideExpandabletblView;
@property(nonatomic,weak)IBOutlet UILabel *LLB1;

@end
