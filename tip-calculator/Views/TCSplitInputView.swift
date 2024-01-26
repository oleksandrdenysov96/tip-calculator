//
//  TCSplitInputView.swift
//  tip-calculator
//
//  Created by Oleksandr Denysov on 21.01.2024.
//

import UIKit
import Combine
import CombineCocoa
import Foundation

class TCSplitInputView: UIView {

    private let splitSubject = CurrentValueSubject<Int, Never>(1)
    public var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()

    private let headerView: TCHeaderView = {
        let view = TCHeaderView()
        view.configure(
            topText: "Split", bottomText: "the total")
        return view
    }()

    private lazy var decrementButton: UIButton = {
        let button = self.buildButton(text: "-", corners: [
            .layerMinXMaxYCorner, .layerMinXMinYCorner]
        )
        button.tapPublisher.flatMap { [unowned self] _ in
            return Just(
                splitSubject.value == 1
                ? 1
                : splitSubject.value - 1
            )
        }
        .assign(to: \.value, on: splitSubject)
        .store(in: &cancellables)
        return button
    }()

    private lazy var incrementButton: UIButton = {
        let button = self.buildButton(text: "+", corners: [
            .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        )
        button.tapPublisher.flatMap { [unowned self] _ in
            return Just(splitSubject.value + 1)
        }
        .assign(to: \.value, on: splitSubject)
        .store(in: &cancellables)
        return button
    }()

    private lazy var quantityLabel: UILabel = {
        let label = LabelFactory.build(
            text: "0",
            font: TCThemeFont.tcBold(ofSize: 20)
        )
        label.backgroundColor = .white
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            decrementButton, quantityLabel, incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
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
        splitSubject.sink { [unowned self] value in
            quantityLabel.text = value.stringValue
        }
        .store(in: &cancellables)
    }

    private func layout() {
        addSubview(headerView)
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }

        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }

        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(stackView.snp.centerY)
            make.trailing.equalTo(stackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
    }

    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = TCThemeFont.tcBold(ofSize: 20)
        button.backgroundColor = TCThemeColor.tcPrimary
        button.addRoundedCorners(corners: corners, radius: 8.0)
        return button
    }
}
