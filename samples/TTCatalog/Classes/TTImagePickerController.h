#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

@interface TTImagePickerController : UIImagePickerController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, TTNavigatorDelegate> {

}

- (id)initWith:(id)delegate;

@end
