//
//  TCHeaderView.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 22.01.2024.
//

import UIKit

class TCHeaderView: UIView {

    private let topLabel: UILabel = {
        LabelFactory.build(
            text: nil,
            font: TCThemeFont.tcBold(ofSize: 18)
        )
    }()

    private let bottomLabel: UILabel = {
        LabelFactory.build(
            text: nil,
            font: TCThemeFont.tcRegular(ofSize: 17)
        )
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topSpacer,
            topLabel,
            bottomLabel,
            bottomSpacer
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
        return stackView
    }()

    private let topSpacer = UIView()
    private let bottomSpacer = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        topSpacer.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacer)
        }
    }

    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
}
