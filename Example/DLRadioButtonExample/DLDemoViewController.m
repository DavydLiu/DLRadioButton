#import "DLDemoViewController.h"

@interface DLDemoViewController ()

@property (nonatomic, strong) DLRadioGroup *radioGroup;

@end

@implementation DLDemoViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // enable multiple selection for water, beer and wine buttons.
    self.squareRadioGroup.multipleSelectionEnabled = YES;
    
    self.radioGroup = [DLRadioGroup new];
    self.radioGroup.delegate = self;
    
    // programmatically add buttons
    NSArray *colorNames = @[@"Red", @"Brown", @"Orange", @"Green", @"Blue", @"Purple"];
    NSArray *buttonColors = @[[UIColor redColor], [UIColor brownColor], [UIColor orangeColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor]];
    
    NSInteger i = 0;
    for (UIColor *buttonColor in buttonColors) {
        // customize button
        DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 131, 350 + 30 * i, 262, 17)];
        radioButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [radioButton setTitle:[colorNames[i] stringByAppendingString:@" Button"] forState:UIControlStateNormal];
        [radioButton setTitleColor:buttonColor forState:UIControlStateNormal];
        radioButton.iconColor = buttonColor;
        radioButton.indicatorColor = buttonColor;
        if (i % 2 == 0) {
            radioButton.iconSquare = YES;
        }
        if (i > 2) {
            // put icon on the right side
            radioButton.iconOnRight = YES;
            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        } else {
            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
        [self.view addSubview:radioButton];
        i++;
        
        // add to group
        [self.radioGroup addRadioButton:radioButton];
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
}

#pragma mark DLRadioGroupDelegate

- (void)dlRadioGroup:(DLRadioGroup *)radioGroup didSelect:(DLRadioButton *)radioButton {
    if (radioGroup.isMultipleSelectionEnabled) {
        NSMutableArray *strings = [NSMutableArray new];
        
        for (DLRadioButton *button in radioGroup.selectedRadioButtons) {
            [strings addObject:button.titleLabel.text];
        }
        
        if (strings.count > 0) {
            NSLog(@"%@ %@ selected.\n", [strings componentsJoinedByString:@", "], strings.count > 1 ? @"are" : @"is");
        }
    } else {
        NSLog(@"%@ is selected.\n", radioGroup.selectedRadioButton.titleLabel.text);
    }
}

@end
