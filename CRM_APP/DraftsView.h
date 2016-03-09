#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DraftsView : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    AppDelegate *appdelegate;
    
}
@property (weak, nonatomic) IBOutlet UITableView *draftTableview;
@property(strong,nonatomic) IBOutlet  AppDelegate *appdelegate;
@property (nonatomic, strong) NSArray *drafts;
@end
