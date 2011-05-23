#import "ActionSheetTestController.h"
#import "TTImagePickerController.h"

@implementation ActionSheetTestController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        TTURLMap *map = [TTNavigator navigator].URLMap;
        [map from:@"tt://displaychoices" toViewController:self selector:@selector(displayChoices)];
        [map from:@"tt://riskychoice" toViewController:self selector:@selector(riskyChoice)];
        [map from:@"tt://safechoice" toViewController:self selector:@selector(safeChoice)];
        [map from:@"tt://photo-library" toModalViewController:[TTImagePickerController class]];
        [map from:@"tt://manual" toModalViewController:[TTImagePickerController class]];
    }

    return self;
}

- (void)layout {
    TTFlowLayout *flowLayout = [[[TTFlowLayout alloc] init] autorelease];
    flowLayout.padding = 20;
    flowLayout.spacing = 20;
    CGSize size = [flowLayout layoutSubviews:self.view.subviews forView:self.view];

    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.contentSize = CGSizeMake(scrollView.width, size.height);
}

- (void)loadView {
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:TTNavigationFrame()] autorelease];
    scrollView.autoresizesSubviews = YES;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.backgroundColor = RGBCOLOR(216, 221, 231);
    scrollView.canCancelContentTouches = NO;
    scrollView.delaysContentTouches = NO;
    self.view = scrollView;

    TTButton *button = [TTButton buttonWithStyle:@"toolbarButton:" title:@"Display Choices"];
    [button sizeToFit];
    [scrollView addSubview:button];
    [button addTarget:self action:@selector(invokeChooser:) forControlEvents:UIControlEventTouchUpInside];

    [self layout];
}

- (void)invokeChooser:(id)sender {
    TTURLAction *action = [TTURLAction actionWithURLPath:@"tt://displaychoices"];
    [action setAnimated:YES];
    [action setTransition:UIViewAnimationTransitionNone];
    [action setWithDelay:NO];
    [[TTNavigator navigator] openURLAction:action];
}

- (UIViewController *)displayChoices {
    TTActionSheetController *controller = [[[TTActionSheetController alloc] initWithTitle:@"Choose" delegate:self] autorelease];
    [controller addDestructiveButtonWithTitle:@"Risky" URL:@"tt://riskychoice"];
    [controller addButtonWithTitle:@"Safe" URL:@"tt://safechoice"];
    [controller addButtonWithTitle:@"Choose Existing" URL:@"tt://photo-library"];
    [controller addButtonWithTitle:@"Choose Existing Manually" URL:@"tt://manual"];
    [controller addCancelButtonWithTitle:@"Cancel" URL:nil];
    return controller;
}

- (BOOL)actionSheetController:(TTActionSheetController *)controller didDismissWithButtonIndex:(NSInteger)buttonIndex URL:(NSString *)URL {
    TTDPRINT(@"buttonIndex: %d URL: %@", buttonIndex, URL);
    if (URL && [URL caseInsensitiveCompare:@"tt://manual"] == NSOrderedSame) {
        TTImagePickerController *picker = [[[TTImagePickerController alloc] initWith:self] autorelease];
        [self presentModalViewController:picker animated:YES];
        return NO;
    }
    return (nil != URL);
}

- (void)riskyChoice {
    TTAlert(@"Be careful!");
}

- (void)safeChoice {
    TTAlert(@"This is the safe choice!");
}

- (void)dealloc {
    TTURLMap *map = [TTNavigator navigator].URLMap;
    [map removeURL:@"tt://displaychoices"];
    [map removeURL:@"tt://riskychoice"];
    [map removeURL:@"tt://safechoice"];
    [map removeURL:@"tt://photo-library"];
    [map removeURL:@"tt://manual"];
    [super dealloc];
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
