//
//  ViewController.swift
//  BWWalkthroughExample
//
//  Created by Yari D'areglia on 17/09/14.
//  Copyright (c) 2014 Yari D'areglia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BWWalkthroughViewControllerDelegate {
    @IBOutlet weak var pictureBackground: UIImageView!
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var startQuoteBtn: UIButton!
    
    static let sharedUtils = ViewController()
    
    class func redoQuoteScreens(targetVC: UIViewController)
    {
        // Get view controllers and build the walkthrough
        let stb = UIStoryboard(name: "walkthrough", bundle: nil)
        let walkthrough = stb.instantiateViewControllerWithIdentifier("walk") as! BWWalkthroughViewController
        let page_four = stb.instantiateViewControllerWithIdentifier("walk4")
        let page_one = stb.instantiateViewControllerWithIdentifier("walk1")
        let page_two = stb.instantiateViewControllerWithIdentifier("walk2")
        let page_three = stb.instantiateViewControllerWithIdentifier("walk3")
        
        // Attach the pages to the master
        walkthrough.addViewController(page_one)
        walkthrough.addViewController(page_two)
        walkthrough.addViewController(page_three)
        walkthrough.addViewController(page_four)
        
        targetVC.presentViewController(walkthrough, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        startQuoteBtn.alpha = 0
        startQuoteBtn.hidden = true
        
        let application = UIApplication.sharedApplication()
        application.statusBarHidden = true
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.walkthroughCloseButtonPressed), name: "close", object: nil)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        //userDefaults.setBool(false, forKey: "walkthroughPresented")
        
        if !userDefaults.boolForKey("walkthroughPresented") {
            UIView.animateWithDuration(1.0, animations: {
                self.logo.alpha = 0
                //self.logo.center = CGPoint(x: UIScreen.mainScreen().bounds.size.width / 2, y: -300)
                
            })
            UIView.animateWithDuration(0.5, animations: {
                self.pictureBackground.alpha = 0
                
                }, completion: {
                    (value: Bool) in
                    self.setUpQuote()
                    
            })
            
            
        }else{
            self.startQuoteBtn.hidden = false
            UIView.animateWithDuration(1.0, animations: {
                self.view.backgroundColor = UIColor.whiteColor()
                self.pictureBackground.alpha = 0
                self.logo.alpha = 0
                
            })
            UIView.animateWithDuration(1.5, animations: {
                self.startQuoteBtn.alpha = 1.0
            })
            
          
            let nib = UIStoryboard(name: "Main", bundle: nil)
            let home = nib.instantiateViewControllerWithIdentifier("NavController")
            self.presentViewController(home, animated: true, completion: nil)
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setUpQuote(){
        self.startQuoteBtn.hidden = false
        UIView.animateWithDuration(1.0, animations: {
            self.view.backgroundColor = UIColor.blackColor()
            self.startQuoteBtn.alpha = 0
            }, completion: {
                (value: Bool) in
                
                // Get view controllers and build the walkthrough
                let stb = UIStoryboard(name: "walkthrough", bundle: nil)
                let walkthrough = stb.instantiateViewControllerWithIdentifier("walk") as! BWWalkthroughViewController
                let page_four = stb.instantiateViewControllerWithIdentifier("walk4")
                let page_one = stb.instantiateViewControllerWithIdentifier("walk1")
                let page_two = stb.instantiateViewControllerWithIdentifier("walk2")
                let page_three = stb.instantiateViewControllerWithIdentifier("walk3")
                
                // Attach the pages to the master
                walkthrough.delegate = self
                walkthrough.addViewController(page_one)
                walkthrough.addViewController(page_two)
                walkthrough.addViewController(page_three)
                walkthrough.addViewController(page_four)
                
                self.presentViewController(walkthrough, animated: true, completion: nil)
                
        })
    }
    
    
    // MARK: - Walkthrough delegate -
    
    func walkthroughPageDidChange(pageNumber: Int) {
        print("Current Page \(pageNumber)")
    }
    
    func walkthroughCloseButtonPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


