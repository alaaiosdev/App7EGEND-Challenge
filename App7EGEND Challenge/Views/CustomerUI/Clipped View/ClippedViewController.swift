//
//  ClippedViewController.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 07/11/2021.
//

import UIKit

class ClippedViewController: OpaqueViewController {
    
    var clippedView: ClippedView!
    var alpha: CGFloat = 0.7
    internal var yPadding: CGFloat = 190.0
    private var bgView: UIView!
    private var backgroundImageView: UIImageView!
    private var closeIcon: UIImageView!
    private var clippedViewAnimted = false
    private var topAnchorConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !clippedViewAnimted {
            clippedViewAnimted = true
            animateClippedView()
            animateBackgroundImageView()
        }
    }
    
    private func initSubViews() {
        initBackgroundView()
        initClipedView()
        initCloseIcon()
    }
    
    private func initBackgroundView() {
        bgView = UIView()
        view.addSubview(self.bgView)
        bgView.anchorToFill(view: view)
        bgView.backgroundColor = .black
        bgView.alpha = 0.0
        backgroundImageView = UIImageView()
        bgView.addSubview(backgroundImageView)
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.anchorToFill(view: bgView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapRecognized(_ :)))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        bgView.addGestureRecognizer(gesture)
    }
    
    private func initCloseIcon() {
        closeIcon = UIImageView()
        closeIcon.image = UIImage(named: "closeIcon")
        bgView.addSubview(closeIcon)
        closeIcon.anchor(top: bgView.layoutMarginsGuide.topAnchor, leading: nil, bottom: nil, trailing: bgView.trailingAnchor,
                         padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8),
                         size: CGSize(width: 36.0, height: 36.0))
        closeIcon.isUserInteractionEnabled = true
        closeIcon.layer.zPosition = 1100
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeIconTapped))
        closeIcon.addGestureRecognizer(tapGesture)
    }
    
    @objc func closeIconTapped(gesture : UITapGestureRecognizer) {
        dismissClipped()
    }
    
    func setBackgroundImage(imagePath: String) {
        backgroundImageView.setImage(urlStr: imagePath, placeholder: nil)
        bgView.addSubview(backgroundImageView)
    }
    
    private func initClipedView() {
        let frame = CGRect(x: 0, y: yPadding , width: view.frame.width, height: view.frame.height - yPadding)
        clippedView = ClippedView(frame: frame, topOffset: yPadding)
        clippedView.isHidden = true
        view.addSubview(clippedView)
        clippedView.delegate = self
    }
    
    private func animateClippedView() {
        clippedView.frame.origin.y = view.frame.height
        clippedView.isHidden = false
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .transitionFlipFromLeft, animations: {
            self.clippedView.frame.origin.y = self.yPadding
            self.bgView.alpha = self.alpha
            self.bgView.alpha = 1
        }) { (finished) in
            
        }
    }
    
    private func animateBackgroundImageView() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
            self.backgroundImageView.transform = CGAffineTransform.identity.scaledBy(x: 1.06, y: 1.06)
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                self.backgroundImageView.transform = CGAffineTransform.identity
            })
        }
    }
    
    func addOnClippedView(_ view: UIView) {
        clippedView.addOnClippedView(view)
    }
    
    func addOnClippedViewAtCenter(_ view: UIView) {
        clippedView.addSubViewAtCenter(view)
    }
    
    func dismissClipped() {
        clippedView.dismiss()
    }
    
    @objc func tapRecognized(_ sender: UITapGestureRecognizer) {
        clippedView.dismiss()
    }
}

extension ClippedViewController: ClippedViewDelegate {
    func clippedViewDelegateDismissVC() {
        dismiss(animated: true, completion: {
            self.transDelegate?.opaqueViewControllerDelegateDidDismiss()
        })
    }
}
