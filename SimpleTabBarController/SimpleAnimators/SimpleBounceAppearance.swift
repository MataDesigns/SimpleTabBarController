//
//  BounceAnimator.swift
//  Pods
//
//  Created by Nicholas Mata on 10/25/16.
//
//

import UIKit

open class SimpleBounceAppearance: SimpleBarItemAppearance {
    
    open var duration = 0.3
    
    required public init() {
        super.init()
        textColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
        iconColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
        backgroundColor = UIColor.clear
        highlightBackgroundColor = UIColor.clear
    }
    
    open override func selectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.selectAnimation(content: content, animated: animated, completion: completion)
        if let content = content as? SimpleBarItemContent {
            self.bounceAnimation(content.imageView)
        }
    }
    
    open override func reselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.reselectAnimation(content: content, animated: animated, completion: completion)
//        if let content = content as? SimpleBarItemContent {
//            self.bounceAnimation(content.imageView)
//        }
    }
    
    open override func deselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.deselectAnimation(content: content, animated: animated, completion: completion)
    }
    
    internal func bounceAnimation(_ view: UIView) {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        view.layer.add(impliesAnimation, forKey: nil)
    }
    
    //    open var duration = 0.3
    
    open override func badgeChangedAnimation(content: UIView, completion: (() -> ())?) {
        super.badgeChangedAnimation(content: content, completion: completion)
        if let content = content as? SimpleBarItemContent {
            notificationAnimation(content.imageView)
        }
    }
    
    internal func notificationAnimation(_ view: UIView) {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        impliesAnimation.values = [0.0 ,-8.0, 4.0, -4.0, 3.0, -2.0, 0.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        view.layer.add(impliesAnimation, forKey: nil)
    }
    
}
