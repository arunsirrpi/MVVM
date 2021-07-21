//
//  BooksSearchViewModel.swift
//  BooksSearchViewModel
//
//  Created by Arun Sinthanaisirrpi on 21/7/21.
//

import Foundation
import UIKit

struct ISBNValidator {
    private let validCharacterSet = CharacterSet.decimalDigits
    func isValid(ISBN: String) -> Bool {
        let ISBNAsCharacterSet = CharacterSet(charactersIn: ISBN)
        return validCharacterSet.isSuperset(of: ISBNAsCharacterSet)
    }
}

struct BookSearchQuery {
    
    private let isbnValidator = ISBNValidator()
    private(set) var ISBN: String = ""
    
    var hasValidISBN: Bool {
        return !ISBN.isEmpty
    }
    
    mutating func updateISBN(toPossibleISBN possibleISBN:String) -> Bool {
        let digitCount = possibleISBN.count
        guard
            isbnValidator.isValid(ISBN: possibleISBN),
            (digitCount == 10 || digitCount == 13)
        else {
            return false
        }
        
        ISBN = possibleISBN
        return true
    }
}

typealias PublishBind<T> = (T) -> Void

final class BookSearchViewModel {
    
    /// Publications
    typealias SearchButtonEnabledStateChanged = (Bool) -> Void
    var onNextSearchButtonEnabledChanged: PublishBind<Bool>? = nil
    
    typealias SearchQueryBackgroundColorChanged = (UIColor) -> Void
    var onNextSearchQueryBackgroundColorChanged: PublishBind<UIColor>? = nil
    
    typealias PerformSearch = (String) -> Void
    let onPerformSearch: PerformSearch
    
    /// Backing Model
    private var model: BookSearchQuery
    
    /// View State Representation
    private(set) var isSearchButtonEnabled: Bool    = false
    private(set) var searchBackgroundColor: UIColor = .green
    private(set) var searchQueryText:String
    
    let viewbackgrounColour = UIColor.white
    
    let searchButtonText                = "Search"
    let searchButtonTextColor           = UIColor.white
    let searchButtonDisabledTextColor   = UIColor.gray
    let searchButtonBackgroundColor     = UIColor.black
    
    init(
        withModel model:BookSearchQuery,
        andOnPerformSearchBinding performSearchBinding: @escaping PerformSearch
    ) {
        self.model = model
        searchQueryText = model.ISBN
        onPerformSearch = performSearchBinding
    }
}

extension BookSearchViewModel {
    /// Subscriptions
    func onNextSearchText(searchText: String) {
        let validInput = model.updateISBN(toPossibleISBN: searchText)
        isSearchButtonEnabled = validInput
        onNextSearchButtonEnabledChanged?(isSearchButtonEnabled)
        searchBackgroundColor = validInput ? .green : .red
        onNextSearchQueryBackgroundColorChanged?(searchBackgroundColor)
    }
    
    func onSearchButtonPressed() {
        guard model.hasValidISBN else { return }
        onPerformSearch(model.ISBN)
    }
}
