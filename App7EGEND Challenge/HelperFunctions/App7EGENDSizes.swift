//
//  App7EGENDSizes.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 07/11/2021.
//

import UIKit

class App7EGENDSizes : NSObject {
    static var statusBarHeight = UIApplication.shared.statusBarFrame.height
    static var safeAreaInsets = UIEdgeInsets.zero
    static var topPadding: CGFloat {
        get {
            return App7EGENDSizes.safeAreaInsets.top == 0.0 ? App7EGENDSizes.statusBarHeight : App7EGENDSizes.safeAreaInsets.top
        }
    }
}
