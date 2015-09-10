#import <XCTest/XCTest.h>
#import "DLRadioButton.h"

@interface DLRadioButtonExampleTests : XCTestCase

@property DLRadioButton *firstButton;
@property DLRadioButton *secondButton;
@property DLRadioButton *thirdButton;

@end

@implementation DLRadioButtonExampleTests

- (void)setUp {
    [super setUp];
    self.firstButton = [[DLRadioButton alloc] init];
    self.secondButton = [[DLRadioButton alloc] init];
    self.thirdButton = [[DLRadioButton alloc] init];
    self.firstButton.otherButtons = @[self.secondButton, self.thirdButton];
}

- (void)tearDown {
    self.firstButton = nil;
    self.secondButton = nil;
    self.thirdButton = nil;
    [super tearDown];
}

- (void)testButtonSelection {
    [self.firstButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self.secondButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertEqualObjects([self.firstButton selectedButton], self.secondButton);
    XCTAssertEqualObjects([self.secondButton selectedButton], self.secondButton);
    [self.thirdButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertEqualObjects([self.secondButton selectedButton], self.thirdButton);
}

- (void)testButtonDeselection {
    [self.secondButton sendActionsForControlEvents:UIControlEventTouchDown];
    [self.firstButton deselectOtherButtons];
    XCTAssertNil([self.firstButton selectedButton]);
}

@end
