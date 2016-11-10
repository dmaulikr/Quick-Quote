//
//  FourthViewController.swift
//  CreditApp
//
//  Created by Ryan Daulton on 8/15/16.
//  Copyright © 2016 Ryan Daulton. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController, BWWalkthroughPage {
    @IBAction func finishBtn_pushed(sender: AnyObject) {
        
        //SAVE ALL ENTRIES HERE
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "walkthroughPresented")
        userDefaults.synchronize()
        
        NSNotificationCenter.defaultCenter().postNotificationName("close", object: nil)


    }
    @IBOutlet weak var finishBtn: UIButton!
    var creditRating = ""
    
    @IBOutlet weak var D: UIButton!
    @IBAction func _D(sender: AnyObject) {
        D.backgroundColor = UIColor.whiteColor()
        C.backgroundColor = tamarackPurpleLight
        B.backgroundColor = tamarackPurpleLight
        A.backgroundColor = tamarackPurpleLight
        creditRating = "D"
        print("Credit Rating | \(creditRating)")
        creditLabel.text = "D"
        self.finishBtn.hidden = false

    }
    @IBOutlet weak var C: UIButton!
    @IBAction func _C(sender: AnyObject) {
        D.backgroundColor = UIColor.whiteColor()
        C.backgroundColor = UIColor.whiteColor()
        B.backgroundColor = tamarackPurpleLight
        A.backgroundColor = tamarackPurpleLight
        creditRating = "C"
        print("Credit Rating | \(creditRating)")
        creditLabel.text = "C"
        self.finishBtn.hidden = false

    }
    @IBOutlet weak var B: UIButton!
    @IBAction func _B(sender: AnyObject) {
        D.backgroundColor = UIColor.whiteColor()
        C.backgroundColor = UIColor.whiteColor()
        B.backgroundColor = UIColor.whiteColor()
        A.backgroundColor = tamarackPurpleLight
        creditRating = "B"
        print("Credit Rating | \(creditRating)")
        creditLabel.text = "B"
        self.finishBtn.hidden = false

    }
    @IBOutlet weak var A: UIButton!
    @IBAction func _A(sender: AnyObject) {
        D.backgroundColor = UIColor.whiteColor()
        C.backgroundColor = UIColor.whiteColor()
        B.backgroundColor = UIColor.whiteColor()
        A.backgroundColor = UIColor.whiteColor()
        creditRating = "A"
        print("Credit Rating | \(creditRating)")
        creditLabel.text = "A"
        self.finishBtn.hidden = false

    }

    @IBOutlet weak var creditLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.finishBtn.hidden = true
        
        self.view.layer.masksToBounds = true
        subsWeights = Array()
        
        for v in view.subviews{
            speed.x += speedVariance.x
            speed.y += speedVariance.y
            if !notAnimatableViews.contains(v.tag) {
                subsWeights.append(speed)
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.backgroundColor = tamarackPurple
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func walkthroughDidScroll(position: CGFloat, offset: CGFloat) {
        for i in 0 ..< subsWeights.count{
            
            // Perform Transition/Scale/Rotate animations
            switch animation{
                
            case .Linear:
                animationLinear(i, offset)
                
            case .Zoom:
                animationZoom(i, offset)
                
            case .Curve:
                animationCurve(i, offset)
                
            case .InOut:
                animationInOut(i, offset)
            }
            
            // Animate alpha
            if(animateAlpha){
                animationAlpha(i, offset)
            }
        }
        
    }
    private var animation:WalkthroughAnimationType = .Linear
    private var subsWeights:[CGPoint] = Array()
    private var notAnimatableViews:[Int] = [] // Array of views' tags that should not be animated during the scroll/transition
    
    // MARK: Inspectable Properties
    // Edit these values using the Attribute inspector or modify directly the "User defined runtime attributes" in IB
    @IBInspectable var speed:CGPoint = CGPoint(x: 0.0, y: 0.0);            // Note if you set this value via Attribute inspector it can only be an Integer (change it manually via User defined runtime attribute if you need a Float)
    @IBInspectable var speedVariance:CGPoint = CGPoint(x: 0.0, y: 0.0)     // Note if you set this value via Attribute inspector it can only be an Integer (change it manually via User defined runtime attribute if you need a Float)
    @IBInspectable var animationType:String {
        set(value){
            self.animation = WalkthroughAnimationType(rawValue: value)!
        }
        get{
            return self.animation.rawValue
        }
    }
    @IBInspectable var animateAlpha:Bool = false
    @IBInspectable var staticTags:String {                                 // A comma separated list of tags that you don't want to animate during the transition/scroll
        set(value){
            self.notAnimatableViews = value.componentsSeparatedByString(",").map{Int($0)!}
        }
        get{
            return notAnimatableViews.map{String($0)}.joinWithSeparator(",")
        }
    }
    
    // MARK: BWWalkthroughPage Implementation
    
    
    
    // MARK: Animations (WIP)
    
    func animationAlpha(index:Int, _ offset:CGFloat){
        let cView = view.subviews[index]
        var mutableOffset = offset
        if(mutableOffset > 1.0){
            mutableOffset = 1.0 + (1.0 - mutableOffset)
        }
        cView.alpha = (mutableOffset)
    }
    
    private func animationCurve(index:Int, _ offset:CGFloat){
        var transform = CATransform3DIdentity
        let x:CGFloat = (1.0 - offset) * 10
        transform = CATransform3DTranslate(transform, (pow(x,3) - (x * 25)) * subsWeights[index].x, (pow(x,3) - (x * 20)) * subsWeights[index].y, 0 )
        applyTransform(index, transform: transform)
    }
    
    private func animationZoom(index:Int, _ offset:CGFloat){
        var transform = CATransform3DIdentity
        
        var tmpOffset = offset
        if(tmpOffset > 1.0){
            tmpOffset = 1.0 + (1.0 - tmpOffset)
        }
        let scale:CGFloat = (1.0 - tmpOffset)
        transform = CATransform3DScale(transform, 1 - scale , 1 - scale, 1.0)
        applyTransform(index, transform: transform)
    }
    
    private func animationLinear(index:Int, _ offset:CGFloat){
        var transform = CATransform3DIdentity
        let mx:CGFloat = (1.0 - offset) * 100
        transform = CATransform3DTranslate(transform, mx * subsWeights[index].x, mx * subsWeights[index].y, 0 )
        applyTransform(index, transform: transform)
    }
    
    private func animationInOut(index:Int, _ offset:CGFloat){
        var transform = CATransform3DIdentity
        //var x:CGFloat = (1.0 - offset) * 20
        
        var tmpOffset = offset
        if(tmpOffset > 1.0){
            tmpOffset = 1.0 + (1.0 - tmpOffset)
        }
        transform = CATransform3DTranslate(transform, (1.0 - tmpOffset) * subsWeights[index].x * 100, (1.0 - tmpOffset) * subsWeights[index].y * 100, 0)
        applyTransform(index, transform: transform)
    }
    
    private func applyTransform(index:Int, transform:CATransform3D){
        let subview = view.subviews[index]
        if !notAnimatableViews.contains(subview.tag){
            view.subviews[index].layer.transform = transform
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
