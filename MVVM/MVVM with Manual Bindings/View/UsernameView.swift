//
//  UserNameView.swift
//  MVVM
//
//  Created by Arun Sinthanaisirrpi on 17/7/21.
//

import Foundation
import UIKit

final class UsernameView: UIView {
    
    private let viewModel: UsernameViewModel
    
    private let userNameTextField   = UITextField(frame: .zero)
    private let userNameLabel       = UILabel(frame: .zero)
    
    
    init(withViewModel viewmodel: UsernameViewModel) {
        self.viewModel = viewmodel
        super.init(frame: .zero)
        build {
            buildView()
            $0.backgroundColor = .white
        }
        /// Setup the binding
        userNameTextField.addTarget(
            self,
            action: #selector(valueChanged),
            for: .editingChanged
        )
        /// Perform incoming binding
        viewmodel.infoLabelValid.onValueChange = { [weak self] newValue in
            guard let uNewValue = newValue else { return }
            self?.userNameTextField.backgroundColor = uNewValue ? .green : .red
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UsernameView {
    private func buildView() {
        userNameLabel.addToAndBuild(inParentView: self) {
            NSLayoutConstraint.activate([
                $0.topAnchor
                    .constraint(
                        equalTo: safeAreaLayoutGuide.topAnchor,
                        constant: directionalLayoutMargins.top
                    ),
                $0.leadingAnchor
                    .constraint(
                        equalTo: safeAreaLayoutGuide.leadingAnchor,
                        constant: directionalLayoutMargins.leading
                    ),
                safeAreaLayoutGuide
                    .trailingAnchor
                    .constraint(
                        equalTo: $0.trailingAnchor,
                        constant: directionalLayoutMargins.trailing
                    ),
                $0.heightAnchor
                    .constraint(equalToConstant: 44)
            ])
        }
        userNameLabel.text = viewModel.infoLabelBinding.value
        
        userNameTextField.addToAndBuild(inParentView: self) {
            NSLayoutConstraint.activate([
                $0.topAnchor
                    .constraint(
                        equalTo: userNameLabel.bottomAnchor,
                        constant: 8
                    ),
                $0.leadingAnchor
                    .constraint(
                        equalTo: safeAreaLayoutGuide.leadingAnchor,
                        constant: directionalLayoutMargins.leading
                    ),
                safeAreaLayoutGuide
                    .trailingAnchor
                    .constraint(
                        equalTo: $0.trailingAnchor,
                        constant: directionalLayoutMargins.trailing
                    ),
                $0.heightAnchor
                    .constraint(equalToConstant: 44)
            ])
        }
        userNameTextField.backgroundColor = .red
    }
}

extension UsernameView {
    @objc func valueChanged() {
        viewModel.userNameBinding.bindingChanged(to: userNameTextField.text)
    }
}
