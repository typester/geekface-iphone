#import <UIKit/UIKit.h>
#import "OverlayView.h"

@interface ResultViewController : UIViewController {
    UIImage *image;
    UIImageView *imageview;
    OverlayView *overlay;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImageView *imageview;
@property (nonatomic, assign) OverlayView *overlay;

@end

