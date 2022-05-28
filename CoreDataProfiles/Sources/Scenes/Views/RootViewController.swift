//
//  RootViewController.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import UIKit

// MARK: - View
class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter = RootPresenter()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setViewDelegate(delegate: self)
        
        view.backgroundColor = .systemTeal
    }
}

// MARK: - Presenter Delegate
extension RootViewController: RootPresenterDelegate {
    
}
