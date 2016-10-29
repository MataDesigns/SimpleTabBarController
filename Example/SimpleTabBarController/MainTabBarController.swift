//
//  ViewController.swift
//  SimpleBarController
//
//  Created by Nicholas Mata on 10/24/2016.
//  Copyright (c) 2016 Nicholas Mata. All rights reserved.
//

import UIKit
import SimpleTabBarController

class MainTabBarController: SimpleTabBarController {
    
    var value: Int64 = 0
    open override func viewDidLoad() {
        super.viewDidLoad()
//        self.transparentShadowBar = true
        
        self.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        self.hijackHandler = {
            [weak self] tabbarController, viewController, index in
            if index == 2 {
                self?.showPhoto()
            }
        }
        
        let v3          = UIViewController()
        v3.tabBarItem = SimpleTabBarItem(animator: SimpleIrregularAnimator())
        
        v3.tabBarItem.image = UIImage(named: "photo_verybig")
        self.viewControllers?.insert(v3, at: 2)
    }
    
    func showPhoto() {
        // Alert Example
        //        let alertController =  UIAlertController(title: "Photo Button", message: "tapped!", preferredStyle: .alert)
        //        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        //        alertController.addAction(okayAction)
        //        self.present(alertController, animated: true, completion: nil)
        
        // Segue Example
        self.performSegue(withIdentifier: "goToPhoto", sender: self)
    }
    
}
