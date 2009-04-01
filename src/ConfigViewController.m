#import "ConfigViewController.h"

@implementation ConfigViewController

-(void)loadView {
    UIBarButtonItem *back = [[[UIBarButtonItem alloc]
                                initWithTitle:@"Back"
                                style:UIBarButtonItemStylePlain
                                target:self action:@selector(onClose:)] autorelease];
    self.navigationItem.leftBarButtonItem = back;

    tableView = [[UITableView alloc]
                            initWithFrame:[[UIScreen mainScreen] applicationFrame]
                            style:UITableViewStyleGrouped];

    tableView.autoresizingMask =
        UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;

    self.title = @"Select geek type";
    self.view = tableView;
}

-(void)onClose:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {

    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];

    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                    initWithFrame:CGRectZero
                    reuseIdentifier:@"MyIdentifier"] autorelease];
    }

    NSInteger overlay_index = [[[self parentViewController]
                                   parentViewController] overlay_index];

    switch (indexPath.row) {
        case 0:
            cell.text = @"Super geek";
            if (overlay_index == 0)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            break;
        case 1:
            cell.text = @"Normal geek";
            if (overlay_index == 1)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            break;
        case 2:
            cell.text = @"Moose";
            if (overlay_index == 2)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            break;
        case 3:
            cell.text = @"Pony";
            if (overlay_index == 3)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            break;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath {

    NSInteger i, count = [tableView numberOfRowsInSection:[newIndexPath section]];
    for (i = 0; i < count; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i
                                          inSection:[newIndexPath section]];
        if ([newIndexPath row] == i) {
            [[tableView cellForRowAtIndexPath:index]
                setAccessoryType:UITableViewCellAccessoryCheckmark];
            [[[self parentViewController] parentViewController] loadOverlay:i];
        }
        else {
            [[tableView cellForRowAtIndexPath:index]
                setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
}

@end
