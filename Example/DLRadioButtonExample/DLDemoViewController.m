#import "DLDemoViewController.h"

@interface DLDemoViewController ()

@property (weak, nonatomic) IBOutlet DLRadioButton *waterButton;

@end

@implementation DLDemoViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // enable multiple selection for water, beer and wine buttons.
    self.waterButton.multipleSelectionEnabled = YES;
    
    // programmatically add button
    // first button
    CGRect frame = CGRectMake(self.view.frame.size.width / 2 - 131, 350, 262, 17);
    DLRadioButton *firstRadioButton = [self createRadioButtonWithFrame:frame
                                                                 Title:@"Red Button"
                                                                 Color:[UIColor redColor]];
    
    // other buttons
    NSArray *colorNames = @[@"Brown", @"Orange", @"Green", @"Blue", @"Purple"];
    NSArray *colors = @[[UIColor brownColor], [UIColor orangeColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor]];
    NSInteger i = 0;
    NSMutableArray *otherButtons = [NSMutableArray new];
    for (UIColor *color in colors) {
        CGRect frame = CGRectMake(self.view.frame.size.width / 2 - 131, 380 + 30 * i, 262, 17);
        DLRadioButton *radioButton = [self createRadioButtonWithFrame:frame
                                                                Title:[colorNames[i] stringByAppendingString:@" Button"]
                                                                Color:color];
        if (i % 2 == 0) {
            radioButton.iconSquare = YES;
        }
        if (i > 1) {
            // put icon on the right side
            radioButton.iconOnRight = YES;
            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
        [otherButtons addObject:radioButton];
        i++;
    }
    
    firstRadioButton.otherButtons = otherButtons;
}

#pragma mark - Helper

- (DLRadioButton *)createRadioButtonWithFrame:(CGRect) frame Title:(NSString *)title Color:(UIColor *)color
{
    DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:frame];
    radioButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [radioButton setTitle:title forState:UIControlStateNormal];
    [radioButton setTitleColor:color forState:UIControlStateNormal];
    radioButton.iconColor = color;
    radioButton.indicatorColor = color;
    radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:radioButton];
    
    return radioButton;
}

- (IBAction)logSelectedButton:(DLRadioButton *)radioButton {
    if (radioButton.isMultipleSelectionEnabled) {
        for (DLRadioButton *button in radioButton.selectedButtons) {
            NSLog(@"%@ is selected.\n", button.titleLabel.text);
        }
    } else {
        NSLog(@"%@ is selected.\n", radioButton.selectedButton.titleLabel.text);
    }
}

@end
