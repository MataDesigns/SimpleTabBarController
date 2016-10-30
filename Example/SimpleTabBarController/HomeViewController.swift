//
//  HomeViewController.swift
//  SimpleTabBarController
//
//  Created by Nicholas Mata on 10/29/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import SimpleTabBarController

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        (self.tabBarItem as? SimpleBarItem)?.badgeColor = UIColor(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func incrementBadge(_ sender: Any) {
        if let value = self.tabBarItem.badgeValue {
            var intValue = Int(value)!
            intValue += 1
            self.tabBarItem.badgeValue = String(intValue)
        } else {
            self.tabBarItem.badgeValue = "1"
        }
    }
    
    @IBAction func decrementBadge(_ sender: Any) {
        if let value = self.tabBarItem.badgeValue {
            var intValue = Int(value)!
            intValue -= 1
            if intValue <= 0 {
                self.tabBarItem.badgeValue = nil
                return
            }
            self.tabBarItem.badgeValue = String(intValue)
        }
    }

}
