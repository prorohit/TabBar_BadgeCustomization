//
//  UITabBarController.swift
//  TabBar-Badge
//
//  Created by Rohit.Singh on 08/02/17.
//  Copyright © 2017 Rohit.Singh. All rights reserved.
//

import Foundation
import UIKit

enum AnimationType {
    case Push
    case Shake
    case Ratate
    case Scale
    case ScaleRotate
    case NoAnimation
}

//MARK: Extension For ViewAnimation
extension UIView {
    //For Shake Animation
    func shake(count : Float? = nil,for duration : TimeInterval? = nil,withTranslation translation : Float? = nil) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        animation.repeatCount = count ?? 2
        animation.duration = (duration ?? 0.5)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? -5
        layer.add(animation, forKey: "shake")
    }
    
    // For Push Animation
    func animationWithPushOnView() {
        let applicationLoadViewIn : CATransition = CATransition.init()
        applicationLoadViewIn.duration = 0.4
        applicationLoadViewIn.type = kCATransitionPush
        applicationLoadViewIn.subtype = kCATransitionFromRight
        applicationLoadViewIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.add(applicationLoadViewIn, forKey: kCATransitionPush)
    }
    // For Rotation Animation
    func animationWithRotationOnView() {
        let duration = 0.5
        let delay = 0.1
        let options = UIViewKeyframeAnimationOptions.calculationModeLinear
        let fullRotation = CGFloat(M_PI * 2)
        
        UIView.animateKeyframes(withDuration: duration, delay: delay, options: options, animations: {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                // start at 0.00s (5s × 0)
                // duration 1.67s (5s × 1/3)
                // end at   1.67s (0.00s + 1.67s)
                self.transform = CGAffineTransform(rotationAngle: 1/3 * fullRotation)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                self.transform = CGAffineTransform(rotationAngle: 2/3 * fullRotation)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                self.transform = CGAffineTransform(rotationAngle: 3/3 * fullRotation)
            })
            
        }, completion: {finished in
            // any code entered here will be applied
            // once the animation has completed
            
        })
    }
    
    // For Scale Animation 
    func animationScale(){
        // Zooming In
        UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: { (finish) in
            
        })
        
        // Zooming Out
        UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform(scaleX: 1,y: 1)
        })
    }
    
    // For Scale And Rotate Animation
    func animationRotationScale(){
        let fullRotation = CGFloat(M_PI )
        // Zooming In
        UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform(rotationAngle: fullRotation)
            self.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: { (finish) in
            
        })
        
        // Zooming Out
        UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform(scaleX: 1,y: 1)
        })
    }
    
}


//MARK: Extension for the UITabBarController For Adding BadgeIcons
extension UITabBarController {
    
    func setBadges(badgeValues: [Int]) {
        
        for view in self.tabBar.subviews {
            if view is CustomTabBadge {
                view.removeFromSuperview()
            }
        }
        
        for index in 0...badgeValues.count-1 {
            if badgeValues[index] != 0 {
                if index == 0 {

                    addBadgeWithSize(width: 25, height: 25, xOffset: 12, yOffset: 14, animationType: AnimationType.NoAnimation, isEnglish: true, index: 0, value: 12, color: UIColor.black, font: UIFont.systemFont(ofSize: 12))
                }
            }
        }
    }
    
    // Positioning
    func positionBadges(isEnglish : Bool, width : CGFloat, height : CGFloat,xOffset : CGFloat, yOffset : CGFloat) {
        var tabbarButtons = self.tabBar.subviews.filter { (view: UIView) -> Bool in
            return view.isUserInteractionEnabled // only UITabBarButton are userInteractionEnabled
        }
        tabbarButtons = tabbarButtons.sorted(by: { $0.frame.origin.x < $1.frame.origin.x })
        for view in self.tabBar.subviews {
            if view is CustomTabBadge {
                let badgeView = view as! CustomTabBadge

                
                self.positionBadgeWithSize(width : width,height : height,xOffset: xOffset, yOffset: yOffset, badgeView: badgeView, items: tabbarButtons, index: badgeView.tag, isEnglish: isEnglish)
            }
        }
    }
    
    func positionBadgeWithSize(width : CGFloat = CGFloat(25),height:CGFloat = CGFloat(25),xOffset:CGFloat = CGFloat(12),yOffset:CGFloat = CGFloat(14), badgeView: UIView, items: [UIView], index: Int,isEnglish : Bool) {
        
        let itemView = items[index]
        let center = itemView.center
        
        var xOffsetPosition: CGFloat = 0
        var yOffsetPosition: CGFloat = 0

        if isEnglish == true {
            xOffsetPosition = xOffset
        } else {
            xOffsetPosition = -xOffset
        }
        
        yOffsetPosition = -yOffset
        badgeView.frame.size = CGSize(width: width, height: height)
        badgeView.center = CGPoint(x: center.x + xOffsetPosition,  y: center.y + yOffsetPosition)
        badgeView.layer.cornerRadius = badgeView.bounds.height/2
        self.tabBar.bringSubview(toFront: badgeView)
    }
    
    
    func addBadgeWithSize(width : CGFloat,height : CGFloat, xOffset : CGFloat, yOffset:CGFloat, animationType : AnimationType,isEnglish : Bool ,index: Int, value: Int, color: UIColor, font: UIFont) {
        let badgeView = CustomTabBadge()
        badgeView.adjustsFontSizeToFitWidth = true
        
        
        // Removing all the previous added lables
        for case let viewBadge as UILabel in self.tabBar.subviews as [UIView] {
            if viewBadge.tag == index {
                viewBadge.removeFromSuperview()
            }
        }
        
        
        badgeView.clipsToBounds = true
        badgeView.textColor = UIColor.white
        badgeView.textAlignment = .center
        badgeView.font = font
        badgeView.text = String(value)
        badgeView.backgroundColor = color
        badgeView.tag = index
        self.tabBar.backgroundColor = color
        self.tabBar.addSubview(badgeView)
        
        // Check of the various animation types
        if animationType.hashValue == 0 {
            badgeView.animationWithPushOnView()
        } else if animationType.hashValue == 1 {
            badgeView.shake(count: 2, for: 0.3, withTranslation: 8)
        } else if animationType.hashValue == 2 {
            badgeView.animationWithRotationOnView()
        }else if animationType.hashValue == 3 {
            badgeView.animationScale()
        }else if animationType.hashValue == 4 {
            badgeView.animationRotationScale()
        }else if animationType.hashValue == 5 {
            // No Animation
        }
        
        // Positioning the badge Icon as per the Arabic and English
        self.positionBadges(isEnglish: isEnglish,width: width,height: height,xOffset: xOffset,yOffset: yOffset)
        
    }
    
    
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.setNeedsLayout()
        self.tabBar.layoutIfNeeded()
        self.positionBadges(isEnglish: true,width: 25,height: 25,xOffset: 12,yOffset: 14)
    }
    
    
}

//MARK:Extension CustomTabBadge Lable
class CustomTabBadge: UILabel {}
