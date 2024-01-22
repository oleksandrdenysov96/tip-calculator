//
//  TCResultView.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 21.01.2024.
//

import UIKit
import Foundation

class TCResultView: UIView {

    private let headerLabel: UILabel = {
        LabelFactory.build(
            text: "Total p/person",
            font: TCThemeFont.tcDemiBold(ofSize: 18)
        )
    }()

    private let amountPerPerson: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [
                .font: TCThemeFont.tcBold(ofSize: 48)
            ]
        )
        text.addAttributes(
            [.font: TCThemeFont.tcBold(ofSize: 24)],
            range: NSMakeRange(0, 1)
        )
        label.attributedText = text
        return label
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = TCThemeColor.tcSeparator
        return view
    }()

    // MARK: Stack

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPerson,
            separator,
            addSpacer(height: 0),
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            AmountView(
                title: "Total bill",
                textAlignment: .left
            ),
            UIView(),
            AmountView(
                title: "Total tip",
                textAlignment: .right
            )
        ])
        stackView.axis = .horizontal
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
        backgroundColor = .white
        addSubview(vStackView)

        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }

        separator.snp.makeConstraints { make in
            make.height.equalTo(1)
        }

        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: .black,
            radius: 12.0,
            opacity: 0.1
        )
    }

    private func addSpacer(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor
            .constraint(equalToConstant: height)
            .isActive = true
        return view
    }
}


