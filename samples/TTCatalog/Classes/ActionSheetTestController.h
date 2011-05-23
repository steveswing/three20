//
//  Created by sswing on 05/13/2011.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import "Three20/Three20+Additions.h"


@interface ActionSheetTestController : TTViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, TTActionSheetControllerDelegate> {
}

- (void)riskyChoice;

- (void)safeChoice;

- (void)invokeChooser:(id)sender;

- (UIViewController *)displayChoices;


@end
