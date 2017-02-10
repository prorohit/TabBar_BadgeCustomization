//
//  ViewController.swift
//  TabBar-Badge
//
//  Created by Rohit.Singh on 03/02/17.
//  Copyright © 2017 Rohit.Singh. All rights reserved.
//

import UIKit

class Home: UIViewController, UITabBarControllerDelegate {
    
    var isEnglish : Bool = true;
    var color : UIColor = UIColor.black
    var animationType : AnimationType = AnimationType.Push
    
    @IBOutlet weak var segmentLanguage: UISegmentedControl!
    
    
    //MARK: ViewLife Cycle Methods
    override func viewDidLoad() {
        self.navigationItem.title = "TabBar-Badge-POC"
        super.viewDidLoad()
    }
    
    //MARK: TabBar Delegate Methods
    
    func tabBarController(_ tabBarController: UITabBarController, didSelectviewController: UIViewController) {
        print(tabBarController.selectedIndex)
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    
    //MARK: - IBActions for the Segment Control
    // IBAction For the SegmentChange of the Language
    @IBAction func segmentChangeLanguage(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isEnglish = true
        } else {
            isEnglish = false
        }
        positionTabBadge(animation: animationType)
    }
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            color = UIColor.black
        } else if sender.selectedSegmentIndex == 1{
            color = UIColor.brown
        }else if sender.selectedSegmentIndex == 2{
            color = UIColor.blue
        }
        
        positionTabBadge(animation: self.animationType)
    }
    
    
    
    @IBAction func segmentAnimation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.animationType = AnimationType.Push
            positionTabBadge(animation: self.animationType)
        } else if sender.selectedSegmentIndex == 1 {
            self.animationType = AnimationType.Shake
            positionTabBadge(animation: self.animationType)
        } else if sender.selectedSegmentIndex == 2 {
            self.animationType = AnimationType.Ratate
            positionTabBadge(animation: self.animationType)
        }else if sender.selectedSegmentIndex == 3 {
            self.animationType = AnimationType.Scale
            positionTabBadge(animation: self.animationType)
        }
        else if sender.selectedSegmentIndex == 4 {
            self.animationType = AnimationType.ScaleRotate
            positionTabBadge(animation: self.animationType)
        }
    }
    
    //MARK: Private Methods
    func positionTabBadge(animation : AnimationType) {
        self.tabBarController?.addBadgeWithSize(width: 24, height: 24, xOffset: 12, yOffset: 15, animationType: animation, isEnglish: isEnglish, index: 0, value: 10, color: color, font: UIFont.systemFont(ofSize: 13))

    }
    
    
    
}

