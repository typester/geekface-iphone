#import "GeekFaceAppDelegate.h"

@implementation GeekFaceAppDelegate

@synthesize window, view;

-(void)applicationDidFinishLaunching:(UIApplication *)application {
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view   = [[MainViewController alloc] initWithNibName:nil bundle:nil];

    [window addSubview:view.view];
    [window makeKeyAndVisible];
}

-(void)dealloc {
    [view release];
    [window release];
    [super dealloc];
}

@end
