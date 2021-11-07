//
//  HelperFunctions.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 30/10/2021.
//

import UIKit
import Kingfisher

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

extension UIImageView {
    func setImage(urlStr: String?, placeholder: UIImage?) {
        if urlStr != nil, let url = urlStr, let url = URL(string: url) {
            self.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.3))], progressBlock: nil)
        } else {
            DispatchQueue.main.async { self.image = placeholder }
        }
    }
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                centerX: NSLayoutXAxisAnchor? = nil,
                centerY: NSLayoutYAxisAnchor? = nil,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var _topAnchor: NSLayoutConstraint?
        var _leadingAnchor: NSLayoutConstraint?
        var _bottomAnchor: NSLayoutConstraint?
        var _trailingAnchor: NSLayoutConstraint?
        var _widthAnchor: NSLayoutConstraint?
        var _heightAnchor: NSLayoutConstraint?
        var _centerXAnchor: NSLayoutConstraint?
        var _centerYAnchor: NSLayoutConstraint?
        var anchorsArr = [NSLayoutConstraint]()
        
        if let top = top {
            _topAnchor = topAnchor.constraint(equalTo: top, constant: padding.top)
            anchorsArr.append(_topAnchor!)
        }
        
        if let leading = leading {
            _leadingAnchor = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
            anchorsArr.append(_leadingAnchor!)
        }
        
        if let bottom = bottom {
            _bottomAnchor = bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom)
            anchorsArr.append(_bottomAnchor!)
        }
        
        if let trailing = trailing {
            _trailingAnchor = trailingAnchor.constraint(equalTo: trailing, constant: padding.right)
            anchorsArr.append(_trailingAnchor!)
        }
        
        if let centerX = centerX {
            _centerXAnchor = centerXAnchor.constraint(equalTo: centerX, constant: 0)
            anchorsArr.append(_centerXAnchor!)
        }
        
        if let centerY = centerY {
            _centerYAnchor = centerYAnchor.constraint(equalTo: centerY, constant: 0)
            anchorsArr.append(_centerYAnchor!)
        }
        
        if size.width != 0 {
            _widthAnchor = widthAnchor.constraint(equalToConstant: size.width)
            anchorsArr.append(_widthAnchor!)
        }
        
        if size.height != 0 {
            _heightAnchor = heightAnchor.constraint(equalToConstant: size.height)
            anchorsArr.append(_heightAnchor!)
        }
        
        NSLayoutConstraint.activate(anchorsArr)
    }
    
    func anchorToFill(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let topAnchor = self.topAnchor.constraint(equalTo: view.topAnchor)
        let leadingAnchor = self.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let bottomAnchor = self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let trailingAnchor = self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([topAnchor, leadingAnchor, bottomAnchor, trailingAnchor])
    }
    
    func addSubViewAtCenter(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

class PanDirectionGestureRecognizer: UIPanGestureRecognizer {
    
    enum PanDirection {
        case vertical
        case horizontal
    }
    
    let direction: PanDirection
    
    init(direction: PanDirection, target: AnyObject, action: Selector) {
        self.direction = direction
        super.init(target: target, action: action)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if state == .began {
            let vel = velocity(in: view)
            switch direction {
            case .horizontal where abs(vel.y) > abs(vel.x): state = .cancelled
            case .vertical where abs(vel.x) > abs(vel.y): state = .cancelled
            default: break
            }
        }
    }
}
