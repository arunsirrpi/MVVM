//
//  BookSearchTestViewModel.swift
//  BookSearchTestViewModel
//
//  Created by Arun Sinthanaisirrpi on 21/7/21.
//

import XCTest
@testable import MVVM

class BookSearchTestViewModel: XCTestCase {

    func testInValidColor() {
        /// expected output
        let expected_search_field_background_color: UIColor = .red
        let expected_search_button_enabled_state: Bool = false
        
        /// setup
        let sut = BookSearchViewModel(
            withModel: BookSearchQuery()
        ) { _ in
          XCTFail("Should never ever be called")
        }
        /// On Next setup
        sut.onNextSearchButtonEnabledChanged = { acutalButtonState in
            XCTAssertEqual(acutalButtonState, expected_search_button_enabled_state)
        }
        /// on Next background setup
        sut.onNextSearchQueryBackgroundColorChanged = { actualBackgroundColor in
            XCTAssertEqual(actualBackgroundColor, expected_search_field_background_color)
        }
        
        /// Simulate
        sut.onNextSearchText(searchText: "0123")
    }
    
    func testValidColor() {
        /// expected output
        let expected_search_field_background_color: UIColor = .green
        let expected_search_button_enabled_state: Bool = true
        let expected_search_query = "0123456789"
        
        /// setup
        let sut = BookSearchViewModel(
            withModel: BookSearchQuery()
        ) { actualQuery in
          XCTAssertEqual(expected_search_query, actualQuery)
        }
        /// On Next setup
        sut.onNextSearchButtonEnabledChanged = { acutalButtonState in
            XCTAssertEqual(acutalButtonState, expected_search_button_enabled_state)
        }
        /// on Next background setup
        sut.onNextSearchQueryBackgroundColorChanged = { actualBackgroundColor in
            XCTAssertEqual(actualBackgroundColor, expected_search_field_background_color)
        }
        
        /// Simulate
        sut.onNextSearchText(searchText: "0123456789")
    }

}
