//
//  ThirdViewController.swift
//  CreditApp
//
//  Created by Ryan Daulton on 8/12/16.
//  Copyright © 2016 Ryan Daulton. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, BWWalkthroughPage {

    @IBOutlet weak var c_monthly: UIButton!
    @IBAction func c_monthly_pushed(sender: AnyObject) {
        if c_monthly.selected{
        }else{
            c_monthly.selected = true
            c_quarterly.selected = false
            c_semiAn.selected = false
            c_An.selected = false
        }
        
    }
    @IBOutlet weak var c_quarterly: UIButton!
    @IBAction func c_quarterly_pushed(sender: AnyObject) {
        if c_quarterly.selected{
        }else{
            c_monthly.selected = false
            c_quarterly.selected = true
            c_semiAn.selected = false
            c_An.selected = false
        }
    }
    @IBOutlet weak var c_semiAn: UIButton!
    @IBAction func c_semiAn_pushed(sender: AnyObject) {
        if c_semiAn.selected{
        }else{
            c_monthly.selected = false
            c_quarterly.selected = false
            c_semiAn.selected = true
            c_An.selected = false
        }
    }
    @IBOutlet weak var c_An: UIButton!
    @IBAction func c_An_pushed(sender: AnyObject) {
        if c_An.selected{
        }else{
            c_monthly.selected = false
            c_quarterly.selected = false
            c_semiAn.selected = false
            c_An.selected = true
        }
    }
    @IBOutlet weak var commercial: UIButton!
    @IBAction func commercial_pushed(sender: AnyObject) {
        if commercial.selected{
            commercial.selected = false
        }else{
            commercial.selected = true
        }
    }
    @IBOutlet weak var farming: UIButton!
    @IBAction func farming_pushed(sender: AnyObject) {
        if farming.selected{
            farming.selected = false
        }else{
            farming.selected = true
        }
    }
    @IBOutlet weak var construc: UIButton!
    @IBAction func construc_pushed(sender: AnyObject) {
        if construc.selected{
            construc.selected = false
        }else{
            construc.selected = true
        }
    }
    @IBOutlet weak var mining: UIButton!
    @IBAction func mining_pushed(sender: AnyObject) {
        if mining.selected{
            mining.selected = false
        }else{
            mining.selected = true
        }
    }
    @IBOutlet weak var trans: UIButton!
    @IBAction func trans_pushed(sender: AnyObject) {
        if trans.selected{
            trans.selected = false
        }else{
            trans.selected = true
        }
    }
    @IBOutlet weak var tech: UIButton!
    @IBAction func tech_pushed(sender: AnyObject) {
        if tech.selected{
            tech.selected = false
        }else{
            tech.selected = true
        }
    }
    @IBOutlet weak var other: UIButton!
    @IBAction func other_pushed(sender: AnyObject) {
        if other.selected{
            other.selected = false
        }else{
            other.selected = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI Button States
        c_monthly.setImage(UIImage(named: "unchecked_b.png"), forState: UIControlState.Normal)
        c_monthly.setImage(UIImage(named: "checked_b.png"), forState: UIControlState.Selected)
        c_quarterly.setImage(UIImage(named: "unchecked_b.png"), forState: UIControlState.Normal)
        c_quarterly.setImage(UIImage(named: "checked_b.png"), forState: UIControlState.Selected)
        c_semiAn.setImage(UIImage(named: "unchecked_b.png"), forState: UIControlState.Normal)
        c_semiAn.setImage(UIImage(named: "checked_b.png"), forState: UIControlState.Selected)
        c_An.setImage(UIImage(named: "unchecked_b.png"), forState: UIControlState.Normal)
        c_An.setImage(UIImage(named: "checked_b.png"), forState: UIControlState.Selected)
        commercial.setImage(UIImage(named: "commercial.png"), forState: UIControlState.Normal)
        commercial.setImage(UIImage(named: "_commercial.png"), forState: UIControlState.Selected)
        farming.setImage(UIImage(named: "farming.png"), forState: UIControlState.Normal)
        farming.setImage(UIImage(named: "_farming.png"), forState: UIControlState.Selected)
        construc.setImage(UIImage(named: "construction.png"), forState: UIControlState.Normal)
        construc.setImage(UIImage(named: "_construction.png"), forState: UIControlState.Selected)
        mining.setImage(UIImage(named: "mining.png"), forState: UIControlState.Normal)
        mining.setImage(UIImage(named: "_mining.png"), forState: UIControlState.Selected)
        trans.setImage(UIImage(named: "transportation.png"), forState: UIControlState.Normal)
        trans.setImage(UIImage(named: "_transportation.png"), forState: UIControlState.Selected)
        tech.setImage(UIImage(named: "tech.png"), forState: UIControlState.Normal)
        tech.setImage(UIImage(named: "_tech.png"), forState: UIControlState.Selected)
        other.setImage(UIImage(named: "other.png"), forState: UIControlState.Normal)
        other.setImage(UIImage(named: "_other.png"), forState: UIControlState.Selected)
        c_monthly.selected = true

        //
        self.view.layer.masksToBounds = true
        subsWeights = Array()
        
        for v in view.subviews{
            speed.x += speedVariance.x
            speed.y += speedVariance.y
            if !notAnimatableViews.contains(v.tag) {
                subsWeights.append(speed)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        self.view.backgroundColor = tamarackBlue
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
