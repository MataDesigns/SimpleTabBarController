//
//  SimpleTabBarItemProtocol.swift
//  Pods
//
//  Created by Nicholas Mata on 10/25/16.
//
//

import Foundation
import UIKit

public protocol SimpleTabBarItemAnimatorProtocol {
    
    mutating func selectAnimation(content: UIView, animated: Bool, completion: (() -> ())?)
    
    mutating func deselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?)
    
    mutating func reselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?)
    
    mutating func highlightAnimation(content: UIView, animated: Bool, completion: (() -> ())?)
    
    mutating func dehighlightAnimation(content: UIView, animated: Bool, completion: (() -> ())?)
    
    mutating func badgeChangedAnimation(content: UIView, completion: (() -> ())?)
    
}
