//
//  TCTipInputView.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 21.01.2024.
//

import UIKit
import Combine
import CombineCocoa
import Foundation

class TCTipInputView: UIView {

    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    public var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()

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
        button.tapPublisher.flatMap {
            return Just(Tip.tenPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()

    private lazy var fiftenPercentButton: UIButton = {
        let button = self.buildTipButton(tip: .fiftenPercent)
        button.tapPublisher.flatMap {
            return Just(Tip.fiftenPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()

    private lazy var twentyPercentButton: UIButton = {
        let button = self.buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap {
            return Just(Tip.twentyPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()

    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = TCThemeFont.tcBold(ofSize: 20)
        button.backgroundColor = TCThemeColor.tcPrimary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)

        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }
        .store(in: &cancellables)
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
        observe()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            resetView()

            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentButton.backgroundColor = TCThemeColor.tcSecondary
            case .fiftenPercent:
                fiftenPercentButton.backgroundColor = TCThemeColor.tcSecondary
            case .twentyPercent:
                twentyPercentButton.backgroundColor = TCThemeColor.tcSecondary
            case .custom(let value):
                let text = NSMutableAttributedString(
                    string: "$\(value)",
                    attributes: [.font: TCThemeFont.tcBold(ofSize: 20)]
                )
                text.addAttributes(
                    [.font: TCThemeFont.tcBold(ofSize: 14)],
                    range: NSMakeRange(0, 1)
                )
                customTipButton.setAttributedTitle(text, for: .normal)
                customTipButton.backgroundColor = TCThemeColor.tcSecondary
            }
        }
        .store(in: &cancellables)
    }


    private func handleCustomTipButton() {
        let alertController = {
            let alertController = UIAlertController(
                title: "Enter your tip sum",
                message: nil,
                preferredStyle: .alert
            )
            alertController.addTextField { field in
                field.placeholder = "Make it generous!"
                field.keyboardType = .numberPad
                field.autocorrectionType = .no
            }

            let cancelAction = UIAlertAction(
                title: "Cancel", style: .cancel
            )
            let okAction = UIAlertAction(
                title: "Ok", style: .default
            ) { [weak self] _ in
                guard let text = alertController.textFields?.first?.text,
                        let value = Int(text)
                else {
                    return
                }
                self?.tipSubject.send(.custom(value: value))
            }
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            return alertController
        }()
        parentViewController?.present(alertController, animated: true)
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
}


// MARK: HELPERS:

extension TCTipInputView {


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

    private func resetView() {
        [tenPercentButton,
         fiftenPercentButton,
         twentyPercentButton,
         customTipButton]
            .forEach {
                $0.backgroundColor = TCThemeColor.tcPrimary
            }

        let text = NSMutableAttributedString(
            string: "Custom tip",
            attributes: [.font: TCThemeFont.tcBold(ofSize: 20)]
        )
        customTipButton.setAttributedTitle(text, for: .normal)
    }
}
