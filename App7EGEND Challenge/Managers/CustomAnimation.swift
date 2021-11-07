//
//  CustomAnimation.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 07/11/2021.
//

import UIKit

class CustomAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var animationDuration = 0.36
    private var presenting : Bool = false
    
    init(animationDuration: TimeInterval, presenting: Bool) {
        self.presenting = presenting
        self.animationDuration = animationDuration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to), let fromVC = transitionContext.viewController(forKey: .from) else { return }
        
        if !self.presenting {
            let duration = self.transitionDuration(using: transitionContext)
            toVC.view.alpha = 1
            UIView.animate(withDuration: duration, animations: {
                fromVC.view.alpha = 0
            }) { (finished) in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        } else {
            let containerView = transitionContext.containerView
            let finalFrame = transitionContext.finalFrame(for: toVC)
            containerView.addSubview(toVC.view)
            let duration = self.transitionDuration(using: transitionContext)
            
            UIView.animate(withDuration: duration, animations: {
                toVC.view.alpha = 1
                toVC.view.frame = finalFrame
            }) { (finished) in
                transitionContext.completeTransition(true)
            }
        }
    }
}
