//
//  SecondViewController.swift
//  CreditApp
//
//  Created by Ryan Daulton on 8/12/16.
//  Copyright © 2016 Ryan Daulton. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, BWWalkthroughPage {
    @IBOutlet weak var twelveMo: UIButton!
    @IBAction func twelveSelected(sender: AnyObject) {
        if twelveMo.selected{
            twelveMo.selected = false
        }else{
            twelveMo.selected = true
        }
    }
    @IBOutlet weak var twentyFourMo: UIButton!
    @IBAction func twentyFourSelected(sender: AnyObject) {
        if twentyFourMo.selected{
            twentyFourMo.selected = false
        }else{
            twentyFourMo.selected = true
        }
    }
    @IBOutlet weak var thirtySixMo: UIButton!
    @IBAction func thirtySixSelected(sender: AnyObject) {
        if thirtySixMo.selected{
            thirtySixMo.selected = false
        }else{
            thirtySixMo.selected = true
        }
    }
    @IBOutlet weak var fourtyEightMo: UIButton!
    @IBAction func fourtyEightSelected(sender: AnyObject) {
        if fourtyEightMo.selected{
            fourtyEightMo.selected = false
        }else{
            fourtyEightMo.selected = true
        }
    }
    @IBOutlet weak var sixtyMo: UIButton!
    @IBAction func sixtySelected(sender: AnyObject) {
        if sixtyMo.selected{
            sixtyMo.selected = false
        }else{
            sixtyMo.selected = true
        }
    }
    @IBOutlet weak var seventyTwoMo: UIButton!
    @IBAction func seventyTwoSelected(sender: AnyObject) {
        if seventyTwoMo.selected{
            seventyTwoMo.selected = false
        }else{
            seventyTwoMo.selected = true
        }
    }
    @IBOutlet weak var lease: UIButton!
    @IBAction func leaseSelected(sender: AnyObject) {
        if lease.selected{
        }else{
            lease.selected = true
        }
        if loan.selected{
            loan.selected = false
        }
    }
    @IBOutlet weak var loan: UIButton!
    @IBAction func loanSelected(sender: AnyObject) {
        if loan.selected{
        }else{
            loan.selected = true
        }
        if lease.selected{
            lease.selected = false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Button UI selected/deselected
        twelveMo.setImage(UIImage(named: "12mo.png"), forState: UIControlState.Normal)
        twelveMo.setImage(UIImage(named: "_12mo.png"), forState: UIControlState.Selected)
        twentyFourMo.setImage(UIImage(named: "24mo.png"), forState: UIControlState.Normal)
        twentyFourMo.setImage(UIImage(named: "_24mo.png"), forState: UIControlState.Selected)
        thirtySixMo.setImage(UIImage(named: "36mo.png"), forState: UIControlState.Normal)
        thirtySixMo.setImage(UIImage(named: "_36mo.png"), forState: UIControlState.Selected)
        fourtyEightMo.setImage(UIImage(named: "48mo.png"), forState: UIControlState.Normal)
        fourtyEightMo.setImage(UIImage(named: "_48mo.png"), forState: UIControlState.Selected)
        sixtyMo.setImage(UIImage(named: "60mo.png"), forState: UIControlState.Normal)
        sixtyMo.setImage(UIImage(named: "_60mo.png"), forState: UIControlState.Selected)
        seventyTwoMo.setImage(UIImage(named: "72mo.png"), forState: UIControlState.Normal)
        seventyTwoMo.setImage(UIImage(named: "_72mo.png"), forState: UIControlState.Selected)
        lease.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
        lease.setImage(UIImage(named: "checked.png"), forState: UIControlState.Selected)
        lease.selected = true
        loan.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
        loan.setImage(UIImage(named: "checked.png"), forState: UIControlState.Selected)
        
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
        self.view.backgroundColor = tamarackRed
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
