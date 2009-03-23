#import "OverlayView.h"

@implementation OverlayView

@synthesize startTouchPosition;

-(id)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];

    if ([touch tapCount] == 1 && [[event allTouches] count] == 1) {
        startTouchPosition = [touch locationInView:self];
    }

    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];

    if ([touch tapCount] == 1 && [[event allTouches] count] == 1 &&
        startTouchPosition.x >= 0 && startTouchPosition.y >= 0
    ) {
        CGPoint currentTouchPosition = [touch locationInView:self];
        self.center = CGPointMake(
            self.center.x + (currentTouchPosition.x - startTouchPosition.x),
            self.center.y + (currentTouchPosition.y - startTouchPosition.y)
        );
    }
    else if ([[event allTouches] count] >= 2) {
        startTouchPosition = CGPointMake(-1, -1);
    }

    [super touchesMoved:touches withEvent:event];
}

@end
