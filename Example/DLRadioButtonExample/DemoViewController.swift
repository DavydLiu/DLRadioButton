import UIKit
import DLRadioButton

class DemoViewController : UIViewController {
    @IBOutlet var waterButton : DLRadioButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // enable multiple selection for water, beer and wine buttons.
        self.waterButton.multipleSelectionEnabled = true;
        
        // programmatically add buttons
        // first button
        let frame = CGRectMake(self.view.frame.size.width / 2 - 131, 350, 262, 17);
        let firstRadioButton = createRadioButton(frame, title: "Red Button", color: UIColor.redColor());
        
        //other buttons
        let colorNames = ["Brown", "Orange", "Green", "Blue", "Purple"];
        let colors = [UIColor.brownColor(), UIColor.orangeColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.purpleColor()];
        var i = 0;
        var otherButtons : [DLRadioButton] = [];
        for color in colors {
            let frame = CGRectMake(self.view.frame.size.width / 2 - 131, 380 + 30 * CGFloat(i), 262, 17);
            let radioButton = createRadioButton(frame, title: colorNames[i] + " Button", color: color);
            if (i % 2 == 0) {
                radioButton.iconSquare = true;
            }
            if (i > 1) {
                // put icon on the right side
                radioButton.iconOnRight = true;
                radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right;
            }
            otherButtons.append(radioButton);
            i += 1;
        }
        
        firstRadioButton.otherButtons = otherButtons;
    }
    
    // MARK: Helper
    
    private func createRadioButton(frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFontOfSize(14);
        radioButton.setTitle(title, forState: UIControlState.Normal);
        radioButton.setTitleColor(color, forState: UIControlState.Normal);
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        radioButton.addTarget(self, action: #selector(DemoViewController.logSelectedButton), forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
        if (radioButton.multipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selectedButton()!.titleLabel!.text!));
        }
    }
}

