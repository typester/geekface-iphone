#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface GeekFaceAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *view;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) MainViewController *view;

@end
