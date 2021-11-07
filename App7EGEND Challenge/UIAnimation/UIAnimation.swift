//
//  UIAnimation.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 02/11/2021.
//

import UIKit

extension UIView {
    func didSelectItemWithAnimate() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 2
        animation.duration = 0.4
        
        backgroundColor = .clear
        layer.add(animation, forKey: "basic")
        
        UIView.animate(withDuration: 0.2 , animations: { [weak self] in
            guard let `self` = self else { return }
            self.layer.transform = CATransform3DMakeScale(1.04, 1.04, 1)
        },completion: { finish in
            UIView.animate(withDuration: 0.2){
                self.transform = CGAffineTransform.identity
            }
        })
    }
}
