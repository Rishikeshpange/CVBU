#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DraftsView : UIViewController<UITableViewDelegate,UITableViewDataSource,UISplitViewControllerDelegate,UIPopoverControllerDelegate>
{
    
    AppDelegate *appdelegate;
    
}
@property (weak, nonatomic) IBOutlet UITableView *draftTableview;

@property (strong, nonatomic) UIPopoverController* masterPopoverController;

@property(weak,nonatomic)UISplitViewController *splitController;

@property(strong,nonatomic) IBOutlet  AppDelegate *appdelegate;

@property (nonatomic, strong) NSArray *drafts;
@end
