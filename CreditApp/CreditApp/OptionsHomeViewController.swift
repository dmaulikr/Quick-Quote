//
//  OptionsHomeViewController.swift
//  CreditApp
//
//  Created by Ryan Daulton on 10/25/16.
//  Copyright © 2016 Ryan Daulton. All rights reserved.
//

import UIKit
import Graphs
import SACountingLabel

class OptionsHomeViewController: UIViewController {
    @IBAction func redo_pushed(sender: AnyObject) {
        ViewController.redoQuoteScreens(self)
    }
    
    @IBOutlet weak var firstcell: UIView!

    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var secondcell: UIView!
    @IBAction func apply_pushed(sender: AnyObject) {
        print("APPLY")
    }
    @IBOutlet weak var ApplyButton: UIButton!
    @IBOutlet weak var cell1LoanTerms: UILabel!
    @IBOutlet weak var cell1AmtLbl: SACountingLabel!
    @IBOutlet weak var cell2AmtLbl: SACountingLabel!

    lazy var rect = CGRect()
    var Main = ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        ApplyButton.hidden = true
        rect = graphView.bounds
        self.navigationController?.navigationBar.titleTextAttributes=[NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        //Uncomment following line for  -> Pie Chart
        /*let view = data.pieGraph() { (unit, totalValue) -> String? in
            return unit.key! + "\n" + String(format: "%.0f%%", unit.value / totalValue * 100.0)
            }.view(rect)
        */
        
        //Uncomment following line for -> Bar Graph
        //let view = [8, 12, 20, -10, 6, 20, -11, 9, 12, 16, -10, 6, 20, -12].barGraph().view(graphView.bounds).barGraphConfiguration({ BarGraphViewConfig(barColor: UIColor(hex: "#ff6699"), contentInsets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)) })

        //Uncomment following line for -> Line Graph
        let view = [10, 20, 4, 8, 25, 18, 21, 24, 8, 15].lineGraph(GraphRange(min: 0, max: 30)).view(rect)

        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        graphView.addSubview(view)
    }
    
    func countForAnimationType(type: SACountingLabel.AnimationType) {
        cell1AmtLbl.countFrom(0, to: 4793.42, withDuration: NSTimeInterval(1.5), andAnimationType: type, andCountingType: .Custom)
        cell1AmtLbl.format = "$%.2f"
        cell2AmtLbl.countFrom(0, to: 11884.50, withDuration: NSTimeInterval(1.2), andAnimationType: type, andCountingType: .Custom)
        cell2AmtLbl.format = "$%.2f"
    }
    
    override func viewDidAppear(animated: Bool) {
        countForAnimationType(.EaseInOut)
    }
    override func viewWillAppear(animated: Bool) {
        
        let application = UIApplication.sharedApplication()
        application.statusBarHidden = false
        application.statusBarStyle = .LightContent

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        testTouches(touches)
    }
    
    func testTouches(touches: NSSet!) {
        // Get the first touch and its location in this view controller's view coordinate system
        let touch = touches.allObjects[0] as! UITouch
        let touchLocation = touch.locationInView(self.view)
        // Convert the location of the obstacle view to this view controller's view coordinate system
        let obstacle1ViewFrame = self.view.convertRect(firstcell.frame, fromView: firstcell.superview)
        let obstacle2ViewFrame = self.view.convertRect(secondcell.frame, fromView: secondcell.superview)
        // Check if the touch is inside the obstacle view
        if CGRectContainsPoint(obstacle1ViewFrame, touchLocation) {
            firstcell.layer.borderWidth = 1
            firstcell.layer.borderColor = UIColor.redColor().CGColor
            secondcell.layer.borderWidth = 0
            ApplyButton.hidden = false
        }else if CGRectContainsPoint(obstacle2ViewFrame, touchLocation){
            secondcell.layer.borderWidth = 1
            secondcell.layer.borderColor = UIColor.redColor().CGColor
            firstcell.layer.borderWidth = 0
            ApplyButton.hidden = false
        }
    }
}

//The Following Struct is for Pie Chart Generation
struct Data<T: Hashable, U: NumericType>: GraphData {
    typealias GraphDataKey = T
    typealias GraphDataValue = U
    
    private let _key: T
    private let _value: U
    
    init(key: T, value: U) {
        self._key = key
        self._value = value
    }
    
    var key: T { get{ return self._key } }
    var value: U { get{ return self._value } }
}

let data = [
    Data(key: "John", value: 18.9),
    Data(key: "Ken", value: 32.9),
    Data(key: "Taro", value: 15.3),
    Data(key: "Micheal", value: 22.9),
    Data(key: "Jun", value: 12.9),
    Data(key: "Hanako", value: 32.2),
    Data(key: "Kent", value: 3.8)
]


