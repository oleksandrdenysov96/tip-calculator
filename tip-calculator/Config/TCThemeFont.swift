//
//  TCThemeFont.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 21.01.2024.
//

import UIKit

struct TCThemeFont {
    static func tcRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size) ??
            .systemFont(ofSize: size)
    }

    static func tcBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size) ??
            .systemFont(ofSize: size)
    }

    static func tcDemiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size) ??
            .systemFont(ofSize: size)
    }
}
