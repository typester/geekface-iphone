#import "GeekFaceAppDelegate.h"

@implementation GeekFaceAppDelegate

@synthesize window;

-(void)applicationDidFinishLaunching:(UIApplication *)application {
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    MainViewController *view = [[MainViewController alloc]
                                   initWithNibName:nil bundle:nil];

    [window addSubview:view.view];
    [window makeKeyAndVisible];
}

-(void)dealloc {
    [window release];
    [super dealloc];
}

@end
