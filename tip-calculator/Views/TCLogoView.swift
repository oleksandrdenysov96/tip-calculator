//
//  TCLogoView.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 21.01.2024.
//

import UIKit
import Foundation

class TCLogoView: UIView {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icCalculatorBW")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Mr TIP",
            attributes: [
                .font: TCThemeFont.tcDemiBold(ofSize: 16)
            ])
        text.addAttributes(
            [.font: TCThemeFont.tcBold(ofSize: 24)],
            range: NSMakeRange(3, 3)
        )
        label.attributedText = text
        return label
    }()


    private let bottomLabel: UILabel = {
        LabelFactory.build(
            text: "Calculator",
            font: TCThemeFont.tcDemiBold(ofSize: 20),
            textAlignment: .left
        )
    }()

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = -4
        return stackView
    }()

    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoImageView,
            vStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
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
        addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        logoImageView.snp.makeConstraints { make in
            make.height.equalTo(logoImageView.snp.width)
        }
    }
}

