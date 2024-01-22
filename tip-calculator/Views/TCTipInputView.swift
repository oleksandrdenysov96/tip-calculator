//
//  TCTipInputView.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 21.01.2024.
//

import UIKit
import Foundation

class TCTipInputView: UIView {

    private let headerView: TCHeaderView = {
        let view = TCHeaderView()
        view.configure(
            topText: "Choose",
            bottomText: "your tip"
        )
        return view
    }()

    private lazy var tenPercentButton: UIButton = {
        let button = self.buildTipButton(tip: .tenPercent)
        return button
    }()

    private lazy var fiftenPercentButton: UIButton = {
        let button = self.buildTipButton(tip: .fiftenPercent)
        return button
    }()

    private lazy var twentyPercentButton: UIButton = {
        let button = self.buildTipButton(tip: .twentyPercent)
        return button
    }()

    private let customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = TCThemeFont.tcBold(ofSize: 20)
        button.backgroundColor = TCThemeColor.tcPrimary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        return button
    }()

    private lazy var buttonsHorizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPercentButton,
            fiftenPercentButton,
            twentyPercentButton
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var buttonsVerticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonsHorizontalStack,
            customTipButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        [headerView, buttonsVerticalStack].forEach(addSubview(_:))

        buttonsVerticalStack.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonsVerticalStack.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(buttonsHorizontalStack.snp.centerY)
        }

    }

    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = TCThemeColor.tcPrimary
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: TCThemeFont.tcBold(ofSize: 20),
                .foregroundColor: UIColor.white
            ]
        )
        text.addAttributes(
            [.font: TCThemeFont.tcDemiBold(ofSize: 14)],
            range: NSMakeRange(2, 1)
        )
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
