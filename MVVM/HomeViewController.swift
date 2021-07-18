//
//  ViewController.swift
//  MVVM
//
//  Created by Arun Sinthanaisirrpi on 17/7/21.
//

import UIKit

/**
 Main Home scene
 */
struct HomeViewModel {
    let title: String
}

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    
    required init?(coder: NSCoder) {
        fatalError("XIB Not supported")
    }
    
    /**
     - Parameters:
        - withViewModel: `HomeViewModel`
     */
    init(withViewModel viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = UsernameView(
            withViewModel: UsernameViewModel(withDefaultUserName: "Arun Sirrpi")
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
