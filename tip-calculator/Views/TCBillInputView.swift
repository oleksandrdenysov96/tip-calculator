//
//  TCBillInputView.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 21.01.2024.
//

import UIKit
import Foundation

class TCBillInputView: UIView {

    private let headerView: TCHeaderView = {
        let view = TCHeaderView()
        view.configure(topText: "Enter", bottomText: "your bill")
        return view
    }()

    private let textContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        return view
    }()

    private let currencyDenominationLabel: UILabel = {
        let label = LabelFactory.build(
            text: "$",
            font: TCThemeFont.tcBold(ofSize: 24)
        )
        label.setContentHuggingPriority(
            .defaultHigh, for: .horizontal
        )
        return label
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = TCThemeFont.tcDemiBold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = TCThemeColor.tcText
        textField.textColor = TCThemeColor.tcText

        // Toolbar
        let toolbar = UIToolbar(
            frame: CGRect(
                x: 0, y: 0, 
                width: frame.size.width,
                height: 36
            )
        )
        toolbar.barStyle = .default
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )

        toolbar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            ),
            doneButton
        ]
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        return textField

    }()

    init() {
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        [headerView, textContainerView].forEach(addSubview(_:))

        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textContainerView.snp.leading).offset(-24)
        }

        textContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }

        textContainerView.addSubview(currencyDenominationLabel)
        textContainerView.addSubview(textField)

        currencyDenominationLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textContainerView.snp.leading).offset(16)
        }

        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textContainerView.snp.trailing).offset(-16)
        }
    }

    @objc private func doneButtonTapped() {
        textField.endEditing(true)
    }
}
