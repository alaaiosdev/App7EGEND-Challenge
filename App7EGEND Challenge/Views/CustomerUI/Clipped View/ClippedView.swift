//
//  ClippedView.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 03/11/2021.
//

import UIKit

protocol ClippedViewDelegate: AnyObject {
    func clippedViewDelegateDismissVC()
}

class ClippedView: UIView {
    
    private(set) var clippedView: UIView!
    private var panGesture: PanDirectionGestureRecognizer!
    internal var topPadding: CGFloat!
    private let MAX_VELOCITY : CGFloat = 1500
    private var yDefault: CGFloat!
    
    weak var delegate : ClippedViewDelegate?
    
    init(frame: CGRect, topOffset: CGFloat) {
        super.init(frame: frame)
        self.topPadding = topOffset
        initClipedView()
        isUserInteractionEnabled = true
        panGesture = PanDirectionGestureRecognizer(direction: .vertical, target: self, action: #selector(self.panGesutureHandler(gesture:)))
        addGestureRecognizer(self.panGesture)
        yDefault = self.frame.minY
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clippedView.roundCorners([.topLeft, .topRight], radius: 15)
    }
    
    @objc func downArrowTapped(gesture : UITapGestureRecognizer) {
        animateSelfTo(yPoint: UIScreen.main.bounds.height, remove: true)
    }
    
    private func initClipedView() {
        clippedView = UIView()
        clippedView.backgroundColor = .white
        addSubview(clippedView)
        clippedView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                           padding: UIEdgeInsets(top: 5.0, left: 0, bottom: 0, right: 0))
    }
    
    @objc func panGesutureHandler(gesture : UIPanGestureRecognizer) {
        if gesture != self.panGesture { return }
        let translation = gesture.translation(in: self)
        let yOffset = self.frame.origin.y + translation.y
        let vel = gesture.velocity(in: self)
        
        switch gesture.state {
        case .began:
            break
        case .changed:
            if yOffset <= topPadding {
                gesture.state = .ended
                return
            }
            self.center = CGPoint(x: self.center.x, y: self.center.y + translation.y)
            gesture.setTranslation(CGPoint.zero, in: self)
            break
        case .cancelled:
            break
        case .ended:
            if vel.y > self.MAX_VELOCITY {
                animateSelfTo(yPoint: UIScreen.main.bounds.height, remove: true)
                return
            }
            if yOffset <= yDefault + 40 {
                animateSelfTo(yPoint: topPadding)
            } else {
                animateSelfTo(yPoint: UIScreen.main.bounds.height, remove: true)
            }
            
            break
        default:
            break
        }
    }
    
    private func animateSelfTo(yPoint: CGFloat, remove: Bool = false) {
        if remove {
            self.delegate?.clippedViewDelegateDismissVC()
        }
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.frame.origin.y = yPoint
        }) { (finished) in
            if remove {
                self.removeFromSuperview()
            }
        }
    }
    
    func addOnClippedView(_ view: UIView) {
        clippedView.addSubview(view)
    }
    
    func addOnClippedViewAtCenter(_ view: UIView) {
        clippedView.addSubViewAtCenter(view)
    }
    
    func dismiss() {
        animateSelfTo(yPoint: UIScreen.main.bounds.height, remove: true)
    }
}
