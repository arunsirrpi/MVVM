//
//  BookSearchHomeViewController.swift
//  BookSearchHomeViewController
//
//  Created by Arun Sinthanaisirrpi on 21/7/21.
//

import UIKit

final class BookSearchHomeViewController: UIViewController {
    
    override func loadView() {
        let bookSearchViewModel = BookSearchViewModel(
            withModel: BookSearchModel()
        )
        view = BookSearchView(withViewModel: bookSearchViewModel)
    }
}

struct LoadingViewModel {
    
}

