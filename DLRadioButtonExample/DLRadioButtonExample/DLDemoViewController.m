#import "DLDemoViewController.h"
#import "DLRadioButton.h"

@interface DLDemoViewController ()

@property (strong, nonatomic) IBOutletCollection(DLRadioButton) NSArray *topRadioButtons;
@property (nonatomic) NSArray *buttomRadioButtons;

@end

@implementation DLDemoViewController

#pragma mark - Helpers

- (void)showSelectedButton:(NSArray *)radioButtons {
    NSString *buttonName = [(DLRadioButton *)radioButtons[0] selectedButton].titleLabel.text;
    [[[UIAlertView alloc] initWithTitle: buttonName ? @"Selected Button" : @"No Button Selected" message:buttonName delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (IBAction)touched:(id)sender {
    [self showSelectedButton:self.topRadioButtons];
}

- (IBAction)secondButtonTapped:(id)sender {
    [self showSelectedButton:self.buttomRadioButtons];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // programmatically add buttons
    // first button
    DLRadioButton *firstRadioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(30, 200, self.view.frame.size.width - 60, 30)];
    firstRadioButton.size = 30;
    [firstRadioButton setTitle:@"Red Button" forState:UIControlStateNormal];
    [firstRadioButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    firstRadioButton.circleColor = [UIColor redColor];
    firstRadioButton.indicatorColor = [UIColor redColor];
    firstRadioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // other buttons
    [self.view addSubview:firstRadioButton];
    NSArray *colorNames = @[@"Orange", @"Green", @"Cyon", @"Blue", @"Purple"];
    NSArray *buttonColors = @[[UIColor orangeColor], [UIColor greenColor], [UIColor cyanColor], [UIColor blueColor], [UIColor purpleColor]];
    NSInteger i = 0;
    NSMutableArray *otherButtons = [NSMutableArray new];
    for (UIColor *buttonColor in buttonColors) {
        // customize button
        DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(30, 240 + 40 * i, self.view.frame.size.width - 60, 30)];
        radioButton.size = 30;
        [radioButton setTitle:[colorNames[i] stringByAppendingString:@" Button"] forState:UIControlStateNormal];
        [radioButton setTitleColor:buttonColor forState:UIControlStateNormal];
        radioButton.circleColor = buttonColor;
        radioButton.indicatorColor = buttonColor;
        if (i == 1 || i == 2) {
            // put icon on the right side
            radioButton.iconOnRight = YES;
            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        } else {
            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
        [otherButtons addObject:radioButton];
        [self.view addSubview:radioButton];
        i++;
    }
    
    firstRadioButton.otherButtons = otherButtons;
    self.buttomRadioButtons = [@[firstRadioButton] arrayByAddingObjectsFromArray:otherButtons];
}

@end
