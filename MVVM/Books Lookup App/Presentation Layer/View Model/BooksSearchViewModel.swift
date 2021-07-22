//
//  BooksSearchViewModel.swift
//  BooksSearchViewModel
//
//  Created by Arun Sinthanaisirrpi on 21/7/21.
//

import Foundation
import UIKit

struct BookInfo {
    let title: String
    let isbn: String
}

/// Data Access Layer
struct BookInfoLoader {
    typealias AsyncCallback = (BookInfo) -> Void
    func load(isbn: String, _ callback: @escaping AsyncCallback) {
        let popTime = DispatchTime.now() + DispatchTimeInterval.seconds(10)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: popTime) {
            let bookInfo = BookInfo(
                title: "Amazing Book on MVVM",
                isbn: isbn
            )
            DispatchQueue.main.async {
                callback(bookInfo)
            }
        }
    }
}
/// Simple validator
struct ISBNValidator {
    private let validCharacterSet = CharacterSet.decimalDigits
    func isValid(ISBN: String) -> Bool {
        let ISBNAsCharacterSet = CharacterSet(charactersIn: ISBN)
        return validCharacterSet.isSuperset(of: ISBNAsCharacterSet)
    }
}

/// BookQuery
final class BookSearchModel {
    enum SearchError: Error {
        case notFound
        case ISBNNotSetCorrectly
    }
    
    /// Publication
    typealias OnNextBook = (BookInfo?) -> Void
    var onNextBook: PublishBind<Result<BookInfo, SearchError>>? = nil
    
    /// Data Access layer
    private let bookInfoLoader = BookInfoLoader()
    /// Bussiness logic on validation
    private let isbnValidator = ISBNValidator()
    private(set) var ISBN: String = ""
    
    var hasValidISBN: Bool {
        return !ISBN.isEmpty
    }
    
    func updateISBN(toPossibleISBN possibleISBN:String) -> Bool {
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
    
    func searchBook() {
        guard hasValidISBN else {
            onNextBook?(.failure(.ISBNNotSetCorrectly))
            return
        }
        
        bookInfoLoader.load(isbn: ISBN) { bookInfo in
            onNextBook?(.success(bookInfo))
        }
    }
}

typealias PublishBind<T> = (T) -> Void

final class BookSearchViewModel {
    
    /// Publications
    typealias SearchButtonEnabledStateChanged = (Bool) -> Void
    var onNextSearchButtonEnabledChanged: PublishBind<Bool>? = nil
    
    typealias SearchQueryBackgroundColorChanged = (UIColor) -> Void
    var onNextSearchQueryBackgroundColorChanged: PublishBind<UIColor>? = nil
    
    typealias SearchingStateChanged = (Bool) -> Void
    let onPerformSearch: SearchingStateChanged
    
    /// Backing Model
    private var model: BookSearchModel
    
    /// View State Representation
    private(set) var isSearchButtonEnabled: Bool    = false
    private(set) var searchBackgroundColor: UIColor = .green
    private(set) var searchQueryText:String
    private(set) var isSearching: Bool              = false
    private(set) var searchResult: String           = ""
    
    let viewbackgrounColour = UIColor.white
    
    let searchButtonText                = "Search"
    let searchButtonTextColor           = UIColor.white
    let searchButtonDisabledTextColor   = UIColor.gray
    let searchButtonBackgroundColor     = UIColor.black
    
    init(withModel model:BookSearchModel)
    {
        self.model = model
        searchQueryText = model.ISBN
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
        /// TODO: Change the next set of things
    }
}
