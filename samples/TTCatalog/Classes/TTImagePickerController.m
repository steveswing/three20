#import "TTImagePickerController.h"

@implementation TTImagePickerController

- (id)init {
    if ((self = [super init])) {
        self.delegate = self;
        self.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    
    return self;
}

- (id)initWith:(id)delegate {
    if ((self = [super init])) {
        self.delegate = delegate;
        self.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    
    return self;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
//        self.delegate = self;
//        self.allowsEditing = YES;
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//            self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        }
//    }
//
//    return self;
//}

- (BOOL)persistView:(NSMutableDictionary *)state {
    return NO;
}

- (void)dealloc {
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [picker dismissModalViewControllerAnimated:YES];
}

@end
