//
//  UIResponderExtension.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 25.01.2024.
//

import UIKit
import Foundation


extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
