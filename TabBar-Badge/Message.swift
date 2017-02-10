//
//  ViewController.swift
//  TabBar-Badge
//
//  Created by Rohit.Singh on 03/02/17.
//  Copyright © 2017 Rohit.Singh. All rights reserved.
//

import UIKit

class Message: UIViewController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        print(tabBarController.selectedIndex)
    }


}

