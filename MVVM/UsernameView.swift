//
//  UserNameView.swift
//  MVVM
//
//  Created by Arun Sinthanaisirrpi on 17/7/21.
//

import Foundation
import UIKit

extension UIView {
    typealias SetupClosure = (UIView) -> Void
    func build(_ setupClosure: SetupClosure) {
        translatesAutoresizingMaskIntoConstraints = false
        setupClosure(self)
    }
    
    @discardableResult
    func addToAndBuild(
        inParentView parent:UIView,
        _ setupClosure: SetupClosure) -> UIView
    {
        parent.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        setupClosure(self)
        return self
    }
    
    @discardableResult
    func customize(_ setupClosure: SetupClosure) -> UIView {
        setupClosure(self)
        return self
    }
}

struct UsernameViewModel {
    private(set) var userNameBinding: Bindable<String?>
    
    init(withDefaultUserName defaultUserName: String) {
        userNameBinding = Bindable(defaultUserName)
        
        userNameBinding.onValueChange = {
            print("\(String(describing: $0))")
        }
    }
}

final class UsernameView: UIView {
    /// Value changed closure
    typealias OnUsernameInputChange = (String?) -> Void
    
    private let viewModel: UsernameViewModel
    private let userNameTextField = UITextField(frame: .zero)
    
    private let userNameBind: Bindable<String?>
    
    init(
        withViewModel viewmodel: UsernameViewModel
    ) {
        self.viewModel = viewmodel
        self.userNameBind = viewmodel.userNameBinding
        super.init(frame: .zero)
        build {
            buildView()
            $0.backgroundColor = .white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UsernameView {
    private func buildView() {
        userNameTextField.addToAndBuild(inParentView: self) {
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
        }.customize {
            $0.backgroundColor = .red
        }
        /// Setup the binding
        userNameTextField.addTarget(
            self,
            action: #selector(valueChanged),
            for: .editingChanged
        )
    }
}

extension UsernameView {
    @objc func valueChanged() {
        userNameBind.bindingChanged(to: userNameTextField.text)
    }
}
