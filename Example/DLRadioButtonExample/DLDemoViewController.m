#import "DLDemoViewController.h"

@implementation DLDemoViewController

#pragma mark - Helpers

- (IBAction)logSelectedButton:(DLRadioButton *)radiobutton {
    if (radiobutton.isMultipleSelectionEnabled) {
        for (DLRadioButton *button in radiobutton.selectedButtons) {
            NSLog(@"%@ is selected.\n", button.titleLabel.text);
        }
    } else {
        NSLog(@"%@ is selected.\n", radiobutton.selectedButton.titleLabel.text);
    }
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // enable multiple selection for water, beer and wine buttons.
    self.waterButton.multipleSelectionEnabled = YES;
    
    // programmatically add buttons
    // first button
    DLRadioButton *firstRadioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 131, 350, 262, 17)];
    firstRadioButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [firstRadioButton setTitle:@"Red Button" forState:UIControlStateNormal];
    [firstRadioButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    firstRadioButton.iconColor = [UIColor redColor];
    firstRadioButton.indicatorColor = [UIColor redColor];
    firstRadioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [firstRadioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstRadioButton];
    
    // other buttons
    NSArray *colorNames = @[@"Brown", @"Orange", @"Green", @"Blue", @"Purple"];
    NSArray *buttonColors = @[[UIColor brownColor], [UIColor orangeColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor]];
    NSInteger i = 0;
    NSMutableArray *otherButtons = [NSMutableArray new];
    for (UIColor *buttonColor in buttonColors) {
        // customize button
        DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 131, 380 + 30 * i, 262, 17)];
        radioButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [radioButton setTitle:[colorNames[i] stringByAppendingString:@" Button"] forState:UIControlStateNormal];
        [radioButton setTitleColor:buttonColor forState:UIControlStateNormal];
        radioButton.iconColor = buttonColor;
        radioButton.indicatorColor = buttonColor;
        if (i % 2 == 0) {
            radioButton.iconSquare = YES;
        }
        if (i > 1) {
            // put icon on the right side
            radioButton.iconOnRight = YES;
            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        } else {
            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
        [otherButtons addObject:radioButton];
        [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:radioButton];
        i++;
    }
    
    firstRadioButton.otherButtons = otherButtons;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
}

@end
