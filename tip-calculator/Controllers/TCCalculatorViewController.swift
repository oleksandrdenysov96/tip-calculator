//
//  ViewController.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 21.01.2024.
//

import UIKit
import SnapKit

class TCCalculatorViewController: UIViewController {

    private let logoView = TCLogoView()
    private let resultView = TCResultView()
    private let billInputView = TCBillInputView()
    private let tipInputView = TCTipInputView()
    private let splitInputView = TCSplitInputView()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TCThemeColor.tcMainBg
        layout()
    }


    private func layout() {
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(15)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-15)
            make.top.equalTo(view.snp.topMargin).offset(15)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-15)
        }

        logoView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        resultView.snp.makeConstraints {
            $0.height.equalTo(224)
        }
        billInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        tipInputView.snp.makeConstraints {
            $0.height.equalTo(56 + 56 + 16)
        }
        splitInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
}

