#import <UIKit/UIKit.h>

@interface OverlayView : UIImageView <NSCopying> {
    CGPoint startTouchPosition;
}

@property (nonatomic) CGPoint startTouchPosition;

@end
