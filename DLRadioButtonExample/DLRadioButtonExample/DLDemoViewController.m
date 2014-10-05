//
//  DLDemoViewController.m
//  DLRadioButtonExample
//
//  Created by Liu, Xingruo on 8/25/14.
//  Copyright (c) 2014 Xingruo Liu. All rights reserved.
//

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set up button icons
    for (DLRadioButton *radioButton in self.topRadioButtons) {
        radioButton.ButtonIcon = [UIImage imageNamed:@"RadioButton"];
        radioButton.ButtonIconSelected = [UIImage imageNamed:@"RadioButtonSelected"];
    }
    
    // programmatically add buttons
    
    // first button
    DLRadioButton *firstRadioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(30, 200, 200, 30)];
    firstRadioButton.buttonSideLength = 30;
    [firstRadioButton setTitle:@"Red Button" forState:UIControlStateNormal];
    [firstRadioButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    firstRadioButton.circleColor = [UIColor redColor];
    firstRadioButton.indicatorColor = [UIColor redColor];
    firstRadioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // add other buttons
    [self.view addSubview:firstRadioButton];
    NSArray *colorNames = @[@"Orange", @"Green", @"Cyon", @"Blue", @"Purple"];
    NSArray *buttonColors = @[[UIColor orangeColor], [UIColor greenColor], [UIColor cyanColor], [UIColor blueColor], [UIColor purpleColor]];
    NSInteger i = 0;
    NSMutableArray *otherButtons = [NSMutableArray new];
    for (UIColor *buttonColor in buttonColors) {
        // customize this button
        DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(30, 240+40*i, 200, 30)];
        radioButton.buttonSideLength = 30;
        [radioButton setTitle:[colorNames[i] stringByAppendingString:@" Button"] forState:UIControlStateNormal];
        [radioButton setTitleColor:buttonColor forState:UIControlStateNormal];
        radioButton.circleColor = buttonColor;
        radioButton.indicatorColor = buttonColor;
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [otherButtons addObject:radioButton];
        [self.view addSubview:radioButton];
        i++;
    }
    firstRadioButton.otherButtons = otherButtons;
    self.buttomRadioButtons = [@[firstRadioButton] arrayByAddingObjectsFromArray:otherButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
