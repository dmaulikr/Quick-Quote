//
//  FirstViewController.swift
//  CreditApp
//
//  Created by Ryan Daulton on 8/11/16.
//  Copyright © 2016 Ryan Daulton. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, BWWalkthroughPage, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryField: UITextField!
    var currentString = ""
    var snap: UISnapBehavior!
    var animator: UIDynamicAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        entryField.delegate = self
        entryField.hidden = true
        titleLabel.hidden = true
        // Do any additional setup after loading the view.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.3, animations: {
            self.view.backgroundColor = tamarackGreen
            
            
            }, completion: {
                (value: Bool) in
                UIView.animateWithDuration(0.2, animations: {
                    self.entryField.hidden = false
                    self.titleLabel.hidden = false
                    self.entryField.transform = CGAffineTransformMakeScale(0.98, 0.98)
                    
                    }, completion: {
                        (value:Bool) in
                        UIView.animateWithDuration(0.1, animations: {
                            self.entryField.transform = CGAffineTransformIdentity
                        })
                })
                
        })
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                              target: self, action: #selector(FirstViewController.doneClicked))
        
        toolbarDone.items = [barBtnDone] // You can even add cancel button too
        entryField.inputAccessoryView = toolbarDone
        self.entryField.becomeFirstResponder()
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool { // return NO to not change text
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            currentString += string
            formatCurrency(currentString)
        default:
            let array = Array(string.characters)
            var currentStringArray = Array(currentString.characters)
            if array.count == 0 && currentStringArray.count != 0 {
                currentStringArray.removeLast()
                currentString = ""
                for character in currentStringArray {
                    currentString += String(character)
                }
                formatCurrency(currentString)
            }
        }
        return false
    }
    
    func formatCurrency(string: String) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        let numberFromField = (NSString(string: currentString).doubleValue)/100
        entryField.text = formatter.stringFromNumber(numberFromField)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: BWWalkThroughPage protocol
    func doneClicked(){
        print("DONE")
        dismissKeyboard()
    }
    func walkthroughDidScroll(position: CGFloat, offset: CGFloat) {
        if ((entryField.text?.isEmpty) != nil){
            entryField.text = "$100,000.00"
        }
        dismissKeyboard()
        var tr = CATransform3DIdentity
        tr.m34 = -1 / 200.0
        var tr1 = CATransform3DIdentity
        tr1.m34 = 1 / 300.0
        
        //entryField?.layer.transform = CATransform3DRotate(tr, CGFloat(M_PI) * (1.0 - offset), 1, 1, 1)
        
        var tmpOffset = offset
        if(tmpOffset > 1.0){
            tmpOffset = 1.0 + (1.0 - tmpOffset)
        }
        titleLabel?.layer.transform = CATransform3DTranslate(tr1, 0 , (1.0 - tmpOffset) * -200, 0)
        entryField?.layer.transform = CATransform3DTranslate(tr, 0 , (1.0 - tmpOffset) * 200, 0)
        
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
