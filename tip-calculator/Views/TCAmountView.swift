//
//  TCAmountView.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 22.01.2024.
//

import UIKit

class AmountView: UIView {

    private let title: String
    private let textAlignment: NSTextAlignment

    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            text: title,
            font: TCThemeFont.tcRegular(ofSize: 18),
            textColor: TCThemeColor.tcText,
            textAlignment: textAlignment
        )
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = TCThemeColor.tcPrimary

        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [
                .font: TCThemeFont.tcBold(ofSize: 24)
            ]
        )
        text .addAttributes(
            [.font: TCThemeFont.tcBold(ofSize: 16)],
            range: NSMakeRange(0, 1)
        )
        label.attributedText = text
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()

    init(title: String, textAlignment: NSTextAlignment) {
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with amount: Double) {
        let text = NSMutableAttributedString(
            string: "$\(amount.currencyFormatted)",
            attributes: [
            .font: TCThemeFont.tcBold(ofSize: 24)
        ])
        text.addAttributes(
            [.font: TCThemeFont.tcBold(ofSize: 16)],
            range: NSMakeRange(0, 1)
        )
        amountLabel.attributedText = text
    }

    private func layout() {
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

