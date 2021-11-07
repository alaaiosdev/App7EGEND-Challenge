//
//  OpaqueViewController.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 07/11/2021.
//

import UIKit

protocol OpaqueViewControllerDelegate: AnyObject {
    func opaqueViewControllerDelegateDidDismiss()
}

class OpaqueViewController: UIViewController {
    
    weak var transDelegate: OpaqueViewControllerDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
}
