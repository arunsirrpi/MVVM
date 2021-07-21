//
//  BookSearchView.swift
//  BookSearchView
//
//  Created by Arun Sinthanaisirrpi on 21/7/21.
//

import UIKit

final class BookSearchView: UIView {
    private let viewModel: BookSearchViewModel
    
    private let bookISBNTextField   = UITextField(frame: .zero)
    private let searchButton        = UIButton(frame: .zero)
    
    init(withViewModel bookSearchViewModel:BookSearchViewModel) {
        self.viewModel = bookSearchViewModel
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

extension BookSearchView {
    private func buildView() {
        bookISBNTextField.addToAndBuild(inParentView: self) {
            NSLayoutConstraint.activate([
                $0.topAnchor
                    .constraint(
                        equalTo: safeAreaLayoutGuide.topAnchor,
                        constant: 44
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
        bookISBNTextField.backgroundColor = viewModel.searchBackgroundColor
        /// Setup the binding
        bookISBNTextField.addTarget(
            self,
            action: #selector(valueChanged),
            for: .editingChanged
        )
        /// Bind to the published
        viewModel.onNextSearchQueryBackgroundColorChanged = { [weak self] newColor in
            self?.bookISBNTextField.backgroundColor = newColor
        }
        /// Lay the search button
        searchButton.addToAndBuild(inParentView: self) {
            NSLayoutConstraint.activate([
                $0.topAnchor
                    .constraint(
                        equalTo: bookISBNTextField.bottomAnchor,
                        constant: 44
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
        searchButton.setTitle(
            viewModel.searchButtonText,
            for: .normal
        )
        
        searchButton.backgroundColor = viewModel.searchButtonBackgroundColor
        searchButton.setTitleColor(viewModel.searchButtonTextColor, for: .normal)
        searchButton.setTitleColor(viewModel.searchButtonDisabledTextColor, for: .disabled)
        
        searchButton.addTarget(
            self,
            action: #selector(searchButtonTapped),
            for: .touchUpInside
        )
        viewModel.onNextSearchButtonEnabledChanged = { [weak self] isButtonEnabled in
            self?.searchButton.isEnabled = isButtonEnabled
        }
    }
}

extension BookSearchView {
    @objc func valueChanged() {
        guard
            let query = bookISBNTextField.text,
            !query.isEmpty
        else {
            return
        }
        viewModel.onNextSearchText(searchText: query)
    }
    
    @objc func searchButtonTapped() {
        viewModel.onSearchButtonPressed()
    }
}
