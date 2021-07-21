//
//  BookSearchHomeViewController.swift
//  BookSearchHomeViewController
//
//  Created by Arun Sinthanaisirrpi on 21/7/21.
//

import UIKit

class BookSearchHomeViewController: UIViewController {
    
    override func loadView() {
        let bookSearchViewModel = BookSearchViewModel(
            withModel: BookSearchQuery()) { newQuery in
                /// Tell the model to get me the book
            }
        view = BookSearchView(withViewModel: bookSearchViewModel)
    }
}
