#import <UIKit/UIKit.h>

#import "OverlayView.h"
#import "ConfigViewController.h"
#import "ResultViewController.h"

@interface MainViewController : UIViewController {
    OverlayView *overlay;
    NSInteger overlay_index;
    CGFloat initialDistance;
}

@property (nonatomic, retain) OverlayView *overlay;
@property (nonatomic) NSInteger overlay_index;
@property (nonatomic) CGFloat initialDistance;

-(CGFloat)distanceFrom:(CGPoint)fromPoint to:(CGPoint)toPoint;

@end
