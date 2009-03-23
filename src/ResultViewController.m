#import "ResultViewController.h"

@implementation ResultViewController

@synthesize image;
@synthesize imageview;
@synthesize overlay;

-(void)loadView {
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    self.view = view;

    imageview = [[UIImageView alloc] initWithImage:image];
    imageview.transform = CGAffineTransformMakeRotation(M_PI/2);
    imageview.frame = CGRectMake(0, 0, rect.size.width, rect.size.height - 44);

    // navigation
    UIToolbar *toolbar =
        [[UIToolbar alloc]
            initWithFrame:CGRectMake(0, (rect.size.height - 44), 320, 44)];
    toolbar.barStyle = UIBarStyleBlackOpaque;

    UIBarButtonItem *back =
        [[UIBarButtonItem alloc]
            initWithTitle:@"back"
            style:UIBarButtonItemStyleBordered
            target:self action:@selector(onBack:)];

    UIBarButtonItem *save =
        [[UIBarButtonItem alloc]
            initWithTitle:@"Save"
            style:UIBarButtonItemStyleBordered
            target:self action:@selector(onSave:)];

    UIBarButtonItem *space =
        [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
            target:nil action:nil];

    [toolbar setItems:[NSArray arrayWithObjects:back, space, save, nil]];

    [view addSubview: imageview];
    [view addSubview: overlay];
    [view addSubview: toolbar];
}

-(void)onBack:(id)sender {
    overlay.userInteractionEnabled = YES;
    [[self parentViewController].view insertSubview: overlay atIndex:1];
    [self dismissModalViewControllerAnimated:NO];
}

-(void)onSave:(id)sender {
    UIGraphicsBeginImageContext(imageview.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *data = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageWriteToSavedPhotosAlbum(data, nil, nil, nil);

    UIAlertView *alert = [[UIAlertView alloc]
                             initWithTitle:@"Image saved!" message:@""
                             delegate:self cancelButtonTitle:nil
                             otherButtonTitles:@"OK", nil];
    [alert show];

    overlay.userInteractionEnabled = YES;
    [[self parentViewController].view insertSubview: overlay atIndex:1];
    [self dismissModalViewControllerAnimated:NO];
}

@end
