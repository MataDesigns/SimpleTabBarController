//
//  SimpleIrregularAnimator.swift
//  Pods
//
//  Created by Nicholas Mata on 10/25/16.
//
//

import UIKit

open class SimpleIrregularAppearance: SimpleBarItemAppearance {
    
    open var borderWidth: CGFloat = 3.0
    open var borderColor = UIColor(white: 235 / 255.0, alpha: 1.0)
    
    open var radius: CGFloat = 35
    
    open var insets: UIEdgeInsets = UIEdgeInsets(top: -32, left: 0, bottom: 0, right: 0)
    
    open var irregularBackgroundColor: UIColor = .gray
    
    open override var content: UIView? {
        didSet {
            if let content = content as? SimpleBarItemContent {
                content.imageView.backgroundColor = irregularBackgroundColor
                content.imageView.layer.borderWidth = borderWidth
                content.imageView.layer.borderColor = borderColor.cgColor
                content.imageView.layer.cornerRadius = radius
                content.insets = insets
                let transform = CGAffineTransform.identity
                content.imageView.transform = transform
                content.superview?.bringSubviewToFront(content)
            }
        }
    }
    
    public required init() {
        super.init()
        textColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        backgroundColor = UIColor.clear
        highlightBackgroundColor = UIColor.clear
    }
    
    open override func selectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.selectAnimation(content: content, animated: animated, completion: completion)
    }

    open override func reselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.reselectAnimation(content: content, animated: animated, completion: completion)
    }

    open override func deselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.deselectAnimation(content: content, animated: animated, completion: completion)

    }

    open override func highlightAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.highlightAnimation(content: content, animated: animated, completion: completion)

    }

    open override func dehighlightAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        super.dehighlightAnimation(content: content, animated: animated, completion: completion)

    }
    
}

