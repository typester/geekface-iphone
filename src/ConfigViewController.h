#import <UIKit/UIKit.h>

@interface ConfigViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource> {

    UITableView *tableView;
}

@property (nonatomic, retain) UITableView *tableView;

@end

