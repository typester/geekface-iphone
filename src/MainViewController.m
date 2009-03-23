#import "MainViewController.h"

@implementation MainViewController

-(void)loadView {
    CGRect rect = [[UIScreen mainScreen] applicationFrame];

    UIView *view = [[UIView alloc] initWithFrame:rect];

    // camera preview
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker release];

    id camera = [objc_getClass("PLCameraController") sharedInstance];
    [camera setDelegate:self];
    [camera startPreview];

    UIView *preview = [[UIView alloc] initWithFrame:CGRectMake(
            rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - 44
        )];
    object_setInstanceVariable(camera, "_cameraLayer", preview.layer);
    object_setInstanceVariable(camera, "_previewView", preview);

    [view addSubview: preview];

    self.view = view;
}

// PLCameraController Delegate methods
-(void)cameraController:(id)sender
            tookPicture:(UIImage*)picture
            withPreview:(UIImage*)preview
               jpegData:(NSData*)jpeg
        imageProperties:(NSDictionary *)exif {

}

-(void)cameraControllerReadyStateChanged:(id)sender { }

@end
