//
//  SimpleBarItemAnimator.swift
//  Pods
//
//  Created by Nicholas Mata on 10/25/16.
//
//

import UIKit
import Foundation

public protocol SimpleBarItemAnimatorProtocol {
    
    mutating func selectAnimation(content: UIView, animated: Bool, completion: (() -> ())?)
    
    mutating func deselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?)
    
    mutating func reselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?)
    
    mutating func highlightAnimation(content: UIView, animated: Bool, completion: (() -> ())?)
    
    mutating func dehighlightAnimation(content: UIView, animated: Bool, completion: (() -> ())?)
    
    mutating func badgeChangedAnimation(content: UIView, completion: (() -> ())?)
    
}

/**
 This is responsible for the appearance of SimpleBarItem.
 This includes colors and animations.
 
 Defaults:
 
 */
open class SimpleBarItemAppearance: NSObject, SimpleBarItemAnimatorProtocol {
    
    open weak var content: UIView?
    
    open var textColor = UIColor(white: 146.0 / 255.0, alpha: 1.0)
    open var highlightTextColor = UIColor(red: 0.0 / 255.0, green: 116.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    
    open var iconColor = UIColor(white: 146.0 / 255.0, alpha: 1.0)
    open var highlightIconColor: UIColor = .black
    
    open var backgroundColor = UIColor.clear
    open var highlightBackgroundColor = UIColor.clear
    
    override required public init() {
        
    }
    
    open func selectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        if let content = content as? SimpleBarItemContent {
            content.backgroundColor = highlightBackgroundColor
            content.titleLabel.textColor = highlightTextColor
            if let image = content.imageView.image {
                var renderImage = image.withRenderingMode(.alwaysTemplate)
                if let selectedImage = content.item.selectedImage {
                    renderImage = selectedImage.withRenderingMode(.alwaysTemplate)
                }
                content.imageView.image = renderImage
                content.imageView.tintColor = highlightIconColor
            }
        }
        completion?()
    }
    
    open func reselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        if let content = content as? SimpleBarItemContent {
            content.backgroundColor = highlightBackgroundColor
            content.titleLabel.textColor = highlightTextColor
            if let image = content.imageView.image {
                let renderImage = image.withRenderingMode(.alwaysTemplate)
                content.imageView.image = renderImage
                content.imageView.tintColor = highlightIconColor
            }
        }
        completion?()
    }
    
    open func deselectAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        if let content = content as? SimpleBarItemContent {
            content.backgroundColor = backgroundColor
            content.titleLabel.textColor = textColor
            if let image = content.imageView.image {
                let renderImage = image.withRenderingMode(.alwaysTemplate)
                content.imageView.image = renderImage
                content.imageView.tintColor = iconColor
            }
        }
        completion?()
    }
    
    open func highlightAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        completion?()
    }
    
    open func dehighlightAnimation(content: UIView, animated: Bool, completion: (() -> ())?) {
        completion?()
    }
    
    open func badgeChangedAnimation(content: UIView, completion: (() -> ())?) {
        completion?()
    }
}
