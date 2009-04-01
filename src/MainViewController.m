#import "MainViewController.h"

@implementation MainViewController

@synthesize overlay;
@synthesize overlay_index;
@synthesize initialDistance;

-(void)loadView {
    CGRect rect = [[UIScreen mainScreen] applicationFrame];

    UIView *view = [[[UIView alloc] initWithFrame:rect] autorelease];
    self.view = view;

    // camera preview
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker release];

    id camera = [objc_getClass("PLCameraController") sharedInstance];
    UIView *preview = [[UIView alloc] initWithFrame:CGRectMake(
            0, 0, rect.size.width, rect.size.height - 44
        )];
    if ([camera previewView]) [[camera previewView] release];
    object_setInstanceVariable(camera, "_cameraLayer", preview.layer);
    object_setInstanceVariable(camera, "_previewView", preview);

    [camera setDelegate:self];
    [camera startPreview];

    [view addSubview: preview];

    // overlay
    [self loadOverlay:0];

    // navigation
    UIToolbar *toolbar =
        [[[UIToolbar alloc]
            initWithFrame:CGRectMake(0, (rect.size.height - 44), 320, 44)] autorelease];
    toolbar.barStyle = UIBarStyleBlackOpaque;

    UIBarButtonItem *select =
        [[[UIBarButtonItem alloc]
            initWithTitle:@"Select geek type"
            style:UIBarButtonItemStyleBordered
            target:self action:@selector(onSelect:)] autorelease];

    UIBarButtonItem *generate =
        [[[UIBarButtonItem alloc]
            initWithTitle:@"Generate"
            style:UIBarButtonItemStyleBordered
            target:self action:@selector(onGenerate:)] autorelease];

    UIBarButtonItem *space =
        [[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
            target:nil action:nil] autorelease];

    [toolbar setItems:[NSArray arrayWithObjects:select, space, generate, nil]];

    // set as subviews
    [view addSubview: toolbar];

    preview.multipleTouchEnabled = YES;
}

-(void)dealloc {
    [overlay release];
    [super dealloc];
}

-(void)loadOverlay:(NSInteger)index {
    if (overlay) {
        [overlay removeFromSuperview];
        [overlay release];
    }

    switch (index) {
        case 0:
            overlay = [[OverlayView alloc]
                          initWithImage:[UIImage imageNamed:@"miyagawa.png"]];
            break;
        case 1:
            overlay = [[OverlayView alloc]
                          initWithImage:[UIImage imageNamed:@"mizzy.png"]];
            break;
        case 2:
            overlay = [[OverlayView alloc]
                          initWithImage:[UIImage imageNamed:@"nara.png"]];
            break;
        case 3:
            overlay = [[OverlayView alloc]
                          initWithImage:[UIImage imageNamed:@"jesse.png"]];
            break;
    }

    overlay_index  = index;
    overlay.center = self.view.center;
    overlay.multipleTouchEnabled = YES;

    [self.view insertSubview:overlay atIndex:1];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];

    if ([allTouches count] == 2) {
        UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
        UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
        initialDistance =
            [self distanceFrom:[touch1 locationInView:self.view]
                  to:[touch2 locationInView:self.view]];

        NSLog(@"pinch start: %f", initialDistance);
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];

    if ([allTouches count] == 2) {
        UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
        UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
        CGFloat currentDistance =
            [self distanceFrom:[touch1 locationInView:self.view]
                  to:[touch2 locationInView:self.view]];

        CGPoint center = overlay.center;
        CGRect  frame  = overlay.frame;
        CGFloat diff   = currentDistance - initialDistance;

        if (abs(diff) >= 1.0) {
            frame.size.width *= (100.0 + diff) / 100.0;
            frame.size.height *= (100.0 + diff) / 100.0;

            if (20 <= frame.size.width && frame.size.width <= 1000 &&
                20 <= frame.size.height && frame.size.height <= 1000) {
                overlay.frame = frame;
                overlay.center = center;
            }
        }

        initialDistance = currentDistance;
    }
}

-(CGFloat)distanceFrom:(CGPoint)fromPoint to:(CGPoint)toPoint {
    float x = toPoint.x - fromPoint.x;
    float y = toPoint.y - fromPoint.y;
    return sqrt(x * x + y * y);
}

-(void)onSelect:(id)sender {
    ConfigViewController *config = [[[ConfigViewController alloc]
                                       initWithNibName:nil bundle:nil] autorelease];

    UINavigationController *nav = [[[UINavigationController alloc]
                                      initWithRootViewController:config] autorelease];

    [self presentModalViewController:nav animated:YES];
}

-(void)onGenerate:(id)sender {
    id cameraview = [objc_getClass("PLCameraView") alloc];
    [cameraview _playShutterSound];
    [cameraview release];

    id camera = [objc_getClass("PLCameraController") sharedInstance];
    [camera capturePhoto];
}

// PLCameraController Delegate methods
-(void)cameraController:(id)sender
            tookPicture:(UIImage*)picture
            withPreview:(UIImage*)preview
               jpegData:(NSData*)jpeg
        imageProperties:(NSDictionary *)exif {


    ResultViewController *result = [[[ResultViewController alloc]
                                       initWithNibName:nil bundle:nil] autorelease];
    result.image   = preview;

    result.overlay = overlay;
    overlay.userInteractionEnabled = NO;

    [self presentModalViewController:result animated:NO];
}

-(void)cameraControllerReadyStateChanged:(id)sender { }

@end
